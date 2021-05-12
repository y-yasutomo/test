
--q13
 SELECT  *
 FROM [kensyu].[dbo].[practice]
 ;

 --check
 SELECT  *
 FROM [kensyu].[dbo].[practice]
 WHERE [name] NOT LIKE '% %' 
 ;

 BEGIN TRANSACTION ;
 UPDATE [kensyu].[dbo].[practice]
 SET [name] = '松本 正樹'
 WHERE [temp_no] = 6 
 ;

 SELECT  *
 FROM [kensyu].[dbo].[practice]
 WHERE [temp_no] = 6 
 ;
 COMMIT ;

 BEGIN TRANSACTION ;
 UPDATE [kensyu].[dbo].[practice]
 SET [name] = '中西 達也'
 WHERE [temp_no] = 18 
 ;
 SELECT  *
 FROM [kensyu].[dbo].[practice]
 WHERE [temp_no] = 18 
 ;

 UPDATE [kensyu].[dbo].[practice]
 SET [name] = '高野 亮'
 WHERE [temp_no] = 23 
 ;
 SELECT  *
 FROM [kensyu].[dbo].[practice]
 WHERE [temp_no] = 23
 ;
 COMMIT ;

 SELECT  
		SUBSTRING([name], 1, CHARINDEX(' ',[name]) - 1 ) as fname
		--LEFT([name],IIF(CHARINDEX(' ',[name]) = 0,1,CHARINDEX(' ',[name])-1)) as fname
		--,CHARINDEX(' ',[name]) as idx
		,[name]
 FROM [kensyu].[dbo].[practice]
 ;

 BEGIN TRANSACTION ;
 
 UPDATE [kensyu].[dbo].[practice]
 SET [kensyu].[dbo].[practice].[family_name] = t2.[fname]
 FROM [kensyu].[dbo].[practice] as t1
 INNER JOIN (
	 SELECT  
		SUBSTRING([name], 1, CHARINDEX(' ',[name]) - 1 ) as fname
		,[temp_no]
	FROM [kensyu].[dbo].[practice]
 ) as t2
ON t1.[temp_no] = t2.[temp_no]
;

SELECT [family_name],[name]
FROM [kensyu].[dbo].[practice] 

ROLLBACK ;

-- given name
BEGIN TRANSACTION ;
/*
SELECT  
	[name]
	,RIGHT([name], LEN([name]) - CHARINDEX(' ',[name])) as gname
	,[temp_no]
FROM [kensyu].[dbo].[practice]
*/

 UPDATE [kensyu].[dbo].[practice]
 SET [kensyu].[dbo].[practice].[given_name] = t2.[gname]
 FROM [kensyu].[dbo].[practice] as t1
 INNER JOIN (
	SELECT  
		[name]
		,RIGHT([name], LEN([name]) - CHARINDEX(' ',[name])) as gname
		,[temp_no]
	FROM [kensyu].[dbo].[practice]
 ) as t2
ON t1.[temp_no] = t2.[temp_no]
;

SELECT [given_name],[name]
FROM [kensyu].[dbo].[practice] 
;
ROLLBACK ;

--q14
SELECT 
	[name]
	,[japanese]
	,[math]
	,[science]
	,[society]
	,[english]
FROM [kensyu].[dbo].[practice] 
WHERE 
	[science] >= (SELECT AVG([science]) FROM [kensyu].[dbo].[practice])
	AND [japanese] >= (SELECT AVG([japanese]) FROM [kensyu].[dbo].[practice])
	AND [math] >= (SELECT AVG([math]) FROM [kensyu].[dbo].[practice])
	AND [society] >= (SELECT AVG([society]) FROM [kensyu].[dbo].[practice])
	AND [english] >= (SELECT AVG([english]) FROM [kensyu].[dbo].[practice])
;


--q15
exec sp_columns @table_name = [取得するテーブル名]

SELECT TOP 1
	[name]
	,ABS(([japanese] + [society] + [english])/3 - ([math] + [science])/2) as diff
	,([japanese] + [society] + [english])/3 as b_val
	,([math] + [science])/2 as r_val
FROM [kensyu].[dbo].[practice] 
ORDER BY diff desc
;

--q16
SELECT
	t1.[name]
	,t1.[class]
	,t1.[english]
FROM [kensyu].[dbo].[practice] as t1
INNER JOIN (
	SELECT 
		MAX(english) as eng
		,[class]
	FROM [kensyu].[dbo].[practice]
	GROUP BY [class]
) as t2
ON t1.[english] = t2.[eng]
AND t1.[class] = t2.[class]
ORDER BY t1.[class]
;


SELECT
	t1.[name]
	,t1.[class]
	,t1.[english]
FROM [kensyu].[dbo].[practice] as t1
INNER JOIN (
	SELECT
		[temp_no]
		,[class]
		,RANK() OVER(PARTITION BY [class] ORDER BY [english] DESC) as rnk
	FROM [kensyu].[dbo].[practice]
) as t2
ON t1.[temp_no] = t2.[temp_no]
WHERE t2.rnk = 1 
ORDER BY [class]
;

