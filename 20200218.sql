상향식 계층 쿼리(leaf ==> root node(상위 node)
전체 노드를 방문하는게 아니라 자신의 부모노드만 방문(하향식과 다른점)
시작점 : 디자인팀
연결은 : 상위부서;

SELECT dept_h.*, level,lpad(' ', (level-1)*4,' ') || deptnm
FROM dept_h
START WITH deptnm = '디자인팀'
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
insert into no_emp values('XX회사', null, 1);
insert into no_emp values('정보시스템부', 'XX회사', 2);
insert into no_emp values('개발1팀', '정보시스템부', 5);
insert into no_emp values('개발2팀', '정보시스템부', 10);
insert into no_emp values('정보기획부', 'XX회사', 3);
insert into no_emp values('기획팀', '정보기획부', 7);
insert into no_emp values('기획파트', '기획팀', 4);
insert into no_emp values('디자인부', 'XX회사', 1);
insert into no_emp values('디자인팀', '디자인부', 7);

commit;



SELECT lpad(' ', (level -1)*4) || org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;


계층형 쿼리의 행 제한 조건 기술 위치에 따른 결과 비교(pruning branch - 가지치기)
FROM => START WITH, CONNECT BY => WHERE
1.WHERE : 계층 연결을 다 하고나서 행을 제한
2.CONNECT BY : 계층 연결을 하는 과정에서 행을 제한;

WHERE 절 기술전 : 총 9개의 행이 조회되는것을 확인할 수 있다.
WHERE 절(deptnm != '정보기획부') : 정보기획부를 제외한 8개의 행이 조회된다.
SELECT lpad(' ', (level -1)*4) || org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

CONNECT BY 절에 조건을 기술 : ;

SELECT lpad(' ', (level -1)*4) || org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd and org_cd != '정보기획부';

CONNECT_BY_ROOT(컬럼) : 해당 컬럼의 최상위 행의 값을 리턴;
SYS_CONNECT_BY_PATH(컬럼, 구분자) : 해당 행의 컬럼이 거쳐온 컬럼 값을 추천, 구분자로 이어준다.
CONNECT_BY_ISLEAF : 해당 행의 LEAF노드인지 아닌지 값을 리턴 LEAF면1을 아니면 0을 반환;

SELECT lpad(' ', (level -1)*4) || org_cd, no_emp, CONNECT_BY_ROOT(org_cd) root,
       ltrim(SYS_CONNECT_BY_PATH(org_cd,'-'),'-') path,
       CONNECT_BY_ISLEAF leaf
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;



CREATE table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, '첫번째 글입니다');
insert into board_test values (2, null, '두번째 글입니다');
insert into board_test values (3, 2, '세번째 글은 두번째 글의 답글입니다');
insert into board_test values (4, null, '네번째 글입니다');
insert into board_test values (5, 4, '다섯번째 글은 네번째 글의 답글입니다');
insert into board_test values (6, 5, '여섯번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (7, 6, '일곱번째 글은 여섯번째 글의 답글입니다');
insert into board_test values (8, 5, '여덜번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (9, 1, '아홉번째 글은 첫번째 글의 답글입니다');
insert into board_test values (10, 4, '열번째 글은 네번째 글의 답글입니다');
insert into board_test values (11, 10, '열한번째 글은 열번째 글의 답글입니다');
commit;


SELECT *
FROM board_test;

SELECT seq, lpad(' ', (level - 1)* 4) || title title
FROM board_test
START WITH parent_seq is null
CONNECT BY PRIOR seq = parent_seq;

그룹번호를 저장할 컬럼 추가;
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
--------------------과제---------------------

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





