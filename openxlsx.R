
df<-openxlsx::read.xlsx("temp3.xlsx")
#df<-openxlsx::loadWorkbook("temp3.xlsx")
#文字化けるerror

NewWb <- createWorkbook()
addWorksheet(wb = NewWb, sheetName = "Sheet1")

#ウィンドウ枠の固定:freezePaneコマンド
#先頭行,列の固定:firstRowオプション,firstColオプション;初期値:FALSE
#範囲を指定し行,列の固定:firstActiveRowオプション,firstActiveColオプション
freezePane(wb = NewWb, sheet = 1,
           firstRow = TRUE, firstCol= FALSE)
writeData(wb = NewWb, sheet = 1, x = df)
Sheet1Style <- createStyle(border = "TopBottomLeftRight",
                           borderStyle = "thin",
                           borderColour = "black")

SheetStyle_header <- createStyle(fgFill = "red",
                                 border = "TopBottomLeftRight",
                                 borderStyle = "thin",
                                 borderColour = "black")

SheetStyle_header2 <- createStyle(fgFill = "blue",
                                  border = "TopBottomLeftRight",
                                  borderStyle = "thin",
                                  borderColour = "black")


addStyle(wb = NewWb, sheet = 1, style = SheetStyle_header,
         rows = 1, cols = 1:2, gridExpand = T)

addStyle(wb = NewWb, sheet = 1, style = SheetStyle_header2,
         rows = 1, cols = 3:ncol(df), gridExpand = T)

addStyle(wb = NewWb, sheet = 1, style = Sheet1Style,
         rows = 2:nrow(df), cols = 1:ncol(df), gridExpand = T)


addFilter(wb = NewWb, sheet = 1,rows = 1,cols = 1:ncol(df))

setColWidths(wb = NewWb, sheet = 1,
             cols = 1:ncol(df), widths = "auto")
#showGridLines(wb = NewWb, sheet = 1, showGridLines = FALSE)
saveWorkbook(wb = NewWb, file = "Test.xlsx", overwrite = TRUE)

