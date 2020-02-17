SELECT deptno, job, sum(sal+nvl(comm,0))
FROM emp
GROUP BY ROLLUP(deptno, job);

SELECT dept.dname, emp.job,sum(sal+nvl(comm,0))
FROM emp join dept on(emp.deptno = dept.deptno)
GROUP BY ROLLUP(dept.dname, emp.job)
ORDER BY dname,job desc;


SELECT  b.dname, a.job, a.esum
FROM
(SELECT deptno, job, sum(sal+nvl(comm,0))esum
FROM emp
GROUP BY ROLLUP(deptno, job)) a LEFT OUTER JOIN dept b on(a.deptno = b.deptno)
ORDER BY dname, job desc;

SELECT dept.dname, emp.job,sum(sal+nvl(comm,0))
FROM emp join dept on(emp.deptno = dept.deptno)
GROUP BY ROLLUP(dept.dname, emp.job)
ORDER BY dname,job desc;


SELECT DECODE(dept.dname,null,'����',dept.dname) dname, emp.job,sum(sal+nvl(comm,0)) sal
FROM emp join dept on(emp.deptno = dept.deptno)
GROUP BY ROLLUP(dept.dname, emp.job)
ORDER BY dname,job desc;

REPORT GROUP FUNCTION
1. ROLLUP
2. CUBE
3. GROUPING SETS

GROUPING SETS 
���� ������� ���� �׷��� ����ڰ� ���� ����
����� : GROUP BY GROUPING SETS(COL1, COL2,...)
GROUP BY GROUPING SETS(COL1, COL2)
==>
GROUP BY CO1
UNION ALL
GROUP BY COL2

GROUP BY GROUPING SETS((COL1, COL2),COL3,COL4)
==>
GROUP BY COL1,COL2
UNION ALL
GROUP BY COL3
UNION ALL
GROUP BY COL4

GROUPING SETS�� ��� �÷� ��� ������ ����� ������ ��ġ�� �ʴ´�.
ROLLUP�� �÷� ��� ������ ��� ������ ��ģ��. 

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job,deptno);

job,deptno�� GROUP BY �� �����
mgr�� GROUP BY �� ����� ��ȸ�ϴ� SQL�� GROUPING SETS�� �ۼ�;

SELECT job, deptno,mgr, sum(sal) sal
FROM emp
GROUP BY GROUPING SETS((job,deptno),mgr);

CUBE
������ ����������� �÷��� ������ SUB GROUP�� �����Ѵ�.
�� ����� �÷��� ������ ��Ų��.

EX : GROUP BY CUBE(COL1, COL2);
(col1,col2) =>
(null,col2) == GROUP BY col2
(null,null) == GROUP BY ��ü
(col1,null) == GROUP BY col1
(col1,col2) == GROUP BY col1,col2

���� �÷� 3���� CUBE���� ����� ��� ���� �� �ִ� �������� ? ;

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY CUBE(job, deptno);

---------------------------------����-----------------------------
SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY job, rollup(deptno), CUBE(mgr);


GROUP BY job, deptno, mgr == GROUP BY job, deptno, mgr
GROUP BY job, deptno == GROUP BY job, deptno
GROUP BY job, null, mgr == GROUP BY job, mgr
GROUP BY job, null, null == GROUP BY job

�������� UPDATE
1.emp_test ���̺�  drop
2.emp ���̺��� �̿��ؼ� emp_test ���̺� ����(��� �࿡ ���� ctas)
3.emp_test ���̺� dname VARCHAR2(14)�÷��߰�
4.emp_test.dname �÷��� dept ���̺��� �̿��ؼ� �μ����� ������Ʈ;
DROP TABLE emp_test;
CREATE TABLE emp_test AS
SELECT *
FROM emp;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT *
FROM emp_test;

UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE dept.deptno = emp_test.deptno);
commit;

DROP TABLE dept_test;
CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD(empcnt NUMBER);
select deptno, count(*)
from emp
group by deptno;

select *
from dept_test;

UPDATE dept_test SET empcnt = nvl((SELECT count(*)
                               FROM emp
                               WHERE dept_test.deptno = emp.deptno
                               GROUP BY deptno),0);
sub_a2;
dept_test���̺� �ִ� �μ��߿� ������ ������ �ʴ� �μ� ������ ����
dept_test.empcnt �÷��� ������� �ʰ�
emp���̺��� �̿��Ͽ� ����;
INSERT INTO dept_test VALUES(99,'it1','daejeon',0);
INSERT INTO dept_test VALUES(98,'it2','daejeon',0);                               
COMMIT;


DELETE FROM dept_test
WHERE deptno IN (
                 SELECT deptno
                 FROM dept_test 
                 WHERE deptno NOT IN(SELECT deptno
                                     FROM emp_test
                                     WHERE dept_test.deptno = emp_test.deptno
                                     GROUP BY deptno))
;

select avg(sal)
from emp_test
group by deptno;

UPDATE emp_test SET sal = 200 +sal
WHERE emp_test.empno IN (SELECT empno
                         FROM emp_test a
                         WHERE sal < (SELECT avg(sal)
                                      FROM emp_test b
                                      WHERE a.deptno = b.deptno
                                      GROUP BY deptno))             
;


UPDATE emp_test a SET sal = 200 +sal
WHERE a.sal <  (SELECT avg(sal)
                FROM emp_test b
                WHERE a.deptno = b.deptno
                )             
;

WITH ��
�ϳ��� �������� �ݺ��Ǵ� SUBQUERY�� ���� ��
�ش� SUBQUERY�� ������ �����Ͽ� ����.

MAIN������ ����� �� WITH ������ ���� ���� �޸𸮿� �ӽ������� ����
==> MAIN ������ ���� �Ǹ� �޸� ����
SUBQUERY �ۼ��ÿ��� �ش� SUBQUERY�� ����� ��ȸ�ϱ� ���� I/O�� �ݺ������� �Ͼ����

WITH���� ���� �����ϸ� �ѹ��� SUBQUERY�� ����ǰ� �� ����� �޸𸮿� ������ ���� ����
��, �ϳ��� �������� ������ SUBQUERY�� �ݺ������� �����°Ŵ� �߸� �ۼ��� SQL�� Ȯ���� ����.

WITH ��������̸� AS (
    ��������
)

SELECT *
FROM ��������̸�;

������ �μ��� �޿� ����� ��ȸ�ϴ� ��������� WITH���� ���� ����;
WITH sal_avg_dept AS(
    SELECT deptno, ROUND(AVG(sal),2) sal
    FROM emp
    GROUP BY deptno
),
 dept_empcnt AS(
 SELECT deptno, COUNT(*) empcnt
 FROM emp
 GROUP BY deptno
 )

SELECT *
FROM sal_avg_dept a JOIN dept_empcnt b
                    ON (a.deptno = b.deptno);

-----------------------�޷� �����-------------------------
CONNECT BY LEVEL <[=] ����
�ش� ���̺��� ���� ������ŭ �����ϰ�, ������ ���� �����ϱ� ���ؼ� LEVEL�� �ο�
LEVEL�� 1���� ����;

SELECT dummy, LEVEL
FROM DUAL
CONNECT BY LEVEL <= 10;

SELECT dept.*, LEVEL
FROM dept
CONNECT BY LEVEL <=5;

2020�� 2�� �޷� ����
:dt = 202002, 202003
�޷� 
�� �� ȭ �� �� �� ��

SELECT TO_DATE('202002','YYYYMM') + LEVEL -1,
       TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL -1,'D'),
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL -1,'D'),1,
       TO_DATE('202002','YYYYMM') + LEVEL -1) s,
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL -1,'D'),2,
       TO_DATE('202002','YYYYMM') + LEVEL -1) m,
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL -1,'D'),3,
       TO_DATE('202002','YYYYMM') + LEVEL -1) t,
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL -1,'D'),4,
       TO_DATE('202002','YYYYMM') + LEVEL -1) w,
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL -1,'D'),5,
       TO_DATE('202002','YYYYMM') + LEVEL -1) t2,
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL -1,'D'),6,
       TO_DATE('202002','YYYYMM') + LEVEL -1) f,
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL -1,'D'),7,
       TO_DATE('202002','YYYYMM') + LEVEL -1) s2
FROM DUAL
CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD');

SELECT TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD')
FROM DUAL;

























