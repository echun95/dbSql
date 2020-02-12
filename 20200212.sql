1.table full
2.idx1 : empno
3.idx2 : job;

EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

CREATE INDEX idx_n_emp03 ON emp(job,ename);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER' AND ename LIKE '%C';

SELECT *
FROM TABLE(dbms_xplan.display);

1.table full
2.idx1 : empno
3.idx2 : job
4.idx3 : job  + ename
5.idx4 : ename + job;
CREATE INDEX idx_n_emp04 ON emp(ename,job);

SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;

3��° �ε����� ������
3,4��° �ε����� �÷������� �����ϰ� ������ �ٸ���
DROP INDEX idx_n_emp03;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER' AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

emp - table full, pk_emp(empno)
dept - table full, pk_dept(deptno)

(emp-table full, dept-table full) 
(emp-table full, dept-pk_dept)
(emp-pk_emp, dept-table full)
(emp-pk_emp, dept-pk_dept) ���� �ٲٴ°ͱ��� �� 8�� 

1.����
2�� ���̺� ����
������ ���̺� �ε��� 5���� �ִٸ� 
�� ���̺� ���� ���� : 6��
36 * 2 = 72

ORALCE - �ǽð� ���� : OLTP (ON LINE TRANSACTION PROCESSING)
         ��ü ó���ð� : OLAP (ON LINE ANALYSIS PROCESSING) - ������ ������ �����ȹ�� ����µ� 30��~1�ð��ҿ�;
EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

SELECT *
FROM TABLE(dbms_xplan.display);

CREATE TABLE DEPT_TEST2 AS 
SELECT *
FROM DEPT 
WHERE 1 = 1;

CREATE UNIQUE INDEX idx_dept01 ON dept_test2(deptno);
CREATE INDEX idx_n_dept02 ON dept_test2(dname);
CREATE INDEX idx_n_dept03 ON dept_test2(deptno, dname);

DROP INDEX idx_dept01;
DROP INDEX idx_n_dept02;
DROP INDEX idx_n_dept03;




CREATE TABLE emp_2 AS 
SELECT *
FROM emp
WHERE 1 = 1;

CREATE TABLE DEPT_2 AS 
SELECT *
FROM DEPT 
WHERE 1 = 1;
=====================����=====================
empno(=)
ename(=)

deptno(=), empno(like ������ȣ%) => empno, deptno
deptno(=),sal(between)
deptno(=) / mgr �����ϸ� ����
deptno, hiredate�� �ε��� �����ϸ� ����

emp - empno(unique), ename, deptno, ;


CREATE INDEX idx_n_emp_2_04 ON emp_2(deptno);
CREATE UNIQUE INDEX idx_dept_2_01 ON dept_2(deptno);
CREATE UNIQUE INDEX idx_emp_2_01 ON emp_2(empno);
DROP INDEX idx_n_emp_2_04;

EXPLAIN PLAN FOR
SELECT *    
FROM emp_2 a, emp_2 b
WHERE a.mgr = b.empno 
and a.deptno = 20;

SELECT *
FROM TABLE(dbms_xplan.display);

 
