

--�X�܂��Ɠ��t���Ԃ��Ƒ��w����(����̂�)

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
--�X�܂��ƌ��ʔ�����z(����̂�)
/*
�����F[SALESTAXINCLUDED]�̒P�����v��p����
��قǍl�����ׂ�����
�E���z�}�C�i�X������
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


--�X�܂��ƌ��ʔ�����z(�����̂�)
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


--�X�܂��ƌ��ʔ�����z(�S��)
/*
�����F[SALESTAXINCLUDED]�̒P�����v��p����
��قǍl�����ׂ�����
�E���z�}�C�i�X������
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




--����̒j���ʍw������
/*
�����F�������̓������Ԃ̍w���͈�̍w���Ƃ��ăJ�E���g    

��قǍl�����ׂ�����
�E���z�}�C�i�X������
�E�Ǝ҂͏����H
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

