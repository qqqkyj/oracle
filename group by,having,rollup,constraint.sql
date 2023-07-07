--group by절
--group by절과 having절
--유일한 값에 따라 무리를 지음, 한 테이블의 행동을 원하는 그룹으로 나눔
--professor에서 학과별로 교수들의 평균급여를 출력
--어떤것에 대한 group by인지를 알기 위해 group지어진 이름을 같이 넣어줌
select deptno 학과, avg(pay)"평균 급여" 
from professor
group by deptno;

--select절에 사용된 그룹함수 이외의 컬럼이나 표현식은 반드시 group by에 사용돼야함
--professor에서 직급별 평균보너스 구하기
select position 직급별, avg(nvl(bonus,0))평균보너스
from professor
group by position;

--학과별 직급별로 교수들의 평균급여
select deptno 학과, position 직급별, avg(pay)평균급여
from professor
group by deptno, position;

--student에서 학년별 최고키와 최고몸무게 출력
select grade 학년, max(height) 최고신장, max(weight) 최고몸무게
from student
group by grade;

--교수의 직급별 총급여와 최고보너스를 구하시오
select position 직급, sum(pay) 총급여, max(nvl(bonus,0))최고보너스
from professor
group by position;

--emp에서 동일한 직업끼리의 사원수
--직무 사원수 
select * from emp;
select job 직무, count(*) 사원수
from emp
group by job;

--Having절_조건주고 검색하기_반드시 group by뒤에...
--emp에서 평균급여가 2000이상인 부서의 부서번호화 평균급여를 구하시오
--where절은 그룹함수의 비교조건으로 쓸 수 없음
select deptno 부서, round(avg(sal),0) 평균급여 
from emp
group by deptno--그룹
having round(avg(sal),0)>=2000;--조건

--professor에서 평균급여가 300이상인 학과의 학과번호와 평균급여를 구하시오
select * from professor;
select deptno 학과번호, avg(pay) 평균급여
from professor--professor table로 부터
where deptno not in(101)--학과번호(deptno)가 101이 아닌
group by deptno--학과별(deptno)
having avg(pay)>=300--평균연봉이 300이상인
order by deptno desc;--부서번호가 내림차순으로 정리

--emp에서 job별로 sal의 평균급여를 조회
select job 직업, round(avg(sal),0)평균급여
from emp
group by job;

--professor에서 직급별 총급여를 조회
select position 직급, sum(pay)
from professor
group by position;

--emp에서 직업별 인원수 최대급여 최소급여 출력(job의 오름차순)
select job 직업, count(*) 인원수, max(sal) 최대급여, min(sal)최소급여
from emp
group by job
order by job;
--emp에서 입사년도 그룹별로 출력(입사년도, 인원수,급여평균(소수점1자리)_입사년도의 오름차순
select to_char(hiredate,'yyyy') 입사년도, count(*) 인원수, round(avg(sal),0) 급여평균
from emp
group by to_char(hiredate,'yyyy')
order by to_char(hiredate,'yyyy');

--Rollup함수
--자동으로 소계/합계 구해주는 함수
--group by절에 주어진 조건으로 소계값을 구해준다
select * from professor;
select deptno 학과번호, position 직위, sum(pay) 총급여
from professor
group by position, rollup(deptno);

select deptno 학과번호, position 직위, sum(pay) 총급여
from professor
group by deptno, rollup(position);

--count
select deptno, position, count(*), sum(pay)
from professor
group by rollup(deptno);


--cube함수
--rollup처럼 각소계에 전체총계까지 구해준다
select deptno, position, count(*), sum(pay)
from professor
group by cube(deptno,position);

--오늘의 총복습
--Q1.emp에서 평균연봉이 2000이상인 부서의 부서번호와 평균급여를 구하시오
select empno 부서번호, avg(sal)평균급여
from emp
group by empno
having avg(sal)>=2000;

--Q2.emp에서 deptno별 인원수는?
select deptno 부서, count(*)인원수
from emp
group by deptno;

--Q3.emp에서 job별 인원수를 구하시오(단 인원이 2명이상인곳만 구할 것)
select job 직업, count(*) 인원수
from emp
group by job
having count(*)>=2;

--Q4.emp에서 job별 급여합계를 구하는데 (president는 제외할 것) 급여합계가 5000이상만 구하시고 
--급여합계가 높은것부터 출력하시오
select job 직업, sum(sal) 급여합계
from emp
where job not in('PRESIDENT')--president 제외
group by job --job 그룹별
having sum(sal)>=5000--급여합계가 5000이상
order by sum(sal) desc;--급여합계 내림차순

--제약조건
--constraint
--테이블생성
create table sawon(
num number(5) constraint sawon_pk_num primary key,
name varchar2(20),
gender varchar2(10),
buseo varchar2(20) constraint sawon_ck_buseo check(buseo in('홍보부','인사부','교육부')),
pay number(10) default 2000000);

--시퀀스생성
create sequence seq_sawon nocache;
--데이터 10개정도 insert
--insert into sawon values (seq_sawon.nextval, '홍길동','남자','게임개발부',3500000);
insert into sawon values (seq_sawon.nextval, '홍길동','남자','홍보부',3500000);
insert into sawon values (seq_sawon.nextval, '홍길순','여자','홍보부',2000000);
insert into sawon values (seq_sawon.nextval, '이명자','여자','교육부',4000000);
insert into sawon values (seq_sawon.nextval, '이창길','남자','인사부',4650000);
insert into sawon values (seq_sawon.nextval, '이영미','여자','인사부',2000000);
insert into sawon values (seq_sawon.nextval, '김주연','여자','홍보부',3000000);
insert into sawon values (seq_sawon.nextval, '남길도','남자','교육부',3500000);
insert into sawon values (seq_sawon.nextval, '이윤슬','여자','홍보부',2000000);
insert into sawon values (seq_sawon.nextval, '김영철','남자','인사부',8000000);
insert into sawon values (seq_sawon.nextval, '이영자','여자','교육부',6500000);
commit;

--부서별 인원수와 최고급여, 최저급여, 조회
--위의 쿼리문에서 최고급여,최저급여에 화폐단위 붙히고 3자리 컴마도 나오게 해주세요
select buseo 부서, count(*) 인원수, to_char(max(pay),'L999,999,999') 최고급여, to_char(min(pay),'L999,999,999') 최저급여
from sawon
group by buseo;

--성별 인원수와 평균급여를 출력(인원수 뒤에 명이라고 나오도록)
select gender 성별, count(*)||'명' 인원수, avg(pay)평균급여
from sawon
group by gender;
select * from sawon;

--부서별 인원수와 평균급여를 구하되 인원이 4명 이상인 경우에만 출력
select buseo 부서, count(*)인원, avg(pay) 평균급여
from sawon
group by buseo
having count(*)>=4;









