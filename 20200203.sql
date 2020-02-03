select m.mem_id, m.mem_name, p.prod_id, c.cart_qty
from member m join cart c on (m.mem_id = c.cart_member) join prod p on (c.cart_prod = p.prod_id);

select * 
from customer;

select *
from product;

select *
from cycle;

select c.cid, c.cnm, cycle.pid, cycle.day, cycle.cnt
from customer c join cycle on ( c.cid = cycle.cid)
where c.cnm = 'brown' or c.cnm = 'sally';

select c.cid, c.cnm, cycle.pid, p.pnm,cycle.day, cycle.cnt
from customer c join cycle on ( c.cid = cycle.cid) join product p on ( cycle.pid = p.pid )
where c.cnm = 'brown' or c.cnm = 'sally';

select c.cid, c.cnm, cycle.pid, p.pnm,cycle.day, cycle.cnt
from customer c join cycle on ( c.cid = cycle.cid) join product p on ( cycle.pid = p.pid )
;
--6��
select c.cid, c.cnm, cycle.pid, p.pnm, sum(cycle.cnt)
from customer c join cycle on ( c.cid = cycle.cid) join product p on ( cycle.pid = p.pid )
group by c.cid, c.cnm, cycle.pid, p.pnm;

select c.pid, p.pnm, sum(c.cnt)
from cycle c join product p on (c.pid = p.pid)
group by c.pid, p.pnm;

--OUTER JOIN
--�� ���̺��� ������ �� ���� ������ ���� ��Ű�� ���ϴ� �����͸� �������� ������ ���̺��� �����͸��̶� ��ȸ �ǰԲ� �ϴ� ���ι��
--emp ���̺��� �����ʹ� �� 14�������� �Ʒ��� ���� ���������� ����� 13���� �ȴ�.(1�� ���ν���)
select e.empno, e.ename, e.mgr, m.ename
from emp e join emp m on (e.mgr = m.empno);

--ansi outer
--1.���ο� �����ϴ��� ��ȸ�� �� ���̺��� ���� (�Ŵ��� ������ ��� ��������� �����Բ�)

select e.empno, e.ename, e.mgr, m.ename
from emp m right outer join emp e on (e.mgr = m.empno);

--oracle outer join
--�����Ͱ� ���� ���� ���̺� �÷� �ڿ� (+) ��ȣ�� �ٿ��ش�.
select e.empno, e.ename, e.mgr, m.ename
from emp e, emp m 
where e.mgr = m.empno(+);

--���� sql�� �Ƚ� sql(outer join)���� �����غ�����;
--�Ŵ��� �μ���ȣ�� 10���λ���� ��ȸ
--�Ʒ� left outer ������ ���������� outer������ �ƴϴ�.
--�Ʒ� inner ���ΰ� ����� �����ϴ�.
select e.empno, e.ename, e.mgr, m.ename
from emp e left outer join emp m on (e.mgr = m.empno)
where m.deptno = 10;

--�������� outer����
select e.empno, e.ename, e.mgr, m.ename
from emp e left outer join emp m on (e.mgr = m.empno and m.deptno = 10);

--����Ŭ outer join
--����Ŭ outer join�� ���� ���̺��� �ݴ��� ���̺��� ��� �÷��� (+)�� �ٿ��� outer������ ���������� �����Ѵ�.
--�� �ø��̶� �����ϸ� inner�������� ����

--�Ʒ��� oracle outer������ inner�������� ���� : m.deptno�÷� �̸��� (+)�� ���� ����
select e.empno, e.ename, e.mgr, m.ename, m.deptno
from emp e, emp m
where e.mgr = m.empno(+) and m.deptno = 10;

select e.empno, e.ename, e.mgr, m.ename, m.deptno
from emp e, emp m
where e.mgr = m.empno(+) 
and m.deptno(+) = 10;

--��� - �Ŵ����� right outer join
select empno, ename, mgr
from emp e;

select empno, ename
from emp m;

select e.empno, e.ename, e.mgr, m.ename
from emp e right outer join emp m on ( e.mgr = m.empno );

select e.empno, e.ename, e.mgr, m.ename
from emp e, emp m
where e.mgr(+) = m.empno ;

--full outer : left outer + right outer - �ߺ�����
select e.empno, e.ename, e.mgr, m.ename
from emp e full outer join emp m on ( e.mgr = m.empno );

select nvl(b.buy_date,to_date('2005/01/25','yyyy/mm/dd')), b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
from buyprod b right outer join prod p on (b.buy_prod = p.prod_id and B.Buy_Date = to_date('2005/01/25','yyyy/mm/dd'));












