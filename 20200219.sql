���� ���� ��� 11��
����¡ ó��(�������� 10���� �Խñ�)
1������ : 1~10
2������ : 11~20
���ε庯�� :page, :pageSize;
rn (page-1)*pagesize+1 ~ page * pagesize;

SELECT *
FROM(
     SELECT rownum rn,seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root
     FROM board_test
     START WITH parent_seq IS NULL
     CONNECT BY PRIOR seq = parent_seq
     ORDER SIBLINGS BY root DESC, seq ASC)
WHERE rn between (:page-1)*:pageSize +1 and :page * :pageSize;




-------���� ��ŷ�ο��ϱ�-------
SELECT b.ename, b.sal, a.lv
FROM
(SELECT a.*, rownum rm
FROM
(SELECT *
FROM
(   SELECT LEVEL lv
    FROM dual
    CONNECT BY LEVEL <=14) a,
(   SELECT deptno, COUNT(*) cnt
    FROM emp
    GROUP BY deptno) b
WHERE b.cnt >= a.lv
ORDER BY b.deptno, a.lv) a) a 
JOIN
(SELECT b.*, rownum rm
FROM
(SELECT ename, sal, deptno
FROM emp
ORDER BY deptno, sal desc)b) b ON(a.rm = b.rm);

���� ������ �м��Լ��� ����ؼ� ǥ���ϸ�...;

SELECT ename, sal, deptno, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;

�м��Լ� ����
�м��Լ���([����]) OVER([PARTITION BY �÷�] [ORDER BY �÷�] [WINDOWING])
PARTITION BY �÷� : �ش� �÷��� ���� ROW ���� �ϳ��� �׷����� ���´�. 
ORDER BY �÷� : PARTITION BY�� ���� ���� �׷� ������ ORDER BY �÷����� ����

ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) rank;

���� ���� �м��Լ�
RANK : ���� ���� ������ �ߺ� ������ ����, �ļ����� �ߺ� ����ŭ ������ ������ ����
       2���� 2���̸� 3���� ���� 4����� �ļ����� �����ȴ�.
DENSE_RANK() : ���� ���� ������ �ߺ� ������ ����, �ļ����� �ߺ����� �������� ����
               2���� 2���̴��� �ļ����� 3����� ����
ROW_NUMBER() : ROWNUM�� ����, �ߺ��� ���� ������� ����.;

�μ���, �޿� ������ 3���� ��ŷ ���� �Լ��� ����;
SELECT ename, sal, deptno, 
       RANK() OVER(PARTITION BY deptno ORDER BY sal) sal_rank,
       DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal) sal_dense_rank,
       ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal) sal_row_number
FROM emp;


----��� ��ü �޿� ����---
�м��Լ����� �׷� : PARTITION BY ==> ������� ������ ��ü���� ������� �Ѵ�.

SELECT ename, sal, deptno, RANK() OVER(ORDER BY sal DESC, empno) sal_rank, 
        DENSE_RANK() OVER(ORDER BY sal DESC, empno) sal_dense_rank,
        ROW_NUMBER() OVER(ORDER BY sal DESC, empno) sal_row_number
FROM emp;


-- NO_ANA2 --
SELECT a.empno, a.ename, a.deptno, b.cnt
FROM
    (SELECT empno, ename, deptno
     FROM emp
     ORDER BY deptno,empno) a 
JOIN
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) b
ON(a.deptno = b.deptno);

������ �м��Լ� (GROUP �Լ����� �����ϴ� �Լ� ������ ����)
SUM(�÷�)
COUNT(*), COUNT(�÷�) : �ΰ��� ������ ��
MIN(�÷�)
MAX(�÷�)
AVG(�÷�)

NO_ANA2�� �м��Լ��� ����ؼ� ����
�μ��� ���� ��

SELECT empno, ename, deptno, COUNT(*) OVER(PARTITION BY deptno ORDER BY deptno) cnt
FROM emp;

NO_ANA2 �ǽ�;

SELECT empno, ename, sal, deptno, ROUND(AVG(sal) OVER(PARTITION BY deptno),2) avg_sal
FROM emp;

NO_ANA3
SELECT empno, ename, sal, deptno, MAX(sal) OVER(PARTITION BY deptno ORDER BY deptno) max_sal
FROM emp;

NO_ANA4 
SELECT empno, ename, sal, deptno, MIN(sal) OVER(PARTITION BY deptno ORDER BY deptno) min_sal
FROM emp;

�޿��� ������� ������ ����, �޿��� ������� �Ի����ڰ� ��������� ���� �켱������ ����
�������� ������(LEAD)�� SAL�÷��� ���ϴ� ���� �ۼ�;

SELECT empno, ename, hiredate, sal, LEAD(sal) OVER(ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

SELECT empno, ename, hiredate, sal, LAG(sal) OVER(ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

SELECT empno, ename, hiredate, job, sal, LAG(sal) OVER(PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

SELECT a.empno, a.ename, a.sal, sum(b.sal)
FROM
    (SELECT empno, ename, sal, ROWNUM rn   
     FROM 
        (SELECT empno, ename, sal
         FROM emp
         ORDER BY sal)) a,
     (SELECT empno, ename, sal, ROWNUM rn   
      FROM 
        (SELECT empno, ename, sal
         FROM emp
         ORDER BY sal)) b    
WHERE a.rn >= b.rn
GROUP BY a.empno, a.ename, a.sal, a.rn
ORDER BY a.rn, a.empno;

NO_ANA3�� �м��Լ��� �̿��Ͽ� SQL �ۼ�
SELECT empno, ename, sal, SUM(sal) OVER(ORDER BY sal,empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumm_sal
FROM emp;

���� ���� �������� �յ� �� �྿;
SELECT empno, ename, sal, SUM(sal) OVER(ORDER BY sal,empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING ) c_sum
FROM emp;

ORDER BY ����� WINDOWING ���� ������� ���� ��� ���� WINDOWING�� �⺻������ ����ȴ�.
(DEFAULT) RANGE UNBOUNDED PRECEDING == RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW;

NO_ANA7;     
SELECT empno, ename, deptno, sal, 
       SUM(sal) OVER(PARTITION BY deptno ORDER BY deptno,sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) c_sum
FROM emp;

RANGE => ������ ���� ����, ���� ���� ������ �÷����� �ڽ��� ������ ���
ROWS => �������� ���� ����, �ߺ��� ������ �ϳ��� ���
DEFAULT => RANGE�� ����.;

SELECT empno, ename, deptno, sal, 
       SUM(sal) OVER(PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) row_,
       SUM(sal) OVER(PARTITION BY deptno ORDER BY sal RANGE UNBOUNDED PRECEDING) range_,
       SUM(sal) OVER(PARTITION BY deptno ORDER BY sal) default_
FROM emp;




