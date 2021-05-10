/****** Script for SelectTopNRows command from SSMS  ******/
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
  FROM [kensyu].[dbo].[practice]

--Q7
--各項目の最大値最小値,充足率

--MIN
  SELECT 
	MIN([temp_no]) as minval
	,MIN([class_no]) as min_class_no
	,MIN([name]) as min_name
	,MIN([family_name]) as min_family_name
	,MIN([given_name]) as min_given_name
	,MIN([reading]) as min_reading
	,MIN([year]) as min_year
	,MIN([class]) as min_class
	,MIN([japanese]) as min_japanese
	,MIN([math]) as min_math
	,MIN([science]) as min_science
	,MIN([society]) as min_society
	,MIN([english]) as min_english
	,MIN([sum]) as min_sum
	,MIN([ave]) as min_ave
  FROM [kensyu].[dbo].[practice]
  ;

  --MAX
  SELECT 
	MAX([temp_no]) as MAXval
	,MAX([class_no]) as MAX_class_no
	,MAX([name]) as MAX_name
	,MAX([family_name]) as MAX_family_name
	,MAX([given_name]) as MAX_given_name
	,MAX([reading]) as MAX_reading
	,MAX([year]) as MAX_year
	,MAX([class]) as MAX_class
	,MAX([japanese]) as MAX_japanese
	,MAX([math]) as MAX_math
	,MAX([science]) as MAX_science
	,MAX([society]) as MAX_society
	,MAX([english]) as MAX_english
	,MAX([sum]) as MAX_sum
	,MAX([ave]) as MAX_ave
  FROM [kensyu].[dbo].[practice]
  ;
  
  --cnt
  
SELECT
	1.0*(COUNT(*)-COUNT([temp_no]))/COUNT(*) as cnt_temp_no
	,1.0*(COUNT(*)-COUNT([class_no]))/COUNT(*) as cnt_class_no
	,1.0*(COUNT(*)-COUNT([name]))/COUNT(*) as cnt_name
	,1.0*(COUNT(*)-COUNT([family_name]))/COUNT(*) as cnt_family_name
	,1.0*(COUNT(*)-COUNT([given_name]))/COUNT(*) as cnt_given_name
	,1.0*(COUNT(*)-COUNT([reading]))/COUNT(*) as cnt_reading
	,1.0*(COUNT(*)-COUNT([year]))/COUNT(*) as cnt_year
	,1.0*(COUNT(*)-COUNT([class]))/COUNT(*) as cnt_class
	,1.0*(COUNT(*)-COUNT([japanese]))/COUNT(*) as cnt_japanese
	,1.0*(COUNT(*)-COUNT([math]))/COUNT(*) as cnt_math
	,1.0*(COUNT(*)-COUNT([science]))/COUNT(*) as cnt_science
	,1.0*(COUNT(*)-COUNT([society]))/COUNT(*) as cnt_society
	,1.0*(COUNT(*)-COUNT([english]))/COUNT(*) as cnt_english
	,1.0*(COUNT(*)-COUNT([sum]))/COUNT(*) as cnt_sum
	,1.0*(COUNT(*)-COUNT([ave]))/COUNT(*) as cnt_ave
  FROM [kensyu].[dbo].[practice]
  ;

  select 
	(200 - 199)*100/200 as 全件200 -- 1/200件がNULL
	,(100 - 99)*100/100 全件100 -- 1/100件がNULL:OK
	,((10-9))*100/10 全件10 -- 1/10件がNULL:OK
	,((50-49))*100/50 全件50 --今回の数:OK
;

  select 
	(200 - 180)*100/200 as 全件200 --
;

  --------------------
 /*
SELECT
	(COUNT(*)-COUNT([temp_no]))/COUNT(*) as cnt_temp_no
	,(COUNT(*)-COUNT([class_no]))/COUNT(*) as cnt_class_no
	,(COUNT(*)-COUNT([name]))/COUNT(*) as cnt_name
	,(COUNT(*)-COUNT([family_name]))/COUNT(*) as cnt_family_name
	,(COUNT(*)-COUNT([given_name]))/COUNT(*) as cnt_given_name
	,(COUNT(*)-COUNT([reading]))/COUNT(*) as cnt_reading
	,(COUNT(*)-COUNT([year]))/COUNT(*) as cnt_year
	,(COUNT(*)-COUNT([class]))/COUNT(*) as cnt_class
	,(COUNT(*)-COUNT([japanese]))/COUNT(*) as cnt_japanese
	,(COUNT(*)-COUNT([math]))/COUNT(*) as cnt_math
	,(COUNT(*)-COUNT([science]))/COUNT(*) as cnt_science
	,(COUNT(*)-COUNT([society]))/COUNT(*) as cnt_society
	,(COUNT(*)-COUNT([english]))/COUNT(*) as cnt_english
	,(COUNT(*)-COUNT([sum]))/COUNT(*) as cnt_sum
	,(COUNT(*)-COUNT([ave]))/COUNT(*) as cnt_ave
  FROM [kensyu].[dbo].[practice]
  ;
*/
--Q8
  SELECT *
  FROM [kensyu].[dbo].[practice]
  ;

  SELECT 
	[class]
	,ROUND(AVG([sum]),1) AS [calss_ave]
  FROM [kensyu].[dbo].[practice]
  GROUP BY [class]
  ORDER BY [calss_ave] DESC
  ;

--Q9
  SELECT TOP (5)
    [name]
	,[math]
  FROM [kensyu].[dbo].[practice]
  WHERE [class] = 3
  ORDER BY [math] DESC
  ;

--Q10
  SELECT
    [name]
	,[math] + [science] as [r_score]
  FROM [kensyu].[dbo].[practice]
  WHERE [math] + [science] >= 160
  ORDER BY [r_score] DESC
  ;

 --Q10 これはエラー
  SELECT
    [name]
	,[math] + [science] as [r_score]
  FROM [kensyu].[dbo].[practice]
  WHERE [r_score] >= 160
  ORDER BY [r_score] DESC
  ;


--Q11
--case
  SELECT
	*
	,CASE WHEN [sum] >= 370 THEN '☆' ELSE NULL END AS star
  FROM [kensyu].[dbo].[practice]
  ;

 --iif
  SELECT
	*
	,IIF([sum] >= 370, '☆', NULL) AS star
  FROM [kensyu].[dbo].[practice]
  ;

--join
  SELECT
	main.*
	,[temp].[star]
  FROM [kensyu].[dbo].[practice] AS main
  LEFT OUTER JOIN (
	SELECT [temp_no] 
			,'☆' as star 
    FROM [kensyu].[dbo].[practice]
	WHERE [sum] >= 370 
  ) AS [temp] 
  ON main.[temp_no] = temp.[temp_no]
 ;

 --空文字とNULL
 WITH temp AS (
 	SELECT 
		'' as [空文字]
		,NULL as [NULL]
 )
 SELECT *
 FROM [temp]
 --WHERE [空文字] IS NOT NULL
;


--Q12
  SELECT
	[class]
	,[reading]
	,ROW_NUMBER() OVER(PARTITION BY [class] ORDER BY [reading]) AS [class_no]
  FROM [kensyu].[dbo].[practice]
  ;

 BEGIN transaction ;
 UPDATE pra
 SET pra.[class_no] = temp.[class_no]
 FROM [kensyu].[dbo].[practice] as pra
 INNER JOIN (
	  SELECT
		[temp_no]
		,[class]
		,[reading]
		,ROW_NUMBER() OVER(PARTITION BY [class] ORDER BY [reading]) AS [class_no]
	  FROM [kensyu].[dbo].[practice]
 ) AS [temp]
 ON pra.[temp_no] = temp.[temp_no]
;

SELECT [class],[reading],[class_no]
FROM [kensyu].[dbo].[practice] 
ORDER BY [class],[reading]
;
ROLLBACK ;






