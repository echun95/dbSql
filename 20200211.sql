
1. emp_test ���̺��� drop�� empno, ename, deptno, hp 4���� �÷����� ���̺� ����
2. empno, ename, deptno 3���� �÷����� (9999, 'brown', 99) �����ͷ� INSERT
3. emp_test ���̺��� hp �÷��� �⺻���� '010'���� ����
4. 2�������� �Է��� �������� hp �÷� ���� ��� �ٲ���� Ȯ��

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    hp VARCHAR2(10)
);

INSERT INTO emp_test (empno, ename, deptno) VALUES(9999,'brown',99);

ALTER TABLE emp_test MODIFY(hp DEFAULT '010');

SELECT *
FROM emp_test;

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name IN('EMP','DEPT','EMP_TEST','DEPT_TEST');

EMP, DEPT PK, FK ������ �������� ����
EMP : pk(empno)
      fk(deptno) - dept.deptno fk������ �����ϱ� ���ؼ��� �����ϴ� ���̺� �÷��� �ε����� �����ؾ� �Ѵ�.
      
dept : pk(deptno);

ALTER TABLE emp ADD CONSTRAINT pk_emp1 PRIMARY KEY(empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept1 PRIMARY KEY(deptno);
ALTER TABLE emp ADD CONSTRAINT fk_emp1_dept1 FOREIGN KEY(deptno) REFERENCES dept(deptno);

���̺�, �÷� �ּ� : DICTIONARY Ȯ�� ����
���̺� �ּ� : USER_TAB_COMMENS
�÷� �ּ� : USER_COL_COMMENT;

�ּ�����
���̺� �ּ� : COMMENT ON TABLE ���̺�� IS '�ּ�'
�÷� �ּ� : COMMENT ON COLUMN ���̺�.�÷��� IS '�ּ�';
emp : ����
dept : �μ�;

COMMENT ON TABLE emp IS '����';
COMMENT ON TABLE dept IS '�μ�';

SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN('EMP','DEPT');

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN('EMP','DEPT');

DEPT	DEPTNO : �μ���ȣ
DEPT	DNAME : �μ���
DEPT	LOC : �μ���ġ
EMP	EMPNO : ������ȣ
EMP	ENAME : �����̸�
EMP	JOB : ������
EMP	MGR : �Ŵ��� ������ȣ
EMP	HIREDATE : �Ի�����
EMP	SAL : �޿�
EMP	COMM : ������
EMP	DEPTNO : �ҼӺμ���ȣ;

COMMENT ON COLUMN dept.deptno IS '�μ���ȣ';
COMMENT ON COLUMN dept.dname IS '�μ���';
COMMENT ON COLUMN dept.loc IS '�μ���ġ';
COMMENT ON COLUMN emp.empno IS '������ȣ';
COMMENT ON COLUMN emp.ename IS '�����̸�';
COMMENT ON COLUMN emp.job IS '������';
COMMENT ON COLUMN emp.mgr IS '�Ŵ��� ������ȣ';
COMMENT ON COLUMN emp.hiredate IS '�Ի�����';
COMMENT ON COLUMN emp.sal IS '�޿�';
COMMENT ON COLUMN emp.comm IS '������';
COMMENT ON COLUMN emp.deptno IS '�ҼӺμ���ȣ';

SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN('EMP','DEPT');

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN('EMP','DEPT');

SELECT tab.table_name, tab.table_type, tab.comments tab_comment, col.column_name, col.comments col_comment
FROM   (SELECT table_name, table_type, comments
        FROM USER_TAB_COMMENTS
        WHERE TABLE_NAME IN('CUSTOMER','CYCLE','DAILY','PRODUCT')) tab 
        JOIN 
        (SELECT table_name, column_name, comments
         FROM USER_COL_COMMENTS
         WHERE TABLE_NAME IN('CUSTOMER','CYCLE','DAILY','PRODUCT')) col
        ON(tab.table_name = col.table_name);

VIEW : QUERY
TABLEó�� �̸� DBMS�� �ۼ��� ��ü
==> �ۼ����� �ʰ� QUERY���� �ٷ� �ۼ��� VIEW : IN-LINEVIEW ==> �̸��� ���� ������ ��Ȱ���� �Ұ�
VIEW�� ���̺��̴�.(X)
������
1. ���� ����(Ư�� �÷��� �����ϰ� ������ ����� �����ڿ� ����)
2. INLINE VIWE�� VIEW�� �����Ͽ� ��Ȱ��
    , �������� ����

�������
CREATE [OR REPLACE] VIEW ���Ī [(column1,column2)] AS SUBQUERY;
emp ���̺��� 8���� �÷��� sal, comm �÷��� ������ 6�� �÷��� �����ϴ� v_emp VIEW����;
CREATE OR REPLACE VIEW v_emp AS 
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

�ý��� �������� STUDENT�������� VIEW�������� �߰�;
GRANT CREATE VIEW TO STUDENT;

���� �ζ��� ��� �ۼ���;
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
      FROM emp);
      
�� ��ü Ȱ��
SELECT *
FROM v_emp;

emp���̺��� �μ����� ���� ==> dept ���̺�� ������ ����ϰ� ����
���ε� ����� view�� ���� �س����� �ڵ带 �����ϰ� �ۼ��ϴ°� ����;

VIEW : v_emp_dept
dname(�μ���), empno(������ȣ), ename(�����̸�), job(������), hiredate(�Ի�����);

SELECT *
FROM emp;
DEPTNO,DNAME
EMPNO, ENAME, JOB, HIREDATE

CREATE OR REPLACE VIEW v_emp_dept AS
SELECT d.dname, e.empno, e.ename, e.job, e.hiredate
FROM EMP e JOIN DEPT d ON (e.deptno = d.deptno);

VIEW Ȱ���;

VIEW�� �������� �����͸� ���� �ʰ�, ������ �������� ���� ����(SQL)�̱� ������ VIEW���� �����ϴ� ���̺��� �����Ͱ� ����Ǹ�

SELECT *
FROM v_emp_dept;

SEQUENCE : ������ - �ߺ����� �ʴ� �������� �������ִ� ����Ŭ ��ü
CREATE SEQUENCE ������_�̸�
[OPTION.....]
����Ģ : SEQ_���̺��;

emp ���̺��� ����� ������ ����;
CREATE SEQUENCE seq_emp;

������ ���� �Լ�
NEXTVAL : ���������� ���� ���� ������ �� ���
CURRVAL : NEXTVAL�� ����ϰ��� ���� �о� ���� ������ ����

������ ������
ROLLBACK�� �ϴ��� NEXTVAL�� ���� ���� ���� �������� �ʴ´�.
NEXTVAL�� ���� ���� �޾ƿ��� �� ���� �ٽ� ����� �� ����.;

SELECT seq_emp.NEXTVAL
FROM DUAL;

SELECT seq_emp.CURRVAL
FROM DUAL;

INSERT INTO emp_test VALUES(seq_emp.NEXTVAL, 'james',99,'017');

SELECT *
FROM emp_test;

SELECT ROWID, EMP.* 
FROM emp;

�ε����� ������ empno ������ ��ȸ�ϴ� ���
emp ���̺��� pk_emp1 ���������� �����Ͽ� empno�÷����� �ε����� �������� �ʴ� ȯ���� ����;

ALTER TABLE emp DROP CONSTRAINT pk_emp1;
explain plan for
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

emp ���̺��� empno �÷����� pk ������ �����ϰ� ������ sql�� ����
PK : NIQUE + NOT NULL
    (UNIQUE �ε����� �������ش�)
==> empno �÷����� unique �ε����� ������

�ε����� SQL�� �����ϰ� �Ǹ� �ε����� �������� ��� �ٸ��� �������� Ȯ��;

ALTER TABLE emp ADD CONSTRAINT pk_emp1 PRIMARY KEY (empno);

SELECT rowid, emp.*
FROM emp;

SELECT empno, rowid
FROM emp 
ORDER BY empno;

explain plan for
SELECT empno 
FROM emp 
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--1661375629

UNIQUE VS NON-UNIQUE �ε����� ���� Ȯ��
1. PK_EMP ����
2. EMPNO �÷����� NON-UNIQUE �ε��� ����
3. �����ȹ Ȯ��;

ALTER TABLE EMP DROP CONSTRAINT pk_emp1;
CREATE INDEX idx_n_emp_01 ON EMP(empno);

explain plan for
SELECT * 
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

emp ���̺� job �÷��� �������� �ϴ� ���ο� non-unique �ε����� ����;
CREATE INDEX idx_n_emp02 ON emp (job);

SELECT job, rowid
FROM emp
ORDER BY job;

���ð����� ����
1. EMP���̺� ��ü �б�
2. idx_n_emp01 �ε��� Ȱ��
3. idx_n_emp02 �ε��� Ȱ��;
EXPLANIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);









