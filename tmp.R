---
title: "Hindcast PM"
output:
  html_document:
    code_folding: hide
    df_print: paged
    fig_caption: yes
    highlight: tango
    number_sections: yes
    theme: paper
    toc: yes
    toc_float: no
  word_document:
    toc: yes
---

```{r setup}
library(knitr)
library(rmarkdown)
options(max.print="90")
opts_chunk$set(fig.height=5, 
               fig.width=10)
```


 body{
   font-size: 12pt;
 }
 
 
```{r}
library(tidyverse)
```

# Reading functions
```{r}
logit<-function(x)log(x/(1-x))
logistic<-function(x)1/(1+exp(-x))

#logistic and Fox
fp.schaefer<-function(B,K){
  (1-(B/K))
}#fp.schaefer

fp.fox<-function(B,K){
  log(K/B)
}#fp.fox

# Data generation ---------------------------------------------------------

Data_maker<- function(r,K,Dep,E,q,tau,nyear=50,Type){
  
  fp<-ifelse(Type==Type,fp.schaefer,fp.fox)
  
  B <- numeric(nyear)
  B[1] <- K*Dep
  
  for(i in 2:nyear){ 
    B[i] <- B[i-1] +r*B[i-1]*fp(B=B[i-1],K=K) - E[i-1]*B[i-1]
  }
  
  C_obs <- E*B
  CPUE_obs <-B*q* 
    exp(rnorm(length(C_obs),mean=0,sd=tau))
  
  Data<-list(B=B,E=E,Catch=C_obs,CPUE=CPUE_obs)
  return(Data)
}


  PM<-function(r,K,Dep,Catch,nyear,Type){
    fp<-ifelse(Type=="S",fp.schaefer,fp.fox)
    B <- numeric(nyear)
    B[1]<-K*Dep
    for(i in 2:nyear){
      B[i]<-B[i-1]+r*B[i-1]*fp(B=B[i-1],K=K)-Catch[i-1]
      B[i]<-ifelse(B[i]<0,10,B[i])
    }#for(i)
    B
  }
  
  NLL_PM<-function(para,Data,nyear,Type){
    r<-exp(para[1])
    K<-exp(para[2])
    q<-exp(para[3])
    tau<-exp(para[4])   
    Dep<-logistic(para[5])

    B<-PM(r=r,K=K,Dep=Dep,Catch=Data$Catch,nyear=nyear,Type=Type)
    CPUE<-Data$CPUE
    
    val<-sum(log(dnorm(log(CPUE),log(q*B),tau)),na.rm=T)
    (-1)*val
  }#NLL.PM
```


# OM
```{r}
 set.seed(2020)
 nyear<-50
 E<-runif(50,0.05,0.1) #fishing rate
 q<-1.0*10^(-5) #cathability coefficient
 K<-10^5 #carrying capacity
 Dep<-0.8 #initial depletion
 r<-0.25 #intrinsic rate of natural increase 
 tau<-0.05 #observation error 
 Type<-"S" #increasing type S=logistic F=Fox
 Data<-Data_maker(r=r,K=K,Dep=Dep,E=E,q=q,tau=tau,Type=Type)
 B_true<-Data$B  
 fishig_rate<-Data$E 
 Catch<-Data$Catch
 CPUE<-Data$CPUE
 
 #Population dynamics
 Df<-data.frame(Year=1:nyear,B=B_true,CPUE=CPUE)
 Df_plot<- Df %>% mutate(B_cpuescale=B*q) %>% 
   gather(key = variable,value=value,-Year) %>% 
   filter(variable%in%c("CPUE","B_cpuescale"))

  ggplot() + 
   geom_line(data=Df_plot,aes(x=Year,y=value,col=variable),lwd=1.2)
```

# Estimation
```{r}
inits<-c(log(r),log(K),log(q),log(tau),logit(Dep))
 
 res<-optim(inits,NLL_PM,Data=Data,nyear=nyear,Type=Type,
            hessian=T,control=list(trace=1),method="BFGS")
 r_est<-exp(res$par[1])
 K_est<-exp(res$par[2])
 q_est<-exp(res$par[3])
 tau_est<-exp(res$par[4])
 Dep_est<-logistic(res$par[5])
 
 data.frame(r_est,K_est,q_est,tau_est,Dep_est)
 
 Df<-data.frame(Year=1:nyear,CPUE_est=q_est*PM(r=r_est,K=K_est,Dep=Dep_est,Catch=Data$Catch,nyear=nyear,Type=Type),CPUE=CPUE)
 
  Df %>%  
   gather(key = variable,value=value,-Year) %>% 
   ggplot() + 
    geom_line(aes(x=Year,y=value,col=variable),lwd=1.2)
```

# Hindcast
```{r}
 #rm_year : number of yeras to be removed
 #when rm_year=9
 #the range of data used to conduct stock assessment become 1-40yr 

 Hindcast<-function(inits,Data,nyear,rm_year,Type){

   Catch<-Data$Catch[1:(nyear-rm_year)]
   CPUE<-Data$CPUE[1:(nyear-rm_year)]
   Data_rm<-list(Catch=Catch,CPUE=CPUE)
   #inits<-c(log(r),log(K),log(q),log(tau),logit(Dep))
   
   res<-optim(inits,NLL_PM,Data=Data_rm,nyear=nyear,Type=Type,
              hessian=T,control=list(trace=1),method="BFGS")
   r_est<-exp(res$par[1])
   K_est<-exp(res$par[2])
   q_est<-exp(res$par[3])
   tau_est<-exp(res$par[4])
   Dep_est<-logistic(res$par[5])
   para_est<-data.frame(r_est,K_est,q_est,tau_est,Dep_est)
   B_est<-PM(r=para_est$r_est,K=para_est$K_est,Dep=para_est$Dep_est,
      Catch=Data$Catch,nyear=nyear,Type=Type)
   
   return(list(para=para_est,B=B_est))
 }

```

## Hindcast (schaefer)
```{r}
   #using 1-40years data to construct model
   #prediction 41-50 years
    rm_year<-9
    inits<-c(log(r),log(K),log(q),log(tau),logit(Dep))
    res<-Hindcast(inits=inits,Data=Data,nyear=nyear,rm_year=rm_year,Type = "S") 
    para_est<-res$para
    CPUE_pred<-Data$CPUE
    CPUE_pred[(nyear-rm_year):nyear]<-(res$B*para_est$q_est)[(nyear-rm_year):nyear]

```

## Hindcast (Fox)
```{r}
    rm_year<-9
    inits<-c(log(r),log(K),log(q),log(tau),logit(Dep))
    res<-Hindcast(inits=inits,Data=Data,nyear=nyear,rm_year=rm_year,Type = "F") 
    para_est<-res$para
    CPUE_pred_f<-Data$CPUE
    CPUE_pred_f[(nyear-rm_year):nyear]<-(res$B*para_est$q_est)[(nyear-rm_year):nyear]
```

## Results vis
```{r}
    Df<-data.frame(Year=1:nyear,
                   CPUE=Data$CPUE,
                   CPUE_rmsh=CPUE_pred,
                   CPUE_rmfox=CPUE_pred_f)
    
    Df_pred<-Df[(nyear-rm_year-1):nyear,] %>% 
      gather(key = variable,value=value,-Year)
    
    Df %>%
      ggplot() + 
      geom_line(aes(x=Year,y=CPUE),lwd=1.2) +
      geom_line(data=Df_pred,
                aes(x=Year,y=value,col=variable),lwd=1.2)
```

## RMSE
- $RMSE = \sqrt{\frac{\sum_{y=t-n}^{t}((log I_y)-(log\hat{I_y}))^2}{n+1}}$
- *latest year* : $t$
- *the year prediction starts* : $t-n$
- In this case the results of RMSE has become too close...
```{r}    
    rmse_s<-sqrt(sum((log(CPUE[(nyear-rm_year):nyear])-log(CPUE_pred[(nyear-rm_year):nyear]))^2)/(rm_year+1))
    rmse_f<-sqrt(sum((log(CPUE[(nyear-rm_year):nyear])-log(CPUE_pred_f[(nyear-rm_year):nyear]))^2)/(rm_year+1))

    data.frame(Schaefer=rmse_s,Fox=rmse_f)
```

