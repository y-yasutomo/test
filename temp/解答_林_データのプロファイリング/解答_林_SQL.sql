/****** SSMS の SelectTopNRows コマンドのスクリプト  ******/
SELECT TOP (1000) [Make]
      ,[Model]
      ,[Car Explanation]
      ,[Fuel Type]
      ,[Hybrid Type]
      ,[PlugIn]
      ,[Sales Volume]
  FROM [hayashi].[dbo].[Car_Sales_New]



  --NULL値の数
  SELECT  COUNT(*) - COUNT([Make])
  FROM [hayashi].[dbo].[Car_Sales_New]
  ;

 

  --ブランク＆スペースの数
  select COUNT([Make])
  FROM [hayashi].[dbo].[Car_Sales_New]
  WHERE [Make] = ''
  ;


  --NULL + ブランク＆スペース
  SELECT  COUNT(*)
  FROM [hayashi].[dbo].[Car_Sales_New]
  WHERE [Make] = ''
  OR [Make] IS NULL
  ;


  --値あり件数
  SELECT COUNT([Make])
  FROM [hayashi].[dbo].[Car_Sales_New]
  WHERE NOT  [Make] = ''
  ;


  --ユニーク数
  SELECT COUNT(DISTINCT [Make])
  FROM [hayashi].[dbo].[Car_Sales_New]
  WHERE NOT  [Make] = ''
  ;


  --最小桁数
  SELECT TOP 1
		LEN([Make])
  FROM [hayashi].[dbo].[Car_Sales_New]
  WHERE NOT  [Make] = ''
  ORDER BY LEN([Make]) ASC
  ;


   --最大桁数
  SELECT TOP 1
		LEN([Make])
  FROM [hayashi].[dbo].[Car_Sales_New]
  WHERE NOT  [Make] = ''
  ORDER BY LEN([Make]) DESC
  ;


  --最小値
  SELECT TOP 1
		[Make]
  FROM [hayashi].[dbo].[Car_Sales_New]
  WHERE NOT  [Make] = ''
  ORDER BY [Make] ASC
  ;



   --最大値
  SELECT TOP 1
		[Make]
  FROM [hayashi].[dbo].[Car_Sales_New]
  WHERE NOT  [Make] = ''
  ORDER BY [Make] DESC
  ;

 