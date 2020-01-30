SELECT empno, ename, 
                CASE 
                     WHEN deptno = 10 THEN 'ACCOUNING'
                     WHEN deptno = 20 THEN 'RESEARCH'
                     WHEN deptno = 30 THEN 'SALES'
                     WHEN deptno = 40 THEN 'OPERATIONS'                     
                ELSE 'DDIT' END DNAME
FROM emp;

--DECODE(JOB,'SALESMAN',SAL * 1.05,'MANAGER', SAL * 1.1,'PRESIDENT',SAL * 1.2,SAL)
--올해가 짝,홀인지 판단하고 hiredate 홀년, 짝년인지봐야함



SELECT empno, ename, hiredate, 
                CASE 
                    When mod(to_char(sysdate,'yy'),2) = 0 then (DECODE(mod(to_char(hiredate,'yy'),2),0,'건강검진 대상자',1,'건강검진 비대상자'))
                    ELSE (DECODE(mod(to_char(hiredate,'yy'),2),1,'건강검진 대상자',0,'건강검진 비대상자'))
                END CONTACT_TO_DOCTOR                                                                           
FROM emp;


--GROUP BY 행을 묶을 기준
--부서번호가 같은 ROW 끼리 묶는 경우 : GROUP BY deptno
--담당업무가 같은 ROW 끼리 묶는 경우 : GROUP BY job
--MGR가 같고 담당업무가 같은 ROW 끼리 묶는 경우 : GROUP BY mgr, job

--그룹함수의 종류
--sum : 합계
--count : 갯수 (null값은 무시)
--max : 최대값
--min : 최소값
--avg : 평균

--그룹함수 주의점
--GROUP BY 절에 나온 컬럼이외의 다른컬럼이 SELECT절에 표현되면 에러

--부서별 급여 합
select deptno, ename, 
        sum(sal), max(sal),min(sal),round(avg(sal),2),count(sal)
from emp
group by deptno, ename;

--GROUP BY 절이 없는 상ㅌ에서 그룹함수를 사용한 경우
--전체행을 하나의 행으로 묶는다.
select sum(sal), max(sal),min(sal),round(avg(sal),2),count(sal),count(comm)
from emp;


select sum(sal), max(sal),min(sal),round(avg(sal),2),count(sal),count(comm)
from emp
group by empno;

--SINGLE OR FUNCTION의 경우 WHERE절에서 사용하는 것이 가능하나 MULTI ROW FUNCTION(GROUP FUNCTION)의 경우 WHERE절에서 사용하는 것이 불가능하고
--HAVING절에서 조건을 기술한다.

--부서별 급여 합 조회, 단 급여합이 9000이상인 row만 조회
SELECT deptno, sum(sal)
FROM emp
GROUP BY deptno
HAVING sum(sal)>9000;


--직원중 가장 높은 급여, 직원중 가장 낮은 급여, 직원의 급여 평균, 직업의 급여 합, 직원중 급여가 있는 직원의 수(null제외), 직원이 상급자가 있는 직원의 수
--전체 직원의 수
SELECT max(sal),min(sal),round(avg(sal),2),sum(sal),count(sal),count(mgr),count(*)
FROM emp;


--부서별 기준
SELECT deptno,max(sal),min(sal),round(avg(sal),2),sum(sal),count(sal),count(mgr),count(*)
FROM emp
GROUP BY deptno;

SELECT decode(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES') job,
       max(sal),min(sal),round(avg(sal),2),sum(sal),count(sal),count(mgr),count(*)
FROM emp
GROUP BY deptno;


SELECT to_char(hiredate,'YYYYMM'), count(*)
FROM emp
GROUP BY to_char(hiredate,'YYYYMM');

SELECT to_char(hiredate,'YYYY'), count(*)
FROM emp
GROUP BY to_char(hiredate,'YYYY');



SELECT count(deptno) CNT
FROM dept;

SELECT
    COUNT(*)
FROM
    (
        SELECT
            deptno
        FROM
            emp
        GROUP BY
            deptno
    );
    
    