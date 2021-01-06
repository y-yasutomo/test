--店舗ごと会員数
SELECT DISTINCT STORECD,STORENAME 
FROM JDMC2020.JDMC2020_RETAIL
;

--店舗ごと会員数
SELECT STORECD,STORENAME,COUNT(DISTINCT MEMBERID) AS cnt
FROM JDMC2020.JDMC2020_RETAIL
GROUP BY STORECD,STORENAME 
;

-------------------------------------------------
--店舗ごと会員の購入回数
/*
条件：同じ日の同じ時間の購入は一つの購入としてカウント    

後ほど考慮すべき事項
・金額マイナスを除く
・業者は除く？
 */

/*
 *year month
	SELECT 
   	    DISTINCT LEFT(DEAL_YMD,7) AS YR_MONTH
	FROM JDMC2020.JDMC2020_RETAIL
	ORDER BY YR_MONTH

--店舗ごと日付指定での総購買数(会員のみ)
SELECT STORECD,STORENAME,COUNT(DISTINCT MEMBERID) AS member_purchase
FROM JDMC2020.JDMC2020_RETAIL
WHERE MEMBERID <> '0' AND DEAL_YMD ='2019-01-03'
GROUP BY STORECD,STORENAME
;

*/

WITH yearmonth_split AS (
	SELECT 
   	     DEAL_YMD
   	    ,LEFT(DEAL_YMD,7) AS YR_MONTH
   	    --,LEFT(DEAL_YMD,4) AS YR
		--,SUBSTRING(DEAL_YMD ,6,2) AS MON
		,DEAL_HOUR 
		,STORECD
		,STORENAME
		,MEMBERID
	FROM JDMC2020.JDMC2020_RETAIL
)
SELECT 
   	 STORECD
	,STORENAME
	,YR_MONTH
	,COUNT(DISTINCT MEMBERID) AS member_purchase
FROM yearmonth_split
WHERE MEMBERID <> '0'
GROUP BY STORECD 
		,STORENAME
		,YR_MONTH
ORDER BY STORECD, YR_MONTH
;

-------------------------------------------------
--店舗ごと月別売上金額(全体：非会員も含む)
/*
条件：[SALESTAXINCLUDED]の単純合計を用いる
後ほど考慮すべき事項
・金額マイナスを除く
 */

WITH yearmonth_split AS (
	SELECT 
   	     DEAL_YMD
   	    ,LEFT(DEAL_YMD,7) AS YR_MONTH
		,DEAL_HOUR 
		,STORECD
		,STORENAME
		,MEMBERID
		,SALESTAXINCLUDED 
	FROM JDMC2020.JDMC2020_RETAIL
)
SELECT 
   	 STORECD
	,STORENAME
	,YR_MONTH
	,SUM(SALESTAXINCLUDED) AS SUM_SALSE
FROM yearmonth_split
WHERE MEMBERID <> '0'
GROUP BY STORECD 
		,STORENAME
		,YR_MONTH
ORDER BY STORECD, YR_MONTH
;

-------------------------------------------------
--総会員数
SELECT 
	 COUNT(*)
FROM JDMC2020.JDMC2020_RETAIL
WHERE MEMBERID <> '0'
;

--会員の男女比率（店舗ごと）
SELECT 
	 STORECD
	,STORENAME
	,SEX
	,COUNT(SEX) AS CNT
FROM JDMC2020.JDMC2020_RETAIL
WHERE MEMBERID <> '0'
GROUP BY STORECD ,STORENAME ,SEX 
ORDER BY STORECD
;


--会員の男女別購買件数
/*
条件：同じ日の同じ時間の購入は一つの購入としてカウント    

後ほど考慮すべき事項
・金額マイナスを除く
・業者は除く？
 */

WITH yearmonth_split AS (
	SELECT 
   	     DEAL_YMD
   	    ,LEFT(DEAL_YMD,7) AS YR_MONTH
		,DEAL_HOUR 
		,STORECD
		,STORENAME
		,MEMBERID
		,SEX 
	FROM JDMC2020.JDMC2020_RETAIL
)
SELECT 
   	 STORECD
	,STORENAME
	,YR_MONTH
	,SEX
	,COUNT(DISTINCT MEMBERID) AS member_purchase
FROM yearmonth_split
WHERE MEMBERID <> '0'
GROUP BY STORECD 
		,STORENAME
		,YR_MONTH
		,SEX
ORDER BY STORECD, YR_MONTH
;







SELECT *SALESTAXINCLUDED 
FROM JDMC2020.JDMC2020_RETAIL
LIMIT 1000
;

SELECT *
FROM JDMC2020.JDMC2020_RETAIL
WHERE MEMBERID = '0'
LIMIT 1000
;

SELECT *
FROM JDMC2020.JDMC2020_RETAIL
WHERE JANCD = '00000004950349595193'
LIMIT 1000
;




