������ SQL �����̶� : �ؽ�Ʈ�� �Ϻ��ϰ� ������ SQL
1. ��ҹ��� ����
2. ���鵵 ���� �ؾ���
3. ��ȸ ����� ���ٰ� ������ SQL�� �ƴ�
4. �ּ��� ������ ��ħ

�׷��� ������ ���� �ΰ��� SQL ������ ������ ������ �ƴ�;

SELECT * FROM dept;
select * from dept;
select   * FROM dept;
select *
FROM dept;

SQL ����� v$SQL �信 �����Ͱ� ��ȸ�Ǵ��� Ȯ��;
SELECT /*sql_test*/ * 
FROM dept
WHERE deptno = 10;

SELECT /*sql_test*/ * 
FROM dept
WHERE deptno = 20;

�� �ΰ��� SQL�� �˻��ϰ��� �ϴ� �μ���ȣ�� �ٸ���
������ �ؽ�Ʈ�� �����ϴ�. ������ �μ���ȣ�� �ٸ��� ������ DBMS ���忡���� ���� �ٸ� SQL�� �νĵȴ�.
==> �ٸ� SQL ���� ��ȹ�� �����.
==> ���� ��ȹ�� �������� ���Ѵ�.
==> �ذ�å ���ε� ����
SQL���� ����Ǵ� �κ��� ������ ������ �ϰ� �����ȹ�� ������ ���Ŀ� ���ε� �۾��� ����
���� ����ڰ� ���ϴ� ���� ������ ġȯ �� ����
==> ���� ��ȹ �������� ==> �޸� �ڿ� ���� ����;

SELECT /*sql_test*/ * 
FROM dept
WHERE deptno =:deptno;

SQL Ŀ�� : SQL���� �����ϱ� ���� �޸� ����
������ ����� SQL���� ������ Ŀ���� ���
������ �����ϱ� ���� Ŀ�� : ����� Ŀ��

SELECT ��� �������� TABLE Ÿ���� ������ ������ �� ������ �޸𸮴� �������̱� ������ ���� ���� �����͸� ��⿡�� ������ �ִ�.

SQL Ŀ���� ���� �����ڰ� ���� �����͸� FETCH �����ν� SELECT ����� ���� �ҷ����� �ʰ� ������ ����;

Ŀ�� ���� ���
�����(DECLARE)���� ����
    CURSOR Ŀ���̸� IS
            ������ ����;      
            
�����(BEGIN)���� Ŀ�� ����
    OPEN Ŀ���̸�;

�����(BEGIN)���� Ŀ���κ��� ������ FETCH
    FETCH Ŀ���̸� INTO ����;
    
�����(BEGIN)���� Ŀ�� �ݱ�
    CLOSE Ŀ���̸�;
    
�μ� ���̺��� Ȱ���Ͽ� ��� �࿡ ���� �μ���ȣ�� �μ��̸��� CURSOR�� ���� FETCH, FETCH�� ����� Ȯ��;
SET SERVEROUTPUT ON;
DECLARE
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    
    CURSOR dept_cursor IS
        SELECT deptno, dname
        FROM dept;
BEGIN
    OPEN dept_cursor;
    LOOP        
        FETCH dept_cursor INTO v_deptno, v_dname;
        EXIT WHEN dept_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
    END LOOP;
    CLOSE dept_cursor;
END;
/
    
CURSOR�� ���� �ݴ� ������ �ټ� �����彺����
CURSOR�� �Ϲ������� LOOP�� �Բ� ����ϴ� ��찡 ����
==> ����� Ŀ���� FOR loop���� ����� �� �ְ� �� �������� ����

List<String> userNameList = new ArrayList<String>();
userNameList.add("brown");
userNameList.add("cony");
userNameList.add("sally");

�Ϲ� for
for(int i = 0; i< userNameList.Size(); i++){
    String name = userNameList.get(i);
}

���� for
for(String name : userNameList){
    name ���� ��� 
}
;


java�� ���� for ���� ����
FOR record_name(������ ������ ���� �����̸� / ������ ���� ���� ����) IN Ŀ���̸� LOOP
    record_name.�÷��� 
END LOOP;


DECLARE
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    
    CURSOR dept_cursor IS
        SELECT deptno, dname
        FROM dept;
BEGIN
    FOR rec IN dept_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(rec.deptno || ' : ' || rec.dname);
    END LOOP;
END;
/

���ڰ� �ִ� ����� Ŀ��
���� Ŀ�� ������
    CURSOR Ŀ���̸� IS
        ��������...;
        
���ڰ� �ִ� Ŀ�� ������
    CURSOR Ŀ���̸�(����1 ����1 Ÿ��,...) IS
    ��������...
    (Ŀ�� ����ÿ� �ۼ��� ���ڸ� ������������ ����� �� �ִ�.);

DECLARE
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    
    CURSOR dept_cursor(p_deptno dept.deptno%TYPE) IS
        SELECT deptno, dname
        FROM dept
        WHERE deptno <= p_deptno;
BEGIN
    FOR rec IN dept_cursor(20) LOOP
    DBMS_OUTPUT.PUT_LINE(rec.deptno || ' : ' || rec.dname);
    END LOOP;
END;
/

�������̽��� �̿��Ͽ� ��ü�� ���� ���� �Ѱ�?

FOR LOOP���� Ŀ���� �ζ��� ���·� �ۼ�
FOR ���ڵ��̸� IN Ŀ���̸� => FOR ���ڵ��̸� IN (��������);

DECLARE
BEGIN
    FOR rec IN (SELECT deptno, dname FROM dept) LOOP
    DBMS_OUTPUT.PUT_LINE(rec.deptno || ' : ' || rec.dname);
    END LOOP;
END;
/


SELECT dt
FROM dt;

---------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE avgdt IS
    TYPE dt_tab IS TABLE OF dt%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt_tab dt_tab;
    v_sum NUMBER := 0;
    v_count NUMBER := 0;
BEGIN
    SELECT * BULK COLLECT INTO v_dt_tab
    FROM dt;

    FOR i IN 1..v_dt_tab.count-1 loop 
         v_sum := v_sum + to_number(to_char((v_dt_tab(i).dt - v_dt_tab(i+1).dt)));     
         v_count := v_count + 1;
    END loop;
    DBMS_OUTPUT.PUT_LINE(v_sum/v_count);  
END;
/
EXEC AVGDT;

SELECT avg(dt3)
FROM
(SELECT dt, LEAD(dt) OVER(ORDER BY dt desc) dt2, dt- LEAD(dt) OVER(ORDER BY dt desc) dt3
FROM dt);
------------
SELECT (MAX(dt) - MIN(dt)) / (COUNT(dt) -1)
FROM dt;

