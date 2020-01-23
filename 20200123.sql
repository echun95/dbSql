SELECT ename, hiredate
FROM emp
WHERE to_date(19820101,'YYYYMMDD') <= hiredate and hiredate <= to_date(19830101,'YYYYMMDD');

-- where 절에 기술하는 조건에 순서는 조회 결과에 영향을 미치지 않는다.
-- SQL은 집합의 개념을 갖고 있다.
-- 집합 : 키카 185cm 이상이고 몸무게가 70kg 이상인 사람들의 모임
-- 몸무게가 70kg 이상이고 키가 185cm 이상인 사람들의 모임
-- 집합의 특징 : 집합에는 순서가 없다. ex) {1,4,5} = {4,5,1}
-- 테이블에는 순서가 보장되지 않음
-- SELECT 결과가 순서가 다르더라도 값이 동일하면 정답
-- 정령기능 제공(ORDER BY)

-- IN 연산자
-- 특징 집합에 포함되는지 여부를 확인
SELECT empno, ename, deptno
FROM emp;

-- 부서번호가 10번 혹은 20번에 속하는 직원 조회
SELECT empno, ename, deptno
FROM emp 
WHERE deptno IN (10,20);

SELECT empno, ename, deptno
FROM emp 
WHERE deptno = 10 or deptno = 20;

-- emp테이블에서 사원이름이 SMITH, JONES 인 직원만 조회(empno, ename, deptno)
SELECT empno, ename, deptno
FROM emp 
WHERE ename IN('SMITH','JONES');

SELECT userid 아이디, usernm 이름, ALIAS 별명
FROM users
WHERE userid IN('brown','cony','sally');

-- 문자열 매칭 연산자 : LIKE, %,_
-- 위에서 연습한 조건은 문자열 일치에 대해서 다룸
-- 이름이 BR로 시작하는 사람만 조회
-- 이름에 R 문자열 들어가는 사람만 조회

SELECT *
FROM emp;

--사원 이름이 S로 시작하는 사원 조회
--% 어떤 문자열(한글자, 글자 없을수도 있고, 여러 문자열이 올수도 있다.

SELECT *
FROM emp
WHERE ename like 'S%';

--글자 수를 제한한 매턴 패칭
-- _ 정확히 한문자
--직원 이름이 S로 시작하고 이름의 전체 길이가 5글자 인 직원
SELECT *
FROM emp
WHERE ename like 'S____';

-- 사원 이름에 s글자가 들어가는 사원 조회
SELECT *
FROM emp
WHERE ename like '%S%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name like '신%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name like '%이%';

-- null 비교 연산(IS)
-- comm 컬럼의 값이 null인 데이터를 조회 (WHERE comm = null)
SELECT *
FROM emp
WHERE comm is null;

SELECT *
FROM emp
WHERE job = 'SALESMAN';

SELECT *
FROM emp
WHERE comm is not null;

-- 사원의 관리가자 7698, 7839 그리고 null이 아닌 직원만 조회
-- NOT IN 연산자에서는 NULL 값을 포함 시키면 안된다.
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

-- emp 테이블에서 사원 이름이 SMITH 이거나 사원 이름이 ALLEN 이면서 담당업무가 SALESMAN인 사원 조회
SELECT *
FROM emp
WHERE ename in('SMITH') or ename='ALLEN' and job = 'SALESMAN';

--사원 이름이 SMITH 이거나 ALLEN이면 담당업무가 SALESMAN인 사원 조회
SELECT *
FROM emp
WHERE ename in('SMITH','ALLEN') and job = 'SALESMAN';

--14
select *
from emp
where job = 'SALESMAN' OR empno like '78%' AND hiredate >= to_date(19810601,'yyyymmdd');

--정렬
-- ORDER BY {컬럼명|별칭|인덱스 [ASC(오름차순)/DESC(내림차순)],...}

--EMP 테이블의 모든 사원을 ename 칼럼 값을 기준으로 오름차순 정렬한 결과를 조회하시오.
SELECT *
FROM emp
ORDER BY ename;

--EMP 테이블의 모든 사원을 ename 칼럼 값을 기준으로 내림차순 정렬한 결과를 조회하시오.
SELECT *
FROM emp
ORDER BY ename desc;

--emp 테이블에서 사원 정보를 ename 컬럼으로 내림차순, ename 값이 같을 경우 mgr 컬럼으로 오름차순 정렬하는 쿼리를 작성하세요.
SELECT *
FROM emp
ORDER BY ename desc, mgr;

--정렬시 별칭을 사용
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY nm;

--컬럼 인덱스로 정렬
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
















