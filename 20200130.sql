SELECT empno, ename, 
                CASE 
                     WHEN deptno = 10 THEN 'ACCOUNING'
                     WHEN deptno = 20 THEN 'RESEARCH'
                     WHEN deptno = 30 THEN 'SALES'
                     WHEN deptno = 40 THEN 'OPERATIONS'                     
                ELSE 'DDIT' END DNAME
FROM emp;

--DECODE(JOB,'SALESMAN',SAL * 1.05,'MANAGER', SAL * 1.1,'PRESIDENT',SAL * 1.2,SAL)
--���ذ� ¦,Ȧ���� �Ǵ��ϰ� hiredate Ȧ��, ¦������������



SELECT empno, ename, hiredate, 
                CASE 
                    When mod(to_char(sysdate,'yy'),2) = 0 then (DECODE(mod(to_char(hiredate,'yy'),2),0,'�ǰ����� �����',1,'�ǰ����� ������'))
                    ELSE (DECODE(mod(to_char(hiredate,'yy'),2),1,'�ǰ����� �����',0,'�ǰ����� ������'))
                END CONTACT_TO_DOCTOR                                                                           
FROM emp;


--GROUP BY ���� ���� ����
--�μ���ȣ�� ���� ROW ���� ���� ��� : GROUP BY deptno
--�������� ���� ROW ���� ���� ��� : GROUP BY job
--MGR�� ���� �������� ���� ROW ���� ���� ��� : GROUP BY mgr, job

--�׷��Լ��� ����
--sum : �հ�
--count : ���� (null���� ����)
--max : �ִ밪
--min : �ּҰ�
--avg : ���

--�׷��Լ� ������
--GROUP BY ���� ���� �÷��̿��� �ٸ��÷��� SELECT���� ǥ���Ǹ� ����

--�μ��� �޿� ��
select deptno, ename, 
        sum(sal), max(sal),min(sal),round(avg(sal),2),count(sal)
from emp
group by deptno, ename;

--GROUP BY ���� ���� �󤼿��� �׷��Լ��� ����� ���
--��ü���� �ϳ��� ������ ���´�.
select sum(sal), max(sal),min(sal),round(avg(sal),2),count(sal),count(comm)
from emp;


select sum(sal), max(sal),min(sal),round(avg(sal),2),count(sal),count(comm)
from emp
group by empno;

--SINGLE OR FUNCTION�� ��� WHERE������ ����ϴ� ���� �����ϳ� MULTI ROW FUNCTION(GROUP FUNCTION)�� ��� WHERE������ ����ϴ� ���� �Ұ����ϰ�
--HAVING������ ������ ����Ѵ�.

--�μ��� �޿� �� ��ȸ, �� �޿����� 9000�̻��� row�� ��ȸ
SELECT deptno, sum(sal)
FROM emp
GROUP BY deptno
HAVING sum(sal)>9000;


--������ ���� ���� �޿�, ������ ���� ���� �޿�, ������ �޿� ���, ������ �޿� ��, ������ �޿��� �ִ� ������ ��(null����), ������ ����ڰ� �ִ� ������ ��
--��ü ������ ��
SELECT max(sal),min(sal),round(avg(sal),2),sum(sal),count(sal),count(mgr),count(*)
FROM emp;


--�μ��� ����
SELECT deptno,max(sal),min(sal),round(avg(sal),2),sum(sal),count(sal),count(mgr),count(*)
FROM emp
GROUP BY deptno;

SELECT decode(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES') job,
       max(sal),min(sal),round(avg(sal),2),sum(sal),count(sal),count(mgr),count(*)
FROM emp
GROUP BY deptno;


SELECT to_char(hiredate,'YYYYMM'), count(*)
FROM emp
GROUP BY to_char(hiredate,'YYYYMM');

SELECT to_char(hiredate,'YYYY'), count(*)
FROM emp
GROUP BY to_char(hiredate,'YYYY');



SELECT count(deptno) CNT
FROM dept;

SELECT
    COUNT(*)
FROM
    (
        SELECT
            deptno
        FROM
            emp
        GROUP BY
            deptno
    );
    
    