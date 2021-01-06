--�X�܂��Ɖ����
SELECT DISTINCT STORECD,STORENAME 
FROM JDMC2020.JDMC2020_RETAIL
;

--�X�܂��Ɖ����
SELECT STORECD,STORENAME,COUNT(DISTINCT MEMBERID) AS cnt
FROM JDMC2020.JDMC2020_RETAIL
GROUP BY STORECD,STORENAME 
;

-------------------------------------------------
--�X�܂��Ɖ���̍w����
/*
�����F�������̓������Ԃ̍w���͈�̍w���Ƃ��ăJ�E���g    

��قǍl�����ׂ�����
�E���z�}�C�i�X������
�E�Ǝ҂͏����H
 */

/*
 *year month
	SELECT 
   	    DISTINCT LEFT(DEAL_YMD,7) AS YR_MONTH
	FROM JDMC2020.JDMC2020_RETAIL
	ORDER BY YR_MONTH

--�X�܂��Ɠ��t�w��ł̑��w����(����̂�)
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
--�X�܂��ƌ��ʔ�����z(�S�́F�������܂�)
/*
�����F[SALESTAXINCLUDED]�̒P�����v��p����
��قǍl�����ׂ�����
�E���z�}�C�i�X������
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
--�������
SELECT 
	 COUNT(*)
FROM JDMC2020.JDMC2020_RETAIL
WHERE MEMBERID <> '0'
;

--����̒j���䗦�i�X�܂��Ɓj
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


--����̒j���ʍw������
/*
�����F�������̓������Ԃ̍w���͈�̍w���Ƃ��ăJ�E���g    

��قǍl�����ׂ�����
�E���z�}�C�i�X������
�E�Ǝ҂͏����H
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




