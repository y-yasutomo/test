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
  FROM [mishina].[dbo].[practice]


  --Q1全データを参照し、クラスごとに並べてください。

  SELECT *
  FROM [mishina].[dbo].[practice]
  ORDER BY [class]
  ;


  --Q2全データの件数を数えてください。

  SELECT COUNT (*) 
  FROM [mishina].[dbo].[practice]
  ;

  --Q3各クラスに何人の人がいるかを算出してください。

  SELECT [class]
         ,COUNT([class]) --(*)null値も数えるために、asで名前をつける
  FROM [mishina].[dbo].[practice]
  GROUP BY [class] --groupbで指定したカラムのみに限定する
  ;

  --Q4クラスごとの、国語の平均点を算出してください。

  SELECT [class]
         ,ROUND(AVG ([japanese]),1) --ROUNDで四捨五入（丸めただけ）
  FROM [mishina].[dbo].[practice]
  GROUP BY [class]
  ;

  --Q5クラスごとの、国語の総得点を算出してください。

  SELECT [class]
 　　　　,SUM ([japanese]) --nullの場合は無視される
  FROM [mishina].[dbo].[practice]
  GROUP BY [class]
  ;

  --Q6１組の五科目合計点数最高得点者の名前と、その人の合計点を抽出してください。

  SELECT TOP(1) [name]  --SQL,Acessのみ使用可
               ,[sum]
  FROM [mishina].[dbo].[practice]
  WHERE [class] = 1
  ORDER BY [sum] DESC
  ;

  --7.各項目（temp_no～ave）について、以下の項目を出力し、不適切な値がないかをチェックしてください。（★４）
　--最大値

 SELECT MAX ([temp_no]) AS temp_no
       ,MAX ([class_no]) AS class_no
       ,MAX ([name]) AS name
       ,MAX ([family_name]) AS family_name
       ,MAX ([given_name]) AS given_name
       ,MAX ([reading]) AS reading
       ,MAX ([year]) AS year
       ,MAX ([class]) AS class
       ,MAX ([japanese]) AS japanese
       ,MAX ([math]) AS math
       ,MAX ([science]) AS science
       ,MAX ([society]) AS society
       ,MAX ([english]) AS english
       ,MAX ([sum]) AS sum
       ,MAX ([ave]) AS average
	     FROM [mishina].[dbo].[practice]
		 --class_no,family_name,given_nameはnullで不適切,society 103?
;	

SELECT MIN ([temp_no]) AS temp_no
       ,MIN ([class_no]) AS class_no
       ,MIN ([name]) AS name
       ,MIN ([family_name]) AS family_name
       ,MIN ([given_name]) AS given_name
       ,MIN ([reading]) AS reading
       ,MIN ([year]) AS year
       ,MIN ([class]) AS class
       ,MIN ([japanese]) AS japanese
       ,MIN ([math]) AS math
       ,MIN ([science]) AS science
       ,MIN ([society]) AS society
       ,MIN ([english]) AS english
       ,MIN ([sum]) AS sum
       ,MIN ([ave]) AS average
	     FROM [mishina].[dbo].[practice]
		  --class_no,family_name,given_nameはnullで不適切
;	

 


  SELECT COUNT (*)
  FROM [mishina].[dbo].[practice];
  
 SELECT COUNT ([temp_no]) AS temp_no
       ,COUNT ([class_no])AS class_no
       ,COUNT ([name]) AS name
       ,COUNT ([family_name])AS family_name
       ,COUNT ([given_name])AS given_name
       ,COUNT ([reading])AS reading
       ,COUNT ([year]) AS year
       ,COUNT ([class]) AS class
       ,COUNT ([japanese]) AS japanese
       ,COUNT ([math])AS math
       ,COUNT ([science]) AS science
       ,COUNT ([society]) AS society
       ,COUNT ([english]) AS english
       ,COUNT ([sum]) AS sum
       ,COUNT ([ave])AS average
  FROM [mishina].[dbo].[practice];

  --充足率2%


  --8.クラスごとに五科目の合計の平均点を算出し、平均点の良いクラス順に並べてください。（★３）

  SELECT [class]
         ,ROUND(AVG ([sum]),1) AS average
  FROM [mishina].[dbo].[practice]
  GROUP BY [class]
  ORDER BY average DESC; 


  --9.３組の数学の点数上位5名の名前と、その点数を抽出し、点数の高い順に並べてください。（★３）

  SELECT TOP(5) [name]
               ,[math]
  FROM [mishina].[dbo].[practice]
  WHERE [class] = 3
  ORDER BY [math] DESC;


  --10.理系教科（数・理）の合計が160点以上の生徒の名前と、その合計点を抽出し、合計点の高い順に並べてください。（★３）

  SELECT [name]
        ,[math] + [science] AS total
  FROM [mishina].[dbo].[practice]
  WHERE ([math] + [science]) >= 160
  ORDER BY total DESC;

  --11.現在のテーブルに一番右に、「star」というカラムを追加して参照してください。（←new!）（★４）

CREATE TABLE startable_3(
                         name varchar(100)
				       , total integer
					   , star varchar(100)
					   )
					   ;


SELECT [name]
      ,[sum]
      FROM [mishina].[dbo].[practice]
WHERE [sum] > = 370
;

INSERT INTO startable_3 (name,total,star)
	            VALUES('渡辺 健太郎',399,'☆')
				     ,('増田 哲也',385,'☆')
					 ,('上田 隆',393,'☆')
					 ,('小島 拓也',392,'☆')
					 ,('櫻井 健太',388,'☆')
					 ,('木下 明',395,'☆')
					 ,('澤田 修',385,'☆')
					 ,('岩田 浩一',377,'☆')
					 ,('荒井 真一',371,'☆')
					 ;


SELECT * FROM startable_3;

				
SELECT *
FROM [mishina].[dbo].[practice]
INNER JOIN startable_3
ON
[mishina].[dbo].[practice].[name]
=
startable_3.[name]
;
--↓同期のアドバイスを参考に。。。

SELECT *,
IIF([sum] > = 370, '☆','') AS [star]
FROM [mishina].[dbo].[practice]
;

--answer
 SELECT table1.*,Table2.[star]
 FROM [mishina].[dbo].[practice] AS Table1
 LEFT OUTER JOIN
 (
 SELECT [temp_no],[sum],'☆' AS [star]
 FROM [mishina].[dbo].[practice]
 WHERE [sum] > = 370
 ) AS Table2
 ON Table1.[temp_no] = Table2.[temp_no]
 ;

  --12.クラスごとにあいうえお順で出席番号を発番し、Class_Noに値を入れてください。（★４）

  
UPDATE [mishina].[dbo].[practice]
SET  [mishina].[dbo].[practice].[class_no]
= 
num.[number]
FROM [mishina].[dbo].[practice]
INNER JOIN
(SELECT *
      ,ROW_NUMBER()
	   OVER(PARTITION BY [class]
	        ORDER BY [reading])AS [number]
FROM [mishina].[dbo].[practice]
) AS num
ON [mishina].[dbo].[practice].[temp_no]
= 
num.[temp_no]
;



SELECT * FROM [mishina].[dbo].[practice] 
  ;
  

  
  
  --13.すべての生徒の苗字（漢字）を抽出し、"Family name"カラムに、名前（漢字）を抽出し、"Given_name"カラムに値を入れてください。（★４）
  
--苗字

UPDATE Table1
SET Table1.[family_name] = Table2.[sei]
FROM [mishina].[dbo].[practice] AS Table1
INNER JOIN
(SELECT [temp_no]
       ,[name]
       ,LEFT([name],3) AS [sei]
 FROM [mishina].[dbo].[practice]  
) AS Table2
ON Table1.[temp_no] = Table2.[temp_no]
;
--要修正→松本正樹、林純、中西達也、高野亮、南雄一

UPDATE [mishina].[dbo].[practice] 
 SET [family_name] = '松本' WHERE [temp_no] = 6

UPDATE [mishina].[dbo].[practice] 
SET [family_name] = '林' WHERE [temp_no] = 9

UPDATE [mishina].[dbo].[practice] 
SET [family_name] = '中西' WHERE [temp_no] = 18

UPDATE [mishina].[dbo].[practice] 
SET [family_name] = '高野' WHERE [temp_no] = 23

UPDATE [mishina].[dbo].[practice] 
SET [family_name] = '南' WHERE [temp_no] = 48
;
--一応できたが、修正が手作業なので間違えやすい。。


SELECT * FROM [mishina].[dbo].[practice] 
  ;

--名前

UPDATE Table1
SET Table1.[given_name] = Table2.[namae]
FROM [mishina].[dbo].[practice] AS Table1
INNER JOIN
(
SELECT [temp_no]
       ,[name]
       ,RIGHT([name],2) AS [namae]
 FROM [mishina].[dbo].[practice] 
) AS Table2
ON Table1.[temp_no] = Table2.[temp_no]
;

--要修正→渡辺健太郎、高野亮

UPDATE [mishina].[dbo].[practice] 
 SET [given_name] = '健太郎' WHERE [temp_no] = 3

UPDATE [mishina].[dbo].[practice] 
 SET [given_name] = '亮' WHERE [temp_no] = 23
 ;



DELETE FROM [mishina].[dbo].[practice] WHERE [temp_no] >= 51; --class_noがずっと続いて消えない。。




  --14.五教科の学年平均を算出し、五教科すべてにおいて平均点以上を獲得している生徒の名前と、その五教科得点を抽出してください。（★５）

  SELECT [name]
        ,[japanese]
		,[math]
		,[society]
		,[science]
		,[english]
  FROM [mishina].[dbo].[practice]
  WHERE [japanese] >= (SELECT ROUND(AVG ([japanese]),1) FROM  [mishina].[dbo].[practice] )
  AND   [math] >= (SELECT ROUND(AVG ([math]),1) FROM  [mishina].[dbo].[practice] )
  AND   [society] >= (SELECT ROUND(AVG ([society]),1) FROM  [mishina].[dbo].[practice] )
  AND   [science] >= (SELECT ROUND(AVG ([science]),1) FROM  [mishina].[dbo].[practice] )
  AND   [english] >= (SELECT ROUND(AVG ([english]),1) FROM  [mishina].[dbo].[practice] )
  ;


  --15.文系科目（国・社・英）の平均点と理系科目（数・理）の平均点の差が最も大きい生徒の名前と各平均を抽出してください。（★５）


SELECT TOP(1)[name]
,ROUND(([japanese] + [society] + [english])/3,1) AS [j_average]
,ROUND(([math] + [science])/2,1) AS [m_average] 
,ABS(ROUND(([japanese] + [society] + [english])/3,1) - ROUND(([math] + [science])/2,1)) AS [gap]
FROM [mishina].[dbo].[practice]
ORDER BY [gap] DESC
;



  --16.各組の英語の最高得点者の名前と得点、及びその人の所属する組を抽出してください。※最高得点者が複数いる場合には、全員抽出すること。（★６）


SELECT Table1.[name]
      ,[english] 
      ,Table1.[class]
FROM [mishina].[dbo].[practice] AS Table1
INNER JOIN
     (SELECT [class]
	        ,MAX ([english]) AS [max]
		FROM [mishina].[dbo].[practice]
		GROUP BY [class]
		) AS Table2
ON Table1.[class] = Table2.[class]
AND Table1.[english] = Table2.[max]
ORDER BY [class] 
;
