#99.99 Plot
library(ggplot2)
library(reshape2)

#ggplot theme
mytheme<- theme(panel.background=element_rect(fill="white"),
                panel.grid.major=element_line(colour="gray80"),
                panel.grid.minor=element_line(colour="gray90"),
                axis.text.y = element_text(size=12),
                axis.text.x = element_text(size=12),
                axis.title = element_text(size=12))
#CAA 
CAA<-read.csv("caa.csv")
CAA<-data.frame(CAA)
colnames(CAA)<-c("0","1","2","3+")
CAA$Year<-1973:2016
CAA2<-melt(CAA,"Year")
CAA2$variable<-factor(CAA2$variable,levels=unique(rev(levels(CAA2$variable))))
CAA2$Age_class<-CAA2$variable
 ggplot(data=CAA2)+geom_bar(stat="identity",aes(x=Year,y=value,fill=Age_class))+
   ylab("Catch(百???尾)")+
   theme(axis.title = element_text(size=15),
         axis.text = element_text(size=13))+mytheme
 
 ##CPUE
 #CPUE<-Data[,c(4:ncol(Data))]
 Ab.index<-read.csv("Abundance_index.csv")
 sy<-c(rep(1997,ncol(Ab.index)-1))
 ey<-c(rep(2016,ncol(Ab.index)-1))
 ayr<-c(1973,2016) 
 use.ind<-grep("CPUE",names(Ab.index))  
 CPUE.Data<-Data.handler(Ab.index,sy,ey,ayr,use.ind)
 df.cpue<-CPUE.Data
 colnames(df.cpue)<-c("Year","?????g???[??????","?v?ʋ??T????","0?Α咆?܂?","???苛?s","???????܂?",
                        "?c??????","1?Α咆?܂?","1?Γ??????܂?","????","2?Α咆?܂?","3?Α咆?܂?")
 df.cpue<-melt(df.cpue,c("Year"))
 if(F)df.cpue<-df.cpue[df.cpue$variable%in%c("0?Α咆?܂?","1?Α咆?܂?","2?Α咆?܂?","3?Α咆?܂?"),]
 
 ggplot()+geom_line(data=df.cpue,aes(x=Year,y=value),size=2,col="purple")+
   ylab("index(ton)")+
   facet_wrap(~variable,scales="free")+
   theme(axis.title = element_text(size=17),
         axis.text.x = element_text(size=12),
         axis.text.y = element_text(size=12),
         strip.text = element_text(face = "bold",size = 13))+
   scale_x_continuous(limits = c(2000,2016))+mytheme
 
 ##Catchのfittingを見る図
 ##
 caa.fit<-function(CAA,caa.est,year.range=c(1973,2016),file.name="catch.fit",save=F){
   ###
   if(F){
     CAA
     caa.est<-RES$caa
     year.range=c(1973,2016)
   }#IF(F)
   ###
   nyear<-ncol(CAA)
   a<-b<-data.frame()
   for(i in 1:nyear){
     tmp<-as.data.frame(CAA[,i])
     a<-rbind(a,tmp)
     tmp<-as.data.frame(caa.est[,i])
     b<-rbind(b,tmp)
   }#for(i)
   yr<-year.range
   a$est<-b[,1]
   a$Year<-factor(rep(yr[1]:yr[2],each=4),levels=yr[1]:yr[2])
   rownames(a)<-NULL
   a$age<-rep(0:3,nyear)
   colnames(a)[1]<-c("obs")
   a$bw<-0
   ind<-1
   plot.list<-vector("list",ifelse(nyear%%16==0,nyear%/%16,(nyear%/%16)+1))
   for(i in 1:ifelse(nyear%%16==0,nyear%/%16,(nyear%/%16)+1)){
     index<-levels(a$Year)[ind:(ind+15)]
     tmp.df<-a[a$Year%in%index,]
     colnames(tmp.df)<-c( "obs","est","Year","age","bw")
     plot.list[[i]]<-
       ggplot()+geom_ribbon(data=tmp.df,aes(x=age,ymax=obs,ymin=bw),fill="#8E9095F7")+
       geom_line(data=tmp.df,aes(x=age,y=obs),col="black",lwd=1.5)+
       geom_point(data=tmp.df,aes(x=age,y=obs),size=2.5)+
       geom_line(data=tmp.df,aes(x=age,y=est),col="red",lwd=1.5)+
       theme(panel.background=element_rect(fill="white"),
             #panel.grid.major=element_line(colour="gray80"),
             panel.grid.minor=element_line(colour="gray90"),
             axis.text.y = element_text(size=8),
             axis.text.x = element_text(size=12),
             axis.title = element_text(size=12))+
       facet_wrap(~Year,scales="free")+
       scale_x_continuous(labels=c("0","1","2","3+"))+
       ylab("catch_obs")
     #print(tmp.plot)
     ind<-ind+16
   }#for(i)
   
   if(save){
     pdf(paste(file.name,".pdf",sep=""))
     for(i in 1:length(plot.list)){
       print(plot.list[[i]])
     }
     dev.off()
   }
   
   return(plot.list)
 }#caa.fit
 #a<-caa.fit(CAA,caa.est,save = T) 
 
 #Recruitment (log)residuals plot
 
 rc.residuals<-function(SSB,Rc.est,R0,B0,h,Rsigma,Type="Beverton"){
   rc<-ifelse(Type=="Beverton",Beverton,Ricker)
   rc_vec<-rc(SSB,R0,B0,h,Rsigma) #optimal val
   #residuals
   resid<-log(Rc.est)-log(rc_vec)
   #resid df
   df.r<-data.frame(Year=1974:2016,resid=resid)
   df.r$Type<-paste(ifelse(phase==1,"BH","Ricker")," h=",h," sigmaR=0.4",sep="")
   ggplot(data=df.r,aes(x=Year,y=resid))+
     geom_hline(yintercept=0,col="purple",size=1.5)+
     ylab("log(residuals)")+
     geom_line()+
     geom_point(col="red")+facet_wrap(~Type)+
     theme(axis.title = element_text(size=17),
           axis.text.x = element_text(size=12),
           axis.text.y = element_text(size=12),
           strip.text = element_text(face = "bold",size = 12))
 }#rc.residuals
 
 
 #selectivity reference age
 select.<-function(select.obj){
   ###
   if(F){
     select.obj<-select
   }#IF(F)
   ###
   
   ind<-select.obj[,2:ncol(select.obj)]==1
   df.frag<-list()
   start.row<-1
   cond<-which(ind[1,]==1)
   
   for(i in 2:nrow(ind)){
     #i<-4
     cand<-which(ind[i,]==1)
     if(cond!=cand){
       end.row<-i-1
       df.frag[[i]]<-select.obj[start.row:end.row,]
       start.row<-i
       cond<-cand
       if(i==nrow(select.obj)){
         end.row<-i
         df.frag[[i+1]]<-select.obj[start.row:end.row,]
       }
     }else{
       if(i==nrow(select.obj)){
         end.row<-i
         df.frag[[i]]<-select.obj[start.row:end.row,]
       }
       next
     }
   }#for(i)
   
   ind<-which(sapply(df.frag,function(x)!is.null(x)))
   plot.df.list<-vector("list",length(ind))
   for(i in 1:length(ind)){
     plot.df.list[[i]]<-df.frag[[ind[i]]]
     plot.df.list[[i]]$val<-apply(plot.df.list[[i]],1,function(x)which(x==1))-2
     plot.df.list[[i]]$val<-factor(plot.df.list[[i]]$val,levels=c(0,1,2,3))
     plot.df.list[[i]]$Year<-as.numeric(as.character(plot.df.list[[i]]$Year))
   }
   
   df.plot<-vector("list",length(plot.df.list))
   for(i in 1:length(df.plot)){
     tmp<-data.frame(xmin=min(plot.df.list[[i]]$Year),xend=max(plot.df.list[[i]]$Year),
                     yval=plot.df.list[[i]]$val)
     if(nrow(tmp)==1){
       tmp$xmin<-tmp$xmin-.3;tmp$xend<-tmp$xend+.3
     }
     df.plot[[i]]<-tmp
     
   }#for(i)
   
   tmp.plot<- ggplot()+geom_segment(data=df.plot[[1]],aes(x=xmin,xend=xend,y=yval,yend=yval,col=yval),
                                    size=4.5,lineend = "round",linejoin = "round")
   if(1!=length(plot.df.list)){
     for(i in 2:length(plot.df.list)){
       tmp.plot<-tmp.plot+geom_segment(data=df.plot[[i]],aes(x=xmin,xend=xend,y=yval,yend=yval,col=yval),
                                       size=4.5,lineend = "round",linejoin = "round")
     }#for(i)
   }
   
   tmp.plot+scale_y_discrete("yval",limits=c("0","1","2","3"),labels=c("0"="0","1"="1","2"="2","3"="3+"))+
     xlab("Year")+ylab("age")+mytheme+
     scale_color_manual(values=c("0"="#E09E22FF","1"="#1D980CFF","2"="#436FFFFF","3"="#2B1CFFFF"))+
     theme(axis.text.y = element_text(size=12,face ="bold"),
           axis.text.x = element_text(size=12,face ="bold"),
           axis.title = element_text(size=12,face ="bold"),
           legend.position ="none")+ggtitle("Reference age")
 }#

 
##Hindcast example
 set.seed(1220)
 obs.cpue<-numeric()
 obs.cpue[1]<-500
 for(i in 2:15)obs.cpue[i]<-rnorm(1,obs.cpue[i-1],20)
 plot(obs.cpue,type="l")
 set.seed(2)
 est.cpue1<-obs.cpue*exp(rnorm(length(obs.cpue),0,0.01)) 
 est.cpue2<-obs.cpue*exp(rnorm(length(obs.cpue),0,0.04)) 
 points(est.cpue1,type="l",col="red")
 points(est.cpue2,type="l",col="blue")
 
 pred1<-est.cpue1[10:length(est.cpue1)]
 pred2<-est.cpue2[10:length(est.cpue2)]
 df.pred<-data.frame(Year=2010:2015,Model1=pred1,Model2=pred2)
 df.pred<-melt(df.pred,"Year")
 clear<-rgb(0,0,0,0)
 ggplot()+
   geom_line(data=data.frame(Year=2001:2010,y=est.cpue1[1:10]),
             aes(x=Year,y=y),col="purple",lwd=2)+
   geom_line(data=df.pred,
             aes(x=Year,y=value,col=variable),lwd=2)+
   geom_point(data=data.frame(Year=2001:2015,val=obs.cpue)
              ,aes(x=Year,y=val),size=2)+mytheme+
   theme(axis.title = element_blank(),
         axis.text.x = element_blank(),
         axis.text.y = element_blank(),
         legend.position = c(.03,.97),
         legend.justification = c("left","top"),
         legend.title = element_blank(),
         legend.background=element_rect(fill="#F7FAF7F5",size=0.5),
         legend.key=element_rect(fill=clear,colour=clear)
   )+xlim(c(2005,2015))
   
##HCR in ggplot2
 
 iHCR<-function(SSBc,SSBlimit,SSBban,Fmsy,beta=0.8){
    
    lin<-function(x,ban,limit)(x-ban)/(limit-ban)
    
    if(SSBc<SSBban){
       F.ap<-0
    }else if((SSBc>=SSBban)&&(SSBc<SSBlimit)){
       F.ap<-lin(SSBc,SSBban,SSBlimit)*beta*Fmsy
    }else if(SSBc>=SSBlimit){
       F.ap<-Fmsy*beta
    }
    
    F.ap
    
 }#HCR2
 SSBc<-319410.7
 SSBmsy<-535597
 Fmsy<-0.6
 beta=0.8
 SSBmsy=533333.3333 
 y<-numeric()
 for(i in 1:length(seq(0,600000,length.out = 1000)))
    {
    y[i]<-iHCR(seq(0,600000,length.out = 1000)[i],
               SSBlimit = 0.6*SSBmsy,SSBban = SSBmsy*0.1,Fmsy=0.6)
 }
 plot(seq(0,600000,length.out = 1000),y,type = "l",lwd=2,ylim = c(0,0.8),xlab="SSB",ylab="Fishing mortality",xaxt="n",yaxt="n")
 axis(side=1, at=c(SSBmsy*0.1,SSBmsy*0.6),
      labels=c("0.1*SSBmsy","0.6*SSBmsy"))
 axis(side=2, at=c(0,0.6*0.8,0.6),
      labels=c(0,"0.8*Fmsy","Fmsy"))
 abline(v=SSBmsy*0.1,lty=2)
 abline(v=SSBmsy*0.6,lty=2)
 abline(h=0.6*0.8,lty=2)
 abline(h=0.6,lty=2)
 abline(h=0,lty=2)
 
 ggplot(data = data.frame(x=seq(0,600000,length.out = 1000),
                          y=y))+
    geom_point(aes(x=x,y=y))+
    geom_vline(data = data.frame(x=SSBmsy*0.1),aes(xintercept=x),lty=2) +
    geom_vline(data = data.frame(x=SSBmsy*0.6),aes(xintercept=x),lty=2) +
    geom_hline(data = data.frame(y=0.6),aes(yintercept=y),lty=2) +
    geom_hline(data = data.frame(y=0.6*0.8),aes(yintercept=y),lty=2) +
    geom_hline(data = data.frame(y=0),aes(yintercept=y),lty=2) +
    mytheme +
    scale_x_continuous(labels = c("0.1*SSBmsy","0.6*SSBmsy"),
                       breaks = c(SSBmsy*0.1,SSBmsy*0.6)) +
    scale_y_continuous(labels = c("Ftarget","Fmsy"),
                       breaks = c(0.6*0.8,0.6)) +
    xlab("SSB") + ylab("Fishing mortality") 
    
 
 
 
 
 
 
 
 
  
 