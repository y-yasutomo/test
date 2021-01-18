

--店舗ごと日付時間ごと総購買数(会員のみ)

SELECT 
   	 STORECD
	,STORENAME
	,DEAL_YMD
	,DEAL_HOUR 
	,COUNT(DISTINCT MEMBERID) AS member_member_purchase_cnt
FROM JDMC2020.JDMC2020_RETAIL jr 
WHERE MEMBERID <> '0'
GROUP BY STORECD 
		,STORENAME
    	,DEAL_YMD
	    ,DEAL_HOUR 
ORDER BY STORECD
    	,DEAL_YMD
	    ,DEAL_HOUR 
;

-------------------------------------------------
--店舗ごと月別売上金額(会員のみ)
/*
条件：[SALESTAXINCLUDED]の単純合計を用いる
後ほど考慮すべき事項
・金額マイナスを除く
 */

SELECT 
	STORENAME
	,DEAL_YMD
	,DEAL_HOUR 
	,SUM(SALESTAXINCLUDED) AS SUM_SALSE
FROM JDMC2020.JDMC2020_RETAIL jr 
WHERE MEMBERID <> '0'
GROUP BY 
		 STORENAME
    	,DEAL_YMD
	    ,DEAL_HOUR 
ORDER BY STORENAME 
    	,DEAL_YMD
	    ,DEAL_HOUR 
;


--店舗ごと月別売上金額(非会員のみ)
SELECT 
	STORENAME
	,DEAL_YMD
	,DEAL_HOUR 
	,SUM(SALESTAXINCLUDED) AS SUM_SALSE
FROM JDMC2020.JDMC2020_RETAIL jr 
WHERE MEMBERID = '0'
GROUP BY STORECD 
		,STORENAME
    	,DEAL_YMD
	    ,DEAL_HOUR 
ORDER BY STORENAME 
    	,DEAL_YMD
	    ,DEAL_HOUR 
;


--店舗ごと月別売上金額(全体)
/*
条件：[SALESTAXINCLUDED]の単純合計を用いる
後ほど考慮すべき事項
・金額マイナスを除く
 */

SELECT 
	STORENAME
	,DEAL_YMD
	,DEAL_HOUR 
	,SUM(SALESTAXINCLUDED) AS SUM_SALSE
FROM JDMC2020.JDMC2020_RETAIL jr 
GROUP BY STORECD 
		,STORENAME
    	,DEAL_YMD
	    ,DEAL_HOUR 
ORDER BY STORENAME 
    	,DEAL_YMD
	    ,DEAL_HOUR 
;




--会員の男女別購買件数
/*
条件：同じ日の同じ時間の購入は一つの購入としてカウント    

後ほど考慮すべき事項
・金額マイナスを除く
・業者は除く？
 */

SELECT 
	 STORENAME
	,DEAL_YMD
	,DEAL_HOUR 
	,SEX
	,COUNT(DISTINCT MEMBERID) AS member_purchase_cnt
FROM JDMC2020.JDMC2020_RETAIL jr 
WHERE MEMBERID <> '0'
GROUP BY STORENAME
    	,DEAL_YMD
	    ,DEAL_HOUR 
		,SEX
ORDER BY STORENAME 
    	,DEAL_YMD
	    ,DEAL_HOUR 
;

