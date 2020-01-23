SELECT ename, hiredate
FROM emp
WHERE to_date(19820101,'YYYYMMDD') <= hiredate and hiredate <= to_date(19830101,'YYYYMMDD');

-- where ���� ����ϴ� ���ǿ� ������ ��ȸ ����� ������ ��ġ�� �ʴ´�.
-- SQL�� ������ ������ ���� �ִ�.
-- ���� : Űī 185cm �̻��̰� �����԰� 70kg �̻��� ������� ����
-- �����԰� 70kg �̻��̰� Ű�� 185cm �̻��� ������� ����
-- ������ Ư¡ : ���տ��� ������ ����. ex) {1,4,5} = {4,5,1}
-- ���̺��� ������ ������� ����
-- SELECT ����� ������ �ٸ����� ���� �����ϸ� ����
-- ���ɱ�� ����(ORDER BY)

-- IN ������
-- Ư¡ ���տ� ���ԵǴ��� ���θ� Ȯ��
SELECT empno, ename, deptno
FROM emp;

-- �μ���ȣ�� 10�� Ȥ�� 20���� ���ϴ� ���� ��ȸ
SELECT empno, ename, deptno
FROM emp 
WHERE deptno IN (10,20);

SELECT empno, ename, deptno
FROM emp 
WHERE deptno = 10 or deptno = 20;

-- emp���̺��� ����̸��� SMITH, JONES �� ������ ��ȸ(empno, ename, deptno)
SELECT empno, ename, deptno
FROM emp 
WHERE ename IN('SMITH','JONES');

SELECT userid ���̵�, usernm �̸�, ALIAS ����
FROM users
WHERE userid IN('brown','cony','sally');

-- ���ڿ� ��Ī ������ : LIKE, %,_
-- ������ ������ ������ ���ڿ� ��ġ�� ���ؼ� �ٷ�
-- �̸��� BR�� �����ϴ� ����� ��ȸ
-- �̸��� R ���ڿ� ���� ����� ��ȸ

SELECT *
FROM emp;

--��� �̸��� S�� �����ϴ� ��� ��ȸ
--% � ���ڿ�(�ѱ���, ���� �������� �ְ�, ���� ���ڿ��� �ü��� �ִ�.

SELECT *
FROM emp
WHERE ename like 'S%';

--���� ���� ������ ���� ��Ī
-- _ ��Ȯ�� �ѹ���
--���� �̸��� S�� �����ϰ� �̸��� ��ü ���̰� 5���� �� ����
SELECT *
FROM emp
WHERE ename like 'S____';

-- ��� �̸��� s���ڰ� ���� ��� ��ȸ
SELECT *
FROM emp
WHERE ename like '%S%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name like '��%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name like '%��%';

-- null �� ����(IS)
-- comm �÷��� ���� null�� �����͸� ��ȸ (WHERE comm = null)
SELECT *
FROM emp
WHERE comm is null;

SELECT *
FROM emp
WHERE job = 'SALESMAN';

SELECT *
FROM emp
WHERE comm is not null;

-- ����� �������� 7698, 7839 �׸��� null�� �ƴ� ������ ��ȸ
-- NOT IN �����ڿ����� NULL ���� ���� ��Ű�� �ȵȴ�.
SELECT *
FROM emp
WHERE mgr not in(7698, 7839);

--7
SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= to_date(19810601,'yyyymmdd');

--8
SELECT *
from emp
where deptno != 10 and hiredate >= to_date(19810601,'yyyymmdd');

--9
select *
from emp
where deptno not in(10) and hiredate >= to_date(19810601,'yyyymmdd');

--10
select *
from emp
where deptno in(20,30) and hiredate >= to_date(19810601,'yyyymmdd');

--11
select *
from emp
where job = 'SALESMAN' OR hiredate >= to_date(19810601,'yyyymmdd');

--12
select *
from emp
where job = 'SALESMAN' OR empno like '78%';


--13
select *
from emp
where job = 'SALESMAN' or empno >= 7800 and empno < 7900;

-- emp ���̺��� ��� �̸��� SMITH �̰ų� ��� �̸��� ALLEN �̸鼭 �������� SALESMAN�� ��� ��ȸ
SELECT *
FROM emp
WHERE ename in('SMITH') or ename='ALLEN' and job = 'SALESMAN';

--��� �̸��� SMITH �̰ų� ALLEN�̸� �������� SALESMAN�� ��� ��ȸ
SELECT *
FROM emp
WHERE ename in('SMITH','ALLEN') and job = 'SALESMAN';

--14
select *
from emp
where job = 'SALESMAN' OR empno like '78%' AND hiredate >= to_date(19810601,'yyyymmdd');

--����
-- ORDER BY {�÷���|��Ī|�ε��� [ASC(��������)/DESC(��������)],...}

--EMP ���̺��� ��� ����� ename Į�� ���� �������� �������� ������ ����� ��ȸ�Ͻÿ�.
SELECT *
FROM emp
ORDER BY ename;

--EMP ���̺��� ��� ����� ename Į�� ���� �������� �������� ������ ����� ��ȸ�Ͻÿ�.
SELECT *
FROM emp
ORDER BY ename desc;

--emp ���̺��� ��� ������ ename �÷����� ��������, ename ���� ���� ��� mgr �÷����� �������� �����ϴ� ������ �ۼ��ϼ���.
SELECT *
FROM emp
ORDER BY ename desc, mgr;

--���Ľ� ��Ī�� ���
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY nm;

--�÷� �ε����� ����
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY 3;

SELECT deptno, dname, loc
from dept
order by 2;

SELECT deptno, dname, loc
from dept
order by 3 desc;

SELECT *
from emp
where comm not in(0)
order by comm desc, empno;

SELECT *
FROM EMP
where mgr is not null
ORDER BY job, empno desc;
















