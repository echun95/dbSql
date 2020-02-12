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

3번째 인덱스를 지우자
3,4번째 인덱스가 컬럼구성이 동일하고 순서만 다르다
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
(emp-pk_emp, dept-pk_dept) 순서 바꾸는것까지 총 8개 

1.순서
2개 테이블 조인
각각의 테이블에 인덱스 5개씩 있다면 
한 테이블에 접근 전략 : 6개
36 * 2 = 72

ORALCE - 실시간 응답 : OLTP (ON LINE TRANSACTION PROCESSING)
         전체 처리시간 : OLAP (ON LINE ANALYSIS PROCESSING) - 복잡한 쿼리의 실행계획을 세우는데 30분~1시간소요;
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
=====================문제=====================
empno(=)
ename(=)

deptno(=), empno(like 직원번호%) => empno, deptno
deptno(=),sal(between)
deptno(=) / mgr 동반하면 유리
deptno, hiredate가 인덱스 존재하면 유리

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

 
