synonym : ���Ǿ�
1. ��ü ��Ī�� �ο� 
==> �̸��� �����ϰ� ǥ��

sem����ڰ� �ڽ��� ���̺� emp���̺��� ����ؼ� ���� v_emp view
hr ����ڰ� ����� �� �ְ� �� ������ �ο�;

v_emp : �ΰ��� ���� sal, comm�� ������ view;

hr ����� v_emp�� ����ϱ� ���� ������ ���� �ۼ�
SELECT *
FROM sem.v_emp;

hr�������� 
synonym sem.v_emp => v_emp ����
v_emp == sem.v_emp

SELECT *
FROM v_emp;

1.sem �������� v_emp�� hr������ ��ȸ�� �� �ֵ��� ��ȸ���� �ο�;

GRANT SELECT ON v_emp TO hr; ���Ѻο�;

2. hr ���� v_emp ��ȸ�ϴ°� ���� (���� 1������ �޾ұ� ������)
���� �ش� ��ü�� �����ڸ� ��� : sem.v_emp
�����ϰ� sem.v_emp ==> v_emp ����ϰ� ���� ��Ȳ
synonym ����
CREATE SYNONYM �ó���̸� FOR �� ��ü��;

synonym ����
DROP SYNONYM �ó���̸�;

GRANT CONNECT TO SEM; �ý��� ����
GRANT SELECT ON ��ü�� TO hr; ��ü ���� 

���� ����
1. �ý��� ���� : table ����, index ����, view ����...
2. ��ü ���� : Ư�� ��ü�� ���� SELECT, UPDATE, INSERT, DELETE...

ROLE : ������ ��Ƴ��� ����
����� ���� ���� ������ �ο��ϸ� ������ ����
Ư�� ROLE�� ������ �ο��ϰ� �ش� ROLE�� ����ڿ��� �ο�
�ش� ROLE�� �����ϰ� �Ǹ� ROLE�� ���� �ִ� ��� ����ڿ��� ������ ���⶧���� ������ ������
���� �ο�/ȸ��
�ý��� ���� : GRANT �����̸� TO ����� | ROLE�̸�;
�ý��� ȸ�� : REVOKE �����̸� FROM ����� | ROLE�̸�;

��ü ���� : GRANT �����̸� ON ��ü�� TO ����� | ROLE�̸�;
��ü ȸ�� : REVOKE �����̸� ON ��ü�� FROM ����� | ROLE�̸�;

data dictionary : ����ڰ� �������� �ʰ�, dbms�� ��ü������ �����ϴ� �ý��� ������ ���� view;
data dictionary ���ξ�
1. USER : �ش� ����ڰ� ������ ��ü
2. ALL : �ش� ����ڰ� ������ ��ü + �ٸ� ����ڷκ��� ������ �ο����� ��ü
3. DBA : ��� ������� ��ü
* V$ Ư�� VIEW


SELECT *
FROM USER_TABLES; 
SELECT *
FROM ALL_TABLES; 
SELECT *
FROM DBA_TABLES; 

DICTIONARY ���� Ȯ�� : SYS.DICTIONARY;

SELECT *
FROM DICTIONARY;

��ǥ���� dictionary
OBJECTS : ��ü ���� ��ȸ(���̺�, �ε���, VIEW, SYNONYM...)
TABLES : ���̺� ������ ��ȸ
TAB_COLUMNS : ���̺��� �÷� ���� ��ȸ
INDEXES : �ε��� ���� ��ȸ
IND_COLUMNS : �ε��� ���� �÷� ��ȸ
CONSTRAINTS : ���� ���� ��ȸ
CONS_COLUMNS : �������� ���� �÷� ��ȸ
TAB_COMMENTS : ���̺� �ּ�
COL_COMMENTS : ���̺��� �÷� �ּ�;

SELECT *
FROM USER_OBJECTS;

emp, dept ���̺��� �ε����� �ε��� �÷� ���� ��ȸ
USER_INDEXES, USER_IND_DOLUMNS JOIN
���̺��, �ε�����, �÷���
emp  ind_n_emp04  ename
emp  ind_n_emp04  job

SELECT *
FROM USER_INDEXES;

SELECT *
FROM USER_IND_COLUMNS;

SELECT IND.TABLE_NAME, IND.INDEX_NAME, COL.COLUMN_NAME, COL.COLUMN_POSITION
FROM USER_INDEXES IND JOIN USER_IND_COLUMNS COL
                      ON (IND.INDEX_NAME = COL.INDEX_NAME);

multiple insert : �ϳ��� insert �������� ���� ���̺� �����͸� �Է��ϴ� DML
SELECT *
FROM dept_test;
SELECT *
FROM dept_test2;

������ ���� ���� ���̺� ���� �Է��ϴ� multiple insert;
INSERT ALL
    INTO dept_test 
    INTO dept_test2
SELECT 96,'���','�߾ӷ�' FROM DUAL UNION ALL
SELECT 97,'IT','����' FROM DUAL;

���̺� �Է��� �÷��� �����Ͽ� multiple insert
INSERT ALL
    INTO dept_test (deptno,loc) VALUES(deptno,loc)
    INTO dept_test2
SELECT 96 deptno,'���' dname,'�߾ӷ�' loc FROM DUAL UNION ALL
SELECT 97,'IT','����' FROM DUAL;
rollback;


���̺� �Է��� �����͸� ���ǿ� ���� multiple insert;
CASE 
    WHEN ���� ��� THEN 
END;
    
INSERT ALL
    WHEN deptno = 97 THEN
        INTO dept_test (deptno,loc) VALUES(deptno,loc)
    ELSE
        INTO dept_test2
SELECT 96 deptno,'���' dname,'�߾ӷ�' loc FROM DUAL UNION ALL
SELECT 97,'IT','����' FROM DUAL;
rollback;


������ �����ϴ� ù��° INSERT�� �����ϴ� multiple insert
INSERT FIRST
    WHEN deptno >= 97 THEN
        INTO dept_test (deptno,loc) VALUES(deptno,loc)
    WHEN deptno >= 96 THEN
        INTO dept_test2
    ELSE
        INTO dept_test2
SELECT 95 deptno,'���' dname,'�߾ӷ�' loc FROM DUAL UNION ALL
SELECT 97,'IT','����' FROM DUAL;

rollback;

����Ŭ ��ü : ���̺� �������� ������ ��Ƽ������ ����
���̺� �̸��� �����ϳ� ���� ������ ���� ����Ŭ ���������� ������ �и��� ������ �����͸� ����;
dept_test ==> dept_test_20200201;

MERGE : ���� 
���̺� �����͸� �Է�/���� �Ϸ��� �� 
1. ���� �Է��Ϸ��� �ϴ� �����Ͱ� �����ϸ� 
   ==> UPDATE
2. ���� �Է��Ϸ��� �ϴ� �����Ͱ� �������� ������ 
   ==> INSERT

1. SELECT ����
2-1. SELECT ���� ����� 0 ROW�̸� INSERT
2-2. SELECT ���� ����� 1 ROW�̸� UPDATE

MERGE ������ ����ϰ� �Ǹ� SELECT�� ���� �ʾƵ� �ڵ����� ������ ������ ���� 
INSERT Ȥ�� UPDATE �����Ѵ�.
2���� ������ �ѹ����� �ش�.

MERGE INTO ���̺�� [Alias] 
USING (TABLE | VIEW | IN_LINEVIEW)
ON (��������)
WHEN MATCHED THEN 
     UPDATE SET col1 = �÷�1 ��, col2 = �÷�2 �� ...
WHEN NOT MATCHED THEN
     INSERT (�÷� 1, �÷� 2 ...) VALUES(�÷�1 ��, �÷�2 ��...);
     
SELECT *
FROM emp_test;

�α׸� ����� -> rollback ����
delete emp_test;
�α׸� �ȳ���� -> ������ �ȵȴ�.(�׽�Ʈ��)
TRUNCATE TABLE emp_test;

emp���̺��� emp_test���̺�� �����͸� ����(7369-SMITH)

INSERT INTO emp_test
SELECT empno, ename, deptno, '010'
FROM emp 
WHERE empno = 7369;

������ Ȯ��
SELECT *
FROM emp_test;

UPDATE emp_test SET ename = 'brown'
WHERE empno = 7369;

commit;

emp���̺��� ��� ������ emp_test���̺�� ����
emp���̺��� ���������� emp_test���� �������� ������ insert
emp���̺��� �����ϰ� emp_test���� �����ϸ� ename, deptno�� update;

emp���̺� �����ϴ� 14���� �������� emp_test���� �����ϴ� 7369�� ������ 13���� �����Ͱ�
emp_test ���̺� �űԷ� �Է��� �ǰ�, emp_test�� �����ϴ� 7369���� �����ʹ� ename(brown)�� emp���̺� �����ϴ� �̸��� SMITH�� ����.
MERGE INTO emp_test a
USING emp b
ON (a.empno = b.empno) --��������
WHEN MATCHED THEN
    UPDATE SET a.ename = b.ename, 
               a.deptno = b.deptno
WHEN NOT MATCHED THEN
    INSERT (empno,ename,deptno) VALUES(b.empno, b.ename, b.deptno);

SELECT *
FROM emp_test;

�ش� ���̺� �����Ͱ� ������ insert, ������ update 
emp_test���̺� ����� 9999���� ����� ������ ���Ӱ� insert
������ update
(9999,'brown',10,'010');

MERGE INTO emp_test
USING DUAL
ON (empno = 9999)
WHEN MATCHED THEN  
     UPDATE SET ename = ename||'_u',
                deptno = 10,
                hp = '010'
WHEN NOT MATCHED THEN
     INSERT VALUES (9999,'brown',10,'010');

SELECT *
FROM emp_test;

merge, window function(�м��Լ�);


SELECT deptno, sum(sal) sal
FROM emp 
GROUP BY deptno 
UNION ALL      
SELECT NUll deptno, sum(sal) sal
FROM emp;
   
REPORT GROUP FUNCTION
ROLLUP
CUBE
GROUPING;

ROLLUP
����� : GROUP BY ROLLUP(�÷�1, �÷�2)
SUBGROUP�� �ڵ������� ����
SUBGROUP�� �����ϴ� ��Ģ : ROLLUP�� ����� �÷��� �����ʿ������� �ϳ��� �����ϸ鼭
                        SUB GROUP�� ����
ex : GROUP BY ROLLUP(deptno)
==>
ù��° sub group : GROUP BY deptno
�ι�° sub group : GROUP BY NULL ==> ��ü ���� ������� ��

GROUP_AD1�� GROUP BY ROLLUP���� ����Ͽ� �ۼ�;
SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno);

SELECT decode(GROUPING(job),1,decode(GROUPING(deptno),1,'�Ѱ�',job),job) job, deptno, GROUPING(job) g_job, GROUPING(deptno) g_deptno, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP BY job, deptno : ������, �μ��� �޿���
GROUP BY job : �������� �޿���
GROUP BY : ��ü �޿���;

SELECT decode(GROUPING(job),1,decode(GROUPING(deptno),1,'��',job),job) job,
       decode(GROUPING(deptno),1,decode(GROUPING(job),1,'��','�Ұ�'),deptno)deptno, 
       GROUPING(job) g_job, GROUPING(deptno) g_deptno, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP(job,deptno);







   

















