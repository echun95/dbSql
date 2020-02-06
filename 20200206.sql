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

SELECT *
FROM emp;




















