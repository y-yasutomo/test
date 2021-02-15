
#non member
Data$member<-"非会員"

Data3<-Data

#member

Data$member<-"会員"

Data4<-Data

colnames(Data)
colnames(Data4)

Data<-rbind(Data3,Data4)
Data$MONTH<-as.character(Data$YR_MONTH)
Data$MONTH <- sapply(strsplit(Data$MONTH,"-"),function(x)x[2])
Data$YEAR <- sapply(strsplit(as.character(Data$YR_MONTH),"-"),function(x)x[1])

temp<-Data %>% filter(.,MONTH%in%c("01","02","03","04","05","06","07"))

temp$MONTH<-as.numeric(temp$MONTH)

Data$YEAR
a<-Data[Data$YEAR=="2020",]
b<-Data[Data$YEAR=="2019",]


tmp<- temp[temp$STORENAME=="みやき店",]

tmp<- temp %>% 
   group_by(.,YEAR,MONTH,member,STORENAME) %>% 
   summarise(.,am=sum(NON_MEMBER_SUM_SALES_AMOUNT)) 

tmp<-tmp[tmp$STORENAME=="みやき店",]

  
 ggplot() +
  geom_line(data=tmp[tmp$YEAR=="2019",],aes(x=MONTH, y=am,col=YEAR),size=1.2) +
   geom_line(data=tmp[tmp$YEAR=="2020",],aes(x=MONTH, y=am,col=YEAR),size=1.2) +
   geom_point(data=tmp[tmp$YEAR=="2019",],aes(x=MONTH, y=am,col=YEAR),size=1.7) +
   geom_point(data=tmp[tmp$YEAR=="2020",],aes(x=MONTH, y=am,col=YEAR),size=1.7) +
   facet_wrap(~member) +
   ylab("SUM_SALES_AMOUNT") 
 
  #geom_line(aes(x=MONTH, y=NON_MEMBER_SUM_SALES_AMOUNT),size=1.2) +
  
  geom_point(aes(x=YR_MONTH, y=NON_MEMBER_SUM_SALES_AMOUNT,group=member,
                 col=member),size=2) +
  facet_wrap(~YEAR) +
  theme(axis.text.x = element_text(angle = 45),
        axis.title.x = element_blank()) + ylab("購入金額") + ggtitle("店舗ごと会員購入金額")










