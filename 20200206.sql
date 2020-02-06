SELECT sido, sigungu, ROUND((kfc+buk+mac)/lot,2) bugscore
FROM
(SELECT sido, sigungu,
       NVL(SUM(DECODE(gb,'KFC',1)),0) kfc, NVL(SUM(DECODE(gb,'버거킹',1)),0) buk, 
       NVL(SUM(DECODE(gb,'맥도날드',1)),0) mac, NVL(SUM(DECODE(gb,'롯데리아',1)),1) lot
FROM fastfood
WHERE gb IN('KFC','맥도날드','버거킹','롯데리아')
GROUP BY sido, sigungu)
ORDER BY bugscore desc;

SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal desc;

--햄버거지수 시도, 햄버거지수 시군구, 햄버거지수, 세금 시도, 세금 시군구, 개인별 근로소득액
--햄버거 지수, 개인별 근로소득 금액 순위가 같은 시도별로 [조인]
--같은 순위의 행끼리 조인



--ROWNUM 사용 시 주의사항
--1.SELECT ==> ORDER BY
--정렬된 결과에 ROWNUM을 적용하기 위해서는 INLINE-VIEW
--2.1번부터 순차적으로 조회가 되는 조건에서만 WHERE절에서 기술이 가능
--ROWNUM = 1 (O)
--ROWNUM = 2 (X)
--ROWNUM < 10 (O)
--ROWNUM > 10 (X)

--ROWNUM - ORDER BY
--ROUND
--GROUP BY
--JOIN 
--DECODE
--NVL
--IN

SELECT b.n, b.sido, b.sigungu, b.bugscore, t.sido, t.sigungu, t.pri_sal
FROM
   (SELECT ROWNUM n, bug.sido, bug.sigungu, bug.bugscore
    FROM
        (SELECT sido, sigungu, ROUND((kfc+buk+mac)/lot,2) bugscore
         FROM
            (SELECT sido, sigungu,
             NVL(SUM(DECODE(gb,'KFC',1)),0) kfc, NVL(SUM(DECODE(gb,'버거킹',1)),0) buk, 
             NVL(SUM(DECODE(gb,'맥도날드',1)),0) mac, NVL(SUM(DECODE(gb,'롯데리아',1)),1) lot
             FROM fastfood
             WHERE gb IN('KFC','맥도날드','버거킹','롯데리아')
             GROUP BY sido, sigungu)
             ORDER BY bugscore desc) bug) b 
JOIN
    (SELECT ROWNUM n, t.sido, t.sigungu, t.pri_sal
     FROM 
           (SELECT sido, sigungu, ROUND(sal/people) pri_sal
            FROM tax
            ORDER BY pri_sal desc) t) t
ON (b.n = t.n);

--DML
--INSERT INTO dept (deptno,dname,loc) VALUES(99,'DDIT','daejeon'); 모든 컬럼이 아닌 부분만 입력할 때는 컬럼명을 기술해야한다.
--INSERT INTO dept VALUES(99,'DDIT','daejeon'); 모든 컬럼의 값을 입력할 때는 컬럼명을 생략해도된다.

--empno 컬럼은 NOT NULL 제약 조건이 있다. INSERT 시 반드시 값이 존재해야 정상적으로 입력된다.
--empno 컬럼을 제외한 나머지 컬럼은 NULLABLE이다.(NULL 값이 저장될 수 있다.)
INSERT INTO emp(empno, ename, job) 
VALUES(9999,'brown',NULL);  

SELECT *
FROM emp;

INSERT INTO emp (ename, job) 
VALUES('sally','salesman');

--문자열 : '오라클' ==> "자바"
--숫자 : 123 
--날짜 : to_date('20200206','yyyymmdd')
--emp 테이블의 hiredate 컬럼의 타입은 date타입
--emp 테이블의 8개의 컬럼에 값을 입력

DESC emp;

INSERT INTO emp 
VALUES(9998,'sally','SALESMAN',NULL,SYSDATE,1000,NULL,99);

rollback;


--여러건의 데이터를 한번에 INSERT : 
--INSERT INTO 테이블명 (컬럼명1,컬럼명2,...)
--SELECT ...
--FROM ;
INSERT INTO emp
SELECT 9998,'sally','SALESMAN',NULL,SYSDATE,1000,NULL,99
FROM dual
    UNION ALL
SELECT 9999,'brown','CLERK',NULL,to_date('20200205','yyyymmdd'),1100, NULL,99
FROM dual;





--UPDATE 쿼리
--UPDATE 테이블명 SET 컬럼명1 = 갱신할 컬럼 값1, 컬럼명2 = 갱신할 컬럼 값2,...
--WHERE 행 제한 조건
--업데이트 쿼리 작성시 WHERE절이 존재하지 않으면 해당 테이블의 모든 행을 대상으로 업데이트가 일어난다.
--UPDATE, DELETE 절에 WHERE절이 없을 경우 의도한게 맞는지 다시한번 확인한다.
--WHERE절이 있다 하더라도 해당 조건으로 해당 테이블을 SELECT하는 쿼리를 작성하여 실행하면 UPDATE 대상 행을 조회 할 수 있으므로 
--확인하고 실행하는 것도 사고 발생 방지에 도움이 된다.

--99번 부서번호를 갖는 부서 정보가 DEPT테이블에 있는상황
INSERT INTO dept VALUES(99,'DDIT','daejeon');

SELECT * 
FROM dept;

--99번 부서번호를 갖는 부서의 dname 컬럼의 값을 '대덕IT', loc 컬럼의 값을 '영민빌딩'으로 업데이트

UPDATE dept 
SET dname = '대덕IT',loc = '영민빌딩'
WHERE deptno = 99;

SELECT *
FROM dept;

--10 => SUBQUERY
--SMITH, WARD가 속한 부서에 소속된 직원 정보
SELECT *
FROM emp
WHERE deptno IN(20,30);

SELECT *
FROM emp
WHERE deptno IN(SELECT deptno
                FROM emp
                WHERE ename IN('SMITH','WARD'));

--UPDATE시에도 서브쿼리 사용이 가능하다.
INSERT INTO emp (empno,ename)
VALUES(9999,'brown');
--9999번 사원 deptno, job 정보를 SMITH 사원이 속한 부서정보, 담당업무로 업데이트
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'), job = (SELECT job FROM emp WHERE ename = 'SMITH');

select *
from emp;

--DELETE SQL : 특정 행을 삭제
--DELETE [FROM] 테이블명
--WHERE 행 제한 조건
SELECT *
FROM dept;

--99번 부서번호에 해당하는 부서 정보 삭제
DELETE dept
WHERE deptno = 99;

--SUBQUERY를 통해서 특정 행을 제한하는 조건을 갖는 DELETE
--매니저가 7698 사번인 직원을 삭제
DELETE emp
WHERE mgr IN (7698, 7521, 7654, 7844, 7900);

DELETE emp
WHERE empno IN (SELECT empno
               FROM emp
               WHERE mgr = 7698);

ROLLBACK;

































