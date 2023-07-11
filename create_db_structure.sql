--7/10��������
--Q1.emp���� ename�� empname���� ����
select * from emp;
alter table emp rename column ename to empname;
--Q2.gift���� 7�� ��Ʈ���� �����е�� ����
update gift set gname='�����е�' where gno=7;
--Q3.gift�� 10�� ������ 9000001~10000000 ������ �߰�
select * from gift;
insert into gift values(10,'������',9000001,10000000);
--Q4.member���� 1003 ������ ����� �����Ͻÿ�
select * from member;
delete from member where no=1003;
roll back;
--Q5.emp���� �Ի����� 82/01/23�� ����� �̸�,�μ���ȣ,�޿��� ���
select empname �����, deptno �μ���ȣ, sal �޿� from emp where to_char(hiredate)='82/01/23';
--Q6.emp���� �������� �ִ�޿�, �ּұ޿�, �ѱ޿�, ��ձ޿��� ���
select * from emp;
select job ������, max(sal)�ִ�޿�, min(sal) �ּұ޿�, sum(sal) �ѱ޿�, round(avg(sal),0)��ձ޿�
from emp
group by job;
--------------------------------------------------------------------------------------
--Join
--1.emp�� dept�� �����ؼ� emp������� �μ����� ���غ���
--����� �μ��� 
select e.empname, d.dname 
from emp e, dept d --allias
where e.deptno=d.deptno; --���� �ʼ�
--2.
select empname, dname--���̺��� �������� ��� e. d. ��������
from emp e, dept d 
where e.deptno=d.deptno; 
--student�� professor�� �����Ͽ� ������ ���� ���
--�й� �л��� ����������
select s.studno �й�, s.name �л���, p.name ����������
from student s, professor p
where s.profno=p.profno;
--�й� �л��� ��1������ ��2������
select s.studno �й�, s.name �л���, d.dname ��1������
from student s, department d
where s.deptno1=d.deptno;
--������ ���� �а���
select p.name ������, p.position ����, d.dname �а���
from professor p, department d
where p.deptno=d.deptno;
--�����ȣ ����� �ٹ�����
select e.empno �����ȣ, e.empname �����, d.loc �ٹ�����
from emp e, dept d
where e.deptno=d.deptno;
--�Ǹ����̺�
�Ǹ����� ��ǰ�� ��ü�Ǹž�
select pan.p_date �Ǹ�����, pro.p_name ��ǰ��, pan.p_total||'����' ��ü�Ǹž�
from product pro, panmae pan
where pan.p_code=pro.p_code;
------------------------------------------------------------------------
--primary Ű�� foreignŰ�� ������ �������̺�(�θ�,�ڽ�) �����

--������ ����
create sequence seq_shop;
--shop���̺�(�θ�)
create table shop(
shopnum number(5) primary key,
sangname varchar2(30), color varchar2(20));

--5���� ��ǰ�߰�
insert into shop values(seq_shop.nextval,'�䰡��Ʈ','pink');
insert into shop values(seq_shop.nextval,'�Ʒ�','black');
insert into shop values(seq_shop.nextval,'���뽺','beige');
insert into shop values(seq_shop.nextval,'����','white');
insert into shop values(seq_shop.nextval,'�縻','yellow');
select * from shop;
commit;--Ŀ�ԿϷ�

--cart1..��ǰ������ shop���̺��� shop_num���� �ܺ�Ű�� ����
create table cart1(
idx number(5) primary key,--�⺻Ű�� �ݵ�� �ʿ�
shop_num number(5) CONSTRAINT cart_fk_shopnum REFERENCES shop(shopnum),--shop���̺��� shopnum ����
cnt number(5),
guipday date);

--cart2..��ǰ������ shop���̺��� shop_num���� �ܺ�Ű�� ����
--�θ����̺��� ��ǰ�� ����� �׻�ǰ�� ����� īƮ�� �ڵ����� ����(on delete cascade)
create table cart2(
idx number(5) primary key,
shop_num number(5) references shop(shopnum)on delete cascade,--�θ����̺� ������ �ڽ����̺� ���� ����
cnt number(5),
guipday date);

--cart1��ǰ�߰�_1��
insert into cart1 values(seq_shop.nextval, 1, 2, sysdate);
insert into cart1 values(seq_shop.nextval, 3, 4, sysdate);
insert into cart1 values(seq_shop.nextval, 3, 2, sysdate);
insert into cart1 values(seq_shop.nextval, 5, 9, sysdate);
insert into cart1 values(seq_shop.nextval, 4, 2, sysdate);

delete from cart1 where shop_num=3;


insert into cart2 values(seq_shop.nextval, 1, 5, sysdate);
insert into cart2 values(seq_shop.nextval, 3, 2, sysdate);
insert into cart2 values(seq_shop.nextval, 4, 7, sysdate);
insert into cart2 values(seq_shop.nextval, 5, 2, sysdate);
insert into cart2 values(seq_shop.nextval, 3, 7, sysdate);
commit;

delete from cart2 where shop_num=4;

--cart1: �θ�1,4,5���� cart2:�θ�1,3,5

--shop�� 1�� ��ǰ ����?
select * from shop;
delete from shop where shopnum=1;--���Ἲ �������� ����(�ڽ� ���ڵ� �߰�)

--cart2���� 3�������� ����(on delete cascade�� �ڽ����̺� �ڵ� ����)
delete from shop where shopnum=3;
rollback;

--cart1�� ��� ��ǰ�� shop���̺�� join�ؼ� �ڼ��� ���
select c1.idx, s.shopnum, s.sangname, s.color, c1.cnt, c1.guipday
from shop s, cart1 c1
where s.shopnum=c1.shop_num;

--�θ����̺�
--menu ���̺�
--�θ� Menu���̺�� m_num:�⺻Ű, m_name:���ĸ�,price:����
--�ڽ� MyOrder���̺�� o_num:�⺻Ű, m_num:�ܺ�Ű, cnt:����, orderday:���糯¥



create sequence seq_menu;
create table Menu(
m_num number(5) primary key,
m_name varchar2(30),
price number(10));

insert into menu values(seq_menu.nextval,'��������',5000);
insert into menu values(seq_menu.nextval,'��ġ������',5500);
insert into menu values(seq_menu.nextval,'¥���',4500);
insert into menu values(seq_menu.nextval,'�߰����������',3000);
insert into menu values(seq_menu.nextval,'��ġ����',3500);
select * from menu;


--�ڽ����̺�(�ڽ����̺� ����� �θ� �־ �θ� ������ �� ������ �θ����̺������ �ڵ����� �ڽĻ���)=>on delete cascade
create table MyOrder(
o_num number(5) primary key,
m_num number(5) CONSTRAINT order_fk_m_num references menu(m_num) on delete cascade,
cnt number(10),
orderDay date);

insert into MyOrder values(seq_menu.nextval,1,5,sysdate);
insert into MyOrder values(seq_menu.nextval,2,3,sysdate);
insert into MyOrder values(seq_menu.nextval,3,2,sysdate);
insert into MyOrder values(seq_menu.nextval,4,4,sysdate);
insert into MyOrder values(seq_menu.nextval,5,7,sysdate);

--�������
--�ֹ���ȣ ���ĸ� ���� ���� �ֹ�����
select * from menu;
select * from myorder;

select o.o_num �ֹ���ȣ, m.m_name ���ĸ�,m.price ����, o.cnt ����, o.orderday �ֹ�����
from menu m, myorder o
where o.m_num=m.m_num;

commit;
---------------------------------------------------------------------------
--<�Խ��� db>
create table board(
bno number(3) constraint board_pk_bno primary key,
writer varchar2(20),
subject varchar2(100),
writeday date);


--board�� 5�� insert
insert into board values(seq_sawon.nextval,'�̼���','�ȳ� �ֵ��',sysdate);
insert into board values(seq_sawon.nextval,'ȫ�浿','��� �ֵ��',sysdate);
insert into board values(seq_sawon.nextval,'ȫ���','��� ������',sysdate);
insert into board values(seq_sawon.nextval,'������','���ť����',sysdate);
insert into board values(seq_sawon.nextval,'����','����',sysdate);

select * from board;
commit;

--answer��� ���(�ڽ�)
--�θ�� ����� �ڽı� �ڵ� ����
create table answer(
num number(5) constraint answer_pk_num primary key,
bno number(3) constraint answer_fk_bno references board(bno) on delete cascade,
nickname varchar2(20),
content varchar2(30),
writeday date);

--���ϴ� �ۿ� ����߰�
select * from board;
insert into answer values(seq_sawon.nextval, 14, '������','�׷��� ������',sysdate);
insert into answer values(seq_sawon.nextval, 15, '�Ѹ�','��������',sysdate);
insert into answer values(seq_sawon.nextval, 12, 'â��','�ȳ�~',sysdate);
insert into answer values(seq_sawon.nextval, 16, '����','������ �����ϴ� ��',sysdate);
insert into answer values(seq_sawon.nextval, 12, '������','�ȳ�',sysdate);
select * from answer;
select * from board;
commit;

--join���� ���
--���۹�ȣ �ۼ��� �ۼ��ڱ� ��۴ܻ�� ��۳��� ���۳�¥ ��۳�¥
select b.bno ���۹�ȣ, b.writer �ۼ���, b.subject �ۼ��ڱ�, a.nickname ��۾����, a.content ��۳���, b.writeday ���۳�¥, a.writeday ��۳�¥
from board b, answer a
where b.bno=a.bno;

--12�� ���� 
delete from board where bno=12;
select * from answer;

--board�� ���� ����
drop table board;--�ܷ� Ű�� ���� �����Ǵ� ���̺��� �ڽ����̺� ���� ���� �� ��������

--�ڽ����̺� ���� �� �θ����̺� ������ ����
drop table answer;
drop table board;
roll back;

--shop,cart��� ����
--�ܺ�Ű�� ������ �� ��� �ڽ����̺� ���� ������ �θ����̺� ��������
drop table cart1;
drop table cart2;
drop table shop;
roll back;

---------------------------------------------------------
--�����ֹ�db
create sequence seq_food;
---------------------------
create table food(
fno number(5) constraint food_pk_fno primary key,
foodname varchar2(20),
price number(20),
shopname varchar2(20),
loc varchar2(50));
----------food insert
insert into food values(seq_food.nextval,'��ġ�',6000,'�ҸӴ��','������ ���ﵿ');
insert into food values(seq_food.nextval,'�����',7000,'�ҸӴ��','������ ���ﵿ');
insert into food values(seq_food.nextval,'�ұ���',6000,'������','������ ������');
insert into food values(seq_food.nextval,'���',3000,'�Ѹ��н�','���ı� õȣ��');
insert into food values(seq_food.nextval,'���뱹',8000,'�ҸӴ��','������ ���ﵿ');
------------------------------------------------------------------------------------
create table jumun(
num number(5) constraint jumun_pk_num primary key,
name varchar2(20),
fno number(5) constraint food_fk_fno references food(fno) on delete cascade,
addr varchar2(50));
-----------jumun insert
insert into jumun values(seq_food.nextval,'ȫ�浿',2,'������ ���ﵿ');
insert into jumun values(seq_food.nextval,'ȫ���',6,'������ ���ﵿ');
insert into jumun values(seq_food.nextval,'��Ѹ�',5,'���ı� õȣ��');
insert into jumun values(seq_food.nextval,'����',4,'������ �Ͽ���');
insert into jumun values(seq_food.nextval,'�����',3,'������ ���ﵿ');

select * from jumun;
select * from food;
--=============================================
--�ֹ���ȣ �ֹ��� ���ĸ� ���� ��ȣ�� ������ġ �ֹ�����ġ
--�̷��� ��� �ֹ����̸��� ������������ ����� ��

------------food and jumun join
select j.num �ֹ���ȣ, j.name �ֹ��ڸ�, f.foodname ���ĸ�, to_char(f.price,'L999,999')||'��' ����,
f.shopname ��ȣ��, f.loc ������ġ, j.addr �ֹ�����ġ
from food f, jumun j
where f.fno=j.fno
order by j.name;

commit;
----------------------------------
create sequence seq_board;--primary key�� Ȱ���� sequence ����

create table snsboard(--���̺� ����
b_num number(5) constraint snsboard_pk_b_number primary key,--�⺻Ű
nick varchar2(20),--�ۼ��� �г���
subject varchar2(30),--����
content varchar2(100),--����
wday date);--�ۼ���¥

select * from snsboard;
insert into snsboard values(seq_board.nextval,'QQ�׻���','�Խ��Ǹ����','���̺��� �����ƿ�',sysdate);
insert into snsboard values(seq_board.nextval,'�����','jdbc','�ڹٿ� ����Ŭ�� ������ ���ƿ�',sysdate);
insert into snsboard values(seq_board.nextval,'������','������','�������ϰ�����',sysdate);
insert into snsboard values(seq_board.nextval,'����','������ �����','������ �ؾߵǳ�..',sysdate);
insert into snsboard values(seq_board.nextval,'����Ƽ','���Թ�','����ϸ� ����Ƽ',sysdate);
insert into snsboard values(seq_board.nextval,'��Ʃ��','��Ʃ��','�ȳ��ϼ��� ���Z�Դϴ�',sysdate);
insert into snsboard values(seq_board.nextval,'QQ�׻���','�Խ��Ǹ����2','���̺� ����� �׽�Ʈ��',sysdate);
insert into snsboard values(seq_board.nextval,'����Ŭ','����','������ ���� ��',sysdate);
insert into snsboard values(seq_board.nextval,'ũ����','ũ���������׵�','���� �ſ�',sysdate);
insert into snsboard values(seq_board.nextval,'�δ��ݸ�','����ü��Ʈ����','�������պ��̺�',sysdate);

commit;

select * from snsboard;




