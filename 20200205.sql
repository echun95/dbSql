SELECT *
FROM product
WHERE pid NOT IN (SELECT pid 
             FROM cycle
             Where cid = 1);

select * 
from cycle;

select * 
from product;

select * 
from customer;

SELECT c.cnm, p.pid, p.pnm, cycle.day, cycle.cnt
FROM customer c JOIN (SELECT *
                      FROM cycle
                      WHERE pid IN (SELECT PID
                      FROM cycle
                      WHERE cid = 2) 
                      AND cid = 1) cycle 
                ON (c.cid = cycle.cid)
                JOIN product p 
                ON (cycle.pid = p.pid);


SELECT *
FROM cycle
WHERE pid IN (SELECT PID
              FROM cycle
              WHERE cid = 2) 
AND cid = 1;

SELECT *
FROM emp
WHERE mgr Is Not Null;

--EXSITS 조건에 만족하는 행이 존재 하는지 확인하는 연산자
--다른 연산자와 다르게 WHERE 절에 컬럼을 기술하지 않는다.
--WHERE empno = 7369 == WHERE EXISTS ( SELECT 'X' FROM ....)
SELECT *
FROM emp e
WHERE EXISTS(SELECT 'x'
             FROM emp b
             WHERE b.empno = e.mgr);
             
SELECT p.pid, p.pnm
FROM product p
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle c
              WHERE c.cid = 1 AND p.pid = c.pid);
             
--집합연산
--합집합 : UNION - 중복제거(집합개념) / UNION ALL - 중복을 제거하지 않음(속도 향상)
--교집합 : INTERSECT (집합개념)
--차집합 : MINUS (집합개념)
--집합연산 공통사항
--두 집합의 컬럼의 개수, 타입이 일치 해야 한다.
             
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)


UNION ALL --UNION ALL 연산자는 UNION과 다르게 중복을 허용한다.

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);
             

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)


INTERSECT --위, 아래 집합에서 값이 같은 행만 조회

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369);                  
             

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)


MINUS --위 집합에서 아래 집합의 데이터를 제가한 나머지 집합

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);


--집합의 기술 순서가 영향이 가는 집합연산자
--A UNION B = B UNION A ==> 같음
--A UNION ALL B = B UNION ALL A ==> 같음(집합)
--A INTERSECT B = B INTERSECT A ==> 같음(집합)
--A MINUS B = B MINUS A ==> 다름(집합)

--집합연산의 결과 컬럼 이름은 첫번째 집합의 컬럼명을 따른다.
SELECT 'X', 'B'
FROM dual

UNION 

SELECT 'X', 'B'
FROM dual;

--정렬(ORDER BY)는 집합연산 가장 마지막 집합 다음에 기술

SELECT deptno,dname
FROM dept
WHERE deptno in(10, 20)
--ORDER BY deptno

UNION ALL

SELECT deptno,dname
FROM dept
WHERE deptno in(30, 40)
ORDER BY deptno;
----------------------------------------------------------

SELECT  sido, sigungu,gb
FROM fastfood;



SELECT sido, sigungu, count(*) lot
FROM fastfood
WHERE gb = '롯데리아'
GROUP BY sido, sigungu; --lot


Select  sido, sigungu, count(*) other
FROM fastfood
WHERE gb IN ('맥도날드','KFC','버거킹')
GROUP BY sido, sigungu;









SELECT f1.sido, f1.sigungu, round((f2.other/f1.lot),2)수치
FROM (SELECT sido, sigungu, count(*) lot
      From fastfood
      WHERE gb = '롯데리아'
      GROUP BY sido, sigungu) f1 
      JOIN (SELECT  sido, sigungu, count(*) other
            FROM fastfood
            Where gb IN ('맥도날드','KFC','버거킹')
            GROUP BY sido, sigungu) f2
      ON (f1.sido = f2.sido and f1.sigungu = f2.sigungu)
ORDER BY 수치 desc;

------------fastfood 테이블을 한번만 읽는 방식으로 작성하기-----------------
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

--ROWNUM 사용 시 주의사항
--1.SELECT ==> ORDER BY
--정렬된 결과에 ROWNUM을 적용하기 위해서는 INLINE-VIEW
--2.1번부터 순차적으로 조회가 되는 조건에서만 WHERE절에서 기술이 가능
--ROWNUM = 1 (O)
--ROWNUM = 2 (X)
--ROWNUM < 10 (O)
--ROWNUM > 10 (X)










