

#non member

Data <- read_csv("nonmember_sum_amount.csv")
temp<-substr(as.character(Data$DEAL_YMD),1,7)
Data$YR_MONTH <- factor(temp,
                        levels = unique(temp))

Data<-Data %>% group_by(.,STORENAME,YR_MONTH) %>% 
  summarise(NON_MEMBER_SUM_SALES_AMOUNT=sum(SUM_SALSE))

head(Data)

#all
Data %>% #filter(.,STORENAME%in%c("アイランドシティ店","寝屋川大成店","出雲白枝店")) %>% 
  ggplot() +
  geom_line(aes(x=YR_MONTH, y=NON_MEMBER_SUM_SALES_AMOUNT,group=STORENAME,
                col=STORENAME),size=1.2) +
  geom_point(aes(x=YR_MONTH, y=NON_MEMBER_SUM_SALES_AMOUNT,group=STORENAME,
                 col=STORENAME),size=2) +
  theme(axis.text.x = element_text(angle = 90,vjust = 0.5),
        axis.title.x = element_blank()) + ylab("購入金額") + ggtitle("店舗ごと非会員購入金額")+
  facet_wrap(~STORENAME)


#extract
#アイランド多い
#出雲少ない　地域

Data %>% filter(.,STORENAME%in%c("アイランドシティ店","出雲白枝店")) %>% 
  ggplot() +
  geom_line(aes(x=YR_MONTH, y=NON_MEMBER_SUM_SALES_AMOUNT,group=STORENAME,
                col=STORENAME),size=1.2) +
  geom_point(aes(x=YR_MONTH, y=NON_MEMBER_SUM_SALES_AMOUNT,group=STORENAME,
                 col=STORENAME),size=2) +
  theme(axis.text.x = element_text(angle =90,vjust = 0.5))

        

#covid
covid<-read_csv("../covid_cases/nhk_news_covid19_prefectures_daily_data.csv") %>% 
  select(.,1:4)
table(covid$都道府県名)

colnames(covid)<-c("Date","preCode","prefecture","incidents")

if(F){
temp<-covid %>% filter(.,prefecture=="島根県")
temp$yrmonth<-sapply(strsplit(temp$date,"/"),function(x)paste(x[[1]],x[[2]],sep="-"))

temp2 <- temp %>% group_by(yrmonth) %>% 
  summarise(SUM = sum(incidents))


temp<-covid %>% filter(.,prefecture=="福岡県")
temp$yrmonth<-sapply(strsplit(temp$date,"/"),function(x)paste(x[[1]],x[[2]],sep="-"))

temp2 <- temp %>% group_by(yrmonth) %>% 
  summarise(SUM = sum(incidents))
}

temp<-covid %>% filter(.,prefecture%in%c("島根県","福岡県"))
temp$yrmonth<-sapply(strsplit(temp$Date,"/"),function(x)paste(x[[1]],x[[2]],sep="-"))
temp$yrmonth<-factor(temp$yrmonth,levels = c(paste0("2020-",1:12),"2021-1"))

temp2 <- temp %>% group_by(yrmonth,prefecture) %>% 
  summarise(SUM = sum(incidents))
  
temp2 %>% 
  filter(.,!yrmonth%in%c("2020-8","2020-9","2020-9","2020-10","2020-11","2020-12","2021-1")) %>% 
  ggplot() +
  geom_line(aes(x=yrmonth, y=SUM,group=prefecture),size=1.2) +
  geom_point(aes(x=yrmonth, y=SUM,group=prefecture),size=2) + 
  facet_wrap(~prefecture,scales = "free") +
  ylab("感染者数") + xlab("年月")



#上記店舗の会員での結果も見ておく -------------------------------------------------------------------------

#member
Data <- read_csv("sales_amount.csv")
temp<-substr(as.character(Data$DEAL_YMD),1,7)
Data$YR_MONTH <- factor(temp,
                        levels = unique(temp))

Data<-Data %>% group_by(.,STORENAME,YR_MONTH) %>% 
  summarise(NON_MEMBER_SUM_SALES_AMOUNT=sum(SUM_SALSE))

Data %>% filter(.,STORENAME%in%c("アイランドシティ店","寝屋川大成店","出雲白枝店")) %>% 
  ggplot() +
  geom_line(aes(x=YR_MONTH, y=NON_MEMBER_SUM_SALES_AMOUNT,group=STORENAME,
                col=STORENAME),size=1.2) +
  geom_point(aes(x=YR_MONTH, y=NON_MEMBER_SUM_SALES_AMOUNT,group=STORENAME,
                 col=STORENAME),size=2) +
  theme(axis.text.x = element_text(angle = 45),
        axis.title.x = element_blank()) + ylab("購入金額") + ggtitle("店舗ごと会員購入金額")


#購買回数 -------------------------------------------------------------------------


