--group by��
--group by���� having��
--������ ���� ���� ������ ����, �� ���̺��� �ൿ�� ���ϴ� �׷����� ����
--professor���� �а����� �������� ��ձ޿��� ���
--��Ϳ� ���� group by������ �˱� ���� group������ �̸��� ���� �־���
select deptno �а�, avg(pay)"��� �޿�" 
from professor
group by deptno;

--select���� ���� �׷��Լ� �̿��� �÷��̳� ǥ������ �ݵ�� group by�� ���ž���
--professor���� ���޺� ��պ��ʽ� ���ϱ�
select position ���޺�, avg(nvl(bonus,0))��պ��ʽ�
from professor
group by position;

--�а��� ���޺��� �������� ��ձ޿�
select deptno �а�, position ���޺�, avg(pay)��ձ޿�
from professor
group by deptno, position;

--student���� �г⺰ �ְ�Ű�� �ְ������ ���
select grade �г�, max(height) �ְ����, max(weight) �ְ������
from student
group by grade;

--������ ���޺� �ѱ޿��� �ְ��ʽ��� ���Ͻÿ�
select position ����, sum(pay) �ѱ޿�, max(nvl(bonus,0))�ְ��ʽ�
from professor
group by position;

--emp���� ������ ���������� �����
--���� ����� 
select * from emp;
select job ����, count(*) �����
from emp
group by job;

--Having��_�����ְ� �˻��ϱ�_�ݵ�� group by�ڿ�...
--emp���� ��ձ޿��� 2000�̻��� �μ��� �μ���ȣȭ ��ձ޿��� ���Ͻÿ�
--where���� �׷��Լ��� ���������� �� �� ����
select deptno �μ�, round(avg(sal),0) ��ձ޿� 
from emp
group by deptno--�׷�
having round(avg(sal),0)>=2000;--����

--professor���� ��ձ޿��� 300�̻��� �а��� �а���ȣ�� ��ձ޿��� ���Ͻÿ�
select * from professor;
select deptno �а���ȣ, avg(pay) ��ձ޿�
from professor--professor table�� ����
where deptno not in(101)--�а���ȣ(deptno)�� 101�� �ƴ�
group by deptno--�а���(deptno)
having avg(pay)>=300--��տ����� 300�̻���
order by deptno desc;--�μ���ȣ�� ������������ ����

--emp���� job���� sal�� ��ձ޿��� ��ȸ
select job ����, round(avg(sal),0)��ձ޿�
from emp
group by job;

--professor���� ���޺� �ѱ޿��� ��ȸ
select position ����, sum(pay)
from professor
group by position;

--emp���� ������ �ο��� �ִ�޿� �ּұ޿� ���(job�� ��������)
select job ����, count(*) �ο���, max(sal) �ִ�޿�, min(sal)�ּұ޿�
from emp
group by job
order by job;
--emp���� �Ի�⵵ �׷캰�� ���(�Ի�⵵, �ο���,�޿����(�Ҽ���1�ڸ�)_�Ի�⵵�� ��������
select to_char(hiredate,'yyyy') �Ի�⵵, count(*) �ο���, round(avg(sal),0) �޿����
from emp
group by to_char(hiredate,'yyyy')
order by to_char(hiredate,'yyyy');

--Rollup�Լ�
--�ڵ����� �Ұ�/�հ� �����ִ� �Լ�
--group by���� �־��� �������� �Ұ谪�� �����ش�
select * from professor;
select deptno �а���ȣ, position ����, sum(pay) �ѱ޿�
from professor
group by position, rollup(deptno);

select deptno �а���ȣ, position ����, sum(pay) �ѱ޿�
from professor
group by deptno, rollup(position);

--count
select deptno, position, count(*), sum(pay)
from professor
group by rollup(deptno);


--cube�Լ�
--rollupó�� ���Ұ迡 ��ü�Ѱ���� �����ش�
select deptno, position, count(*), sum(pay)
from professor
group by cube(deptno,position);

--������ �Ѻ���
--Q1.emp���� ��տ����� 2000�̻��� �μ��� �μ���ȣ�� ��ձ޿��� ���Ͻÿ�
select empno �μ���ȣ, avg(sal)��ձ޿�
from emp
group by empno
having avg(sal)>=2000;

--Q2.emp���� deptno�� �ο�����?
select deptno �μ�, count(*)�ο���
from emp
group by deptno;

--Q3.emp���� job�� �ο����� ���Ͻÿ�(�� �ο��� 2���̻��ΰ��� ���� ��)
select job ����, count(*) �ο���
from emp
group by job
having count(*)>=2;

--Q4.emp���� job�� �޿��հ踦 ���ϴµ� (president�� ������ ��) �޿��հ谡 5000�̻� ���Ͻð� 
--�޿��հ谡 �����ͺ��� ����Ͻÿ�
select job ����, sum(sal) �޿��հ�
from emp
where job not in('PRESIDENT')--president ����
group by job --job �׷캰
having sum(sal)>=5000--�޿��հ谡 5000�̻�
order by sum(sal) desc;--�޿��հ� ��������

--��������
--constraint
--���̺����
create table sawon(
num number(5) constraint sawon_pk_num primary key,
name varchar2(20),
gender varchar2(10),
buseo varchar2(20) constraint sawon_ck_buseo check(buseo in('ȫ����','�λ��','������')),
pay number(10) default 2000000);

--����������
create sequence seq_sawon nocache;
--������ 10������ insert
--insert into sawon values (seq_sawon.nextval, 'ȫ�浿','����','���Ӱ��ߺ�',3500000);
insert into sawon values (seq_sawon.nextval, 'ȫ�浿','����','ȫ����',3500000);
insert into sawon values (seq_sawon.nextval, 'ȫ���','����','ȫ����',2000000);
insert into sawon values (seq_sawon.nextval, '�̸���','����','������',4000000);
insert into sawon values (seq_sawon.nextval, '��â��','����','�λ��',4650000);
insert into sawon values (seq_sawon.nextval, '�̿���','����','�λ��',2000000);
insert into sawon values (seq_sawon.nextval, '���ֿ�','����','ȫ����',3000000);
insert into sawon values (seq_sawon.nextval, '���浵','����','������',3500000);
insert into sawon values (seq_sawon.nextval, '������','����','ȫ����',2000000);
insert into sawon values (seq_sawon.nextval, '�迵ö','����','�λ��',8000000);
insert into sawon values (seq_sawon.nextval, '�̿���','����','������',6500000);
commit;

--�μ��� �ο����� �ְ�޿�, �����޿�, ��ȸ
--���� ���������� �ְ�޿�,�����޿��� ȭ����� ������ 3�ڸ� �ĸ��� ������ ���ּ���
select buseo �μ�, count(*) �ο���, to_char(max(pay),'L999,999,999') �ְ�޿�, to_char(min(pay),'L999,999,999') �����޿�
from sawon
group by buseo;

--���� �ο����� ��ձ޿��� ���(�ο��� �ڿ� ���̶�� ��������)
select gender ����, count(*)||'��' �ο���, avg(pay)��ձ޿�
from sawon
group by gender;
select * from sawon;

--�μ��� �ο����� ��ձ޿��� ���ϵ� �ο��� 4�� �̻��� ��쿡�� ���
select buseo �μ�, count(*)�ο�, avg(pay) ��ձ޿�
from sawon
group by buseo
having count(*)>=4;









