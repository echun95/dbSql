select m.mem_id, m.mem_name, p.prod_id, c.cart_qty
from member m join cart c on (m.mem_id = c.cart_member) join prod p on (c.cart_prod = p.prod_id);

select * 
from customer;

select *
from product;

select *
from cycle;

select c.cid, c.cnm, cycle.pid, cycle.day, cycle.cnt
from customer c join cycle on ( c.cid = cycle.cid)
where c.cnm = 'brown' or c.cnm = 'sally';

select c.cid, c.cnm, cycle.pid, p.pnm,cycle.day, cycle.cnt
from customer c join cycle on ( c.cid = cycle.cid) join product p on ( cycle.pid = p.pid )
where c.cnm = 'brown' or c.cnm = 'sally';

select c.cid, c.cnm, cycle.pid, p.pnm,cycle.day, cycle.cnt
from customer c join cycle on ( c.cid = cycle.cid) join product p on ( cycle.pid = p.pid )
;
--6번
select c.cid, c.cnm, cycle.pid, p.pnm, sum(cycle.cnt)
from customer c join cycle on ( c.cid = cycle.cid) join product p on ( cycle.pid = p.pid )
group by c.cid, c.cnm, cycle.pid, p.pnm;

select c.pid, p.pnm, sum(c.cnt)
from cycle c join product p on (c.pid = p.pid)
group by c.pid, p.pnm;

--OUTER JOIN
--두 테이블을 조인할 때 연결 조건을 만족 시키지 못하는 데이터를 기준으로 지정한 테이블의 데이터만이라도 조회 되게끔 하는 조인방식
--emp 테이블의 데이터는 총 14건이지만 아래와 같은 쿼리에서는 결과가 13건이 된다.(1건 조인실패)
select e.empno, e.ename, e.mgr, m.ename
from emp e join emp m on (e.mgr = m.empno);

--ansi outer
--1.조인에 실패하더라도 조회가 될 테이블을 선정 (매니저 정보가 없어도 사원정보는 나오게끔)

select e.empno, e.ename, e.mgr, m.ename
from emp m right outer join emp e on (e.mgr = m.empno);

--oracle outer join
--데이터가 없는 쪽의 테이블 컬럼 뒤에 (+) 기호를 붙여준다.
select e.empno, e.ename, e.mgr, m.ename
from emp e, emp m 
where e.mgr = m.empno(+);

--위에 sql을 안시 sql(outer join)으로 변경해보세요;
--매니저 부서번호가 10번인사람만 조회
--아래 left outer 조인은 실질적으로 outer조인이 아니다.
--아래 inner 조인과 결과가 동일하다.
select e.empno, e.ename, e.mgr, m.ename
from emp e left outer join emp m on (e.mgr = m.empno)
where m.deptno = 10;

--정상적인 outer조인
select e.empno, e.ename, e.mgr, m.ename
from emp e left outer join emp m on (e.mgr = m.empno and m.deptno = 10);

--오라클 outer join
--오라클 outer join시 기준 테이블의 반대편 테이블의 모든 컬럼에 (+)를 붙여야 outer조인이 정상적으로 동작한다.
--한 컬림이라도 누락하면 inner조인으로 동작

--아래의 oracle outer조인은 inner조인으로 동작 : m.deptno컬럼 이름에 (+)가 붙지 않음
select e.empno, e.ename, e.mgr, m.ename, m.deptno
from emp e, emp m
where e.mgr = m.empno(+) and m.deptno = 10;

select e.empno, e.ename, e.mgr, m.ename, m.deptno
from emp e, emp m
where e.mgr = m.empno(+) 
and m.deptno(+) = 10;

--사원 - 매니저간 right outer join
select empno, ename, mgr
from emp e;

select empno, ename
from emp m;

select e.empno, e.ename, e.mgr, m.ename
from emp e right outer join emp m on ( e.mgr = m.empno );

select e.empno, e.ename, e.mgr, m.ename
from emp e, emp m
where e.mgr(+) = m.empno ;

--full outer : left outer + right outer - 중복제거
select e.empno, e.ename, e.mgr, m.ename
from emp e full outer join emp m on ( e.mgr = m.empno );

select nvl(b.buy_date,to_date('2005/01/25','yyyy/mm/dd')), b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
from buyprod b right outer join prod p on (b.buy_prod = p.prod_id and B.Buy_Date = to_date('2005/01/25','yyyy/mm/dd'));












