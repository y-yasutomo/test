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




  --Q13
  UPDATE  
	[hayashi].[dbo].[practice]
  SET [family_name] = [fname]
	,[given_name] = [gname]
  FROM [hayashi].[dbo].[practice] AS main
	INNER JOIN (SELECT [temp_no] 
					,SUBSTRING([name],1,CHARINDEX(' ',[name])) AS [fname]
					,SUBSTRING([name],CHARINDEX(' ',[name]),LEN([name])-CHARINDEX(' ',[name])+1) AS [gname]
					FROM [hayashi].[dbo].[practice]) AS sub
  ON main.[temp_no]=sub.[temp_no]
  ;

  
  UPDATE  
	[hayashi].[dbo].[practice]
  SET [family_name] = '松本'
	,[given_name] = '正樹'
  WHERE [temp_no] = 6
  ;

    UPDATE  
	[hayashi].[dbo].[practice]
  SET [family_name] = '中西'
	,[given_name] = '達也'
  WHERE [temp_no] = 18
  ;

    UPDATE  
	[hayashi].[dbo].[practice]
  SET [family_name] = '高野'
	,[given_name] = '亮'
  WHERE [temp_no] = 23
  ;


  ---Q13(確認)
  SELECT [temp_no]
	,[name]
	,SUBSTRING([name],1,CHARINDEX(' ',[name])) AS fname
	,SUBSTRING([name],CHARINDEX(' ',[name]),LEN([name]) - CHARINDEX(' ',[name])+1) AS gname
  FROM [hayashi].[dbo].[practice]
  ORDER BY fname
  ;




  --Q14
 SELECT [name]
		,[japanese]
		,[math] 
		,[science]
		,[society]
		,[english]
  FROM [hayashi].[dbo].[practice]
  WHERE [japanese] >= (SELECT AVG([japanese])FROM [hayashi].[dbo].[practice])
  AND  [math] >= (SELECT AVG([math])FROM [hayashi].[dbo].[practice])
  AND  [science] >= (SELECT AVG([science])FROM [hayashi].[dbo].[practice])
  AND  [society] >= (SELECT AVG([society])FROM [hayashi].[dbo].[practice])
  AND  [english] >= (SELECT AVG([english])FROM [hayashi].[dbo].[practice])
  ;



  --Q15
  SELECT TOP 1
		[name]
		,ABS((([japanese]+[society]+[english])/3) - (([math]+[science])/2)) AS rb_dif
		,ROUND(([japanese]+[society]+[english])/3,1) AS b_ave
		,ROUND(([math]+[science])/2,1) AS r_ave
  FROM [hayashi].[dbo].[practice]
 ORDER BY rb_dif DESC;


 --Q16
 SELECT main.[name]
		,main.[class]
		,main.[english]
 FROM [hayashi].[dbo].[practice] as main
 INNER JOIN (
			SELECT [class]
				,MAX([english]) AS [max_eng]
			FROM [hayashi].[dbo].[practice]
			GROUP BY [class]) AS sub
  ON main.[class] = sub.[class]
  AND main.[english] = sub.[max_eng]
  ORDER By main.[class]
  ;






  select *
  from  [hayashi].[dbo].[practice]
  ;