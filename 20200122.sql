SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SeLECT mem_id, mem_pass, mem_name
FROM member;

SELECT *
FROM users;

-- ���̺��� � �÷��� �ִ��� �����ϴ� ���
-- 1. SECLECT *
-- 2. TOOL�� ��� (�����-TABLES)
-- 3. DESC ���̺�� (DESC - DESCRIBE)

DESC users;

-- users ���̺��� userid, usernm, reg_dt Į���� ��ȸ�ϴ� sql�� �ۼ��ϼ���.
-- null : ���� �𸣴� ����
-- null�� ���� ���� ����� �׻� null

SELECT userid u_id, usernm, reg_dt,reg_dt+5 reg_dt_after_5day
FROM users;

SELECT prod_id id, prod_name name FROM prod;
SELECT lprod_gu gu, lprod_nm nm FROM lprod;
SELECT buyer_id ���̾���̵�, buyer_name �̸� FROM buyer;

-- ���ڿ� ����
-- �ڹ� ������ ���ڿ� ���� : + ("hello"+"world")
-- SQL������ : || ('hello'||'world')
-- SQL������ : concat('hello','world')

--userid, usernm �÷��� ����, ��Ī id_name
SELECT concat(userid,usernm) id_name
FROM users;

-- SQL������ ������ ����
-- (�÷��� ����� ����, pl/sql ���� ������ ����)
-- SQL���� ���ڿ� ����� �̱� �����̼����� ǥ��
-- "hell, world" -> 'hello, world'

-- ���ڿ� ����� �÷����� ����
SELECT 'user id : '||userid "user id"
FROM users;

SELECT table_name
FROM user_tables;

SELECT 'SELECT * FROM '||table_name||';' AS QUERY
FROM user_tables;

SELECT concat(concat('SELECT * FROM ',table_name),';') AS QUERY
FROM user_tables;

-- int a = 5; �Ҵ�/���� ������
-- if( a == 5) a�� ���� 5���� ��
-- sql������ ������ ������ ����(pl/sql�� ����)
-- sql = --> equal

--where �� : ���̺��� �����͸� ��ȸ�� �� ���ǿ� �´� �ุ ��ȸ
-- ex : userid �÷��� ���� brown�� �ุ ��ȸ

SELECT *
FROM users
WHERE userid = 'brown';

-- userid�� brown�� �ƴ� �ุ ��ȸ(brown�� ������ 4��)
-- ���� �� : =, �ٸ� �� : !=, <>

SELECT *
FROM users
WHERE userid != 'brown';

-- emp ���̺� �����ϴ� �÷��� ���� �غ�����
desc emp;

-- emp ���̺��� ename �÷� ���� JONES�� �ุ ��ȸ
-- * SQL KEY WORD�� ��ҹ��ڸ� ������ ������ �÷��� ���̳�, ���ڿ� ����� ��ҹ��ڸ� ������.(JONES != jones)
SELECT *
FROM emp
WHERE ename = 'JONES';

-- emp ���̺��� deptno(�μ���ȣ)�� 30���� ũ�ų� ���� ����鸸 ��ȸ
SELECT *
FROM emp
WHERE deptno >= 30;

-- ���ڿ� : '���ڿ�'
-- ���� : 50
-- ��¥ : ??? -> �Լ��� ���ڿ��� �����Ͽ� ǥ��, ���ڿ��� �̿��Ͽ� ǥ�� ����(������������) �������� ��¥ ǥ�� ����� �ٸ��⶧����
-- �ѱ� : �⵵4�ڸ�-��2�ڸ�-����2�ڸ�
-- �̱� : ��2�ڸ�-����2�ڸ�-�⵵4�ڸ�

--�Ի����ڰ� 1980�� 12�� 17�� ������ ��ȸ
-- TO_DATE : ���ڿ��� date Ÿ������ �����ϴ� �Լ�
-- TO_DATE(��¥���� ���ڿ�, ù��° ������ ����)

SELECT *
FROM emp 
WHERE hiredate = to_date('19801217','YYYYMMDD');

-- ��������
-- SAL �÷��� ���� 1000���� 2000 ������ ���
-- sal >= 1000 && sal <= 2000
SELECT *
FROM emp
WHERE SAL >=1000 AND SAL <= 2000;

-- ���������ڸ� �ε�ȣ ��ſ� between A and B �����ڷ� ��ü
SELECT *
FROM emp
WHERE sal between 1000 AND 2000;

SELECT ename, hiredate
FROM emp
WHERE hiredate between to_date('19820101','YYYYMMDD') and to_date('19830101','YYYYMMDD');













