/****** SSMS の SelectTopNRows コマンドのスクリプト  ******/
SELECT TOP (1000) [Make]
      ,[Model]
      ,[Car Explanation]
      ,[Fuel Type]
      ,[Hybrid Type]
      ,[PlugIn]
      ,[Sales Volume]
  FROM [mishina].[dbo].[Car_Sales_New]

   
--NULL値をカウント

  SELECT COUNT(*) AS [Make_Null]
  FROM [mishina].[dbo].[Car_Sales_New]
  WHERE [Make] IS NULL 
  ;

--スペースをカウント
 
  SELECT COUNT(*) AS [Make_space]
  FROM [mishina].[dbo].[Car_Sales_New]
  WHERE [Make] = '' 
  ;

 --値なしセル合計をカウント 

  SELECT COUNT(*) AS [Make_non]
  FROM [mishina].[dbo].[Car_Sales_New]
  WHERE [Make] IS NULL OR [Make] = '' 
  ;
 

--各項目の値ありセルをカウント

  
  SELECT COUNT ([Make])
  -
  (
  SELECT COUNT(*) AS [Make_non]
  FROM [mishina].[dbo].[Car_Sales_New]
  WHERE [Make] =''
  )
  FROM [mishina].[dbo].[Car_Sales_New] 
  ;
  
     
--ユニーク値

 SELECT COUNT (DISTINCT [Make]) AS [Make]
 FROM [mishina].[dbo].[Car_Sales_New] 
 ;

--最小桁数
 
 SELECT LEN([Make]) AS [Make]
 FROM [mishina].[dbo].[Car_Sales_New] 
 ORDER BY LEN([Make]) ;   

 
--最大桁数

 SELECT LEN([Make]) AS [Make]
 FROM [mishina].[dbo].[Car_Sales_New] 
 ORDER BY LEN([Make]) DESC ;   


--最小値

 SELECT MIN ([Make]) AS [Make]
 FROM [mishina].[dbo].[Car_Sales_New] 
 ;
     

--最大値

 SELECT MAX ([Make]) AS [Make]
 FROM [mishina].[dbo].[Car_Sales_New] 
 ;
     