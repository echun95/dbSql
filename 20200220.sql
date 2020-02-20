1. leaf ���(��)�� � ���������� Ȯ��
2. level == ����Ž���� �׷��� ���� ���� �ʿ��� ��
3. leaf ������ ���� Ž��, rownum;

SELECT lpad(' ',level*4) || org_cd, total
FROM
(SELECT org_cd, parent_org_cd, SUM(total) total
FROM
(SELECT org_cd,parent_org_cd, no_emp,
       SUM(no_emp) OVER(PARTITION BY gno ORDER BY rn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) total
FROM
    (SELECT org_cd, parent_org_cd, lv, lv+ROWNUM gno, ROWNUM rn,
            no_emp/COUNT(*) OVER(PARTITION BY org_cd) no_emp
     FROM
         (SELECT no_emp.*, level lv, CONNECT_BY_ISLEAF leaf
          FROM no_emp
          START WITH parent_org_cd is null
          CONNECT BY PRIOR org_cd = parent_org_cd)
     START WITH leaf = 1
     CONNECT BY PRIOR parent_org_cd = org_cd))
GROUP BY org_cd, parent_org_cd)
START WITH parent_org_cd is null
CONNECT BY PRIOR org_cd = parent_org_cd;




DROP TABLE gis_dt;
CREATE TABLE gis_dt AS
SELECT SYSDATE + ROUND(DBMS_RANDOM.value(-30, 30)) dt,
       '����� ����� ������ Ű��� ���� ���� ������ �Դϴ� ����� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴ�' v1
FROM dual
CONNECT BY LEVEL <= 1000000;

CREATE INDEX idx_n_gis_dt_01 ON gis_dt (dt, v1);

gis_dt�� dt�÷����� 2020��2���� �ش��ϴ� ��¥�� �ߺ����� �ʰ� ���Ѵ�.
2020/02/03 => 2020/02/03
2020/02/03 
SELECT to_char(dt,'yyyymmdd') dt
FROM gis_dt
WHERE dt between to_date('2020/02/01','yyyy/mm/dd') and to_date('2020/02/29 23:59:59','yyyy/mm/dd hh24:mi:ss')
GROUP BY dt;


SELECT *
FROM
    (SELECT TO_DATE('20200201','yyyymmdd') + (LEVEL-1) dt
     FROM DUAL
     CONNECT BY LEVEL <=29) a
WHERE EXISTS (SELECT 'X'
              FROM gis_dt
              WHERE gis_dt.dt BETWEEN a.dt AND TO_DATE(TO_CHAR(a.dt,'yyyymmdd') || '235959','yyyymmddhh24MIss'));


--------------------PL/SQL----------------------------

PL/SQL ��� ����
DECLARE : ����, ��� ����[���� ����]
BEGIN : ���� ���[���� �Ұ�]
EXCEPTION : ����ó��[���� ����]

PL/SQL ������
�ߺ� �Ǵ� ������ ���� Ư����
���Կ����ڰ� �Ϲ����� ���α׷��� ���� �ٸ���.
�ڹ� "="
PL/SQL ":="

PL/SQL ��������
�ڹ� : Ÿ�� ������(int a);
PL/SQL : ������ Ÿ�� deptno NUMBER(2);

PL/SQL �ڵ� ������ �� ����� �ڹٿ� �����ϰ� ;�� ����Ѵ�.

PL/SQL ����� ���� ǥ���ϴ� ���ڿ� : /
SQL�� ���� ���ڿ� : ;

HELLO WORLD ���;

SET SERVEROUTPUT ON;

DECLARE
    msg VARCHAR2(50);
BEGIN
    msg := 'Hello World!';
    DBMS_OUTPUT.PUT_LINE(msg);
END;
/

�μ� ���̺��� 10�� �μ��� �μ���ȣ��, �μ��̸��� PL/SQL ������ �����ϰ� ������ ���;

DECLARE
    v_deptno NUMBER(2);
    v_dname VARCHAR2(14);
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
END;
/

PL/SQL ���� Ÿ��
�μ� ���̺��� �μ���ȣ, �μ����� ��ȸ�Ͽ� ������ ��� ����
�μ���ȣ, �μ����� Ÿ���� �μ� ���̺� ���ǰ� �Ǿ�����
NUMBER, VARCHAR2 Ÿ���� ���� ����ϴ°� �ƴ϶� �ش� ���̺��� �÷��� Ÿ���� �����ϵ���
���� Ÿ���� ���� �� �� �ִ�.

DECLARE
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
END;
/

���ν��� ��� ����
�͸� ��(�̸��� ���� ��)
. ������ �Ұ��� �ϴ�(IN-LINE VIEW VS VIEW)

���ν���(�̸��� �ִ� ��)
. ������ �����ϴ�.
. �̸��� �ִ�.
. ���ν����� ������ �� �Լ�ó�� ���ڸ� ���� �� �ִ�.

�Լ�(�̸��� �ִ� ��)
. ������ �����ϴ�.
. �̸��� �ִ�.
. ���ν����� �ٸ����� ���� ���� �ִ�.

���ν��� ����
CREATE OR REPLACE PROCEDURE ���ν��� �̸� is(IN param, OUT param, IN OUT param)
    ����� (DECLARE���� ������ ����.)
    BEGIN
    EXCEPTION(�ɼ�)
END;
/

�μ� ���̺��� 10�� �μ��� �μ���ȣ�� �μ��̸��� PL/SQL ������ �����ϰ�
DBMS_OUTPUT.PUT_LINE �Լ��� �̿��Ͽ� ȭ�鿡 ����ϴ� printdept ���ν����� ����;

CREATE OR REPLACE PROCEDURE printdept IS
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    
    BEGIN
        SELECT deptno, dname INTO v_deptno, v_dname
        FROM dept
        WHERE deptno = 10;
        DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);

END;
/

���ν��� ���� ���
exec ���ν�����(����..);

exec printdept;

printdept_p ���ڷ� �μ���ȣ�� �޾Ƽ�
�ش� �μ���ȣ�� �ش��ϴ� �μ��̸��� ���������� �ֿܼ� ����ϴ� ���ν���;

CREATE OR REPLACE PROCEDURE printdept_p(p_deptno IN dept.deptno%TYPE) IS
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
    
    BEGIN
        SELECT dname, loc  INTO v_dname, v_loc
        FROM dept
        WHERE deptno = p_deptno;
        
        DBMS_OUTPUT.PUT_LINE(v_dname || ' : ' || v_loc);

END;
/
exec printdept_p(40);

========PRO_1 �ǽ�===========;
CREATE OR REPLACE PROCEDURE printemp(p_empno IN emp.empno%TYPE) IS
    v_ename emp.ename%TYPE;
    v_dname dept.dname%TYPE;
    
    BEGIN
        SELECT ename, dname INTO v_ename, v_dname 
        FROM emp JOIN dept ON (emp.deptno = dept.deptno)
        WHERE emp.empno = p_empno;
        
        DBMS_OUTPUT.PUT_LINE(v_ename || ' : ' || v_dname);

END;
/
exec printemp(7369);



