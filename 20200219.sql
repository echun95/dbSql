쿼리 실행 결과 11건
페이징 처리(페이지당 10건의 게시글)
1페이지 : 1~10
2페이지 : 11~20
바인드변수 :page, :pageSize;
rn (page-1)*pagesize+1 ~ page * pagesize;

SELECT *
FROM(
     SELECT rownum rn,seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root
     FROM board_test
     START WITH parent_seq IS NULL
     CONNECT BY PRIOR seq = parent_seq
     ORDER SIBLINGS BY root DESC, seq ASC)
WHERE rn between (:page-1)*:pageSize +1 and :page * :pageSize;




-------과제 랭킹부여하기-------
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

위에 쿼리를 분석함수를 사용해서 표현하면...;

SELECT ename, sal, deptno, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;

분석함수 문법
분석함수명([인자]) OVER([PARTITION BY 컬럼] [ORDER BY 컬럼] [WINDOWING])
PARTITION BY 컬럼 : 해당 컬럼이 같은 ROW 끼리 하나의 그룹으로 묶는다. 
ORDER BY 컬럼 : PARTITION BY에 의해 묶인 그룹 내에서 ORDER BY 컬럼으로 정렬

ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) rank;

순위 관련 분석함수
RANK : 같은 값을 가질때 중복 순위를 인정, 후순위는 중복 값만큼 떨어진 값부터 시작
       2등이 2명이면 3등은 없고 4등부터 후순위가 생성된다.
DENSE_RANK() : 같은 값을 가질때 중복 순위를 인정, 후순위는 중복순위 다음부터 시작
               2등이 2명이더라도 후순위는 3등부터 시작
ROW_NUMBER() : ROWNUM과 유사, 중복된 값을 허용하지 않음.;

부서별, 급여 순위를 3개의 랭킹 관련 함수를 적용;
SELECT ename, sal, deptno, 
       RANK() OVER(PARTITION BY deptno ORDER BY sal) sal_rank,
       DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal) sal_dense_rank,
       ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal) sal_row_number
FROM emp;


----사원 전체 급여 순위---
분석함수에서 그룹 : PARTITION BY ==> 기술하지 않으면 전체행을 대상으로 한다.

SELECT ename, sal, deptno, RANK() OVER(ORDER BY sal DESC, empno) sal_rank, 
        DENSE_RANK() OVER(ORDER BY sal DESC, empno) sal_dense_rank,
        ROW_NUMBER() OVER(ORDER BY sal DESC, empno) sal_row_number
FROM emp;


-- NO_ANA2 --
SELECT a.empno, a.ename, a.deptno, b.cnt
FROM
    (SELECT empno, ename, deptno
     FROM emp
     ORDER BY deptno,empno) a 
JOIN
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) b
ON(a.deptno = b.deptno);

통계관련 분석함수 (GROUP 함수에서 제공하는 함수 종류와 동일)
SUM(컬럼)
COUNT(*), COUNT(컬럼) : 널값을 제외한 수
MIN(컬럼)
MAX(컬럼)
AVG(컬럼)

NO_ANA2를 분석함수를 사용해서 구현
부서별 직원 수

SELECT empno, ename, deptno, COUNT(*) OVER(PARTITION BY deptno ORDER BY deptno) cnt
FROM emp;

NO_ANA2 실습;

SELECT empno, ename, sal, deptno, ROUND(AVG(sal) OVER(PARTITION BY deptno),2) avg_sal
FROM emp;

NO_ANA3
SELECT empno, ename, sal, deptno, MAX(sal) OVER(PARTITION BY deptno ORDER BY deptno) max_sal
FROM emp;

NO_ANA4 
SELECT empno, ename, sal, deptno, MIN(sal) OVER(PARTITION BY deptno ORDER BY deptno) min_sal
FROM emp;

급여가 높은사람 순으로 정렬, 급여가 같을경우 입사일자가 빠른사람이 높은 우선순위로 정렬
현재행의 다음행(LEAD)의 SAL컬럼을 구하는 쿼리 작성;

SELECT empno, ename, hiredate, sal, LEAD(sal) OVER(ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

SELECT empno, ename, hiredate, sal, LAG(sal) OVER(ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

SELECT empno, ename, hiredate, job, sal, LAG(sal) OVER(PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

SELECT a.empno, a.ename, a.sal, sum(b.sal)
FROM
    (SELECT empno, ename, sal, ROWNUM rn   
     FROM 
        (SELECT empno, ename, sal
         FROM emp
         ORDER BY sal)) a,
     (SELECT empno, ename, sal, ROWNUM rn   
      FROM 
        (SELECT empno, ename, sal
         FROM emp
         ORDER BY sal)) b    
WHERE a.rn >= b.rn
GROUP BY a.empno, a.ename, a.sal, a.rn
ORDER BY a.rn, a.empno;

NO_ANA3을 분석함수를 이용하여 SQL 작성
SELECT empno, ename, sal, SUM(sal) OVER(ORDER BY sal,empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumm_sal
FROM emp;

현재 행을 기준으로 앞뒤 한 행씩;
SELECT empno, ename, sal, SUM(sal) OVER(ORDER BY sal,empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING ) c_sum
FROM emp;

ORDER BY 기술후 WINDOWING 절을 기술하지 않을 경우 다음 WINDOWING이 기본값으로 적용된다.
(DEFAULT) RANGE UNBOUNDED PRECEDING == RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW;

NO_ANA7;     
SELECT empno, ename, deptno, sal, 
       SUM(sal) OVER(PARTITION BY deptno ORDER BY deptno,sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) c_sum
FROM emp;

RANGE => 논리적인 행의 단위, 같은 값을 가지는 컬럼까지 자신의 행으로 취급
ROWS => 물리저인 행의 단위, 중복된 값들을 하나로 취급
DEFAULT => RANGE와 같다.;

SELECT empno, ename, deptno, sal, 
       SUM(sal) OVER(PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) row_,
       SUM(sal) OVER(PARTITION BY deptno ORDER BY sal RANGE UNBOUNDED PRECEDING) range_,
       SUM(sal) OVER(PARTITION BY deptno ORDER BY sal) default_
FROM emp;




