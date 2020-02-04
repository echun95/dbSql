--CROSS JOIN
--조인하는 두 테이블의 연결 조건이 누락된경우
--가능한 모든 조합에 대해 연결(조인)이 시도
--dept(4건), emp(14)의 cross join의 결과는 4*14 = 56건
--cross join -> 카티션 프로덕트(cartesian product)

SELECT d.dname, e.empno, e.ename
from dept d cross join emp e 
where d.deptno = 10 and d.deptno = e.deptno;

select c.cid,c.cnm,p.pid,p.pnm
from customer c cross join product p
order by C.Cid;

--SMITH가 속한 부서에 속하는 직원들의 정보를 조회
--1.SMITH가 속하는 부서 번호를 구한다.
--2.1번에서 구한 부서번호에 속하는 직원 정보를 조회

select deptno
from emp 
where ename = 'SMITH';

select *
from emp
where deptno = 20;

--SUBQUERY를 이용하면 두개의 쿼리를 동시에 하나의 SQL로 실행이 가능
select *
from emp
where deptno = 20;

select *
from emp
where deptno = (select deptno 
                from emp
                where ename = 'SMITH');
                     
--subquery : 쿼리안에 다른 쿼리가 들어가있는 경우
--subquery : 사용된 위치에 따라 3가지로 분류
--select 절 : scalar subquery : 하나의 행, 하나의 컬럼만 리턴해야 에러가 발생하지 않음
--from 절 : inline view
--where 절 : subquery

select count(*)
from emp
where sal > (select avg(sal) 
             from emp);
        
--다중행 연산자        
--IN : 서브쿼리의 여러행 중 일치하는 값이 존재 할 때
--ANY [활용도는 다소 떨어짐] : 서브쿼리의 여러행 중 한 행이라도 조건을 만족할 때 
--ALL [활용도는 다소 떨어짐] :서브쿼리의 여러행이 모든 행에 대해 조건을 만족할 때

--SMITH와 WARD직원이 속하는 부서의 모든직원을 조회
select *
from emp
where deptno in (select deptno
                 from emp
                 where ename = 'SMITH' or ename = 'WARD');

--SMITH, WARD 사원이의 급여보다 급여가 작은 직원을 조회(SMITH, WARD의 급여중 아무거나)
select *
from emp 
where sal < any(select sal
               from emp
               where ename in('SMITH','WARD'));

--SMITH, WARD 사원이의 급여보다 급여가 높은 직원을 조회(SMITH, WARD의 급여 2가지 모두에 대해 높을 때)
select *
from emp 
where sal > all(select sal
               from emp
               where ename in('SMITH','WARD'));

--직원의 관리자 사번이 7902이나 null
select *
from emp
where mgr in (7902,null);

select *
from emp
where mgr = 7902 or mgr is null;

--사원번호가 7902가 아니면서 null이 아닌 데이터 not in(7902,null)
select *
from emp
where mgr != 7902 and mgr is not null;

select *
from emp
where (mgr, deptno) in (select mgr, deptno
                        from emp
                        where empno in(7499, 7782));
--non-pairwise는 순서쌍을 동시에 만족시키지 않는 형태로 작성
--mgr 값이 7698이거나 7839이면서 deptno가 10번이거나 30번인 직원
--mgr, deptno
--(7698, 10), (7698, 30), (7839, 10), (7839, 10)

select *
from emp
where mgr in (select mgr
              from emp
              where empno in (7499, 7782))
              and
     deptno in (select deptno
              from emp
              where empno in (7499, 7782))
;

--스칼라 서브쿼리 : select 절에 기술, 1개의 row, 1개의 col을 조회하는 쿼리
--스칼라 서브쿼리는 main 쿼리의 컬럼을 사용하는게 가능하다.
select (select sysdate from dual), dept.*
from dept;

select empno, ename, deptno
from emp;

select empno, ename, deptno, (select dname from dept where deptno= emp.deptno) dname
from emp;

--inline view : from 절에 기술되는 서브쿼리;

--main 쿼리의 컬럼을 subquery에서 사용하는지 유무에 따른 분류
--사용할 경우 : correlated subquery(상호 연관 쿼리), 서브쿼리만 단독으로 실행하는게 불가능함
--사용하지 않을 경우 : non-correlated subquery(비상호 연관 쿼리), 서브쿼리만 단독으로 실행하는게 가능함

--모든 직원의 급여 평균보다 급여가 높은 사람을 조회
select *
from emp
where sal > (select avg(sal) from emp);

--직원이 속한 부서의 급여 평균보다 급여가 높은 사람을 조회
select *
from emp m
where  sal > (select avg(sal)
              from emp e
              where e. deptno = m.deptno);

select m.* 
from emp m join (select deptno, avg(sal) avgsal 
                 from emp group by deptno) e on ( m.deptno = e.deptno and m.sal > e.avgsal);

--데이터 추가
insert into dept Values(99,'ddit','daejeon');
commit;

select *
from dept 
where deptno not in (select deptno
                     from emp
                     group by deptno
);

