:dt ==> 202002;
SELECT DECODE(d,1,iw+1,iw) i,
       MIN(DECODE(d,1,dt)) sun,
       MIN(DECODE(d,2,dt)) mon,
       MIN(DECODE(d,3,dt)) tue,
       MIN(DECODE(d,4,dt)) wed,
       MIN(DECODE(d,5,dt)) tur,
       MIN(DECODE(d,6,dt)) fri,
       MIN(DECODE(d,7,dt)) sat
FROM
(SELECT (TO_DATE(:dt,'YYYYMM') +  LEVEL - 1) dt,
        TO_CHAR((TO_DATE(:dt,'YYYYMM') +  LEVEL - 1),'D') d,       
        TO_CHAR((TO_DATE(:dt,'YYYYMM') +  LEVEL - 1),'iw') iw
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt,'yyyymm')),'DD'))
GROUP BY DECODE(d,1,iw+1,iw)
ORDER BY DECODE(d,1,iw+1,iw);

SELECT TO_DATE(:dt,'YYYYMM') - (TO_CHAR((TO_DATE(:dt,'YYYYMM') +  LEVEL - 1),'D'))+1
FROM dual
CONNECT BY LEVEL <= 1;

SELECT TO_CHAR(LAST_DAY(TO_DATE(:dt,'yyyymm')),'DD')
FROM dual
CONNECT BY LEVEL <= 1;


-------------------------------------------------------------------------------
SELECT TO_DATE(:dt, 'yyyymm') - (TO_CHAR(TO_DATE(:dt, 'yyyymm'),'D')-1) st,
       LAST_DAY(TO_DATE(:dt,'yyyymm')) + (7-TO_CHAR(LAST_DAY(TO_DATE(:dt,'yyyymm')), 'D')) ed,
       LAST_DAY(TO_DATE(:dt,'yyyymm')) + (7-TO_CHAR(LAST_DAY(TO_DATE(:dt,'yyyymm')), 'D')) - 
       (TO_DATE(:dt, 'yyyymm') - (TO_CHAR(TO_DATE(:dt, 'yyyymm'),'D'))) daycnt
FROM dual;


SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);

create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

SELECT *
FROM sales;

SELECT NVL(SUM(jan),0) jan, NVL(SUM(feb),0) feb, NVL(SUM(mar),0) mar, NVL(SUM(apr),0) apr, NVL(SUM(may),0) may, NVL(SUM(jun),0) jun
FROM
(SELECT        
       decode(to_char(dt,'mm'),1,sum(sales)) jan,
       decode(to_char(dt,'mm'),2,sum(sales)) feb,
       decode(to_char(dt,'mm'),3,sum(sales)) mar,
       decode(to_char(dt,'mm'),4,sum(sales)) apr,
       decode(to_char(dt,'mm'),5,sum(sales)) may,
       decode(to_char(dt,'mm'),6,sum(sales)) jun
FROM sales
GROUP BY to_char(dt,'mm'));

create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XXȸ��', '');
insert into dept_h values ('dept0_00', '�����κ�', 'dept0');
insert into dept_h values ('dept0_01', '������ȹ��', 'dept0');
insert into dept_h values ('dept0_02', '�����ý��ۺ�', 'dept0');
insert into dept_h values ('dept0_00_0', '��������', 'dept0_00');
insert into dept_h values ('dept0_01_0', '��ȹ��', 'dept0_01');
insert into dept_h values ('dept0_02_0', '����1��', 'dept0_02');
insert into dept_h values ('dept0_02_1', '����2��', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '��ȹ��Ʈ', 'dept0_01_0');
commit;

SELECT *
FROM dept_h;

����Ŭ ������ ���� ����
SELECT ...
FROM ...
WHERE ...
START WITH ���� : � ���� ���������� ������
CONNECT BY ��� ���� �����ϴ� ����
        PRIOR : �̹� ���� ��,
        "" : ������ ���� ��

����� : �������� �ڽĳ�带 ����(������ �Ʒ���);
XXȸ��(�ֻ��� ����)���� �����Ͽ� ���� �μ��� �������� ���� ����;

SELECT dept_h.*, level, lpad(' ',(level-1)*4, ' ') || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;   --��� ���� ���� ����( PRIOR XXȸ�� - 3���� ��(�����κ�, ������ȹ��, �����ý��ۺ�)

PRIOR XXȸ��.deptcd = �����κ�.p_deptcd
PRIOR �����κ�.deptcd = �������� .p_deptcd

PRIOR XXȸ��.deptcd = ������ȹ��.p_deptcd
PRIOR ������ȹ��.deptcd = ��ȹ��.p_deptcd
PRIOR ��ȹ��.deptcd = ��ȹ��Ʈ.p_depcd

PRIOR XXȸ��.deptcd = �����ý���.p_deptcd
PRIOR �����ý��ۺ�.deptcd = ����1��.p_deptcd
PRIOR �����ý��ۺ�.deptcd = ����2��.p_deptcd;




