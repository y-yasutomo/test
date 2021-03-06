drop table t1 ;

begin transaction;
CREATE TABLE t1 (
	col1 varchar 
);

insert into t1 values  ('') ;
insert into t1 values  (NULL) ;
insert into t1 values  (' ') ;
insert into t1 values  ('  ') ;
insert into t1 values  ('a') ;

select * from t1 ;
select MAX(col1) from t1 ;
select MIN(col1) from t1 ;

--https://style.potepan.com/articles/21972.html
--nullは等号(=)、等号否定(!=)、不等号(<>≦≧)の対象にならない

select *
from t1
WHERE col1 <> '' 
--WHERE col1 = '' 
;

rollback ;

select *
from (
	SELECT --TOP 1
			[Make]
	FROM [kensyu].[dbo].[car]
--	WHERE NOT  [Make] = '' 
) as t
where t.Make is null
;


