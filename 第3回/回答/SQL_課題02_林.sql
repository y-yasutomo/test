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
  FROM [hayashi].[dbo].[practice]



---Q7

--最大値
  SELECT  MAX([temp_no]) AS max_temp_no
      ,MAX([class_no])  AS max_clss_no
      ,MAX([name])  AS max_name
      ,MAX([family_name])  AS max_family_name
      ,MAX([given_name])  AS max_given_name
      ,MAX([reading])  AS max_reading
      ,MAX([year])  AS max_year
      ,MAX([class])  AS max_class
      ,MAX([japanese])  AS max_japanense
      ,MAX([math])  AS max_math
      ,MAX([science])  AS max_science
      ,MAX([society])  AS max_society
      ,MAX([english])  AS max_english
      ,MAX([sum])  AS max_sum
      ,MAX([ave])  AS max_ave
  FROM [hayashi].[dbo].[practice]
  ;

---最小値
    SELECT  MIN([temp_no]) AS min_temp_no
      ,MIN([class_no])  AS min_clss_no
      ,MIN([name])  AS min_name
      ,MIN([family_name])  AS min_family_name
      ,MIN([given_name])  AS min_given_name
      ,MIN([reading])  AS min_reading
      ,MIN([year])  AS min_year
      ,MIN([class])  AS min_class
      ,MIN([japanese])  AS min_japanense
      ,MIN([math])  AS min_math
      ,MIN([science])  AS min_science
      ,MIN([society])  AS min_society
      ,MIN([english])  AS min_english
      ,MIN([sum])  AS min_sum
      ,MIN([ave])  AS min_ave
  FROM [hayashi].[dbo].[practice]
  ;

 
--充足率
   
  
  SELECT  (COUNT(*)-COUNT([temp_no]))*100/COUNT(*) AS satisfaction_temp_no
      ,(COUNT(*)-COUNT([class_no]))*100/COUNT(*) AS satisfaction_clss_no
      ,(COUNT(*)-COUNT([name]))*100/COUNT(*) AS satisfaction_name
      ,(COUNT(*)-COUNT([family_name]))*100/COUNT(*) AS satisfaction_family_name
      ,(COUNT(*)-COUNT([given_name]))*100/COUNT(*) AS satisfaction_given_name
      ,(COUNT(*)-COUNT([reading]))*100/COUNT(*) AS satisfaction_reading
      ,(COUNT(*)-COUNT([year]))*100/COUNT(*) AS satisfaction_year
      ,(COUNT(*)-COUNT([class]))*100/COUNT(*) AS satisfaction_class
      ,(COUNT(*)-COUNT([japanese]))*100/COUNT(*) AS satisfaction_japanense
      ,(COUNT(*)-COUNT([math]))*100/COUNT(*) AS satisfaction_math
      ,(COUNT(*)-COUNT([science]))*100/COUNT(*) AS satisfaction_science
      ,(COUNT(*)-COUNT([society]))*100/COUNT(*) AS satisfaction_society
      ,(COUNT(*)-COUNT([english]))*100/COUNT(*) AS satisfaction_english
      ,(COUNT(*)-COUNT([sum]))*100/COUNT(*) AS satisfaction_sum
      ,(COUNT(*)-COUNT([ave]))*100/COUNT(*) AS satisfaction_ave
  FROM [hayashi].[dbo].[practice]
  ;



---Q8
SELECT [class]
	,ROUND(AVG([sum]),1) AS class_ave
FROM [hayashi].[dbo].[practice]
GROUP BY [class]
ORDER BY class_ave DESC
;

---Q9
SELECT TOP 5
		[name],
		[math]
FROM [hayashi].[dbo].[practice]
WHERE [class] = 3
ORDER BY [math] DESC
;

---Q10
SELECT [name]
	,[math] + [science] AS r_score
FROM [hayashi].[dbo].[practice]
WHERE  [math] + [science] >= 160
ORDER BY r_score DESC;


---Q11
SELECT *
	,IIF (SUM >= 370,'☆',null) AS star
FROM [hayashi].[dbo].[practice]
;



---Q12
UPDATE  
	[hayashi].[dbo].[practice]
SET class_no = sub.num
FROM [hayashi].[dbo].[practice] main
	INNER JOIN (SELECT [temp_no] 
					,ROW_NUMBER() OVER(PARTITION BY [class] ORDER BY [reading]) AS num
					FROM [hayashi].[dbo].[practice]) sub
	ON main.[temp_no] = sub.[temp_no]
;

--Q12(確認)
SELECT [class_no]
	, [class]
	, [reading]
	, ROW_NUMBER() OVER(PARTITION BY [class] ORDER BY [reading]) num
FROM  [hayashi].[dbo].[practice]
ORDER BY [class]
	, [reading] ASC
;


