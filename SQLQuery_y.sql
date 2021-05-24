/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Make]
      ,[Model]
      ,[Car Explanation]
      ,[Fuel Type]
      ,[Hybrid Type]
      ,[PlugIn]
      ,[Sales Volume]
  FROM [kensyu].[dbo].[car]

--NULL
SELECT COUNT(*)
FROM [kensyu].[dbo].[car]
WHERE [Make] IS NULL
;

--blank
SELECT COUNT(*)
FROM [kensyu].[dbo].[car]
WHERE [Make] = ''
;

--unique数

--これはダメ
SELECT COUNT(DISTINCT([Make])) as unique_cnt
FROM [kensyu].[dbo].[car]
;

--distinctのみで実行
SELECT DISTINCT([Make])
FROM [kensyu].[dbo].[car]
;

--サブクエリを使う
--COUNT(*) ならNULLも含めたデータ全件を返す

SELECT COUNT(*)
FROM (
	SELECT DISTINCT([Make])
	FROM [kensyu].[dbo].[car]
) as temp
;


--len,min,max
SELECT 
	MIN(LEN([Make])) as minlen
	,MAX(LEN([Make])) as maxlen
	,MIN([Make]) as minval
	,MAX([Make]) as maxval
FROM [kensyu].[dbo].[car]
;

--
/*
Car Explanation
Fuel Type
Hybrid Type
PlugIn
Sales Volume
*/

--NULL
SELECT COUNT(*)
FROM [kensyu].[dbo].[car]
WHERE [Model] IS NULL
;

--blank
SELECT COUNT(*)
FROM [kensyu].[dbo].[car]
WHERE [Model] = ''
;

--unique
SELECT COUNT(DISTINCT([Model]))
FROM [kensyu].[dbo].[car]
;

--len,min,max
SELECT 
	MIN(LEN([Model])) as minlen
	,MAX(LEN([Model])) as maxlen
	,MIN([Model]) as minval
	,MAX([Model]) as maxval
FROM [kensyu].[dbo].[car]
;

--len
SELECT [Make],LEN([Make]) AS [Make]
FROM [kensyu].[dbo].[car]
ORDER BY LEN([Make]) ;   

SELECT --TOP 1
		[Make],LEN([Make])
FROM [kensyu].[dbo].[car]
WHERE NOT  [Make] = '' 
ORDER BY LEN([Make]) ASC
;

SELECT [Make],LEN([Make]) AS [Make]
FROM [kensyu].[dbo].[car]
where [Make] is not null  
ORDER BY LEN([Make]) ;   

SELECT [Make],LEN([Make]) AS [Make]
FROM [kensyu].[dbo].[car]
WHERE NOT  [Make] = ''
ORDER BY LEN([Make]) asc ;   



with temp as (
 SELECT ' ' as c1, '　' as c2 
)
select *
from temp
where c2 = ''
;
