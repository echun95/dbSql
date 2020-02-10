1. PRIMARY KEY ���� ���� ������ ����Ŭ DBMS�� �ش� �÷����� unique index�� �ڵ����� �����Ѵ�.
(�������� UNIQUE ���࿡ ���� UNIQUE �ε����� �ڵ����� �����ȴ�.)

index : �ش� �÷����� �̸� ������ �س��� ��ü
������ �Ǿ��ֱ� ������ ã���� �ϴ� ���� �����ϴ��� ������ �� ���ִ�.
���� �ε����� ���ٸ� ���ο� �����͸� �Է��� �� �ߺ��� ���� ã�� ���ؼ� �־��� ��� ���̺��� ��� �����͸� ã�ƾ��Ѵ�.
������ �ε����� ������ �̹� ������ �Ǿ��ֱ� ������ �ش� ���� ���� ������ ������ �˼��� �ִ�.

2. FOREIGN KEY �������ǵ� �����ϴ� ���̺� ���� �ִ����� Ȯ�� �ؾ��Ѵ�.
�׷��� �����ϴ� �÷��� �ε����� �־������ FOREIGN KEY ������ ������ ���� �ִ�.

FOREIGN KEY ������ �ɼ�
FOREIGN KEY(���� ���Ἲ) : �����ϴ� ���̺��� �÷��� �����ϴ� ���� �Է� �� �� �ֵ��� ����
(ex : emp ���̺� ���ο� �����͸� �Է½� DEPTNO �÷����� DEPT ���̺� �����ϴ� �μ���ȣ�� �Է� �� �� �ִ�.

FOREIGN KEY�� �����ʿ� ���� �����͸� ������ �� ������
� ���̺��� �����ϰ� �ִ� �����͸� �ٷ� ������ �ȵ�
(ex : emp.deptno ==> dept.deptno �÷��� �����ϰ� ���� �� dept.deptno�� �����͸� ������ �� ����);


INSERT INTO emp_test (empno, ename, deptno) VALUES(9999,'brown',99);
INSERT INTO dept_test VALUES(98,'ddit','����');

emp : 9999, 99
dept : 98, 99
==> 98�� �μ��� �����ϴ� emp ���̺��� �����ʹ� ����
    99�� �μ��� �����ϴ� emp ���̺��� �����ʹ� 9999�� brown ����� ����

���࿡ ���� ������ �����ϰ� �Ǹ� �����ϴ� �����Ͱ� �ֱ� ������ ����;
DELETE dept_test
WHERE deptno = 99;

FOREIGN KEY �ɼ�
1. ON DELETE CASCADE : �θ� ������ ���(dept) �����ϴ� �ڽ� �����͵� ���� �����Ѵ�.(emp)
2. ON DELETE SET NULL : �θ� ������ ���(dept) �����ϴ� �ڽ� �������� �÷��� NULL�� ����;

emp_test���̺��� drop�� �ɼ��� ������ ���� ������ ���� �׽�Ʈ;

DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT PK_emp_test PRIMARY KEY(empno),
    CONSTRAINT FK_emp_dept FOREIGN KEY(deptno) 
    REFERENCE dept_test(deptno) ON DELETE CASCADE
);

INSERT INTO emp_test VALUES(9999,'brown',99);
COMMIT;

SELECT *
FROM dept_test;

emp_test ���̺��� deptno�÷��� dept_test ���̺��� deptno �÷��� ����(ON DELETE CASCADE)
�ɼǿ� ���� �θ����̺�(dept_test)������ �����ϰ� �ִ� �ڽ� �����͵� ���� �����ȴ�.
DELETE dept_test
WHERE deptno = 99;

�ɼ� �ο��� ���� �ʾ��� ���� ���� DELETE ������ ������ �߻�
�ɼǿ� ���� �����ϴ� �ڽ����̺��� �����Ͱ� ���������� ������ �Ǿ����� SELECT Ȯ��; 

FK ON DELETE SET NULL �ɼ� �׽�Ʈ
�θ� ���̺��� ������ ������(dept_test) �ڽ����̺��� �����ϴ� �����͸� NULL�� ������Ʈ�� ���ش�.

DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT PK_emp_test PRIMARY KEY(empno),
    CONSTRAINT FK_emp_dept FOREIGN KEY(deptno) 
    REFERENCE dept_test(deptno) ON DELETE SET NULL
);

INSERT INTO emp_test VALUES(9999,'brown',99);
COMMIT;

dept_test ���̺��� 99�� �μ��� �������ϰ� �Ǹ�(�θ� ���̺��� �����ϸ�) 99�� �μ��� �����ϴ� emp_test ���̺��� 9999��(brown) �������� deptno �÷���
FK �ɼǿ� ���� NULL�� �����Ѵ�.;

DELETE dept_test
WHERE deptno = 99;

�θ� ���̺��� ������ ���� �� �ڽ� ���̺��� �����Ͱ� NULL�� ����Ǿ����� Ȯ��;

CHECK �������� : �÷��� ���� ���� ������ ������ �� ���
ex : �޿� �÷��� ���ڷ� �Ϲ����� ��� �޿����� > 0
EMP���̺��� job�÷��� ���� ���� ���� 4������ ���Ѱ��� ('SALESMAN','PRESIDENT','ALANYST','MANAGER');

���̺� ���� �� �÷� ����� �Բ� CHECK ���� ����
emp_test ���̺��� sal �÷��� 0���� ũ�ٴ� CHECK �������� ����;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    sal NUMBER CHECK (sal > 0),
    
    CONSTRAINT pk_emp_test PRIMARY KEY (empno),
    CONSTRAINT fk_emp1_dept1 FOREIGN KEY (deptno) REFERENCES dept_test(deptno)    
);
INSERT INTO emp_test VALUES(9999,'brown',99,1000);
INSERT INTO emp_test VALUES(9998,'sally',99,-1000);


CREATE TABLE ���̺�� AS
SELECT ����� ���ο� ���̺�� ����

emp ���̺��� �̿��ؼ� �μ���ȣ�� 10�� ����鸸 ��ȸ�Ͽ� �ش� �����ͷ� emp_test2 ���̺��� ����;
CREATE TABLE emp_test2 AS
SELECT *
FROM EMP
WHERE deptno = 10;

SELECT *
FROM emp_test2;

TABLE ����
1.�÷��߰�
2.�÷� ������ ����, Ÿ�Ժ���
3.�⺻�� ����
4.�÷����� RENAME
5.�÷��� ����
6.�������� �߰�/����

TABLE���� 1.�÷��߰�;
DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    CONSTRAINT pk_emp_test PRIMARY KEY(empno),
    CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno)
);

ALTER TABLE ���̺�� ADD(�ű��÷��� �ű��÷� Ÿ��);
ALTER TABLE emp_test ADD(hp VARCHAR2(20));
DESC emp_test;

TABLE���� 2.�÷� �������, Ÿ�Ժ���;
ex : �÷� VARCHAR2(20)==>VARCHAR2(5)
     ������ �����Ͱ� ������ ��� ���������� ������ �ȵ� Ȯ���� ���� 
�Ϲ������� �����Ͱ� �������� �ʴ� ����, �� ���̺��� ������ ���Ŀ� �÷��� ������, Ÿ���� �߸� �� ��� �÷� ������, Ÿ���� ������.
�����Ͱ� �Էµ� ���ķδ� Ȱ�뵵�� �ſ� ������ (������ �ø��°͸� ����);

hp VARCHAR2(20) ==> hp VARCHAR2(30);

ALTER TABLE ���̺�� MODIFY (���� �÷��� �ű� �÷� Ÿ��(������));
ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));
DESC emp_test;

hp VARCHAR2(30) ==> hp NUMBER;
ALTER TABLE emp_test MODIFY (hp NUMBER);
DESC emp_test;

�÷� �⺻�� ����;
ALTER TABLE ���̺�� MODIFY (�÷��� DEFAULT �⺻��);

HP NUMBER ==> VARCHAR2(20) DEFAULT '010';
ALTER TABLE emp_test MODIFY (hp VARCHAR2(20) DEFAULT '010');
DESC emp_test;
hp �÷����� ���� ���� �ʾ����� default ������ ���� '010' ���ڿ��� �⺻������ ����ȴ�.;
INSERT INTO emp_test (empno, ename, deptno) VALUES(9999,'brown',99);

TABLE 4.����� �÷�����
�����Ϸ��� �ϴ� �÷��� FK����, PK������ �־ ��� ����.;
ALTER TABLE ���̺�� RENAME ���� �÷��� TO �ű� �÷���;
hp ==> hp_n;

ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;
desc emp_test;

���̺� ���� 5. �÷�����
ALTER TABLE ���̺�� DROP COLUMN �÷���
emp_test ���̺��� hp_n�÷� ����;

ALTER TABLE emp_test DROP COLUMN hp_n;

emp_est hp_n �÷��� �����Ǿ����� Ȯ��;
SELECT *
FROM emp_test;

1. emp_test ���̺��� drop�� empno, ename, deptno, hp 4���� �÷����� ���̺� ����
2. empno, ename, deptno 3���� �÷����� (9999,'brown',99) �����ͷ� INSERT
3. emp_test ���̺��� hp �÷��� �⺻���� '010'���� ����
4. 2���������� �Է��� �������� hp�÷� ���� ��� �ٲ���� Ȯ��;

TABLE ���� 6. �������� �߰� / ����;
ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� �������� Ÿ��(PRIMARY KEY, FOREIGN KEY) (�ش��÷�);
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;

1. emp_test ���̺� ���� ��
2. �������� ���� ���̺��� ����
3. PRIMARY KEY, FOREIGN KEY ������ ALTER TABLE ������ ���� ����;

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2)
);

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);
ALTER TABLE emp_test ADD CONSTRAINT FOREIGN fk_emp_test_dept_test(deptno) REFERENCES dept_test (deptno); 

PRIMARY KET �׽�Ʈ;
INSERT INTO emp_test VALUES(9999,'brown',99);
INSERT INTO emp_test VALUES (9999, 'sally',99); ù��° �÷��� �ߺ��̶� ����;

�������� ���� : PRIMARY KEY, FOREIGN KEY;
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;
ALTER TABLE emp_test DROP CONSTRAINT fk_emp_test_dept_test;

���������� �����Ƿ� empno�� �ߺ��� ���� �� �� �ְ�, dept_test���̺� �������� �ʴ� deptno ���� �� ���� �ִ�.
INSERT INTO emp_test VALUES(9999,'brown',99);
INSERT INTO emp_test VALUES(9999,'sally',99);
�������� �ʴ� 98�� �μ��� ������ �Է�
INSERT INTO emp_test VALUES(9998,'sally',98);

�������� Ȱ��ȭ / ��Ȱ��ȭ
ALTER TABLE ���̺�� ENABLE | DISABLE CONSTRAINT �������� ��;

1.emp_test ���̺� ����
2.emp_test ���̺� ����
3.ALTER TABLE PRIMARY KEY(empno), FOREIGN KEY(dept_test.deptno) �������� ����
4.�ΰ��� ���������� ��Ȱ��ȭ
5.��Ȱ��ȭ�� �Ǿ����� INSERT�� ���� Ȯ��
6.���������� ������ �����Ͱ� �� ���¿��� �������� Ȱ��ȭ;

DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(20),
    deptno NUMBER(2)
);

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);
ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test1_dept_test FOREIGN KEY(deptno) REFERENCES dept_test(deptno);

ALTER TABLE emp_test DISABLE CONSTRAINT pk_emp_test;
ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test1_dept_test;
INSERT INTO emp_test VALUES(9999,'brown',99);
INSERT INTO emp_test VALUES(9999,'sally',98);

SELECT * 
FROM emp_test;
emp_test���̺��� empno�÷��� ���� 9999�� ����� �θ� �����ϱ� ������
PRIMARY KEY ���������� Ȱ��ȭ �� ���� ����.
==> empno �÷��� ���� �ߺ����� �ʵ��� �����ϰ� �������� Ȱ��ȭ �� �� �ִ�.;

ALTER TABLE emp_test ENABLE CONSTRAINT pk_emp_test;
ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test1_dept_test;

PRIMARY KEY �������� Ȱ��ȭ;
ALTER TABLE emp_Test ENABLE CONSTRAINT pk_emp_test;

dept_test ���̺� �������� �ʴ� �μ���ȣ 98�� emp_test���� �����
1.dept_test���̺� 98�� �μ��� ����ϰų�
2.sally�� �μ���ȣ�� 99������ �����ϰų� 
3.sally�� ����ų�;

UPDATE emp_test SET deptno =99
WHERE ename = 'sally';
ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test1_dept_test;
COMMIT;


