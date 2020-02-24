����� ���� ����(leaf ==> root node(���� node)
��ü ��带 �湮�ϴ°� �ƴ϶� �ڽ��� �θ��常 �湮(����İ� �ٸ���)
������ : ��������
������ : �����μ�;

SELECT dept_h.*, level,lpad(' ', (level-1)*4,' ') || deptnm
FROM dept_h
START WITH deptnm = '��������'
CONNECT BY PRIOR p_deptcd = deptcd; 





SELECT lpad(' ', (level-1)*4, ' ')||s_id s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;



create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XXȸ��', null, 1);
insert into no_emp values('�����ý��ۺ�', 'XXȸ��', 2);
insert into no_emp values('����1��', '�����ý��ۺ�', 5);
insert into no_emp values('����2��', '�����ý��ۺ�', 10);
insert into no_emp values('������ȹ��', 'XXȸ��', 3);
insert into no_emp values('��ȹ��', '������ȹ��', 7);
insert into no_emp values('��ȹ��Ʈ', '��ȹ��', 4);
insert into no_emp values('�����κ�', 'XXȸ��', 1);
insert into no_emp values('��������', '�����κ�', 7);

commit;



SELECT lpad(' ', (level -1)*4) || org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;


������ ������ �� ���� ���� ��� ��ġ�� ���� ��� ��(pruning branch - ����ġ��)
FROM => START WITH, CONNECT BY => WHERE
1.WHERE : ���� ������ �� �ϰ��� ���� ����
2.CONNECT BY : ���� ������ �ϴ� �������� ���� ����;

WHERE �� ����� : �� 9���� ���� ��ȸ�Ǵ°��� Ȯ���� �� �ִ�.
WHERE ��(deptnm != '������ȹ��') : ������ȹ�θ� ������ 8���� ���� ��ȸ�ȴ�.
SELECT lpad(' ', (level -1)*4) || org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

CONNECT BY ���� ������ ��� : ;

SELECT lpad(' ', (level -1)*4) || org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd and org_cd != '������ȹ��';

CONNECT_BY_ROOT(�÷�) : �ش� �÷��� �ֻ��� ���� ���� ����;
SYS_CONNECT_BY_PATH(�÷�, ������) : �ش� ���� �÷��� ���Ŀ� �÷� ���� ��õ, �����ڷ� �̾��ش�.
CONNECT_BY_ISLEAF : �ش� ���� LEAF������� �ƴ��� ���� ���� LEAF��1�� �ƴϸ� 0�� ��ȯ;

SELECT lpad(' ', (level -1)*4) || org_cd, no_emp, CONNECT_BY_ROOT(org_cd) root,
       ltrim(SYS_CONNECT_BY_PATH(org_cd,'-'),'-') path,
       CONNECT_BY_ISLEAF leaf
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;



CREATE table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, 'ù��° ���Դϴ�');
insert into board_test values (2, null, '�ι�° ���Դϴ�');
insert into board_test values (3, 2, '����° ���� �ι�° ���� ����Դϴ�');
insert into board_test values (4, null, '�׹�° ���Դϴ�');
insert into board_test values (5, 4, '�ټ���° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (6, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (7, 6, '�ϰ���° ���� ������° ���� ����Դϴ�');
insert into board_test values (8, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (9, 1, '��ȩ��° ���� ù��° ���� ����Դϴ�');
insert into board_test values (10, 4, '����° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (11, 10, '���ѹ�° ���� ����° ���� ����Դϴ�');
commit;


SELECT *
FROM board_test;

SELECT seq, lpad(' ', (level - 1)* 4) || title title
FROM board_test
START WITH parent_seq is null
CONNECT BY PRIOR seq = parent_seq;

�׷��ȣ�� ������ �÷� �߰�;
ALTER TABLE board_test ADD(gn number);

UPDATE board_test SET gn=4
WHERE seq IN(4,5,6,7,8,10,11);

UPDATE board_test SET gn=2
WHERE seq IN(2,3);

UPDATE board_test SET gn=1
WHERE seq IN(1,9);

commit;

SELECT seq, lpad(' ', (level - 1)* 4) || title title, parent_seq+seq
FROM board_test
START WITH parent_seq is null
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq desc,parent_seq+seq;


SELECT seq, lpad(' ', (level - 1)* 4) || title title, gn
FROM board_test
START WITH parent_seq is null
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn desc;

SELECT a.ename, a.sal, a.deptno, decode(a.deptno,10,rownum,20,rownum-cnt,30,rownum-cnt)
FROM
(SELECT ename, sal, deptno
FROM emp
ORDER BY deptno, sal desc
) a join
(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno) b ON(a.deptno = b.deptno)
ORDER BY deptno, sal desc;

KING	5000	10
CLARK	2450	10
MILLER	1300	10
SCOTT	3000	20
FORD	3000	20
JONES	2975	20
ADAMS	1100	20
SMITH	800	20
BLAKE	2850	30
ALLEN	1600	30
TURNER	1500	30
MARTIN	1250	30
WARD	1250	30
JAMES	950	30
30	6
20	5
10	3

(SELECT b.*, rownum rm
FROM
(SELECT ename, sal, deptno
FROM emp
ORDER BY deptno, sal)b) b;
--------------------����---------------------

SELECT b.ename, b.sal, a.lv
FROM
(SELECT a.*, rownum rm
FROM
(SELECT *
FROM
(   SELECT LEVEL lv
    FROM dual
    CONNECT BY LEVEL <=14) a,
(   SELECT deptno, COUNT(*) cnt
    FROM emp
    GROUP BY deptno) b
WHERE b.cnt >= a.lv
ORDER BY b.deptno, a.lv) a) a 
JOIN
(SELECT b.*, rownum rm
FROM
(SELECT ename, sal, deptno
FROM emp
ORDER BY deptno, sal desc)b) b ON(a.rm = b.rm);





