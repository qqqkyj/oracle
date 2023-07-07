--<복습>
--Q1.emp에서 job종류별로 직업군을 한번씩만 출력해보세요
select * from emp;
select distinct job 직업 from emp;
--Q2.emp테이블에서 사원명이 A나 S로 시작하는 사람만 출력해보세요(사원번호 사원명)
select empno 사원번호 ,ename 사원명 from emp where ename like 'S%' union
select empno 사원번호 ,ename 사원명 from emp where ename like 'A%';
select empno 사원번호 ,ename 사원명 from emp where ename like 'A%' or ename like 'S%';
--Q3.emp에서 deptno가 10인부서만 출력하시오(사원명 부서번호)
select ename 사원명, deptno 부서번호 from emp where deptno=10;
--Q4.emp에서 급여(sal)가 평균보다 더 높은 사람만 사원명 급여를 출력
select ename 사원명, sal 급여 from emp where sal>(select avg(sal) from emp);
--Q5.SCOTT의 급여와 동일하거나 더 많이 받는 사람의 사원명과 급여를 출력
select ename 사원명, sal 급여 from emp where sal>=(select sal from emp where ename='SCOTT');
--Q6.emp에서 hiredate에서 월이 5월인 사람만 사원명 입사일자 출력(to_char사용)
select ename  사원명, hiredate 입사일자 from emp where to_char(hiredate,'mm')='05';

--7월7일 study
--1.테이블 생성
--primary key는 기본키를 의미 not null+unique를 의미
--test테이블
create table test
(num number(5) primary key,
name VARCHAR2(20),--가변형 char
score number(6,2),
birth date);

desc test;--test 구조보기
select * from test;
--test에 전체데이터 insert
insert into test values(1,'손석구',67.2,'1997-11-11');
--test에 일부데이터 insert
insert into test(num,name) values (2,'강호동');
--insert 에러(primary key값에 중복값이 들어가서 오류가 발생=>무결성 제약 조건 위배)
insert into test values(2,'이영애',68.25,'1956-10-12');--이미 num2가 존재
insert into test values(4,'이영애',68.25,'1956-10-12');
--sysdate현재날짜 의미
insert into test values(5,'이효리',88.26,sysdate);
--alter
--나이를 저장할 컬럼 추가, 무조건 null로 추가
--alter table 테이블명 add 추가할 컬럼명 데이터타입;
alter table test add age number(5);
--주소를 저장할 컬럼을 추가하는데 초기값을 강남구라고 지정=>default값으로 초기값 설정
alter table test add addr varchar2(30) default '강남구';
--SQL 오류: ORA-12899: "JOONY"."TEST"."ADDR" 열에 대한 값이 너무 큼
--insert into test values(4,'이영애',68.25,'1956-10-12',22,'대한민구아아라라ㅏㅣ아아ㅣㅣㅏㅏㄴㄹㄹㅈㄴㄹㄴㅇㄹㄴㅇㄹㄴㄹ');
--주소 저장컬럼 30=>50
--alter table 테이블명 modify 컬럼명 데이터타입;
alter table test modify addr varchar2(50);

--age타입을 문자열(10)으로 변경하고 초기값을 20으로 설정하기
alter table test modify age varchar2(10) default '20';
insert into test(num,name) values (6,'강호동');

--num에 오름차순 출력
select * from test order by num;--asc
select * from test order by num desc;--desc

--alter(칼럼수정)
--drop(삭제)
--alter table 테이블명 drop column 삭제할칼럼명
--age라는 컬럼을 삭제
alter table test drop column age;
-addr삭제
alter table test drop column addr;
--column명 변경
--update table 테이블명 rename column old컬럼명 to new컬럼명
alter table test rename column score to jumsu;
--birth==>birthday
alter table test rename column birth to birthday;
--테이블 삭제 test
drop table test;

--시퀀스 생성
--시퀀스 기본으로 생성, 1부터 1씩 증가하는 시퀀스 생성됨
create sequence seq1;
--전체시퀀스 확인
select * from seq;
--다음 시퀀스값을 발생 콘솔에 출력(nextval)
select seq1.nextval from dual;
--현재 마지막 발생한 시퀀스값(currval)
select seq1.currval from dual;
--sql1삭제
drop sequence seq1;
--10부터 5씩 증가하는 시퀀스생성-cache값 삭제
create sequence seq2 start with 10 increment by 5 nocache;
--시퀀스발생
select seq2.nextval from dual;
--시퀀스 삭제
drop sequence seq2;

--seq1:시작값:5 증가값:2 끝값:30 캐시:no, cycle:y
create sequence seq1 start with 5 increment by 2 maxvalue 30 nocache cycle;
--seq2:시작값 1 증가값1 cache:n
create sequence seq2 nocache;
--seq3: 시작값 1 증가값2 cache:n
create sequence seq3 start with 1 increment by 2 nocache;
--출력
select seq1.nextval, seq2.nextval, seq3.nextval from dual;
--전체 삭제
drop sequence seq1;
drop sequence seq2;
drop sequence seq3;
--------------------시퀀스1개생성, 테이블생성
create sequence seq_start nocache;
create table personinfo (
num number(5) primary key,
name varchar2(20),
job varchar2(30),
gender varchar2(20),
age number(5),
hp varchar2(20),
birthday date);

select * from personinfo;
desc personinfo;

--birthday=>ipsaday
alter table personinfo rename column birthday to ipsaday;
--insert
insert into personinfo values (seq_start.nextval, '홍길동','엔지니어','남자',23,'010-5645-5656','1989-05-01');
insert into personinfo values (seq_start.nextval, '홍길순','엔지니어','여자',22,'010-5623-2626','1980-05-01');
insert into personinfo values (seq_start.nextval, '김순길','주부','남자',45,'010-9856-5656','1978-05-01');
insert into personinfo values (seq_start.nextval, '김순길','주부','여자',53,'010-5353-5656','1953-05-01');
insert into personinfo values (seq_start.nextval, '박길자','캐셔','여자',63,'010-5645-5656','1978-05-01');
insert into personinfo values (seq_start.nextval, '박혁진','캐셔','남자',63,'010-5645-5656','1970-05-01');
insert into personinfo values (seq_start.nextval, '이숙자','공무원','여자',53,'010-5645-5656','1973-05-01');
insert into personinfo values (seq_start.nextval, '윤성빈','운동선수','남자',32,'010-5645-5656','1989-05-01');
insert into personinfo values (seq_start.nextval, '김자빈','개발자','여자',23,'010-5645-5656','2002-05-01');
insert into personinfo values (seq_start.nextval, '박재범','가수','남자',33,'010-5645-5656','1989-05-01');
--**commit을 해야 최종적인 insert가 되는 것
commit;--최종저장




select * from personinfo order by age desc;
select * from personinfo order by 5 asc;--컬럼번호로도 조회가능
select * from personinfo order by gender,age desc;
select distinct job from personinfo;
--성이 홍씨
select * from personinfo where name like '홍%';
--이름이 두번째 글자가 성
select * from personinfo where name like '_성%';
--핸드폰 마지막 자리가 5656인 사람
select * from personinfo where hp like '%5656';
--입사일자가 5월인 사람
select * from personinfo where to_char(ipsaday,'mm')='05';
--입사일자가 89년 인사람
select * from personinfo where to_char(ipsaday,'yy')='89';
--나이가 20~30사이 출력
select * from personinfo where age between 20 and 30;
--직업이 가수 이거나 개발자인 사람
select * from personinfo where job='가수' or job='개발자';
--직업이 가수나 개발자가 아닌 사람
select * from personinfo where job not in('가수','개발자');
--평균나이, 소수점 한자리로 구하기
select round(avg(age),1) from personinfo;

--내용수정(update)
--update 테이블명 set 컬럼1='변경할데이터' where 컬럼2='데이터값';
--3번 직업 나이 수정하기, 조건이 없으면 모든 데이터가 수정된다 조건필수
update personinfo set job='간호사',age=35;
--잘못수정한데이터 원래대로 돌려놓기
rollback;
--4번만
update personinfo set job='간호사',age=35 where num=4;
--김씨이면서 주부인 사람의 젠더를 남자로 수정
update personinfo set gender='여자' where name like '김%' and job='주부';
--num이 8번인 사람의 직업을 교사로 입사일을 2000/12/25로 수정
update personinfo set job='교사',ipsaday='2000/12/25' where num=8;
commit;--최종저장

--삭제
--delete from 테이블명
delete from personinfo;
rollback;
--5번만 삭제
delete from personinfo where num=5;
--여자중에서 나이가 25세이상만 모두 삭제
delete from personinfo where gender='여자' and age>=25;

--핸드폰을 ***-***-****수정
update personinfo set hp='***-***-****';
roll back;
select * from personinfo;

--테이블 삭제
drop table personinfo;
--시퀀스 삭제
select * from seq;
drop sequence seq_start;

--dept에서 30번 부서를 시애틀로 변경
update dept set dname='시애틀';
select * from dept;
--emp테이블 TotalSal열을 하나 추가=>number(20)
alter table emp add TotalSal number(20);
select * from emp;
--emp테이블 TotSal에 sal과 comm을 더한 가격을 수정
update emp set TotalSal=sal+nvl(comm,0);
--emp에서 ward 삭제
select * from emp;
delete from emp where ename='WARD';
rollback;
--product테이블에서 100번을 초코파이로 수정
select * from product;
update product set p_name='초코파이' where p_code=100;
rollback;
