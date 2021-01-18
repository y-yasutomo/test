/*
--unique check weather hourly
SELECT COUNT(*)
FROM JDMC2020.JDMC2020_WEATHER_HOURLY ;

SELECT *
FROM JDMC2020.JDMC2020_WEATHER_HOURLY
LIMIT 10 ;
*/

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  DEAL_YMD
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  DEAL_HOUR 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  STORECD
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  STORENAME 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  LOCALPRESSURE 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  SEALEVELPRESSURE 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  PRECIPITATIONAMOUNT 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  TEMPERATURE 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  DEWPOINTTEMPERATURE 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  VAPORPRESSURE 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  HUMIDITY 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  WINDSPEED 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  WINDDIRECTION 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  SUNLIGHTHOURS 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  TOTALSOLARRADIATION 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  SNOWFALL 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  SNOWCOVER 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  WEATHER 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  CLOUDCOVER 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;

SELECT COUNT(*)
FROM (
	SELECT DISTINCT  VISIBILITY 
	FROM JDMC2020.JDMC2020_WEATHER_HOURLY) ;




