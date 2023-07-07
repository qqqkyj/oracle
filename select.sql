--emp테이블에서 ename만 조회하시오
select ename from emp;
--emp테이블에서 job만 조회하시오
select ename,job from emp;
--emp테이블 전체조회
select * from emp;
--student테이블 전체조회
select * from student;
--표현식(컬럼이 생김)
select name,'지금실습중' from student;
--컬럼 별칭 allias 출력=>띄어쓰기를 사용하려면 대따옴표 해주기
select name "이름",grade as "학년",birthday 생일 from student;
--emp에서 사원명,직업,입사일자를 조회하시오
select ename 사원명, job 직업, hiredate 입사일자 from emp;
--destinct: 중복값 제거 후 출력
select distinct job 직업군 from emp;
--emp에서 부서번호를 중복없이 출력하기
select distinct deptno 부서번호 from emp;
--합성연산자:컬럼을 붙혀서 출력=>ex)서진수4
select name||grade from student;
--professor조회
select * from professor;
--하나의 컬럼으로 출력 조인형 님은 정교수 입니다
select name||'님은'||position||'입니다.' "교수별직급" from professor;
--smith님의 job은 clerk 입니다
select ename||'님의 job은'||job||'입니다.' 직업 from emp;
--student에서 서진수님의 키는 180cm, 몸무게는 72kg입니다.
select name||'님의 키는'||height||'cm, 몸무게는 '||weight||'kg입니다.' "신체 정보" from student where name='서진수';
--emp에서 내 직업은 salesman이고 연봉은 *** 입니다.
select * from emp;
select '내 직업은 '||job||'이고 연봉은 '||sal||'입니다.' "개인정보" from emp where job='SALESMAN';

--정렬
--student에서 학생명, 학년, 생일을 학생명의 오름차순으로 조회하시오(order by name asc)
select * from student;
select name, grade, birthday from student order by name asc;--생략가능
--student에서 학생명, 학년, 생일을 학생명의 내림차순으로 조회하시오(order by name desc)
select name, grade, birthday from student order by birthday desc;
--emp에서 사원명, 직업, 급여를 급여가 낮은 사람순으로 조회
select * from emp;
select ename, job, sal from emp order by sal asc;
select ename, job, sal from emp order by 3 desc;--컬럼번호로도 정렬가능(2차정렬도 가능)
--emp에서 직업군 중복없이 출력하고 직업군의 오름차순으로 출력
select distinct job 직업군 from emp order by job asc;

--산술연산자
--emp에서 sal에 특별보너스 100을 더하여 출력하시오
select ename 사원명, sal 기본급, sal+100 특별보너스 from emp;
--where절 : 조건(문자는 ''안에 적어야 됨)
--emp에서 10번부서에 근무하는 사람의 사원명, 급여와 부서번호를 출력하세요
select ename 사원명, sal 급여, deptno 부서번호  from emp where deptno=10;
--emp에서 이름이 KING인 사람의 사원명, 직업을 조회
select ename 사원명, job 직업 from emp where ename='KING';
--emp에서 급여가 3000이상인 사람의 사원명,급여 조회
select ename 사원명, sal 급여 from emp where sal>=3000;
--학생테이블에서 키가 180이상인 학생명, 키를 조회
select name 학생명, height 키 from student where height>=180;
--학생테이블에서 키가 160부터 180사이인 학생명과 키 출력:between a and b
select name 학생명, height 키 from student where height between 160 and 180 order by height;
--in(a,b) :a,b만 조회
--emp에서 deptno가 20,30인 사람들의 사원명, 부서번호
select ename 사원명, deptno 부서번호 from emp where deptno in(20,30) order by deptno;
--null값만 출력
--emp에서 comm이 null인 사람의 이름과 보너스 출력
select ename 사원명, comm 보너스 from emp where comm is null;
select ename 사원명, comm 보너스 from emp where comm is not null;--0은 null이 아님
--NVL : null값 바꾸기=>nvl(칼럼이름, 변경할 이름), 연산이 목적일때
select ename 사원명, nvl(comm,0) 보너스 from emp;

--Like연산자
select name 학생명 from student where name like '%김%';
--학생테이블 총 몇명?--count(*),count(name)
select count(name) "총 학생수" from student;
--emp에서 job이 salesman,manager인 사원명, 직업군만 출력하시오(or와 in)
select ename 사원명, job 직업군 from emp where job='SALESMAN' OR job='MANAGER';
select ename 사원명, job 직업군 from emp where job in('SALESMAN','MANAGER');
--emp에서 급여가 2000-3000인 사원명, 직업군, 급여를 출력(and,between)
select ename 사원명, job 직업군, sal 급여 from emp where sal>=2000 and sal<=3000;
select ename 사원명, job 직업군, sal 급여 from emp where sal between 2000 and 3000;

Quiz.
--Q.student테이블에서 1학년 학생의 학생명,키를 출력
select name 학생명, height 키, grade 학년 from student where grade=1;
--Q.student에서 2학년학생의 학생명 생일 키 몸무게를 출력(단 생일이 빠른사람순서)
select name 학생명, birthday 생일, height 키, weight 몸무게 from student where grade=2 order by birthday;
--Q.professor에서 교수들의 이름 중 조씨성을 가진 교수의 교수명 직위 입사일자를 출력
select * from professor;
select name 교수명, position 직위 from professor where name like '조%';
--Q.emp에서 사원명, 급여, 급여*12, 보너스 ,급여총계를 구하시오
select ename 사원명, sal 급여, sal*12 연봉, nvl(comm,0) 보너스, (sal*12)+nvl(comm,0) 급여총계 from emp;
--Q.emp에서 입사일자가 1982/01/01 이후에 들어온 사람의 사원명과  입사일자를 조회(입사일자 순)
select ename 사원명, hiredate 입사일 from emp where hiredate>to_date('1982/01/01')order by hiredate;
--Q.Like% ,_언더바 이용해서 특정순번에 있는 글을 출력
--emp에서 사원명이 3번째 글자가  a인 사람의 사원명 출력
select ename 사원명 from emp where ename like '__A%';
--emp에서 사원명이 2번째 글자가  s인 사람 or 3번째글자가 s인 사람의 사원명 출력
select ename 사원명 from emp where ename like '_A%'or ename like'__A%';
--날짜 리터럴' '반드시 사용
--emp에서 직급이 clerk이고 입사일이 87/05/23인 사람의 사원명 입사일 구하기
select ename 사원명, hiredate 입사일 from emp where job='CLERK' and hiredate=to_date('87/05/23');
--emp에서 매니저이거나 82년이후 입사자의 사원명 직업군 입사일 출력
select ename 사원명, job 직업군, hiredate 입사일 from emp where job='MANAGER' or hiredate>=to_date('82/01/01')order by hiredate;

--다중정렬
--student에서 학생의 이름과 키와 몸무게 출력(키는 작은 사람부터, 몸무게는 많은 사람부터)
select name 학생명, height 키, weight 몸무게 from student where grade=1 order by height asc, weight desc;
--emp에서 급여 내림차순 후 다시 이름으로 오름차순 사원번호 사원명 급여 조회
select * from emp;
select empno 사원번호, ename 사원명, sal 급여 from emp order by sal desc, ename asc;

select * from student;
--union(쿼리결과 합에서 중복제거)
select name 이름, deptno1 전공,deptno2 부전공 from student where deptno1=101 union
select name 이름, deptno1 전공,deptno2 부전공 from student where deptno2=201;
--unionAll(쿼리결과 합침)
select name 이름, deptno1 전공,deptno2 부전공 from student where deptno1=101 union all
select name 이름, deptno1 전공,deptno2 부전공 from student where deptno2=201;
--intersect(교집합)
select name 이름, deptno1 전공,deptno2 부전공 from student where deptno1=101 intersect
select name 이름, deptno1 전공,deptno2 부전공 from student where deptno2=201;

--SQL 그룹함수(count,sum,avg)
--count(*)null값 포함,count(컬럼):null값 제외
select count(*),count(hpage) from professor;
--sum(컬럼명)
select count(bonus),sum(bonus) from professor;
--avg(컬럼명)
select count(bonus),sum(bonus),avg(bonus) from professor;

--max,min
select * from emp;
select max(sal), min(sal) from emp;
select max(hiredate), min(hiredate) from emp;

--소수점
--emp에서 sal평균
select round(avg(sal),2) from emp;
select round(avg(sal),0) from emp;--반올림
select round(avg(sal),-1) from emp;--10단위

--콘솔에 출력
--현재날짜를 콘솔에 출력
select sysdate from dual;
select sysdate+1 from dual;

--to_char:날짜 및 수치데이터를 문자로 변환하기 위한 함수
--날짜에서 년도만 추출
select to_char(sysdate,'year')from dual;--영어로 출력
select to_char(sysdate,'yyyy')from dual;--년도만 출력
select to_char(sysdate,'mm')from dual;
select to_char(sysdate,'dd')from dual;
select to_char(sysdate,'yyyy-mm-dd hh24-mi-ss')from dual;;

--to_char 숫자에도 적용가능하다
select to_char(245897251,'999,999,999')from dual;

--emp
select empno 사원번호, ename 사원명, to_char(hiredate,'yyyy')년도 from emp;
--emp에서 사원번호, 사원명, 급여 출력(급여는 천단위 구분기호)
select * from emp;
select empno 사원번호, ename 사원명, to_char(sal, 'L999,999') 급여 from emp order by empno;--L(원화),$(달러)
--서브쿼리
--쿼리안에 또다른 쿼리 담김(JAMES보다 급여를 많이 받는 사람은?)2가지 질문..
--서브쿼리가 먼저 수행되어 그결과를 메인쿼리에 전해주고 그 값을 받아 최종메인쿼리가 실행
--서브쿼리안에는 order by절 못옴
--emp에서 JAMES보다 급여 많이 받는 사람의 사원명 급여 조회
select ename 사원명, sal 급여 from emp where sal>(select  sal 급여 from emp where ename='JAMES') order by sal;
