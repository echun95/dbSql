SELECT *
FROM product
WHERE pid NOT IN (SELECT pid 
             FROM cycle
             Where cid = 1);

select * 
from cycle;

select * 
from product;

select * 
from customer;

SELECT c.cnm, p.pid, p.pnm, cycle.day, cycle.cnt
FROM customer c JOIN (SELECT *
                      FROM cycle
                      WHERE pid IN (SELECT PID
                      FROM cycle
                      WHERE cid = 2) 
                      AND cid = 1) cycle 
                ON (c.cid = cycle.cid)
                JOIN product p 
                ON (cycle.pid = p.pid);


SELECT *
FROM cycle
WHERE pid IN (SELECT PID
              FROM cycle
              WHERE cid = 2) 
AND cid = 1;

SELECT *
FROM emp
WHERE mgr Is Not Null;

--EXSITS ���ǿ� �����ϴ� ���� ���� �ϴ��� Ȯ���ϴ� ������
--�ٸ� �����ڿ� �ٸ��� WHERE ���� �÷��� ������� �ʴ´�.
--WHERE empno = 7369 == WHERE EXISTS ( SELECT 'X' FROM ....)
SELECT *
FROM emp e
WHERE EXISTS(SELECT 'x'
             FROM emp b
             WHERE b.empno = e.mgr);
             
SELECT p.pid, p.pnm
FROM product p
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle c
              WHERE c.cid = 1 AND p.pid = c.pid);
             
--���տ���
--������ : UNION - �ߺ�����(���հ���) / UNION ALL - �ߺ��� �������� ����(�ӵ� ���)
--������ : INTERSECT (���հ���)
--������ : MINUS (���հ���)
--���տ��� �������
--�� ������ �÷��� ����, Ÿ���� ��ġ �ؾ� �Ѵ�.
             
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)


UNION ALL --UNION ALL �����ڴ� UNION�� �ٸ��� �ߺ��� ����Ѵ�.

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);
             

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)


INTERSECT --��, �Ʒ� ���տ��� ���� ���� �ุ ��ȸ

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369);                  
             

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)


MINUS --�� ���տ��� �Ʒ� ������ �����͸� ������ ������ ����

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);


--������ ��� ������ ������ ���� ���տ�����
--A UNION B = B UNION A ==> ����
--A UNION ALL B = B UNION ALL A ==> ����(����)
--A INTERSECT B = B INTERSECT A ==> ����(����)
--A MINUS B = B MINUS A ==> �ٸ�(����)

--���տ����� ��� �÷� �̸��� ù��° ������ �÷����� ������.
SELECT 'X', 'B'
FROM dual

UNION 

SELECT 'X', 'B'
FROM dual;

--����(ORDER BY)�� ���տ��� ���� ������ ���� ������ ���

SELECT deptno,dname
FROM dept
WHERE deptno in(10, 20)
--ORDER BY deptno

UNION ALL

SELECT deptno,dname
FROM dept
WHERE deptno in(30, 40)
ORDER BY deptno;
----------------------------------------------------------

select  sido, sigungu,gb
from fastfood;



select sido, sigungu, count(*) lot
from fastfood
where gb = '�Ե�����'
group by sido, sigungu; --lot


select  sido, sigungu, count(*) other
from fastfood
where gb in ('�Ƶ�����','KFC','����ŷ')
group by sido, sigungu;



SELECT f1.sido, f1.sigungu, round((f2.other/f1.lot),2)��ġ
FROM (select sido, sigungu, count(*) lot
      from fastfood
      where gb = '�Ե�����'
      group by sido, sigungu) f1 
      JOIN (select  sido, sigungu, count(*) other
            from fastfood
            where gb in ('�Ƶ�����','KFC','����ŷ')
            group by sido, sigungu) f2
      ON (f1.sido = f2.sido and f1.sigungu = f2.sigungu)
ORDER BY ��ġ desc;





















