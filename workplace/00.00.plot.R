
library(readxl)
library(tidyverse)

Data <- read_xlsx("エンジニア2020の会提供データ.xlsx",sheet = "monthly_member_purchase")
Data
colnames(Data)

#店舗ごと月ごと会員購買回数 -------------------------------------------------------------------------

Data <- read_xlsx("エンジニア2020の会提供データ.xlsx",sheet = "monthly_member_purchase")
temp<-substr(as.character(Data$YR_MONTH),1,7)

Data$YR_MONTH <- factor(temp,
                        levels = unique(temp))

Data %>% ggplot() +
  geom_line(aes(x=YR_MONTH, y=MEMBER_PURCHASE_COUNT,group=STORENAME,
                col=STORENAME),size=1.2) +
  geom_point(aes(x=YR_MONTH, y=MEMBER_PURCHASE_COUNT,group=STORENAME,
                 col=STORENAME),size=2) +
  theme(axis.text.x = element_text(angle = 45),
        axis.title.x = element_blank()) + ylab("購買回数") + ggtitle("店舗ごと会員購買回数")


#店舗ごと月ごと購入金額 -------------------------------------------------------------------------

#member only
Data %>% ggplot() +
  geom_line(aes(x=YR_MONTH, y=MEMBER_SUM_SALES_AMOUNT,group=STORENAME,
                col=STORENAME),size=1.2) +
  geom_point(aes(x=YR_MONTH, y=MEMBER_SUM_SALES_AMOUNT,group=STORENAME,
                 col=STORENAME),size=2) +
  theme(axis.text.x = element_text(angle = 45),
        axis.title.x = element_blank()) + ylab("購入金額") + ggtitle("店舗ごと会員購入金額")

#non member


#all
Data %>% ggplot() +
  geom_line(aes(x=YR_MONTH, y=SUM_SALES_AMOUNT,group=STORENAME,
                col=STORENAME),size=1.2) +
  geom_point(aes(x=YR_MONTH, y=SUM_SALES_AMOUNT,group=STORENAME,
                 col=STORENAME),size=2) +SSSA
  theme(axis.text.x = element_text(angle = 45),
        axis.title.x = element_blank()) + ylab("購入金額") + ggtitle("店舗ごと購入金額")


#性別ごと店舗ごと月ごと購入金額会員） -------------------------------------------------------------------------

Data <- read_xlsx("エンジニア2020の会提供データ.xlsx",sheet = "monthly_member_purchase_div_sex")
temp<-substr(as.character(Data$YR_MONTH),1,7)

Data$YR_MONTH <- factor(temp,
                        levels = unique(temp))
Data$SEX <-factor(Data$SEX,levels = c("男性","女性","不明"))

Data %>% ggplot() +
  geom_line(aes(x=YR_MONTH, y=MEMBER_PURCHASE,group=SEX,
                col=SEX),size=1.2) +
  geom_point(aes(x=YR_MONTH, y=MEMBER_PURCHASE,group=SEX,
                 col=SEX),size=1.8) +
  facet_wrap(~STORENAME) +
  theme(axis.text.x = element_text(angle = 90, size = 5),
        axis.title.x = element_blank()) + ylab("会員購入数") + ggtitle("性別ごと購買回数")







