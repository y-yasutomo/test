/****** SSMS の SelectTopNRows コマンドのスクリプト  ******/
SELECT TOP (1000) [temp_no]
      ,[class_no]
      ,[name]
      ,[family_name]
      ,[given_name]
      ,[reading]
      ,[year]
      ,[class]
      ,[japanese]
      ,[math]
      ,[science]
      ,[society]
      ,[english]
      ,[sum]
      ,[ave]
  FROM [yasuhara].[dbo].[practice]

SELECT [name]
           ,SUBSTRING([name],1,CHARINDEX(' ',[name]) - 1) AS sei
FROM [yasuhara].[dbo].[practice]
;

--半角スペースなしの場合は「0」となって返ってくる
SELECT [name]
           ,CHARINDEX(' ',[name]) AS sei
FROM [yasuhara].[dbo].[practice]
;

--subtringの第二引数に0を指定
SELECT [name]
           ,SUBSTRING([name],1,CHARINDEX(' ',[name])) AS sei
		   --,SUBSTRING([name],1,1) AS sei2
FROM [yasuhara].[dbo].[practice]
;


SELECT CHARINDEX(' ','aa bb cc',4) ;
