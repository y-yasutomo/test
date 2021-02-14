
library(readxl)
library(tidyverse)

colnames(Data)

#店舗ごと月ごと会員購買回数 -------------------------------------------------------------------------

Data <- read_csv("sales_cnt.csv")
colnames(Data)
head(Data)

temp<-substr(as.character(Data$DEAL_YMD),1,7)

Data$YR_MONTH <- factor(temp,
                        levels = unique(temp))

Data<-Data %>% group_by(.,STORENAME,YR_MONTH) %>% 
  summarise(MEMBER_PURCHASE_COUNT=sum(MEMBER_MEMBER_PURCHASE_CNT))

head(Data)
  
Data %>% ggplot() +
  geom_line(aes(x=YR_MONTH, y=MEMBER_PURCHASE_COUNT,group=STORENAME,
                col=STORENAME),size=1.2) +
  geom_point(aes(x=YR_MONTH, y=MEMBER_PURCHASE_COUNT,group=STORENAME,
                 col=STORENAME),size=2) +
  theme(axis.text.x = element_text(angle = 45),
        axis.title.x = element_blank()) + ylab("購買回数") + ggtitle("店舗ごと会員購買回数")


#店舗ごと月ごと購入金額 -------------------------------------------------------------------------


#non member

Data <- read_csv("nonmember_sum_amount.csv")
temp<-substr(as.character(Data$DEAL_YMD),1,7)
Data$YR_MONTH <- factor(temp,
                        levels = unique(temp))

Data<-Data %>% group_by(.,STORENAME,YR_MONTH) %>% 
  summarise(NON_MEMBER_SUM_SALES_AMOUNT=sum(SUM_SALSE))

Data %>% ggplot() +
  geom_line(aes(x=YR_MONTH, y=NON_MEMBER_SUM_SALES_AMOUNT,group=STORENAME,
                col=STORENAME),size=1.2) +
  geom_point(aes(x=YR_MONTH, y=NON_MEMBER_SUM_SALES_AMOUNT,group=STORENAME,
                 col=STORENAME),size=2) +
  theme(axis.text.x = element_text(angle = 45),
        axis.title.x = element_blank()) + ylab("購入金額") + ggtitle("店舗ごと非会員購入金額")


#member
Data <- read_csv("sales_amount.csv")
temp<-substr(as.character(Data$DEAL_YMD),1,7)
Data$YR_MONTH <- factor(temp,
                        levels = unique(temp))

Data<-Data %>% group_by(.,STORENAME,YR_MONTH) %>% 
  summarise(NON_MEMBER_SUM_SALES_AMOUNT=sum(SUM_SALSE))

Data %>% ggplot() +
  geom_line(aes(x=YR_MONTH, y=NON_MEMBER_SUM_SALES_AMOUNT,group=STORENAME,
                col=STORENAME),size=1.2) +
  geom_point(aes(x=YR_MONTH, y=NON_MEMBER_SUM_SALES_AMOUNT,group=STORENAME,
                 col=STORENAME),size=2) +
  theme(axis.text.x = element_text(angle = 45),
        axis.title.x = element_blank()) + ylab("購入金額") + ggtitle("店舗ごと会員購入金額")



#all

Data <- read_csv("sum_amount_all.csv")
temp<-substr(as.character(Data$DEAL_YMD),1,7)
Data$YR_MONTH <- factor(temp,
                        levels = unique(temp))

Data<-Data %>% group_by(.,STORENAME,YR_MONTH) %>% 
  summarise(ALL_SUM_SALES_AMOUNT=sum(SUM_SALSE))

Data %>% ggplot() +
  geom_line(aes(x=YR_MONTH, y=ALL_SUM_SALES_AMOUNT,group=STORENAME,
                col=STORENAME),size=1.2) +
  geom_point(aes(x=YR_MONTH, y=ALL_SUM_SALES_AMOUNT,group=STORENAME,
                 col=STORENAME),size=2) +
theme(axis.text.x = element_text(angle = 45),
      axis.title.x = element_blank()) + ylab("購入金額") + ggtitle("店舗ごと購入金額")


#性別ごと店舗ごと月ごと購入金額会員） -------------------------------------------------------------------------


Data <- read_csv("store_day_sex.csv")
colnames(Data)
temp<-substr(as.character(Data$DEAL_YMD),1,7)
Data$YR_MONTH <- factor(temp,
                        levels = unique(temp))

Data<-Data %>% group_by(.,STORENAME,YR_MONTH,SEX) %>% 
  summarise(MEMBER_PURCHASE_CNT=sum(MEMBER_PURCHASE_CNT))
head(Data)

Data$SEX <-factor(Data$SEX,levels = c("男性","女性","不明"))

Data %>% ggplot() +
  geom_line(aes(x=YR_MONTH, y=MEMBER_PURCHASE_CNT,group=SEX,
                col=SEX),size=1.2) +
  geom_point(aes(x=YR_MONTH, y=MEMBER_PURCHASE_CNT,group=SEX,
                 col=SEX),size=1.8) +
  facet_wrap(~STORENAME) +
  theme(axis.text.x = element_text(angle = 90, size = 5),
        axis.title.x = element_blank()) + ylab("会員購入数") + ggtitle("性別ごと購買回数")

Data %>% group_by(.,STORENAME,YR_MONTH) %>% 
  summarise(MEMBER_PURCHASE_CNT=sum(MEMBER_PURCHASE_CNT))





