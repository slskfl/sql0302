-- 전체 회원의 구매 기록을 보도록 하자. 단, 구매 기록이 없는 회원도 출력되어야 한다.
USE sqldb; 
SELECT * 
FROM buytbl B RIGHT OUTER JOIN usertbl U ON U.userID = B.userID 
ORDER BY U.userID;

-- 한번도 구매한 적이 없는 회원의 목록을 조회하시오.
USE sqldb; 
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1,U.mobile2) AS '연락처' 
FROM usertbl U LEFT OUTER JOIN buytbl B ON U.userID = B.userID 
WHERE B.prodName IS NULL 
ORDER BY U.userID;


CREATE TABLE stdtbl( 
	stdName VARCHAR(10) NOT NULL PRIMARY KEY, 
    addr CHAR(4) NOT NULL 
    );
CREATE TABLE clubtbl( 
	clubName VARCHAR(10) NOT NULL PRIMARY KEY, 
    roomNo CHAR(4) NOT NULL 
    );

CREATE TABLE stdclubtbl( 
num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
stdName VARCHAR(10) NOT NULL, 
clubName VARCHAR(10) NOT NULL,
FOREIGN KEY(stdName) REFERENCES stdtbl(stdName), 
FOREIGN KEY(clubName) REFERENCES clubtbl(clubName) 
);

INSERT INTO stdtbl 
VALUES ('김범수','경남'),('성시경','서울'), ('조용필','경기'),('은지원','경북'),('바비킴','서울');

INSERT INTO clubtbl 
VALUES ('수영','101호'),('바둑','102호'), ('축구','103호'),('봉사','104호');

INSERT INTO stdclubtbl 
VALUES (NULL,'김범수','바둑'), (NULL,'김범수','축구'), (NULL,'조용필','축구'), (NULL,'은지원','축구'), (NULL,'은지원','봉사'), (NULL,'바비킴','봉사');

-- 학생이름, 지역, 가입한 동아리, 동아리방을 조회하시오. 
select S.stdName, S.addr, C.clubName, C.roomNo
from stdtbl S
	inner join stdclubtbl SC
    on SC.stdName=S.stdName
    inner join clubtbl C
    on C.clubName = SC.clubName
order by S.stdName;
    
-- 동아리를 기준으로 가입한 학생의 목록을 조회하시오. 
select C.clubName, S.stdName, S.addr
from stdtbl S
	inner join stdclubtbl SC
    on SC.stdName=S.stdName
    inner join clubtbl C
    on C.clubName = SC.clubName
order by C.clubName;


-- 동아리에 가입하지 않은 학생을 조회하시오.
use sqldb;
select S.stdName, S.addr, C.clubName, C.roomNo
from stdtbl S
	left outer join stdclubtbl SC
    on S.stdName = SC.stdName
    left outer join clubtbl C
    on SC.clubName = C.clubName
order by S.stdName;

-- 동아리 기준으로 가입된 학생을 출력하되, 가입 학생이 없는 동아리도 출력하시오.
select *
from stdtbl S
	left outer join stdclubtbl SC
    on SC.stdName = S.stdName
    right outer join clubtbl C
    on SC.clubName = C.clubName
order by C.clubName;

-- 동아리에 가입하지 않은 학생도 출력하되, 학생이 한명도 없는 동아리도 출력하시오.
USE sqldb; 
SELECT S.stdName, S.addr, C.clubName, C.roomNo 
FROM stdtbl S 
	LEFT OUTER JOIN stdclubtbl SC 
    ON S.stdName = SC.stdName 
    LEFT OUTER JOIN clubtbl C 
    ON SC.clubName = C.ClubName
UNION
SELECT C.clubName, C.roomNo, S.stdName, S.addr buytbl
FROM stdtbl S 
	LEFT OUTER JOIN stdclubtbl SC 
    ON SC.stdName = S.stdName 
    RIGHT OUTER JOIN clubtbl C 
    ON SC.clubName = C.clubName;

-- 전체 회원의 구매 기록을 보도록 하자. 단, 구매 기록이 없는 회원도 출력되어야 한다.
USE sqldb; 
SELECT * 
FROM usertbl U 
	LEFT OUTER JOIN buytbl B 
	ON U.userID = B.userID 
ORDER BY U.userID;

USE sqldb; 
SELECT * 
FROM buytbl B 
	RIGHT OUTER JOIN usertbl U 
	ON U.userID = B.userID 
ORDER BY U.userID;

-- 한번도 구매한 적이 없는 회원의 목록을 조회하시오.
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1,U.mobile2) AS '연락처' 
from usertbl U
	left outer join buytbl B
    on B.userID = U.userID
where B.userID is null
ORDER BY U.userID;

USE sqldb; 
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1,U.mobile2) AS '연락처' 
FROM usertbl U
	LEFT OUTER JOIN buytbl B 
	ON U.userID = B.userID 
	WHERE B.prodName IS NULL 
ORDER BY U.userID;

-- 동아리에 가입하지 않은 학생 조회 (stdtbl에는 있지만 stdclubtbl에는 없는 stdName)
use sqldb;
select S.stdName, S.addr, C.clubName, C.roomNo
from stdtbl S
	left outer join stdclubtbl SC
    on S.stdName = SC.stdName
    left outer join clubtbl C
    on SC.clubName = C.clubName
order by S.stdName;

select S.stdName, S.addr, SC.clubName
from stdtbl S
	left outer join stdclubtbl SC
    on S.stdName = SC.stdName
where SC.stdName is null;

-- 동아리 기준으로 가입된 학생을 출력하되, 가입 학생이 없는 동아리도 출력하시오.
select C.clubName, C.roomNo, S.stdName, S.addr buytbl
from stdtbl S
	left outer join stdclubtbl SC
    on SC.stdName = S.stdName
    right outer join clubtbl C
    on SC.clubName = C.clubName
order by C.clubName;

-- 동아리에 가입하지 않은 학생도 출력하되, 학생이 한명도 없는 동아리도 출력하시오.
USE sqldb; 
SELECT S.stdName, S.addr, C.clubName, C.roomNo 
FROM stdtbl S 
	LEFT OUTER JOIN stdclubtbl SC 
    ON S.stdName = SC.stdName 
    LEFT OUTER JOIN clubtbl C 
    ON SC.clubName = C.ClubName
UNION
SELECT C.clubName, C.roomNo, S.stdName, S.addr buytbl
FROM stdtbl S 
	LEFT OUTER JOIN stdclubtbl SC 
    ON SC.stdName = S.stdName 
    RIGHT OUTER JOIN clubtbl C 
    ON SC.clubName = C.clubName;




