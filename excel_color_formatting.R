library(readxl)
Data<-read_xlsx("Spec.xlsx",sheet = 2)


library(xlsx)


file <- "Spec.xlsx"
wb <- loadWorkbook(file)              # load workbook

border <- Border(color="black", position=c("BOTTOM","LEFT",
                                           "TOP", "RIGHT"),
                 pen="BORDER_THIN")


fo1 <- Fill(foregroundColor="orange")   # create fill object # 1
cs1 <- CellStyle(wb, fill=fo1,border = border)        # create cell style # 1
fo2 <- Fill(foregroundColor="#B593FFFF")
cs2 <- CellStyle(wb, fill=fo2,border = border)
fo3 <- Fill(foregroundColor="yellow")
cs3 <- CellStyle(wb, fill=fo3,border = border)        

sheets <- getSheets(wb)               # get all sheets
sheet <- sheets[["Sheet2"]]          # get specific sheet
rows <- getRows(sheet, rowIndex=2:(nrow(Data)+1))     # get rows
# 1st row is headers
cells <- getCells(rows, colIndex = 2:(ncol(Data)+1))         # get cells

# in the wb I import with loadWorkbook, numeric data starts in column 2
# The first column is row numbers.  The last column is "yes" and "no" entries, so
# we do not include them, thus we use colIndex = 2:cols

values <- lapply(cells, getCellValue) # extract the cell values

# find cells meeting conditional criteria > 5
highlightorange <- NULL
for (i in names(values)) {
  x <- as.numeric(values[i])
  if (x==1  && !is.na(x)) {
    highlightorange <- c(highlightorange, i)
  }    
}

highlightpurple <- NULL
for (i in names(values)) {
  x <- as.numeric(values[i])
  if (x == 2 && !is.na(x)) {
    highlightpurple <- c(highlightpurple, i)
  }    
}

highlightyellow <- NULL
for (i in names(values)) {
  x <- as.numeric(values[i])
  if (x == 3 && !is.na(x)) {
    highlightyellow <- c(highlightyellow, i)
  }    
}



# -------------------------------------------------------------------------

sheet <- sheets[["sheet1"]]
rows <- getRows(sheet, rowIndex=2:(nrow(Data)+1))     # get rows
# 1st row is headers
cells <- getCells(rows, colIndex = 2:(ncol(Data)+1))         # get cells
values <- lapply(cells, getCellValue) # extract the cell values


lapply(names(cells[highlightorange]),
       function(ii) setCellStyle(cells[[ii]], cs1))

lapply(names(cells[highlightpurple]),
       function(ii) setCellStyle(cells[[ii]], cs2))

lapply(names(cells[highlightyellow]),
       function(ii) setCellStyle(cells[[ii]], cs3))


saveWorkbook(wb, file)





