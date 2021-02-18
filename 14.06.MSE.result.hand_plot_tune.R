#13.00.MSE.result.handling
sim.year<-10
library(tidyverse)

mytheme<- theme(panel.background=element_rect(fill="white"),
                panel.grid.major=element_line(colour="gray80"),
                panel.grid.minor=element_line(colour="gray90"),
                axis.text.y = element_text(size=12),
                axis.text.x = element_text(size=12),
                axis.title = element_text(size=12))
source("13.00.MSE.result.hand.functions.R")
source("13.01.MSE.result.hand.functions.R")


# weight at age -----------------------------------------------------------

waa<-read_csv("waa.csv") 
waa<-t(waa)
waa<-waa*10^(-6)
waa.future<-waa
for(i in 1:(sim.year+1))waa.future<-cbind(waa.future,waa[,ncol(waa)])
colnames(waa.future)<-1973:(2016+(sim.year+1))
waa.future

Df.all<-data.frame()


# OM1 ---------------------------------------------------------------------

result.obj<-readRDS("2020-01-26BH_07_M05_sd.obj")
result.list1<-readRDS("h07_M05_SCAAh07_M05_tune.obj")
result.list2<-readRDS("h07_M05_SCAAh08_M05_tune.obj")
result.list3<-readRDS("h07_M05_SCAAh09_M05_tune.obj")
result.list4<-readRDS("h07_M05_SCAAh2_M05_tune.obj")
result.list5<-readRDS("h07_M05_SCAAh3_M05_tune.obj")
result.list6<-readRDS("h07_M05_VPA_M05_tune.obj")
SSB0<-result.obj$value[names(result.obj$value)=="SSB0"]

# Plot -----------------------------------------------------------------------


#variance
rs.df<-data.frame(matrix(NA,6,length(result.list),
                         dimnames=list(c(),paste("sim",1:length(result.list),sep=""))))

for(j in 1:6){
  result.list<-eval(parse(text = paste("result.list",j,sep = "")))
  Df.ssb<-make.df.ssb(result.list)
  
  rs.df[j,]<-apply(Df.ssb[which(Df.ssb$Year>=2017),1:(ncol(Df.ssb)-4)],2,function(x)mean(x/SSB0))[1:100]
}
rs.df$sc<-paste("MP",1:6,"\n",mpvec,sep="")

Df<-rs.df %>% 
  mutate_at(.,vars(sc),as.factor) %>% 
  gather(.,key=variable,value = value,-sc)
Df$OM<-"OM1"
Df.all<-rbind(Df.all,Df)

# OM2 ---------------------------------------------------------------------
result.obj<-readRDS("2020-01-15BH_08_M05_sd.obj")

result.list1<-readRDS("h08_M05_SCAAh07_M05_tune.obj")
result.list2<-readRDS("h08_M05_SCAAh08_M05_tune.obj")
result.list3<-readRDS("h08_M05_SCAAh09_M05_tune.obj")
result.list4<-readRDS("h08_M05_SCAAh2_M05_tune.obj")
result.list5<-readRDS("h08_M05_SCAAh3_M05_tune.obj")
result.list6<-readRDS("h08_M05_VPA_M05_tune.obj")
SSB0<-result.obj$value[names(result.obj$value)=="SSB0"]

# Plot -----------------------------------------------------------------------


#variance
rs.df<-data.frame(matrix(NA,6,length(result.list),
                         dimnames=list(c(),paste("sim",1:length(result.list),sep=""))))

for(j in 1:6){
  result.list<-eval(parse(text = paste("result.list",j,sep = "")))
  Df.ssb<-make.df.ssb(result.list)
  
  rs.df[j,]<-apply(Df.ssb[which(Df.ssb$Year>=2017),1:(ncol(Df.ssb)-4)],2,function(x)mean(x/SSB0))[1:100]
}
rs.df$sc<-paste("MP",1:6,"\n",mpvec,sep="")

Df<-rs.df %>% 
  mutate_at(.,vars(sc),as.factor) %>% 
  gather(.,key=variable,value = value,-sc)

Df$OM<-"OM2"
Df.all<-rbind(Df.all,Df)


# OM3 ---------------------------------------------------------------------

result.obj<-readRDS("2020-01-15BH_09_M05_sd.obj")
result.list1<-readRDS("h09_M05_SCAAh07_M05_tune.obj")
result.list2<-readRDS("h09_M05_SCAAh08_M05_tune.obj")
result.list3<-readRDS("h09_M05_SCAAh09_M05_tune.obj")
result.list4<-readRDS("h09_M05_SCAAh2_M05_tune.obj")
result.list5<-readRDS("h09_M05_SCAAh3_M05_tune.obj")
result.list6<-readRDS("h09_M05_VPA_M05_tune.obj")
SSB0<-result.obj$value[names(result.obj$value)=="SSB0"]

# Plot -----------------------------------------------------------------------


#variance
rs.df<-data.frame(matrix(NA,6,length(result.list),
                         dimnames=list(c(),paste("sim",1:length(result.list),sep=""))))

for(j in 1:6){
  result.list<-eval(parse(text = paste("result.list",j,sep = "")))
  Df.ssb<-make.df.ssb(result.list)
  
  rs.df[j,]<-apply(Df.ssb[which(Df.ssb$Year>=2017),1:(ncol(Df.ssb)-4)],2,function(x)mean(x/SSB0))[1:100]
}
rs.df$sc<-paste("MP",1:6,"\n",mpvec,sep="")

Df<-rs.df %>% 
  mutate_at(.,vars(sc),as.factor) %>% 
  gather(.,key=variable,value = value,-sc)

Df$OM<-"OM3"
Df.all<-rbind(Df.all,Df)


# OM4 ---------------------------------------------------------------------

result.obj<-readRDS("2020-01-15Rc_2_M05_sd.obj")
result.list1<-readRDS("h2_M05_SCAAh07_M05_tune.obj")
result.list2<-readRDS("h2_M05_SCAAh08_M05_tune.obj")
result.list3<-readRDS("h2_M05_SCAAh09_M05_tune.obj")
result.list4<-readRDS("h2_M05_SCAAh2_M05_tune.obj")
result.list5<-readRDS("h2_M05_SCAAh3_M05_tune.obj")
result.list6<-readRDS("h2_M05_VPA_M05_tune2.obj")
SSB0<-result.obj$value[names(result.obj$value)=="SSB0"]

# Plot -----------------------------------------------------------------------


#variance
rs.df<-data.frame(matrix(NA,6,length(result.list),
                         dimnames=list(c(),paste("sim",1:length(result.list),sep=""))))

for(j in 1:6){
  result.list<-eval(parse(text = paste("result.list",j,sep = "")))
  Df.ssb<-make.df.ssb(result.list)
  
  rs.df[j,]<-apply(Df.ssb[which(Df.ssb$Year>=2017),1:(ncol(Df.ssb)-4)],2,function(x)mean(x/SSB0))[1:100]
}
rs.df$sc<-paste("MP",1:6,"\n",mpvec,sep="")

Df<-rs.df %>% 
  mutate_at(.,vars(sc),as.factor) %>% 
  gather(.,key=variable,value = value,-sc)

Df$OM<-"OM4"
Df.all<-rbind(Df.all,Df)



# OM5 ---------------------------------------------------------------------

result.obj<-readRDS("2020-01-15Rc_3_M05_sd.obj")
result.list1<-readRDS("h3_M05_SCAAh07_M05_tune.obj")
result.list2<-readRDS("h3_M05_SCAAh08_M05_tune.obj")
result.list3<-readRDS("h3_M05_SCAAh09_M05_tune.obj")
result.list4<-readRDS("h3_M05_SCAAh2_M05_tune.obj")
result.list5<-readRDS("h3_M05_SCAAh3_M05_tune.obj")
result.list6<-readRDS("h3_M05_VPA_M05_tune.obj")
SSB0<-result.obj$value[names(result.obj$value)=="SSB0"]

# Plot -----------------------------------------------------------------------


#variance
rs.df<-data.frame(matrix(NA,6,length(result.list),
                         dimnames=list(c(),paste("sim",1:length(result.list),sep=""))))

for(j in 1:6){
  result.list<-eval(parse(text = paste("result.list",j,sep = "")))
  Df.ssb<-make.df.ssb(result.list)
  
  rs.df[j,]<-apply(Df.ssb[which(Df.ssb$Year>=2017),1:(ncol(Df.ssb)-4)],2,function(x)mean(x/SSB0))[1:100]
}
rs.df$sc<-paste("MP",1:6,"\n",mpvec,sep="")

Df<-rs.df %>% 
  mutate_at(.,vars(sc),as.factor) %>% 
  gather(.,key=variable,value = value,-sc)

Df$OM<-"OM5"
Df.all<-rbind(Df.all,Df)



# Plot --------------------------------------------------------------------

Df.all$OM
Df.all %>% 
  ggplot() + geom_boxplot(aes(x=sc,y=value,col=sc)) + mytheme +
  theme_bw() + theme(legend.position = "none",
                     axis.title.x = element_blank(),
                     axis.text.x = element_text(angle = 70,hjust = 1)) +
  ylab("Depletion") +
  facet_wrap(~OM)




