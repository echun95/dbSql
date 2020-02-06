SELECT sido, sigungu, ROUND((kfc+buk+mac)/lot,2) bugscore
FROM
(SELECT sido, sigungu,
       NVL(SUM(DECODE(gb,'KFC',1)),0) kfc, NVL(SUM(DECODE(gb,'����ŷ',1)),0) buk, 
       NVL(SUM(DECODE(gb,'�Ƶ�����',1)),0) mac, NVL(SUM(DECODE(gb,'�Ե�����',1)),1) lot
FROM fastfood
WHERE gb IN('KFC','�Ƶ�����','����ŷ','�Ե�����')
GROUP BY sido, sigungu)
ORDER BY bugscore desc;

SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal desc;

--�ܹ������� �õ�, �ܹ������� �ñ���, �ܹ�������, ���� �õ�, ���� �ñ���, ���κ� �ٷμҵ��
--�ܹ��� ����, ���κ� �ٷμҵ� �ݾ� ������ ���� �õ����� [����]
--���� ������ �ೢ�� ����



--ROWNUM ��� �� ���ǻ���
--1.SELECT ==> ORDER BY
--���ĵ� ����� ROWNUM�� �����ϱ� ���ؼ��� INLINE-VIEW
--2.1������ ���������� ��ȸ�� �Ǵ� ���ǿ����� WHERE������ ����� ����
--ROWNUM = 1 (O)
--ROWNUM = 2 (X)
--ROWNUM < 10 (O)
--ROWNUM > 10 (X)

--ROWNUM - ORDER BY
--ROUND
--GROUP BY
--JOIN 
--DECODE
--NVL
--IN

SELECT b.n, b.sido, b.sigungu, b.bugscore, t.sido, t.sigungu, t.pri_sal
FROM
   (SELECT ROWNUM n, bug.sido, bug.sigungu, bug.bugscore
    FROM
        (SELECT sido, sigungu, ROUND((kfc+buk+mac)/lot,2) bugscore
         FROM
            (SELECT sido, sigungu,
             NVL(SUM(DECODE(gb,'KFC',1)),0) kfc, NVL(SUM(DECODE(gb,'����ŷ',1)),0) buk, 
             NVL(SUM(DECODE(gb,'�Ƶ�����',1)),0) mac, NVL(SUM(DECODE(gb,'�Ե�����',1)),1) lot
             FROM fastfood
             WHERE gb IN('KFC','�Ƶ�����','����ŷ','�Ե�����')
             GROUP BY sido, sigungu)
             ORDER BY bugscore desc) bug) b 
JOIN
    (SELECT ROWNUM n, t.sido, t.sigungu, t.pri_sal
     FROM 
           (SELECT sido, sigungu, ROUND(sal/people) pri_sal
            FROM tax
            ORDER BY pri_sal desc) t) t
ON (b.n = t.n);

--DML
--INSERT INTO dept (deptno,dname,loc) VALUES(99,'DDIT','daejeon'); ��� �÷��� �ƴ� �κи� �Է��� ���� �÷����� ����ؾ��Ѵ�.
--INSERT INTO dept VALUES(99,'DDIT','daejeon'); ��� �÷��� ���� �Է��� ���� �÷����� �����ص��ȴ�.

--empno �÷��� NOT NULL ���� ������ �ִ�. INSERT �� �ݵ�� ���� �����ؾ� ���������� �Էµȴ�.
--empno �÷��� ������ ������ �÷��� NULLABLE�̴�.(NULL ���� ����� �� �ִ�.)
INSERT INTO emp(empno, ename, job) 
VALUES(9999,'brown',NULL);  

SELECT *
FROM emp;

INSERT INTO emp (ename, job) 
VALUES('sally','salesman');

--���ڿ� : '����Ŭ' ==> "�ڹ�"
--���� : 123 
--��¥ : to_date('20200206','yyyymmdd')
--emp ���̺��� hiredate �÷��� Ÿ���� dateŸ��
--emp ���̺��� 8���� �÷��� ���� �Է�

DESC emp;

INSERT INTO emp 
VALUES(9998,'sally','SALESMAN',NULL,SYSDATE,1000,NULL,99);

rollback;


--�������� �����͸� �ѹ��� INSERT : 
--INSERT INTO ���̺�� (�÷���1,�÷���2,...)
--SELECT ...
--FROM ;
INSERT INTO emp
SELECT 9998,'sally','SALESMAN',NULL,SYSDATE,1000,NULL,99
FROM dual
    UNION ALL
SELECT 9999,'brown','CLERK',NULL,to_date('20200205','yyyymmdd'),1100, NULL,99
FROM dual;





--UPDATE ����
--UPDATE ���̺�� SET �÷���1 = ������ �÷� ��1, �÷���2 = ������ �÷� ��2,...
--WHERE �� ���� ����
--������Ʈ ���� �ۼ��� WHERE���� �������� ������ �ش� ���̺��� ��� ���� ������� ������Ʈ�� �Ͼ��.
--UPDATE, DELETE ���� WHERE���� ���� ��� �ǵ��Ѱ� �´��� �ٽ��ѹ� Ȯ���Ѵ�.
--WHERE���� �ִ� �ϴ��� �ش� �������� �ش� ���̺��� SELECT�ϴ� ������ �ۼ��Ͽ� �����ϸ� UPDATE ��� ���� ��ȸ �� �� �����Ƿ� 
--Ȯ���ϰ� �����ϴ� �͵� ��� �߻� ������ ������ �ȴ�.

--99�� �μ���ȣ�� ���� �μ� ������ DEPT���̺� �ִ»�Ȳ
INSERT INTO dept VALUES(99,'DDIT','daejeon');

SELECT * 
FROM dept;

--99�� �μ���ȣ�� ���� �μ��� dname �÷��� ���� '���IT', loc �÷��� ���� '���κ���'���� ������Ʈ

UPDATE dept 
SET dname = '���IT',loc = '���κ���'
WHERE deptno = 99;

SELECT *
FROM dept;

--10 => SUBQUERY
--SMITH, WARD�� ���� �μ��� �Ҽӵ� ���� ����
SELECT *
FROM emp
WHERE deptno IN(20,30);

SELECT *
FROM emp
WHERE deptno IN(SELECT deptno
                FROM emp
                WHERE ename IN('SMITH','WARD'));

--UPDATE�ÿ��� �������� ����� �����ϴ�.
INSERT INTO emp (empno,ename)
VALUES(9999,'brown');
--9999�� ��� deptno, job ������ SMITH ����� ���� �μ�����, �������� ������Ʈ
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'), job = (SELECT job FROM emp WHERE ename = 'SMITH');

select *
from emp;

--DELETE SQL : Ư�� ���� ����
--DELETE [FROM] ���̺��
--WHERE �� ���� ����
SELECT *
FROM dept;

--99�� �μ���ȣ�� �ش��ϴ� �μ� ���� ����
DELETE dept
WHERE deptno = 99;

--SUBQUERY�� ���ؼ� Ư�� ���� �����ϴ� ������ ���� DELETE
--�Ŵ����� 7698 ����� ������ ����
DELETE emp
WHERE mgr IN (7698, 7521, 7654, 7844, 7900);

DELETE emp
WHERE empno IN (SELECT empno
               FROM emp
               WHERE mgr = 7698);

ROLLBACK;

































