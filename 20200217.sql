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

insert into dept_h values ('dept0', 'XX회사', '');
insert into dept_h values ('dept0_00', '디자인부', 'dept0');
insert into dept_h values ('dept0_01', '정보기획부', 'dept0');
insert into dept_h values ('dept0_02', '정보시스템부', 'dept0');
insert into dept_h values ('dept0_00_0', '디자인팀', 'dept0_00');
insert into dept_h values ('dept0_01_0', '기획팀', 'dept0_01');
insert into dept_h values ('dept0_02_0', '개발1팀', 'dept0_02');
insert into dept_h values ('dept0_02_1', '개발2팀', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '기획파트', 'dept0_01_0');
commit;

SELECT *
FROM dept_h;

오라클 계층형 쿼리 문법
SELECT ...
FROM ...
WHERE ...
START WITH 조건 : 어떤 행을 시작점으로 삼을지
CONNECT BY 행과 행을 연결하는 기준
        PRIOR : 이미 읽은 행,
        "" : 앞으로 읽을 행

하향식 : 상위에서 자식노드를 연결(위에서 아래로);
XX회사(최상위 조직)에서 시작하여 하위 부서로 내려가는 계층 쿼리;

SELECT dept_h.*, level, lpad(' ',(level-1)*4, ' ') || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;   --행과 행의 연결 조건( PRIOR XX회사 - 3가지 부(디자인부, 정보기획부, 정보시스템부)

PRIOR XX회사.deptcd = 디자인부.p_deptcd
PRIOR 디자인부.deptcd = 디자인팀 .p_deptcd

PRIOR XX회사.deptcd = 정보기획부.p_deptcd
PRIOR 정보기획부.deptcd = 기획팀.p_deptcd
PRIOR 기획팀.deptcd = 기획파트.p_depcd

PRIOR XX회사.deptcd = 정보시스템.p_deptcd
PRIOR 정보시스템부.deptcd = 개발1팀.p_deptcd
PRIOR 정보시스템부.deptcd = 개발2팀.p_deptcd;




