
library(XLConnect)
library(readxl)

Data <-loadWorkbook("Sampleheader.xlsx")
Data_val <- read_xlsx("sample.xlsx")

writeWorksheet(Data,Data_val,
               sheet = "Sheet1",startRow = 2,startCol = 1,
               header = F)
#XLConnect::saveWorkbook(Data,"temp.xlsx")
ncol(Data_val)

cst2 <- XLConnect::createCellStyle(Data)
setBorder(cst2 , side= c("all"),color=XLC$COLOR.BLACK, type=c(XLC$BORDER.THIN))

for(i in 2:(nrow(Data_val)+1)){
  for(j in 1:ncol(Data_val)){
    setCellStyle(Data,sheet="Sheet1", row= i , col= j , cellstyle = cst2)
  }
}

XLConnect::saveWorkbook(Data,"temp2.xlsx")

