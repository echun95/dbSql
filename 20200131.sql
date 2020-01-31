--JOIN  두 테이블을 연결하는 작업
--JOIN 문법
--1. ANSI 문법
--2. ORACLE 문법

-- Natural Join
-- 두 테이블간 컬럼명이 같을 때 해당 컬럼으로 연결(조인)
-- emp, dept 테이블에는 deptno 라는 컬럼이 존재
SELECT *
FROM emp NATURAL JOIN dept;
    
--Natural join에 사용된 조언 컬럼(deptno)는 한정자를 사용하지 않고 컬럼명만 기술한다.(dept.deptno ->deptno)
SELECT emp.empno, emp.ename, dept.dname, deptno
FROM emp NATURAL JOIN dept;

--테이블에 대한 별칭도 사용가능
SELECT e.empno, e.ename, d.dname, deptno
FROM emp e NATURAL JOIN dept d;

--ORACLE JOIN
--FROM 절에 조인할 테이블 목록을 ,로 구분한다.
--조인할 테이블의 연결조건을 where절에 기술한다.
--emp, dept 테이블에 존재하는 deptno 컬럼이 (같을 때) 조인

SELECT emp.empno, emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : join with using
--조인하려는 두개의 테이블에 이름이 같은 컬럼이 두개지만 하나의 컬럼으로만 조인을 하고자 할 때 조인하려는 기준 컬럼을 기술
--emp, dept 테이블의 공통 컬럼 : deptno
SELECT emp.ename, dept.dname, deptno
FROM emp join dept using (deptno);

--join with using 을 ORACLE로 표현하면?
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept 
where emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
SELECT emp.ename, dept.dname, emp.deptno
FROM emp join dept on (emp.deptno = dept.deptno);

--ORACLE : JOIN WITH ON
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept 
where emp.deptno = dept.deptno;

--SELF JOIN : 같은 테이블간의 조인
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e join emp m on(e.mgr = m.empno);

--오라클 문법으로 작성
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--equal 조인 : =  non-equal 조인 : !=, >, <, between and
--사원의 급여 정보와 급여 등급 테이블을 이용하여 해당사원의 급여 등급을 구해보자.
select ename,sal
from emp;

select *
from salgrade;

select e.ename, e.sal, s.grade
from emp e join salgrade s on(e.sal between s.losal and s.hisal);

select e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal;

select e.empno, e.ename, e.deptno, d.dname
from emp e join dept d on(e.deptno = d.deptno);

select e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e join dept d on (e.deptno = d.deptno) 
where sal > 2500
order by deptno;

select e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e join dept d on (e.deptno = d.deptno) 
where sal > 2500 AND empno>7600
order by deptno;

select e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e join dept d on (e.deptno = d.deptno) 
where sal > 2500 AND empno>7600 AND dname = 'RESEARCH'
order by deptno;


select *
from prod;

select *
from lprod;

SELECT l.lprod_gu, l.lprod_nm, p.prod_id, p.prod_name
FROM lprod l JOIN prod p On(l.lprod_gu = p.prod_lgu);

select b.buyer_id, b.buyer_name, p.prod_id, p.prod_name
from prod p join buyer b on (p.prod_buyer = b.buyer_id);











