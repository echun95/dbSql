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

SELECT *
FROM emp;




















