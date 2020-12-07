
a<-Sys.time()

Time<-strsplit(as.character(a)," ")[[1]][2]
Hour<-strsplit(as.character(Time),":")[[1]][1]
Min<-strsplit(as.character(Time),":")[[1]][2]
Min<-as.numeric(Min)

DateMat<-read.csv("C:/Users/sskai/Desktop/temp/format.csv")

DateMat$Date<-as.character(DateMat$Date)
DateMat$sTime<-as.character(DateMat$sTime)
DateMat$eTime<-as.character(DateMat$eTime)

if(DateMat$eTime[nrow(DateMat)]==""){
  if(Min%in%c(0,15,30,45))Min<-Min+1
  while(!(Min%in%c(0,15,30,45))){
    Min<-Min-1 
  }
  stTime<-paste(Hour,Min,sep=":")
  if(Min==0)stTime<-paste0(stTime,"0")
  DateMat$eTime[length(DateMat$eTime)]<-as.character(stTime)
}else{
  if(Min%in%c(0,15,30,45))Min<-Min+1
  while(!(Min%in%c(0,15,30,45))){
    Min<-Min+1 
  }
  stTime<-paste(Hour,Min,sep=":")
  if(Min==0)stTime<-paste0(stTime,"0")
  DateMat<-rbind(DateMat,c(as.character(as.Date(a)),as.character(stTime),""))
}

write.csv(DateMat,"C:/Users/sskai/Desktop/temp/format.csv",row.names = F)

