--day0711, JDBC_TEST
--시퀀스
create sequence seq1;
--테이블(myinfo)
create table myinfo(
num number(5) constraint myinfo_pk_num primary key,
name varchar2(20),
addr varchar2(50),
sdate date);

select * from myinfo;
------------------------------------------------------------
--테이블(myshop)
create table myshop(
shopnum number(5) constraint myshop_pk_shopnum primary key,
sangpum varchar2(20),
su number(5),
price number(5),
ipgo date);

select * from myshop;
------------------------------------------------------------
--mystudent
create sequence seq_stu;

create table mystudent(
stu_num number(5) constraint mystudent_pk_stu_num primary key,
stu_name varchar2(20),
stu_grade number(5),
hp varchar2(20),
addr varchar2(30),
age number(5),
sdate date);

commit;
