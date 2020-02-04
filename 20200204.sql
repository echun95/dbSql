--CROSS JOIN
--�����ϴ� �� ���̺��� ���� ������ �����Ȱ��
--������ ��� ���տ� ���� ����(����)�� �õ�
--dept(4��), emp(14)�� cross join�� ����� 4*14 = 56��
--cross join -> īƼ�� ���δ�Ʈ(cartesian product)

SELECT d.dname, e.empno, e.ename
from dept d cross join emp e 
where d.deptno = 10 and d.deptno = e.deptno;

select c.cid,c.cnm,p.pid,p.pnm
from customer c cross join product p
order by C.Cid;

--SMITH�� ���� �μ��� ���ϴ� �������� ������ ��ȸ
--1.SMITH�� ���ϴ� �μ� ��ȣ�� ���Ѵ�.
--2.1������ ���� �μ���ȣ�� ���ϴ� ���� ������ ��ȸ

select deptno
from emp 
where ename = 'SMITH';

select *
from emp
where deptno = 20;

--SUBQUERY�� �̿��ϸ� �ΰ��� ������ ���ÿ� �ϳ��� SQL�� ������ ����
select *
from emp
where deptno = 20;

select *
from emp
where deptno = (select deptno 
                from emp
                where ename = 'SMITH');
                     
--subquery : �����ȿ� �ٸ� ������ ���ִ� ���
--subquery : ���� ��ġ�� ���� 3������ �з�
--select �� : scalar subquery : �ϳ��� ��, �ϳ��� �÷��� �����ؾ� ������ �߻����� ����
--from �� : inline view
--where �� : subquery

select count(*)
from emp
where sal > (select avg(sal) 
             from emp);
        
--������ ������        
--IN : ���������� ������ �� ��ġ�ϴ� ���� ���� �� ��
--ANY [Ȱ�뵵�� �ټ� ������] : ���������� ������ �� �� ���̶� ������ ������ �� 
--ALL [Ȱ�뵵�� �ټ� ������] :���������� �������� ��� �࿡ ���� ������ ������ ��

--SMITH�� WARD������ ���ϴ� �μ��� ��������� ��ȸ
select *
from emp
where deptno in (select deptno
                 from emp
                 where ename = 'SMITH' or ename = 'WARD');

--SMITH, WARD ������� �޿����� �޿��� ���� ������ ��ȸ(SMITH, WARD�� �޿��� �ƹ��ų�)
select *
from emp 
where sal < any(select sal
               from emp
               where ename in('SMITH','WARD'));

--SMITH, WARD ������� �޿����� �޿��� ���� ������ ��ȸ(SMITH, WARD�� �޿� 2���� ��ο� ���� ���� ��)
select *
from emp 
where sal > all(select sal
               from emp
               where ename in('SMITH','WARD'));

--������ ������ ����� 7902�̳� null
select *
from emp
where mgr in (7902,null);

select *
from emp
where mgr = 7902 or mgr is null;

--�����ȣ�� 7902�� �ƴϸ鼭 null�� �ƴ� ������ not in(7902,null)
select *
from emp
where mgr != 7902 and mgr is not null;

select *
from emp
where (mgr, deptno) in (select mgr, deptno
                        from emp
                        where empno in(7499, 7782));
--non-pairwise�� �������� ���ÿ� ������Ű�� �ʴ� ���·� �ۼ�
--mgr ���� 7698�̰ų� 7839�̸鼭 deptno�� 10���̰ų� 30���� ����
--mgr, deptno
--(7698, 10), (7698, 30), (7839, 10), (7839, 10)

select *
from emp
where mgr in (select mgr
              from emp
              where empno in (7499, 7782))
              and
     deptno in (select deptno
              from emp
              where empno in (7499, 7782))
;

--��Į�� �������� : select ���� ���, 1���� row, 1���� col�� ��ȸ�ϴ� ����
--��Į�� ���������� main ������ �÷��� ����ϴ°� �����ϴ�.
select (select sysdate from dual), dept.*
from dept;

select empno, ename, deptno
from emp;

select empno, ename, deptno, (select dname from dept where deptno= emp.deptno) dname
from emp;

--inline view : from ���� ����Ǵ� ��������;

--main ������ �÷��� subquery���� ����ϴ��� ������ ���� �з�
--����� ��� : correlated subquery(��ȣ ���� ����), ���������� �ܵ����� �����ϴ°� �Ұ�����
--������� ���� ��� : non-correlated subquery(���ȣ ���� ����), ���������� �ܵ����� �����ϴ°� ������

--��� ������ �޿� ��պ��� �޿��� ���� ����� ��ȸ
select *
from emp
where sal > (select avg(sal) from emp);

--������ ���� �μ��� �޿� ��պ��� �޿��� ���� ����� ��ȸ
select *
from emp m
where  sal > (select avg(sal)
              from emp e
              where e. deptno = m.deptno);

select m.* 
from emp m join (select deptno, avg(sal) avgsal 
                 from emp group by deptno) e on ( m.deptno = e.deptno and m.sal > e.avgsal);

--������ �߰�
insert into dept Values(99,'ddit','daejeon');
commit;

select *
from dept 
where deptno not in (select deptno
                     from emp
                     group by deptno
);

