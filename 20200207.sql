--TRUNCATE �׽�Ʈ
--1. REDO�α׸� �������� �ʱ� ������ ������ ������ ������ �Ұ��ϴ�.
--2. DML(SELECT, INSERT, UPDATE, DELETE)�� �ƴ϶� DDL�� �з�(ROLLBACK �Ұ�)
--
--�׽�Ʈ �ó�����
--EMP���̺��� �����Ͽ� EMP_COPY��� �̸����� ���̺� ����
--EMP_COPY ���̺��� ������� TRUNCATE TABLE EMP_COPY ����
--
--EMP_COPY ���̺� �����Ͱ� �����ϴ��� (���������� ������ �Ǿ�����)Ȯ��

CREATE TABLE EMP_COPY AS
SELECT *
FROM emp;

TRUNCATE TABLE emp_copy;

--TRUNCATE TABLE ��ɾ�� DDL�̱� ������ ROLLBACK�� �Ұ��ϴ�.
--ROLLBACK ���� SELECT �غ��� �����Ͱ� �������� ���� ���� �� �� �ִ�.

--��ȭ ����
--
--DDL : DATA DEFINITION Lauguage - ������ ���Ǿ�
--��ü�� ����, ����, ������ ���
--ROLLBACK �Ұ�
--�ڵ� COMMIT;
--
--���̺� ����
--CREAT TABLE [��Ű����.]���̺��(
--    �÷��� �÷�Ÿ�� [DEFAULT ������],
--    �÷���2 �÷�2Ÿ�� [DEFAULT ������],
--)
--ranger��� �̸��� ���̺� ����
CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE DEFAULT SYSDATE
);

SELECT *
FROM ranger;

INSERT INTO ranger (ranger_no,ranger_nm) VALUES(1,'brown');

--���̺� ����
--DROP TABLE ���̺��
DROP TABLE ranger;

--������ Ÿ��
--���ڿ� (varchar2���, char Ÿ�� ��� ����)
--varchar2(10) : �������� ���ڿ�, ������ 1~4000byte, �ԷµǴ� ���� �÷� ������� �۾Ƶ� ���� ������ �������� ä���� �ʴ´�.
--
--char(10) : �������� ���ڿ�, �ش� �÷��� ���ڿ��� 5byte�� �����ϸ� ������ 5byte�� �������� ä������
--'test' -> 'test      '

--����
--NUMBER(p,s) : p - ��ü �ڸ���(38), s - �Ҽ��� �ڸ���
--INTEGER == NUBER(38,0)
--ranger_no NUMBER ==> NUBER(38,0)�� ���� �ǹ�

--��¥
--DATE - ���ڿ� �ð� ������ ���� - 7BYTE ����
--��¥ - DATE
--    - VARCHAR2(8) - '20200207'
--    �� �ΰ��� Ÿ���� �ϳ��� �����ʹ� 1byte�� ������ ���̰� ����.
--    ������ ���� �������� �Ǹ� ������ �� ���� �������, ����� Ÿ�Կ� ���� ����� �ʿ�
--    

--LOB(Large OBject) - �ִ� 4GB
--CLOB - Characer Large OBject
--       VARCHAR2�� ���� �� ���� �������� ���ڿ�(4000BYTE �ʰ� ���ڿ�)
--         ex) �� �����Ϳ� ������ html �ڵ�
--BLOB - Byte Large OBject
--         ������ �����ͺ��̽��� ���̺��� ������ ��
--         �Ϲ������� �Խñ� ÷�������� ���̺� ���� �������� �ʰ�
--         ���� ÷�������� ��ũ�� Ư�� ������ �����ϰ�, �ش� [���]�� ���ڿ��� ����
--         ������ �ſ� �߿��� ��� : �� ������� ���Ǽ� -> [����]�� ���̺� ����
--
--�������� : �����Ͱ� ���Ἲ�� ��Ű���� ���� ����
--1. UNIQUE ���� ����
--   �ش� �÷��� ���� �ٸ� ���� �����Ϳ� �ߺ����� �ʵ��� ����
--   EX : ����� ���� ����� ���� ���� ����.
--   
--2. NOT NULL �������� (CHECK ��������)
--   �ش� �÷��� ���� �ݵ�� �����ؾ��ϴ� ����
--   EX : ��� �÷��� NULL�� ����� ������ ���� ����.
--        ȸ�����Խ� �ʼ� �Է»���(GITHUB - �̸���, �̸�)
--   
--3.  PRIMARY KEY ���� ����
--    UNIQUE + NOT NULL
--    EX : ����� ���� ����� ���� �� ����, ����� ���»���� ���� ���� ����.    
--    PRIMARY KEY ���� ������ ������ ��� �ش� �÷����� UNIQUE INDEX�� �����ȴ�.
--
--4.  FOREIGN KEY ���� ����(���� ���Ἲ)
--    �ش� �÷��� �����ϴ� �ٸ� ���̺��� ���� �����ϴ� ���� �־���Ѵ�.
--    EMP ���̺��� deptno�÷��� dept���̺��� deptno�÷��� ����(����)
--    emp ���̺��� deptno�÷����� dept���̺� �������� �ʴ� �μ���ȣ�� �Է� �� �� ����.
--    ex : ���� dept ���̺��� �μ���ȣ�� 10,20,30,40,���� ���� �� ���
--         emp ���̺� ���ο� ���� �߰��ϸ鼭 �μ���ȣ ���� 99������ ����� ���
--         �� �߰��� �����Ѵ�.
--5.  CHECK �������� (���� üũ)
--    NOT NULL ���� ���ǵ� CHECK ���࿡ ����
--    emp ���̺� JOB �÷��� ��� �� �� �ִ� ���� 'AA','BB' 
--    
--�������� ���� ���
--1. ���̺��� �����ϸ鼭 �÷��� ���
--2. ���̺��� �����ϸ鼭 �÷� ��� ���Ŀ� ������ ���������� ���
--3. ���̺� ������ ������ �߰������� ���������� �߰�
--
--CREATE TABLE ���̺�� (
--    �÷�1 �÷� Ÿ�� [1.��������],
--    �÷�2 �÷� Ÿ�� [1.��������],
--    
--    [2.TABLE_CONSTRAINT]
--)
--3. ALTER TABLE EMP....
--
--PRIMARY KEY ���������� �÷� ������ ����(1�� ���)
--dept�� ���̺��� �����Ͽ� dept_test ���̺��� PRIMARY KEY �������ǰ� �Բ� ����;
--�� �̹���� ���̺��� KEY �÷��� ���� �÷��̸� ���� �Ұ���, ���� �÷��� ���� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

--�������, �츮�� ���ݱ��� ������ ����� dept ���̺��� deptno�÷����� 
--UNIQUE �����̳� PRIMARY KEY ���� ������ ������ ������ �Ʒ� �ΰ��� ������ ���������� ����ȴ�
INSERT INTO dept_test(deptno) VALUES(99); --���������� ����
INSERT INTO dept_test(deptno) VALUES(99); --�ٷ� �� ������ ���� ���� ���� �����Ͱ� �̹� ����� ����

--�������� Ȯ�� ���
--1.TOOL�� ���� Ȯ��, Ȯ���ϰ��� �ϴ� ���̺� ����
--2.dictionary�� ���� Ȯ�� (USER_TABLES)
--3.�𵨸� (EX: EXERD) Ȯ��


SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = 'DEPT_TEST';

SELECT * 
FROM USER_CONS_COLUMNS
WHERE CONSTRAINT_NAME = 'SYS_C007085';

--�������� ���� ������� ���� ��� ����Ŭ���� ���������̸��� ���Ƿ� �ο�(ex : SYS_C008080)
--�������� �������� ������
--��� ��Ģ�����ϰ� �����ϴ°� ����, � ������ ����
--PRIMARY KEY �������� : PK_���̺��
--FOREIGN KEY �������� : FK_������̺��_�������̺��
--�÷� ������ ���������� �����ϸ鼭 �������� �̸��� �ο��Ѵ�.
--CONSTRAINT �������� �� �������� Ÿ��(PRIMARY KEY)

--2.���̺� ������ �÷� ������� ������ �������� ���
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    CONSTRAINT PK_dept_test PRIMARY KEY(deptno)
);


DROP TABLE dept_test;

--NOT NULL �������� �����ϱ�
--1. �÷��� ����ϱ�
--   �� �÷��� ����ϸ鼭 �������� �̸��� �ο��ϴ°� �Ұ�
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13),
    CONSTRAINT PK_dept_test PRIMARY KEY(deptno)
);
DROP TABLE dept_test;
    
--NOT NULL �������� Ȯ��    
INSERT INTO dept_test (deptno, dname) VALUES(99,NULL);    

--2. ���̺� ������ �÷� ��� ���Ŀ� �������� �߰�

    


CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    CONSTRAINT NN_dept_test_dname CHECK(deptno IS NOT NULL)
);
DROP TABLE dept_test;
    
--UNIQUE ���� : �ش� �÷��� �ߺ��Ǵ� ���� ������ ���� ����, �� NULL�� �Է��� �����ϴ�.
--PRIMARY KEY == UNIQUE + NOT NULL;
--1.���̺� ������ �÷� ���� UNIQUE ��������
--    dname �÷��� UNIQUE ��������

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)    
);
DROP TABLE dept_test;

--dept_test ���̺��� dname �÷��� ������ UNIQUE ���������� Ȯ��
INSERT INTO dept_test VALUES(98,'ddit','daejeon');
INSERT INTO dept_test VALUES(97,'ddit','daejeon');


--2.���̺� ������ �÷��� �������� ���, �������� �̸� �ο�

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14) CONSTRAINT UK_dept_test_dname UNIQUE,
    loc VARCHAR2(13)    
);
DROP TABLE dept_test;

--dept_test ���̺��� dname �÷��� ������ UNIQUE ���������� Ȯ��
INSERT INTO dept_test VALUES(98,'ddit','daejeon');
INSERT INTO dept_test VALUES(97,'ddit','daejeon');

--���̺� ������ �÷� ������� �������� ���� - ���� �÷�(deptno, dname)(UNIQUE);
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    CONSTRAINT UK_dept_test_deptno_dname UNIQUE(deptno, dname) 
);

--���� �÷��� ���� UNIQUE ���� Ȯ��(deptno, dname)
INSERT INTO dept_test VALUES(99,'ddit','daejeon');
INSERT INTO dept_test VALUES(98,'ddit','daejeon');
INSERT INTO dept_test VALUES(98,'ddit','daejeon');


--FOREIGN KEY ��������

--�����ϴ� ���̺��� �÷��� �����ϴ� ���� ��� ���̺��� �÷��� �Է��� �� �ֵ��� ����
--EX : emp���̺� deptno �÷��� ���� �Է��� ��, dept ���̺��� deptno �÷��� �����ϴ� �μ���ȣ�� �Է� �� �� �ֵ��� ����
--�������� �ʴ� �μ���ȣ�� emp���̺��� ������� ���ϰԲ� ����

--1.dept_test ���̺� ����
--2.emp_test ���̺� ����
--3.emp_test ���̺� ������ deptno �÷����� dept.dptno �÷��� �����ϵ��� FK�� ����

DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    CONSTRAINT PK_dept_test PRIMARY KEY(deptno)    
);
DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2) REFERENCES dept_test(deptno),
    CONSTRAINT PK_emp_test PRIMARY KEY(empno)
);

--������ �Է¼���
--emp_test ���̺� �����͸� �Է��ϴ� �� �����Ѱ�?
INSERT INTO emp_test VALUES(9999,'brown',NULL); -->FK ������ �÷��� NULL�� ���
INSERT INTO emp_test VALUES(9998,'sally',10);

--dept_test ���̺� �����͸� �غ�
INSERT INTO dept_test VALUES(99,'DDIT','DAEJEON');
INSERT INTO emp_test VALUES(9998,'sally',99);
INSERT INTO emp_test VALUES(9998,'sally',10); -->10�� �μ��� �������� �ʾ� ����

--���̺� ������ �÷� ��� ����, FOREIGN KEY �������� ����
DROP TABLE emp_test;
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    CONSTRAINT PK_dept_test PRIMARY KEY(deptno)    
);
INSERT INTO dept_test VALUES(99,'DDIT','DAEJEON');

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno)
);
INSERT INTO emp_test VALUES(9999,'brown',10); --dept_test���̺� 10�� �μ��� �������� �ʾ� ����
INSERT INTO emp_test VALUES(9999,'brown',99); --dept_test���̺� 99�� �μ��� �����ϹǷ� ���� �۵�













