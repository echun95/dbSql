SELECT rownum, empno, ename
FROM emp 
WHERE deptno IN(10,30) and sal >1500
ORDER BY ename;


    -- ROWNUM을 WHERE절에서도 사용가능
    -- 동작 : ROWNUM = 1, ROWNUM <= N
    -- 동작 X : ROWNUM = N(1이 아닌정수), ROWNUM >= N(1이 아닌정수)
    -- ROWNUM 이미 읽은 데이터에다가 순서를 부여
    -- 읽지 않은 상태의 값들(ROWNUM이 부여되지 않은 행)은 조회할 수가 없다.
    -- 사용용도 : 페이징 처리
    -- 유의점1** : 테이블에 있는 모든 행을 소화하는 것이 아니라 우리가 원하는 페이지에 해당하는 행 데이터만 조회한다. 
    -- 유의점2** : ORDER BY 절은 SELECT 절 이후에 실행
    -- 페이징 처리시 고려사항 : 1페이지당 건수, 정렬 기준
    -- EMP테이블 총 ROW 건수 : 14
    -- 페이징당 5건의 데이터를 조회
    -- 1PAGE = 1~5 2PAGE = 6~10 3PAGE = 11~15
    
SELECT rownum rn, empno, ename
FROM emp
ORDER BY ENAME;

-- 정렬된 결과에 ROWNUM을 부여하기 위해서는 IN LINE VIEW를 사용한다.
-- 요점정리 : 1. 정렬, 2. ROWNUM 부여
-- SELECT 절에 *를 기술할 경우 다른 EXPRESSION을 표기 하기 위해서 테이블명.* 테이블별칭.*로 표현해야한다.
SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e; 

    -- PAGE SIZE = 5, 정렬기준은 ename
    -- 1 PAGE = 1~5 2 PAGE = 6~10 3 PAGE = 11~15
    -- n page = rn (page-1)*pagesize+1 ~ page * pagesize
SELECT *
FROM(SELECT ROWNUM rn, e.*
FROM(SELECT empno, ename
FROM emp
ORDER BY ename) e)
WHERE rn between (1-1)*5 and 1*5;


SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM between 1 and 10;

SELECT *
FROM (SELECT ROWNUM rn, empno, ename
FROM emp)
WHERE rn between 11 and 20;

SELECT rn, empno, ename
FROM(SELECT ROWNUM rn, e.*
     FROM(SELECT *
          FROM emp
          ORDER BY ename) e) 
WHERE rn between (:page-1) * :pagesize and :page * :pagesize;

--DUAL 테이블 : 데이터와 관계 없이, 함수를 테스트 해볼 목적으로 사용
SELECT LENGTH('TEST')
FROM DUAL;
--문자열 대소문자 : LOWER, PPER, INICAP
SELECT LOWER('TEST')
FROM DUAL;
SELECT UPPER('test')
FROM DUAL;
SELECT INITCAP('TEST')
FROM DUAL;

SELECT *
FROM emp
WHERE ename = upper(:ename);

-- SQL작성시 아래 형태는 지양 해야한다.
-- 테이블의 컬럼을 가공하지 않는 형태로 SQL을 작성한다.
SELECT *
FROM emp
WHERE lower(ename) = :ename;

--
SELECT CONCAT('안녕','하세요'), substr('안녕하세요',1,2), length('안녕하세요'), instr('안녕하세요세하녕안','하'), instr('안녕하세요세하녕안','하',4)
, LPAD('안녕하세요',15,'*'), RPAD('안녕하세요',15,'*'), replace('안녕하세요', '녕','뇽'), trim(' 안녕하세요 '), trim('요'from'안녕하세요')
FROM dual;

-- 숫자 함수 
-- ROUND : 반올림 (10.6을 소수점 첫번째 자리에서 반올림 -> 11)
-- TRUNC : 절삭(버림) (10.6을 소수점 첫번째 자리에서 절삭 --> 10)
-- ROUND, TURNC : 몇번째 자리에서 반올림 / 절삭 (인자가 2개)
-- MOD : 나머지 (몫이 아닌 나머지를 구하는 함수 10 / 3 -> 1)

-- ROUND(대상 숫자, 최종 결과 자리) 
SELECT ROUND(105.54, 1) --소수점 첫번째 자리까지 나옴(2번째 자리에서 반올림)
FROM DUAL;

SELECT ROUND(105.55, 1) --소수점 첫번째 자리까지 나옴(2번째 자리에서 반올림)
FROM DUAL;

SELECT ROUND(105.54, 0) --정수부만 나옴(1번째 자리에서 반올림), 두번째 인자를 입력하지 않아도 0이 적용
FROM DUAL;

SELECT TRUNC(105.54, 1) --소수점 첫번째 자리까지 나옴(2번째 자리에서 버림)
FROM DUAL;

SELECT ename, sal, trunc(sal/1000) --몫을 구해보세요
, mod(sal,1000)
from emp;

SELECT MOD(10,3) --몫 3 나머지 1
FROM DUAL;

--년 2자리/ 월 2자리/ 일 2자리
SELECT ename, hiredate
FROM emp;

-- SYSDATE : 현재 오라클 서버의 시분초가 포함된 날짜 정보를 리턴하는 특수 함수
-- 함수명(인자1, 인자2)
-- DATE + 정수 = 일자 연산
SELECT SYSDATE + 5, SYSDATE + 1/24
FROM DUAL;









