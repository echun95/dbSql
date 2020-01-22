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

-- 테이블의 어떤 컬럼이 있는지 학인하는 방법
-- 1. SECLECT *
-- 2. TOOL의 기능 (사용자-TABLES)
-- 3. DESC 테이블명 (DESC - DESCRIBE)

DESC users;

-- users 테이블에서 userid, usernm, reg_dt 칼럼만 조회하는 sql을 작성하세요.
-- null : 값을 모르는 상태
-- null에 대한 연산 결과는 항상 null

SELECT userid u_id, usernm, reg_dt,reg_dt+5 reg_dt_after_5day
FROM users;

SELECT prod_id id, prod_name name FROM prod;
SELECT lprod_gu gu, lprod_nm nm FROM lprod;
SELECT buyer_id 바이어아이디, buyer_name 이름 FROM buyer;

-- 문자열 결합
-- 자바 언어에서는 문자열 결합 : + ("hello"+"world")
-- SQL에서는 : || ('hello'||'world')
-- SQL에서는 : concat('hello','world')

--userid, usernm 컬럼을 결합, 별칭 id_name
SELECT concat(userid,usernm) id_name
FROM users;

-- SQL에서의 변수는 없음
-- (컬럼이 비슷한 역할, pl/sql 변수 개념이 존재)
-- SQL에서 문자열 상수는 싱글 쿼테이션으로 표현
-- "hell, world" -> 'hello, world'

-- 문자열 상수와 컬럼간의 결합
SELECT 'user id : '||userid "user id"
FROM users;

SELECT table_name
FROM user_tables;

SELECT 'SELECT * FROM '||table_name||';' AS QUERY
FROM user_tables;

SELECT concat(concat('SELECT * FROM ',table_name),';') AS QUERY
FROM user_tables;

-- int a = 5; 할당/대입 연산자
-- if( a == 5) a의 값이 5인지 비교
-- sql에서는 대입의 개념이 없다(pl/sql은 있음)
-- sql = --> equal

--where 절 : 테이블에서 데이터를 조회할 때 조건에 맞는 행만 조회
-- ex : userid 컬럼의 값이 brown인 행만 조회

SELECT *
FROM users
WHERE userid = 'brown';

-- userid가 brown이 아닌 행만 조회(brown을 제외한 4건)
-- 같을 때 : =, 다를 때 : !=, <>

SELECT *
FROM users
WHERE userid != 'brown';

-- emp 테이블에 존재하는 컬럼을 학인 해보세요
desc emp;

-- emp 테이블에서 ename 컬럼 값이 JONES인 행만 조회
-- * SQL KEY WORD는 대소문자를 가리지 않지만 컬럼의 값이나, 문자열 상수는 대소문자를 가린다.(JONES != jones)
SELECT *
FROM emp
WHERE ename = 'JONES';

-- emp 테이블에서 deptno(부서번호)가 30보다 크거나 같은 사원들만 조회
SELECT *
FROM emp
WHERE deptno >= 30;

-- 문자열 : '문자열'
-- 숫자 : 50
-- 날짜 : ??? -> 함수와 문자열을 결합하여 표현, 문자열만 이용하여 표현 가능(권장하지않음) 국가별로 날짜 표기 방법이 다르기때문에
-- 한국 : 년도4자리-월2자리-일자2자리
-- 미국 : 월2자리-일자2자리-년도4자리

--입사일자가 1980년 12월 17일 직원만 조회
-- TO_DATE : 문자열을 date 타입으로 변경하는 함수
-- TO_DATE(날짜형식 문자열, 첫번째 인자의 형식)

SELECT *
FROM emp 
WHERE hiredate = to_date('19801217','YYYYMMDD');

-- 범위연산
-- SAL 컬럼의 값이 1000에서 2000 사이인 사람
-- sal >= 1000 && sal <= 2000
SELECT *
FROM emp
WHERE SAL >=1000 AND SAL <= 2000;

-- 범위연산자를 부등호 대신에 between A and B 연산자로 대체
SELECT *
FROM emp
WHERE sal between 1000 AND 2000;

SELECT ename, hiredate
FROM emp
WHERE hiredate between to_date('19820101','YYYYMMDD') and to_date('19830101','YYYYMMDD');













