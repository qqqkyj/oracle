--emp���̺��� ename�� ��ȸ�Ͻÿ�
select ename from emp;
--emp���̺��� job�� ��ȸ�Ͻÿ�
select ename,job from emp;
--emp���̺� ��ü��ȸ
select * from emp;
--student���̺� ��ü��ȸ
select * from student;
--ǥ����(�÷��� ����)
select name,'���ݽǽ���' from student;
--�÷� ��Ī allias ���=>���⸦ ����Ϸ��� �����ǥ ���ֱ�
select name "�̸�",grade as "�г�",birthday ���� from student;
--emp���� �����,����,�Ի����ڸ� ��ȸ�Ͻÿ�
select ename �����, job ����, hiredate �Ի����� from emp;
--destinct: �ߺ��� ���� �� ���
select distinct job ������ from emp;
--emp���� �μ���ȣ�� �ߺ����� ����ϱ�
select distinct deptno �μ���ȣ from emp;
--�ռ�������:�÷��� ������ ���=>ex)������4
select name||grade from student;
--professor��ȸ
select * from professor;
--�ϳ��� �÷����� ��� ������ ���� ������ �Դϴ�
select name||'����'||position||'�Դϴ�.' "����������" from professor;
--smith���� job�� clerk �Դϴ�
select ename||'���� job��'||job||'�Դϴ�.' ���� from emp;
--student���� ���������� Ű�� 180cm, �����Դ� 72kg�Դϴ�.
select name||'���� Ű��'||height||'cm, �����Դ� '||weight||'kg�Դϴ�.' "��ü ����" from student where name='������';
--emp���� �� ������ salesman�̰� ������ *** �Դϴ�.
select * from emp;
select '�� ������ '||job||'�̰� ������ '||sal||'�Դϴ�.' "��������" from emp where job='SALESMAN';

--����
--student���� �л���, �г�, ������ �л����� ������������ ��ȸ�Ͻÿ�(order by name asc)
select * from student;
select name, grade, birthday from student order by name asc;--��������
--student���� �л���, �г�, ������ �л����� ������������ ��ȸ�Ͻÿ�(order by name desc)
select name, grade, birthday from student order by birthday desc;
--emp���� �����, ����, �޿��� �޿��� ���� ��������� ��ȸ
select * from emp;
select ename, job, sal from emp order by sal asc;
select ename, job, sal from emp order by 3 desc;--�÷���ȣ�ε� ���İ���(2�����ĵ� ����)
--emp���� ������ �ߺ����� ����ϰ� �������� ������������ ���
select distinct job ������ from emp order by job asc;

--���������
--emp���� sal�� Ư�����ʽ� 100�� ���Ͽ� ����Ͻÿ�
select ename �����, sal �⺻��, sal+100 Ư�����ʽ� from emp;
--where�� : ����(���ڴ� ''�ȿ� ����� ��)
--emp���� 10���μ��� �ٹ��ϴ� ����� �����, �޿��� �μ���ȣ�� ����ϼ���
select ename �����, sal �޿�, deptno �μ���ȣ  from emp where deptno=10;
--emp���� �̸��� KING�� ����� �����, ������ ��ȸ
select ename �����, job ���� from emp where ename='KING';
--emp���� �޿��� 3000�̻��� ����� �����,�޿� ��ȸ
select ename �����, sal �޿� from emp where sal>=3000;
--�л����̺��� Ű�� 180�̻��� �л���, Ű�� ��ȸ
select name �л���, height Ű from student where height>=180;
--�л����̺��� Ű�� 160���� 180������ �л���� Ű ���:between a and b
select name �л���, height Ű from student where height between 160 and 180 order by height;
--in(a,b) :a,b�� ��ȸ
--emp���� deptno�� 20,30�� ������� �����, �μ���ȣ
select ename �����, deptno �μ���ȣ from emp where deptno in(20,30) order by deptno;
--null���� ���
--emp���� comm�� null�� ����� �̸��� ���ʽ� ���
select ename �����, comm ���ʽ� from emp where comm is null;
select ename �����, comm ���ʽ� from emp where comm is not null;--0�� null�� �ƴ�
--NVL : null�� �ٲٱ�=>nvl(Į���̸�, ������ �̸�), ������ �����϶�
select ename �����, nvl(comm,0) ���ʽ� from emp;

--Like������
select name �л��� from student where name like '%��%';
--�л����̺� �� ���?--count(*),count(name)
select count(name) "�� �л���" from student;
--emp���� job�� salesman,manager�� �����, �������� ����Ͻÿ�(or�� in)
select ename �����, job ������ from emp where job='SALESMAN' OR job='MANAGER';
select ename �����, job ������ from emp where job in('SALESMAN','MANAGER');
--emp���� �޿��� 2000-3000�� �����, ������, �޿��� ���(and,between)
select ename �����, job ������, sal �޿� from emp where sal>=2000 and sal<=3000;
select ename �����, job ������, sal �޿� from emp where sal between 2000 and 3000;

Quiz.
--Q.student���̺��� 1�г� �л��� �л���,Ű�� ���
select name �л���, height Ű, grade �г� from student where grade=1;
--Q.student���� 2�г��л��� �л��� ���� Ű �����Ը� ���(�� ������ �����������)
select name �л���, birthday ����, height Ű, weight ������ from student where grade=2 order by birthday;
--Q.professor���� �������� �̸� �� �������� ���� ������ ������ ���� �Ի����ڸ� ���
select * from professor;
select name ������, position ���� from professor where name like '��%';
--Q.emp���� �����, �޿�, �޿�*12, ���ʽ� ,�޿��Ѱ踦 ���Ͻÿ�
select ename �����, sal �޿�, sal*12 ����, nvl(comm,0) ���ʽ�, (sal*12)+nvl(comm,0) �޿��Ѱ� from emp;
--Q.emp���� �Ի����ڰ� 1982/01/01 ���Ŀ� ���� ����� ������  �Ի����ڸ� ��ȸ(�Ի����� ��)
select ename �����, hiredate �Ի��� from emp where hiredate>to_date('1982/01/01')order by hiredate;
--Q.Like% ,_����� �̿��ؼ� Ư�������� �ִ� ���� ���
--emp���� ������� 3��° ���ڰ�  a�� ����� ����� ���
select ename ����� from emp where ename like '__A%';
--emp���� ������� 2��° ���ڰ�  s�� ��� or 3��°���ڰ� s�� ����� ����� ���
select ename ����� from emp where ename like '_A%'or ename like'__A%';
--��¥ ���ͷ�' '�ݵ�� ���
--emp���� ������ clerk�̰� �Ի����� 87/05/23�� ����� ����� �Ի��� ���ϱ�
select ename �����, hiredate �Ի��� from emp where job='CLERK' and hiredate=to_date('87/05/23');
--emp���� �Ŵ����̰ų� 82������ �Ի����� ����� ������ �Ի��� ���
select ename �����, job ������, hiredate �Ի��� from emp where job='MANAGER' or hiredate>=to_date('82/01/01')order by hiredate;

--��������
--student���� �л��� �̸��� Ű�� ������ ���(Ű�� ���� �������, �����Դ� ���� �������)
select name �л���, height Ű, weight ������ from student where grade=1 order by height asc, weight desc;
--emp���� �޿� �������� �� �ٽ� �̸����� �������� �����ȣ ����� �޿� ��ȸ
select * from emp;
select empno �����ȣ, ename �����, sal �޿� from emp order by sal desc, ename asc;

select * from student;
--union(������� �տ��� �ߺ�����)
select name �̸�, deptno1 ����,deptno2 ������ from student where deptno1=101 union
select name �̸�, deptno1 ����,deptno2 ������ from student where deptno2=201;
--unionAll(������� ��ħ)
select name �̸�, deptno1 ����,deptno2 ������ from student where deptno1=101 union all
select name �̸�, deptno1 ����,deptno2 ������ from student where deptno2=201;
--intersect(������)
select name �̸�, deptno1 ����,deptno2 ������ from student where deptno1=101 intersect
select name �̸�, deptno1 ����,deptno2 ������ from student where deptno2=201;

--SQL �׷��Լ�(count,sum,avg)
--count(*)null�� ����,count(�÷�):null�� ����
select count(*),count(hpage) from professor;
--sum(�÷���)
select count(bonus),sum(bonus) from professor;
--avg(�÷���)
select count(bonus),sum(bonus),avg(bonus) from professor;

--max,min
select * from emp;
select max(sal), min(sal) from emp;
select max(hiredate), min(hiredate) from emp;

--�Ҽ���
--emp���� sal���
select round(avg(sal),2) from emp;
select round(avg(sal),0) from emp;--�ݿø�
select round(avg(sal),-1) from emp;--10����

--�ֿܼ� ���
--���糯¥�� �ֿܼ� ���
select sysdate from dual;
select sysdate+1 from dual;

--to_char:��¥ �� ��ġ�����͸� ���ڷ� ��ȯ�ϱ� ���� �Լ�
--��¥���� �⵵�� ����
select to_char(sysdate,'year')from dual;--����� ���
select to_char(sysdate,'yyyy')from dual;--�⵵�� ���
select to_char(sysdate,'mm')from dual;
select to_char(sysdate,'dd')from dual;
select to_char(sysdate,'yyyy-mm-dd hh24-mi-ss')from dual;;

--to_char ���ڿ��� ���밡���ϴ�
select to_char(245897251,'999,999,999')from dual;

--emp
select empno �����ȣ, ename �����, to_char(hiredate,'yyyy')�⵵ from emp;
--emp���� �����ȣ, �����, �޿� ���(�޿��� õ���� ���б�ȣ)
select * from emp;
select empno �����ȣ, ename �����, to_char(sal, 'L999,999') �޿� from emp order by empno;--L(��ȭ),$(�޷�)
--��������
--�����ȿ� �Ǵٸ� ���� ���(JAMES���� �޿��� ���� �޴� �����?)2���� ����..
--���������� ���� ����Ǿ� �װ���� ���������� �����ְ� �� ���� �޾� �������������� ����
--���������ȿ��� order by�� ����
--emp���� JAMES���� �޿� ���� �޴� ����� ����� �޿� ��ȸ
select ename �����, sal �޿� from emp where sal>(select  sal �޿� from emp where ename='JAMES') order by sal;
