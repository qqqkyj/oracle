--<����>
--Q1.emp���� job�������� �������� �ѹ����� ����غ�����
select * from emp;
select distinct job ���� from emp;
--Q2.emp���̺��� ������� A�� S�� �����ϴ� ����� ����غ�����(�����ȣ �����)
select empno �����ȣ ,ename ����� from emp where ename like 'S%' union
select empno �����ȣ ,ename ����� from emp where ename like 'A%';
select empno �����ȣ ,ename ����� from emp where ename like 'A%' or ename like 'S%';
--Q3.emp���� deptno�� 10�κμ��� ����Ͻÿ�(����� �μ���ȣ)
select ename �����, deptno �μ���ȣ from emp where deptno=10;
--Q4.emp���� �޿�(sal)�� ��պ��� �� ���� ����� ����� �޿��� ���
select ename �����, sal �޿� from emp where sal>(select avg(sal) from emp);
--Q5.SCOTT�� �޿��� �����ϰų� �� ���� �޴� ����� ������ �޿��� ���
select ename �����, sal �޿� from emp where sal>=(select sal from emp where ename='SCOTT');
--Q6.emp���� hiredate���� ���� 5���� ����� ����� �Ի����� ���(to_char���)
select ename  �����, hiredate �Ի����� from emp where to_char(hiredate,'mm')='05';

--7��7�� study
--1.���̺� ����
--primary key�� �⺻Ű�� �ǹ� not null+unique�� �ǹ�
--test���̺�
create table test
(num number(5) primary key,
name VARCHAR2(20),--������ char
score number(6,2),
birth date);

desc test;--test ��������
select * from test;
--test�� ��ü������ insert
insert into test values(1,'�ռ���',67.2,'1997-11-11');
--test�� �Ϻε����� insert
insert into test(num,name) values (2,'��ȣ��');
--insert ����(primary key���� �ߺ����� ���� ������ �߻�=>���Ἲ ���� ���� ����)
insert into test values(2,'�̿���',68.25,'1956-10-12');--�̹� num2�� ����
insert into test values(4,'�̿���',68.25,'1956-10-12');
--sysdate���糯¥ �ǹ�
insert into test values(5,'��ȿ��',88.26,sysdate);
--alter
--���̸� ������ �÷� �߰�, ������ null�� �߰�
--alter table ���̺�� add �߰��� �÷��� ������Ÿ��;
alter table test add age number(5);
--�ּҸ� ������ �÷��� �߰��ϴµ� �ʱⰪ�� ��������� ����=>default������ �ʱⰪ ����
alter table test add addr varchar2(30) default '������';
--SQL ����: ORA-12899: "JOONY"."TEST"."ADDR" ���� ���� ���� �ʹ� ŭ
--insert into test values(4,'�̿���',68.25,'1956-10-12',22,'���ѹα��ƾƶ�󤿤ӾƾƤӤӤ�������������������������������');
--�ּ� �����÷� 30=>50
--alter table ���̺�� modify �÷��� ������Ÿ��;
alter table test modify addr varchar2(50);

--ageŸ���� ���ڿ�(10)���� �����ϰ� �ʱⰪ�� 20���� �����ϱ�
alter table test modify age varchar2(10) default '20';
insert into test(num,name) values (6,'��ȣ��');

--num�� �������� ���
select * from test order by num;--asc
select * from test order by num desc;--desc

--alter(Į������)
--drop(����)
--alter table ���̺�� drop column ������Į����
--age��� �÷��� ����
alter table test drop column age;
-addr����
alter table test drop column addr;
--column�� ����
--update table ���̺�� rename column old�÷��� to new�÷���
alter table test rename column score to jumsu;
--birth==>birthday
alter table test rename column birth to birthday;
--���̺� ���� test
drop table test;

--������ ����
--������ �⺻���� ����, 1���� 1�� �����ϴ� ������ ������
create sequence seq1;
--��ü������ Ȯ��
select * from seq;
--���� ���������� �߻� �ֿܼ� ���(nextval)
select seq1.nextval from dual;
--���� ������ �߻��� ��������(currval)
select seq1.currval from dual;
--sql1����
drop sequence seq1;
--10���� 5�� �����ϴ� ����������-cache�� ����
create sequence seq2 start with 10 increment by 5 nocache;
--�������߻�
select seq2.nextval from dual;
--������ ����
drop sequence seq2;

--seq1:���۰�:5 ������:2 ����:30 ĳ��:no, cycle:y
create sequence seq1 start with 5 increment by 2 maxvalue 30 nocache cycle;
--seq2:���۰� 1 ������1 cache:n
create sequence seq2 nocache;
--seq3: ���۰� 1 ������2 cache:n
create sequence seq3 start with 1 increment by 2 nocache;
--���
select seq1.nextval, seq2.nextval, seq3.nextval from dual;
--��ü ����
drop sequence seq1;
drop sequence seq2;
drop sequence seq3;
--------------------������1������, ���̺����
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
insert into personinfo values (seq_start.nextval, 'ȫ�浿','�����Ͼ�','����',23,'010-5645-5656','1989-05-01');
insert into personinfo values (seq_start.nextval, 'ȫ���','�����Ͼ�','����',22,'010-5623-2626','1980-05-01');
insert into personinfo values (seq_start.nextval, '�����','�ֺ�','����',45,'010-9856-5656','1978-05-01');
insert into personinfo values (seq_start.nextval, '�����','�ֺ�','����',53,'010-5353-5656','1953-05-01');
insert into personinfo values (seq_start.nextval, '�ڱ���','ĳ��','����',63,'010-5645-5656','1978-05-01');
insert into personinfo values (seq_start.nextval, '������','ĳ��','����',63,'010-5645-5656','1970-05-01');
insert into personinfo values (seq_start.nextval, '�̼���','������','����',53,'010-5645-5656','1973-05-01');
insert into personinfo values (seq_start.nextval, '������','�����','����',32,'010-5645-5656','1989-05-01');
insert into personinfo values (seq_start.nextval, '���ں�','������','����',23,'010-5645-5656','2002-05-01');
insert into personinfo values (seq_start.nextval, '�����','����','����',33,'010-5645-5656','1989-05-01');
--**commit�� �ؾ� �������� insert�� �Ǵ� ��
commit;--��������




select * from personinfo order by age desc;
select * from personinfo order by 5 asc;--�÷���ȣ�ε� ��ȸ����
select * from personinfo order by gender,age desc;
select distinct job from personinfo;
--���� ȫ��
select * from personinfo where name like 'ȫ%';
--�̸��� �ι�° ���ڰ� ��
select * from personinfo where name like '_��%';
--�ڵ��� ������ �ڸ��� 5656�� ���
select * from personinfo where hp like '%5656';
--�Ի����ڰ� 5���� ���
select * from personinfo where to_char(ipsaday,'mm')='05';
--�Ի����ڰ� 89�� �λ��
select * from personinfo where to_char(ipsaday,'yy')='89';
--���̰� 20~30���� ���
select * from personinfo where age between 20 and 30;
--������ ���� �̰ų� �������� ���
select * from personinfo where job='����' or job='������';
--������ ������ �����ڰ� �ƴ� ���
select * from personinfo where job not in('����','������');
--��ճ���, �Ҽ��� ���ڸ��� ���ϱ�
select round(avg(age),1) from personinfo;

--�������(update)
--update ���̺�� set �÷�1='�����ҵ�����' where �÷�2='�����Ͱ�';
--3�� ���� ���� �����ϱ�, ������ ������ ��� �����Ͱ� �����ȴ� �����ʼ�
update personinfo set job='��ȣ��',age=35;
--�߸������ѵ����� ������� ��������
rollback;
--4����
update personinfo set job='��ȣ��',age=35 where num=4;
--�达�̸鼭 �ֺ��� ����� ������ ���ڷ� ����
update personinfo set gender='����' where name like '��%' and job='�ֺ�';
--num�� 8���� ����� ������ ����� �Ի����� 2000/12/25�� ����
update personinfo set job='����',ipsaday='2000/12/25' where num=8;
commit;--��������

--����
--delete from ���̺��
delete from personinfo;
rollback;
--5���� ����
delete from personinfo where num=5;
--�����߿��� ���̰� 25���̻� ��� ����
delete from personinfo where gender='����' and age>=25;

--�ڵ����� ***-***-****����
update personinfo set hp='***-***-****';
roll back;
select * from personinfo;

--���̺� ����
drop table personinfo;
--������ ����
select * from seq;
drop sequence seq_start;

--dept���� 30�� �μ��� �þ�Ʋ�� ����
update dept set dname='�þ�Ʋ';
select * from dept;
--emp���̺� TotalSal���� �ϳ� �߰�=>number(20)
alter table emp add TotalSal number(20);
select * from emp;
--emp���̺� TotSal�� sal�� comm�� ���� ������ ����
update emp set TotalSal=sal+nvl(comm,0);
--emp���� ward ����
select * from emp;
delete from emp where ename='WARD';
rollback;
--product���̺��� 100���� �������̷� ����
select * from product;
update product set p_name='��������' where p_code=100;
rollback;
