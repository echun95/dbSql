-- java������ ��¥ ������ ��ҹ��ڸ� ������.(MM/mm ��/��)
-- �ְ�����(1~7) : ������1, ȭ����2 .... ����� 7
-- ���� IW : ISOǥ�� �ش����� ������� �������� ������ ����
--          2019/12/31 ȭ���� -> 2020/01/02(�����) --> �׷��� ������ 1������ ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS'),
       TO_CHAR(SYSDATE,'D'),
       TO_CHAR(SYSDATE,'IW'),
       TO_CHAR(TO_DATE('2019/12/31','YYYY/MM/DD'),'IW')
FROM dual;

--emp ���̺��� hiredate(�Ի�����)�÷��� ����� ��:��:��
SELECT ename, hiredate, TO_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:SS'),
        TO_CHAR(hiredate+ 1, 'YYYY-MM-DD HH24:MI:SS'),
        TO_CHAR(hiredate+ 1/24, 'YYYY-MM-DD HH24:MI:SS'),
        TO_CHAR(hiredate + 30/1440 , 'YYYY-MM-DD HH24:MI:SS')
FROM emp;

SELECT SYSDATE DT_DASH, 
TO_CHAR(sysdate,'YYYY-MM-DD HH24-MI-SS') DT_DASH_WITH_TIME, 
TO_CHAR(sysdate,'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

--MONTHS_BETWEEN(DATE, DATE)
-- ���ڷ� ���� �� ��¥ ������ �������� ����
SELECT empno, hiredate,
       MONTHS_BETWEEN(sysdate, hiredate),
       MONTHS_BETWEEN(TO_DATE('2020-01-17','yyyy-mm-dd'),hiredate)
FROM emp
WHERE ename = 'SMITH';

--ADD_MONTHS(DATE,����-������ ������)
SELECT ADD_MONTHS(SYSDATE,5), --2020/01/29 --> 2020/06/29
       ADD_MONTHS(SYSDATE,-5)
FROM dual;

-- NEXT_DAY(DATE, �ְ�����), ex) NEXT_DAY(SYSDATE,5)--> SYSDATE���� ó�� �����ϴ� �ְ����� 5�� �ش��ϴ� ����
                            -- SYSDATE 2020/01/29(��) ���� ó�� �����ϴ� 5(�����)->2020/01/30(��)
SELECT NEXT_DAY(SYSDATE,5) 
FROM DUAL;

-- LAST_DAY(DATE) DATE�� ���� ���� ������ ���ڸ� ����
SELECT LAST_DAY(SYSDATE)
FROM dual;

-- LAST_DAY�� ���� ���ڷ� ���� date�� ���� ���� ������ ���ڸ� ���� �� �ִµ� date�� ù��° ���ڴ� ��� ���ұ�?
SELECT  SYSDATE,
        LAST_DAY(SYSDATE),
        LAST_DAY(ADD_MONTHS(SYSDATE,-1))+1 FIRST_DAY
FROM dual;

-- hiredate ���� �̿��Ͽ� �ش� ���� ù��° ���ڷ� ǥ��
SELECT ename, hiredate,LAST_DAY(ADD_MONTHS(hiredate,-1))+1 FIRST_DAY
FROM emp;


-- empno�� NUMBER Ÿ��, ���ڴ� ���ڿ�
-- Ÿ���� ���� �ʱ� ������ ������ ����ȯ�� �Ͼ.
-- ���̺� �÷��� Ÿ�Կ� �°� �ùٸ� ���� ���� �ִ°� �߿�
SELECT *
FROM emp
WHERE empno = '7369';

SELECT *
FROM emp
WHERE empno = 7369;

--hiredate Ÿ���� dateŸ��, ���ڴ� ���ڿ��� �־��⶧���� ������ ����ȯ�� �߻�
-- ��¥ ���ڿ����� ��¥ Ÿ������ ��������� ����ϴ� ���� ����
SELECT *
FROM emp
WHERE hiredate = '1980/12/17';

SELECT *
FROM emp
WHERE hiredate = to_date('1980/12/17','yyyy/mm/dd');

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';

SELECT*
FROM table(dbms_xplan.display);

-- ���ڸ� ���ڿ��� �����ϴ� ��� : ����
-- õ����
-- �ѱ� 1,000.50
-- ���� 1.000,50

-- emp sal �÷�(NUMBER Ÿ��)�� ������
-- 9 : ����
-- 0 : ���� �ڸ� ����(0���� ǥ��)
-- L : ��ȭ����


SELECT ename, sal, TO_CHAR(sal,'L0,999')
FROM emp;

-- NULL�� ���� ������ ����� �׻� NULL
-- emp ���̺��� sal�÷����� null �����Ͱ� �������� ����(14���� �����Ϳ� ����)
-- emp ���̺��� comm�÷����� null �����Ͱ� ���� (14���� �����Ϳ� ����)
-- sal + comm -> comm�� null�� �࿡ ���ؼ��� ��� null�� ���´�.
-- �䱸������ comm�� null�̸� sal�÷��� ���� ��ȸ
-- �䱸������ ���� ��Ű�� ���Ѵ� -> sw������ ����

--NVL(Ÿ��, ��ü��) Ÿ���� ���� null�̸� ��ü���� ��ȯ, null���� �ƴϸ� Ÿ�ٰ� ��ȯ
SELECT ename, sal, NVL(comm,0), NVL(sal + comm,sal)
FROM emp;

--NVL2(expr1, expr2, expr3)
--if(expr1 != null) return expr2 else return expr3
SELECT ename, sal, comm, NVL2(comm,10000,0)
FROM emp;

--nullif(expr1, expr2)
--if(expr1 == expr2) return null else return expr1
SELECT ename, sal, comm, nullif(sal,1250) -- sal���� 1250�� ����� null�� �ƴѻ���� sal���� ����
FROM emp;

-- ��������
-- COALESCE �����߿� ���� ó������ �����ϴ� NULL���� �ƴѰ��� ã�� ����
-- COALESCE(expr1,expr2...)
-- if(expr1 != null) return expr1 else return COALESCE(expr2, expr3...)...
SELECT ename, sal, comm, COALESCE(comm, sal)
FROM emp;

SELECT empno,ename,mgr, nvl(mgr,9999) mgr_n, nvl2(mgr,mgr,9999) mgr_n_1, coalesce(mgr,9999) mgr_n_2
FROM emp;

SELECT userid, usernm, reg_dt, NVL(reg_dt,SYSDATE) n_reg_dt
FROM users
WHERE usernm != '����';

--CASE : JAVA�� if - else if - else
--CASE 
--    WHEN ���� THEN ���ϰ�1
--    WHEN ���� THEN ���ϰ�2
--    ELSE �⺻��
--END
--emp ���̺��� job�÷��� ���� SALESMAN�̸� SAL * 1.05 ���� MANAGER �̸� SAL * 1.1 ���� PRESIDENT�̸� SAL * 1.2 ���� �׹��� ����� SAL�� ����

SELECT ename, sal, job, 
    case 
        when job = 'SALESMAN' then sal * 1.05
        when job = 'MANAGER' then sal * 1.1
        when job = 'PRESIDENT' then sal * 1.2
        ELSE SAL
    END AS total
FROM emp;

--DECODE �Լ� : CASE���� ����
--(�ٸ��� CASE �� : WHEN ���� ���Ǻ񱳰� �����Ӵ�.
--       DECODE �Լ� : �ϳ��� ���� ���ؼ� = �񱳸� ���)
--DECODE �Լ��� ��������(������ ������ ��Ȳ�� ���� �ٲ�)
--DECODE(col|expr, ù��° ���ڿ� ���� ��1, ù��° ���ڿ� �ι�° ���ڰ� ������� ��ȯ ��, ù��° ���ڿ� ���� ��2, ù��° ���ڿ� �׹�° ���ڰ� �������
--��ȯ��2,..., option - else ���������� ��Ȱ�� �⺻��)

SELECT ename, sal, job, 
    DECODE(JOB,'SALESMAN',SAL * 1.05,'MANAGER', SAL * 1.1,'PRESIDENT',SAL * 1.2,SAL)
     AS total
FROM emp;

--emp ���̺��� job�÷��� ���� SALESMAN�̸鼭 SAL���� 1400���� ũ�� SAL * 1.05 ���� 
--                          MANAGER �̸鼭 SAL���� 1400���� ������ SAL * 1.1 ����
--                          MANAGER �̸� SAL * 1.1 ����
--                          PRESIDENT�̸� SAL * 1.2 ���� �׹��� ����� SAL�� ����

SELECT ename, sal, job, 
    case 
        when job = 'SALESMAN' AND SAL > 1400 then sal * 1.05
        when job = 'MANAGER' AND SAL < 1400 then sal * 1.1
        when job = 'MANAGER' then sal * 1.1
        when job = 'PRESIDENT' then sal * 1.2
        ELSE SAL
    END AS total
FROM emp;

SELECT ename, sal, job, 
    DECODE(JOB,'SALESMAN', (CASE 
                                WHEN SAL > 1400 THEN SAL * 1.05 
                                ELSE SAL END),
                'MANAGER', (CASE
                                WHEN SAL < 1400 THEN SAL * 1.1
                                ELSE SAL * 1.1 END),
                'PRESIDENT',SAL * 1.2, SAL)
     AS total
FROM emp;