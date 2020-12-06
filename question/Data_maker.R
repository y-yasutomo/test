library(xlsx)
library(dplyr)
# sample data -------------------------------------------------------------

alphabet<-c("A","B","C","D","E","Z")
number<-c("0","1","2","3","4","5","6","7","8","9")

bunrui<-c("分類1","分類2","分類3","分類4","分類5")

Master<-data.frame(matrix(NA,100,3,
                       dimnames = list(c(),c("品目コード","名称","分類"))))

rand<-c(alphabet,number)

set.seed(2021)
temp<-character()
temp2<-character()

for(i in 1:100){
  temp[i]<-paste(paste(sort(sample(rand,4),decreasing = T),collapse = ""),
        paste(sample(number,8),collapse = ""),sep="-")
  temp2[i]<-sample(bunrui,1)
  
}
length(unique(temp))

Master$品目コード<-temp
Master$分類<-temp2

#write.xlsx(Master,"Master_prev.xlsx",row.names = F)



#transaction -------------------------------------------------------------------------

tran<-data.frame(matrix(NA,1000,2,
                          dimnames = list(c(),c("購入日","品目コード"))))

today<-Sys.Date()
today<-as.Date("2020-12-06")
class(today)

#prevMaxdate<- today - 150
diffdate<-sample(1:500,1000,replace = T)
purchase<-sample(Master$品目コード,1000,replace = T)

tran$購入日<-sort(today-diffdate)
tran$品目コード<-purchase

temp<-tran %>% inner_join(.,Master,by=c("品目コード"))

table(temp$分類)
sum(table(temp$分類))

#write.xlsx(tran,"purchase_prev.xlsx",row.names = F)


#purcahse update -------------------------------------------------------------------------

tran.new<-data.frame(matrix(NA,500,2,
                        dimnames = list(c(),c("購入日","品目コード"))))

diffdate<-sample(1:500,500,replace = T)
purchase<-sample(Master$品目コード,500,replace = T)

tran.new$購入日<-sort(today+diffdate)
tran.new$品目コード<-purchase

#write.xlsx(tran.new,"purchase_update.xlsx",row.names = F)

temp2<-tran.new %>% inner_join(.,Master,by=c("品目コード"))

table(temp2$分類)
sum(table(temp2$分類))


#union -------------------------------------------------------------------------

tran.update<-rbind(tran,tran.new)
temp3<-tran.update %>% inner_join(.,Master,by=c("品目コード"))
table(temp3$分類)
sum(table(temp3$分類))



#master update -------------------------------------------------------------------------

#update_vec<-c(20,24,31,32,44,45,53,54,57,83)
update_vec<-c(20,24,31,32,44,45,53,54,57,83)
Master$分類[update_vec]
#old
#c("分類3","分類4","分類2","分類1","分類4","分類5","分類4","分類1","分類2","分類3")

#answer
#sort(Master$品目コード[update_vec])

#update

Master$分類_new<-Master$分類
Master$分類_new[update_vec]<-c("分類1","分類2","分類3","分類4","分類5","分類1","分類2","分類3","分類4","分類5")

Master <-Master %>%  select(.,-分類)
colnames(Master)[3]<-"分類"

#write.xlsx(Master,"Master_update.xlsx",row.names = F)


temp4<-tran %>% inner_join(.,Master,by=c("品目コード"))

table(temp4$分類)
table(temp4$分類_new)

temp4$品目コード%in%Master$品目コード[update_vec]

update.purchased<-temp4[which(temp4$品目コード%in%Master$品目コード[update_vec]),]

table(update.purchased$分類)
table(update.purchased$分類_new)

#distinct(update.purchased,品目コード,,分類,分類_new)
#answer
tmp<-distinct(update.purchased,品目コード,分類,分類_new)
sort(tmp$品目コード)
#roenumber
which(Master$品目コード%in%sort(tmp$品目コード))





