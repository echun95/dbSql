--JOIN  �� ���̺��� �����ϴ� �۾�
--JOIN ����
--1. ANSI ����
--2. ORACLE ����

-- Natural Join
-- �� ���̺� �÷����� ���� �� �ش� �÷����� ����(����)
-- emp, dept ���̺��� deptno ��� �÷��� ����
SELECT *
FROM emp NATURAL JOIN dept;
    
--Natural join�� ���� ���� �÷�(deptno)�� �����ڸ� ������� �ʰ� �÷��� ����Ѵ�.(dept.deptno ->deptno)
SELECT emp.empno, emp.ename, dept.dname, deptno
FROM emp NATURAL JOIN dept;

--���̺� ���� ��Ī�� ��밡��
SELECT e.empno, e.ename, d.dname, deptno
FROM emp e NATURAL JOIN dept d;

--ORACLE JOIN
--FROM ���� ������ ���̺� ����� ,�� �����Ѵ�.
--������ ���̺��� ���������� where���� ����Ѵ�.
--emp, dept ���̺� �����ϴ� deptno �÷��� (���� ��) ����

SELECT emp.empno, emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : join with using
--�����Ϸ��� �ΰ��� ���̺� �̸��� ���� �÷��� �ΰ����� �ϳ��� �÷����θ� ������ �ϰ��� �� �� �����Ϸ��� ���� �÷��� ���
--emp, dept ���̺��� ���� �÷� : deptno
SELECT emp.ename, dept.dname, deptno
FROM emp join dept using (deptno);

--join with using �� ORACLE�� ǥ���ϸ�?
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

--SELF JOIN : ���� ���̺��� ����
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e join emp m on(e.mgr = m.empno);

--����Ŭ �������� �ۼ�
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--equal ���� : =  non-equal ���� : !=, >, <, between and
--����� �޿� ������ �޿� ��� ���̺��� �̿��Ͽ� �ش����� �޿� ����� ���غ���.
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











