--SELECT *
--FROM cycle;
--1�� ���� 100�� ��ǰ�� �����ϳ� 1�� ����
--2020�� 2���� ���� �Ͻ����� ����
--1. 2020�� 2���� �����Ͽ� ���� �Ͻ��� ����
--
--20200203
--20200210
--20200217
--20200224;
----;



--(SELECT TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL -1,'YYYYMMDD') dt,
--       TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL -1,'d') d
--
--FROM dual
--CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD'));
--
--
--
--
--
--CREATE OR REPLACE PROCEDURE cycle_dt IS
--    TYPE cycle_tab IS TABLE OF cycle%ROWTYPE INDEX BY BINARY_INTEGER;
--    v_cycle_tab cycle_tab;    
--    TYPE dal_tab IS TABLE OF (SELECT TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL -1,'YYYYMMDD') dt,
--                                     TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL -1,'d') d
--                              FROM dual
--                              CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD'))%ROWTYPE INDEX BY BINARY_INTEGER;  
--    v_dal_tab dal_tab;
--BEGIN
--    SELECT * BULK COLLECT INTO v_cycle_tab
--    FROM cycle;
--
--    FOR i IN 1..v_cycle_tab.count loop 
--      FOR j IN 1..v_dal_tab.count loop
--        IF v_cycle_tab(i).day = v_dal_tab(j).d THEN
--             DBMS_OUTPUT.PUT_LINE('1�Դϴ�.');
--      END LOOP;
--    END loop;   
--END;
--/

SET SERVEROUTPUT ON;


CREATE OR REPLACE PROCEDURE create_daily_sales(p_yyyymm IN daily.dt%TYPE) IS
    TYPE cal_row IS RECORD(
        dt VARCHAR2(8), 
        d  NUMBER);
    TYPE cal_tab IS TABLE OF cal_row INDEX BY BINARY_INTEGER;
    v_cal_tab cal_tab;
BEGIN

    SELECT TO_CHAR(TO_DATE(p_yyyymm,'YYYYMM') + LEVEL -1,'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(p_yyyymm,'YYYYMM') + LEVEL -1,'d') d
           BULK COLLECT INTO v_cal_tab 
     FROM dual
     CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(p_yyyymm,'YYYYMM')),'DD');
    --�Ͻ��� �����͸� �����ϱ� ���� ������ ������ �����͸� ����
    DELETE daily
    WHERE dt LIKE p_yyyymm || '%'; 
    --�����ֱ� ������ ��ȸ(FOR - CURSOR)
    FOR daily_row IN (SELECT * FROM cycle) LOOP       
        FOR i IN 1..v_cal_tab.count LOOP          
          --OUTER LOOP(�����ֱ�)���� ���� �����̶� INNER LOOP(�޷�)���� ���� ������ ���� �����͸� üũ
          IF daily_row.day = v_cal_tab(i).d THEN
            INSERT INTO daily VALUES (daily_row.cid, daily_row.pid, v_cal_tab(i).dt, daily_row.cnt);
            DBMS_OUTPUT.PUT_LINE(v_cal_tab(i).dt || ' ' || v_cal_tab(i).d);             
          END IF;
        END LOOP;      
    END LOOP;
    COMMIT;
END;
/

SELECT *
FROM daily;

exec create_daily_sales(202002);

--create_daily_sales ���ν������� �Ǻ��� insert �ϴ� ������ INSERT SELECT ����, ONE-QUERY ���·� �����Ͽ� �ӵ��� ����;

DELETE daily
WHERE dt LIKE '202002%';

INSERT INTO daily
SELECT cycle.cid, cycle.pid, cal.dt, cycle.cnt
FROM cycle,
    (SELECT TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL-1,'YYYYMMDD') dt,
               TO_CHAR(TO_DATE('202002','YYYYMM') + LEVEL-1,'D') d
     FROM dual
     CONNECT BY LEVEL <= TO_CHAR(LAST_DAY((TO_DATE('202002','YYYYMM'))),'DD')) cal
WHERE cycle.day = cal.d;

--PL_SQL������ SELECT ����� ��� ���� : NO_DATA_FOUND;

DECLARE
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname INTO v_dname
    FROM dept;
   -- WHERE deptno = 80;
EXCEPTION
    WHEN no_data_found THEN
        DMBS_OUTPUT.PUT_LINE('NO_DATA_FOUND');
    WHEN too_many_rows THEN
        DMBS_OUTPUT.PUT_LINE('TOO_MANY_ROWS');
END;
/

����� ���� ���� ����
NO_DATA_FOUND ==> �츮�� �������� ����� ���ܷ� �����Ͽ� ���Ӱ� ���ܸ� ������ ����;

DECLARE
    no_emp EXCEPTION;
    v_ename emp.ename%TYPE;
BEGIN
    BEGIN
        SELECT ename INTO v_ename
        FROM emp
        WHERE empno =90000;
    EXCEPTION
        WHERE NO_DATA_FOUND THEN
            RAISE no_emp;
    END;
EXCEPTION
    WHEN no_emp THEN
        DBMS_OUTPUT.PUT_LINE('no_emp');
END;
/

emp���̺��� ���ؼ��� �μ��̸��� �˼��� ����. (�μ��̸� dept ���̺� ����)
==> 1. join
    2. ��������-��ī�� ��������(SELECT);
    
SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

SELECT emp.*, (SELECT dname FROM dept WHERE dept.deptno = emp.deptno)
FROM emp;

�μ���ȣ�� ���ڹް� �μ����� �������ִ� �Լ� ����;
getDeptName;

CREATE OR REPLACE FUNCTION getDeptName(p_deptno dept.deptno%TYPE) RETURN VARCHAR2 IS
     v_dname dept.dname%TYPE;
BEGIN
    SELECT dname INTO v_dname
    FROM dept
    WHERE deptno = p_deptno;
    
    RETURN v_dname;
END;
/

SELECT emp.*, getDeptName(emp.deptno)
FROM emp;

getEmpName �Լ��� ����
������ȣ�� ���ڷ��ϰ�
�ش� ������ �̸��� �������ִ� �Լ��� �����غ�����.
SMITH;

SELECT getEmpName(7369)
FROM dual;

CREATE OR REPLACE FUNCTION getEmpName (p_empno emp.empno%TYPE) RETURN VARCHAR2 IS
    v_ename emp.ename%TYPE;
BEGIN
    SELECT ename INTO v_ename
    FROM emp
    WHERE empno = p_empno;
    
    RETURN v_ename;
END;
/

SELECT LPAD(' ', (LEVEL-1) * 4) || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;


CREATE OR REPLACE FUNCTION getPadding(p_lv NUMBER, p_num NUMBER, p_padding VARCHAR2) RETURN VARCHAR2 IS
    v_varchar VARCHAR2(50);
    
BEGIN
    SELECT LPAD(' ', (p_lv-1) * p_num, p_padding) INTO v_varchar
    FROM dual;
    
    RETURN v_varchar;
END;
/

SELECT getPadding(level, 3, ' ') || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

PACKAGE - ������ PL/SQL ����� �����ִ� ����Ŭ ��ü
�����
��ü(������)�� ����;

getempname, getdeptname ==>NAMES ��Ű���� ���;

CREATE OR REPLACE PACKAGE names AS
    FUNCTION getempname(p_empno emp.empno%TYPE) RETURN VARCHAR2;
    FUNCTION getdeptname(p_deptno dept.deptno%TYPE) RETURN VARCHAR2;
END names;
/

CREATE OR REPLACE PACKAGE BODY names AS
    FUNCTION getDeptName(p_deptno dept.deptno%TYPE) RETURN VARCHAR2 AS
        v_dname dept.dname%TYPE;
    BEGIN
        SELECT dname INTO v_dname
        FROM dept
        WHERE deptno = p_deptno;
        RETURN v_dname; 
    END;

    FUNCTION getEmpName(p_empno emp.empno%TYPE) RETURN VARCHAR2 AS
        v_ename emp.ename%TYPE;
    BEGIN
        SELECT ename INTO v_ename
        FROM emp
        WHERE empno = p_empno;
        RETURN v_ename; 
    END;
END;
/

SELECT emp.*, names.getdeptname(emp.deptno) dname
FROM emp;


