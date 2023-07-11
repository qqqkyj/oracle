--7/10복습문제
--Q1.emp에서 ename을 empname으로 변경
select * from emp;
alter table emp rename column ename to empname;
--Q2.gift에서 7번 노트북을 아이패드로 변경
update gift set gname='아이패드' where gno=7;
--Q3.gift에 10번 아이폰 9000001~10000000 한행을 추가
select * from gift;
insert into gift values(10,'아이폰',9000001,10000000);
--Q4.member에서 1003 서새알 멤버를 삭제하시오
select * from member;
delete from member where no=1003;
roll back;
--Q5.emp에서 입사일이 82/01/23인 사원의 이름,부서번호,급여를 출력
select empname 사원명, deptno 부서번호, sal 급여 from emp where to_char(hiredate)='82/01/23';
--Q6.emp에서 직무별로 최대급여, 최소급여, 총급여, 평균급여를 출력
select * from emp;
select job 직무별, max(sal)최대급여, min(sal) 최소급여, sum(sal) 총급여, round(avg(sal),0)평균급여
from emp
group by job;
--------------------------------------------------------------------------------------
--Join
--1.emp와 dept를 조인해서 emp사람들의 부서명을 구해보자
--사원명 부서명 
select e.empname, d.dname 
from emp e, dept d --allias
where e.deptno=d.deptno; --조건 필수
--2.
select empname, dname--테이블의 고유명일 경우 e. d. 생략가능
from emp e, dept d 
where e.deptno=d.deptno; 
--student와 professor를 조인하여 다음과 같이 출력
--학번 학생명 지도교수명
select s.studno 학번, s.name 학생명, p.name 지도교수명
from student s, professor p
where s.profno=p.profno;
--학번 학생명 제1전공명 제2전공명
select s.studno 학번, s.name 학생명, d.dname 제1전공명
from student s, department d
where s.deptno1=d.deptno;
--교수명 직급 학과명
select p.name 교수명, p.position 직급, d.dname 학과명
from professor p, department d
where p.deptno=d.deptno;
--사원번호 사원명 근무도시
select e.empno 사원번호, e.empname 사원명, d.loc 근무도시
from emp e, dept d
where e.deptno=d.deptno;
--판매테이블
판매일자 제품명 전체판매액
select pan.p_date 판매일자, pro.p_name 제품명, pan.p_total||'만원' 전체판매액
from product pro, panmae pan
where pan.p_code=pro.p_code;
------------------------------------------------------------------------
--primary 키와 foreign키를 생성한 조인테이블(부모,자식) 만들기

--시퀀스 생성
create sequence seq_shop;
--shop테이블(부모)
create table shop(
shopnum number(5) primary key,
sangname varchar2(30), color varchar2(20));

--5개의 상품추가
insert into shop values(seq_shop.nextval,'요가매트','pink');
insert into shop values(seq_shop.nextval,'아령','black');
insert into shop values(seq_shop.nextval,'레깅스','beige');
insert into shop values(seq_shop.nextval,'져지','white');
insert into shop values(seq_shop.nextval,'양말','yellow');
select * from shop;
commit;--커밋완료

--cart1..상품정보는 shop테이블의 shop_num값을 외부키로 지정
create table cart1(
idx number(5) primary key,--기본키는 반드시 필요
shop_num number(5) CONSTRAINT cart_fk_shopnum REFERENCES shop(shopnum),--shop테이블의 shopnum 참조
cnt number(5),
guipday date);

--cart2..상품정보는 shop테이블의 shop_num값을 외부키로 지정
--부모테이블의 상품을 지우면 그상품과 연결된 카트를 자동으로 삭제(on delete cascade)
create table cart2(
idx number(5) primary key,
shop_num number(5) references shop(shopnum)on delete cascade,--부모테이블 삭제시 자식테이블도 같이 삭제
cnt number(5),
guipday date);

--cart1상품추가_1번
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

--cart1: 부모1,4,5존재 cart2:부모1,3,5

--shop의 1번 상품 삭제?
select * from shop;
delete from shop where shopnum=1;--무결성 제약조건 위배(자식 레코드 발견)

--cart2에서 3번데이터 삭제(on delete cascade로 자식테이블도 자동 삭제)
delete from shop where shopnum=3;
rollback;

--cart1에 담긴 상품을 shop테이블과 join해서 자세히 출력
select c1.idx, s.shopnum, s.sangname, s.color, c1.cnt, c1.guipday
from shop s, cart1 c1
where s.shopnum=c1.shop_num;

--부모테이블
--menu 테이블
--부모 Menu테이블명 m_num:기본키, m_name:음식명,price:가격
--자식 MyOrder테이블명 o_num:기본키, m_num:외부키, cnt:숫자, orderday:현재날짜



create sequence seq_menu;
create table Menu(
m_num number(5) primary key,
m_name varchar2(30),
price number(10));

insert into menu values(seq_menu.nextval,'제육볶음',5000);
insert into menu values(seq_menu.nextval,'김치볶음밥',5500);
insert into menu values(seq_menu.nextval,'짜장밥',4500);
insert into menu values(seq_menu.nextval,'닭가슴살샐러드',3000);
insert into menu values(seq_menu.nextval,'잔치국수',3500);
select * from menu;


--자식테이블(자식테이블에 연결된 부모가 있어도 부모를 삭제할 수 있으며 부모테이블삭제시 자동으로 자식삭제)=>on delete cascade
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

--최종출력
--주문번호 음식명 가격 개수 주무일자
select * from menu;
select * from myorder;

select o.o_num 주문번호, m.m_name 음식명,m.price 가격, o.cnt 개수, o.orderday 주문일자
from menu m, myorder o
where o.m_num=m.m_num;

commit;
---------------------------------------------------------------------------
--<게시판 db>
create table board(
bno number(3) constraint board_pk_bno primary key,
writer varchar2(20),
subject varchar2(100),
writeday date);


--board에 5개 insert
insert into board values(seq_sawon.nextval,'이수연','안녕 애들아',sysdate);
insert into board values(seq_sawon.nextval,'홍길동','얄루 애들아',sysdate);
insert into board values(seq_sawon.nextval,'홍길순','날찌가 좋구마',sysdate);
insert into board values(seq_sawon.nextval,'강연주','루미큐브중',sysdate);
insert into board values(seq_sawon.nextval,'흑자','훅하',sysdate);

select * from board;
commit;

--answer라는 댓글(자식)
--부모글 지우면 자식글 자동 삭제
create table answer(
num number(5) constraint answer_pk_num primary key,
bno number(3) constraint answer_fk_bno references board(bno) on delete cascade,
nickname varchar2(20),
content varchar2(30),
writeday date);

--원하는 글에 댓글추가
select * from board;
insert into answer values(seq_sawon.nextval, 14, '영지니','그러게 좋구마',sysdate);
insert into answer values(seq_sawon.nextval, 15, '둘리','같이하자',sysdate);
insert into answer values(seq_sawon.nextval, 12, '창희','안녕~',sysdate);
insert into answer values(seq_sawon.nextval, 16, '말왕','오늘은 가슴하는 날',sysdate);
insert into answer values(seq_sawon.nextval, 12, '영지니','안녕',sysdate);
select * from answer;
select * from board;
commit;

--join으로 출력
--원글번호 작성자 작성자글 댓글단사람 댓글내용 원글날짜 댓글날짜
select b.bno 원글번호, b.writer 작성자, b.subject 작성자글, a.nickname 댓글쓴사람, a.content 댓글내용, b.writeday 원글날짜, a.writeday 댓글날짜
from board b, answer a
where b.bno=a.bno;

--12번 원글 
delete from board where bno=12;
select * from answer;

--board를 먼저 삭제
drop table board;--외래 키에 의해 참조되는 테이블은 자식테이블 먼저 삭제 후 삭제가능

--자식테이블 삭제 후 부모테이블 삭제는 가능
drop table answer;
drop table board;
roll back;

--shop,cart모두 삭제
--외부키로 연결이 된 경우 자식테이블 먼저 삭제후 부모테이블 삭제가능
drop table cart1;
drop table cart2;
drop table shop;
roll back;

---------------------------------------------------------
--음식주문db
create sequence seq_food;
---------------------------
create table food(
fno number(5) constraint food_pk_fno primary key,
foodname varchar2(20),
price number(20),
shopname varchar2(20),
loc varchar2(50));
----------food insert
insert into food values(seq_food.nextval,'김치찌개',6000,'할머니찌개','강남구 역삼동');
insert into food values(seq_food.nextval,'된장찌개',7000,'할머니찌개','강남구 역삼동');
insert into food values(seq_food.nextval,'쌀국수',6000,'포베이','강남구 개포동');
insert into food values(seq_food.nextval,'라면',3000,'둘리분식','송파구 천호동');
insert into food values(seq_food.nextval,'순대국',8000,'할머니찌개','강남구 역삼동');
------------------------------------------------------------------------------------
create table jumun(
num number(5) constraint jumun_pk_num primary key,
name varchar2(20),
fno number(5) constraint food_fk_fno references food(fno) on delete cascade,
addr varchar2(50));
-----------jumun insert
insert into jumun values(seq_food.nextval,'홍길동',2,'강남구 역삼동');
insert into jumun values(seq_food.nextval,'홍길순',6,'강남구 역삼동');
insert into jumun values(seq_food.nextval,'김둘리',5,'송파구 천호동');
insert into jumun values(seq_food.nextval,'김희동',4,'강남구 일원동');
insert into jumun values(seq_food.nextval,'김라희',3,'강남구 역삼동');

select * from jumun;
select * from food;
--=============================================
--주문번호 주문자 음식명 가격 상호명 가게위치 주문자위치
--이렇게 출력 주문자이름이 오름차순으로 출력할 것

------------food and jumun join
select j.num 주문번호, j.name 주문자명, f.foodname 음식명, to_char(f.price,'L999,999')||'원' 가격,
f.shopname 상호명, f.loc 가게위치, j.addr 주문자위치
from food f, jumun j
where f.fno=j.fno
order by j.name;

commit;
----------------------------------
create sequence seq_board;--primary key로 활용한 sequence 생성

create table snsboard(--테이블 생성
b_num number(5) constraint snsboard_pk_b_number primary key,--기본키
nick varchar2(20),--작성자 닉네임
subject varchar2(30),--제목
content varchar2(100),--내용
wday date);--작성날짜

select * from snsboard;
insert into snsboard values(seq_board.nextval,'QQ뿡뿡이','게시판만들기','테이블을 만들어보아요',sysdate);
insert into snsboard values(seq_board.nextval,'요롱이','jdbc','자바와 오라클을 연동해 보아요',sysdate);
insert into snsboard values(seq_board.nextval,'공룡이','공부중','하하하하공부중',sysdate);
insert into snsboard values(seq_board.nextval,'말왕','오늘은 가슴운동','뭐부터 해야되나..',sysdate);
insert into snsboard values(seq_board.nextval,'지피티','라면먹방','라면하면 지피티',sysdate);
insert into snsboard values(seq_board.nextval,'곽튜브','유튜버','안녕하세요 곽튭입니다',sysdate);
insert into snsboard values(seq_board.nextval,'QQ뿡뿡이','게시판만들기2','테이블 만들기 테스트중',sysdate);
insert into snsboard values(seq_board.nextval,'오라클','연동','연동해 보는 중',sysdate);
insert into snsboard values(seq_board.nextval,'크리스','크리스범스테드','헤이 매엔',sysdate);
insert into snsboard values(seq_board.nextval,'로니콜먼','월드체스트데이','이지웨잇베이베',sysdate);

commit;

select * from snsboard;




