SELECT rownum, empno, ename
FROM emp 
WHERE deptno IN(10,30) and sal >1500
ORDER BY ename;


    -- ROWNUM�� WHERE�������� ��밡��
    -- ���� : ROWNUM = 1, ROWNUM <= N
    -- ���� X : ROWNUM = N(1�� �ƴ�����), ROWNUM >= N(1�� �ƴ�����)
    -- ROWNUM �̹� ���� �����Ϳ��ٰ� ������ �ο�
    -- ���� ���� ������ ����(ROWNUM�� �ο����� ���� ��)�� ��ȸ�� ���� ����.
    -- ���뵵 : ����¡ ó��
    -- ������1** : ���̺� �ִ� ��� ���� ��ȭ�ϴ� ���� �ƴ϶� �츮�� ���ϴ� �������� �ش��ϴ� �� �����͸� ��ȸ�Ѵ�. 
    -- ������2** : ORDER BY ���� SELECT �� ���Ŀ� ����
    -- ����¡ ó���� ������� : 1�������� �Ǽ�, ���� ����
    -- EMP���̺� �� ROW �Ǽ� : 14
    -- ����¡�� 5���� �����͸� ��ȸ
    -- 1PAGE = 1~5 2PAGE = 6~10 3PAGE = 11~15
    
SELECT rownum rn, empno, ename
FROM emp
ORDER BY ENAME;

-- ���ĵ� ����� ROWNUM�� �ο��ϱ� ���ؼ��� IN LINE VIEW�� ����Ѵ�.
-- �������� : 1. ����, 2. ROWNUM �ο�
-- SELECT ���� *�� ����� ��� �ٸ� EXPRESSION�� ǥ�� �ϱ� ���ؼ� ���̺��.* ���̺�Ī.*�� ǥ���ؾ��Ѵ�.
SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e; 

    -- PAGE SIZE = 5, ���ı����� ename
    -- 1 PAGE = 1~5 2 PAGE = 6~10 3 PAGE = 11~15
    -- n page = rn (page-1)*pagesize+1 ~ page * pagesize
SELECT *
FROM(SELECT ROWNUM rn, e.*
FROM(SELECT empno, ename
FROM emp
ORDER BY ename) e)
WHERE rn between (1-1)*5 and 1*5;


SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM between 1 and 10;

SELECT *
FROM (SELECT ROWNUM rn, empno, ename
FROM emp)
WHERE rn between 11 and 20;

SELECT rn, empno, ename
FROM(SELECT ROWNUM rn, e.*
     FROM(SELECT *
          FROM emp
          ORDER BY ename) e) 
WHERE rn between (:page-1) * :pagesize and :page * :pagesize;

--DUAL ���̺� : �����Ϳ� ���� ����, �Լ��� �׽�Ʈ �غ� �������� ���
SELECT LENGTH('TEST')
FROM DUAL;
--���ڿ� ��ҹ��� : LOWER, PPER, INICAP
SELECT LOWER('TEST')
FROM DUAL;
SELECT UPPER('test')
FROM DUAL;
SELECT INITCAP('TEST')
FROM DUAL;

SELECT *
FROM emp
WHERE ename = upper(:ename);

-- SQL�ۼ��� �Ʒ� ���´� ���� �ؾ��Ѵ�.
-- ���̺��� �÷��� �������� �ʴ� ���·� SQL�� �ۼ��Ѵ�.
SELECT *
FROM emp
WHERE lower(ename) = :ename;

--
SELECT CONCAT('�ȳ�','�ϼ���'), substr('�ȳ��ϼ���',1,2), length('�ȳ��ϼ���'), instr('�ȳ��ϼ��似�ϳ��','��'), instr('�ȳ��ϼ��似�ϳ��','��',4)
, LPAD('�ȳ��ϼ���',15,'*'), RPAD('�ȳ��ϼ���',15,'*'), replace('�ȳ��ϼ���', '��','��'), trim(' �ȳ��ϼ��� '), trim('��'from'�ȳ��ϼ���')
FROM dual;

-- ���� �Լ� 
-- ROUND : �ݿø� (10.6�� �Ҽ��� ù��° �ڸ����� �ݿø� -> 11)
-- TRUNC : ����(����) (10.6�� �Ҽ��� ù��° �ڸ����� ���� --> 10)
-- ROUND, TURNC : ���° �ڸ����� �ݿø� / ���� (���ڰ� 2��)
-- MOD : ������ (���� �ƴ� �������� ���ϴ� �Լ� 10 / 3 -> 1)

-- ROUND(��� ����, ���� ��� �ڸ�) 
SELECT ROUND(105.54, 1) --�Ҽ��� ù��° �ڸ����� ����(2��° �ڸ����� �ݿø�)
FROM DUAL;

SELECT ROUND(105.55, 1) --�Ҽ��� ù��° �ڸ����� ����(2��° �ڸ����� �ݿø�)
FROM DUAL;

SELECT ROUND(105.54, 0) --�����θ� ����(1��° �ڸ����� �ݿø�), �ι�° ���ڸ� �Է����� �ʾƵ� 0�� ����
FROM DUAL;

SELECT TRUNC(105.54, 1) --�Ҽ��� ù��° �ڸ����� ����(2��° �ڸ����� ����)
FROM DUAL;

SELECT ename, sal, trunc(sal/1000) --���� ���غ�����
, mod(sal,1000)
from emp;

SELECT MOD(10,3) --�� 3 ������ 1
FROM DUAL;

--�� 2�ڸ�/ �� 2�ڸ�/ �� 2�ڸ�
SELECT ename, hiredate
FROM emp;

-- SYSDATE : ���� ����Ŭ ������ �ú��ʰ� ���Ե� ��¥ ������ �����ϴ� Ư�� �Լ�
-- �Լ���(����1, ����2)
-- DATE + ���� = ���� ����
SELECT SYSDATE + 5, SYSDATE + 1/24
FROM DUAL;









