
library(xlsx)

# -------------------------------------------------------------------------

Data<-read.xlsx("../OUTPUT/temp.xlsx",sheetIndex = 1)
head(Data)
colnames(Data)[4]<-"nreceipt"

Data$DEAL_YMD<-as.Date(Data$DEAL_YMD)

plot(Data$DEAL_YMD,Data$nreceipt,type="l")


