-- Create tables
CREATE TABLE SAILORS (
    sid INT PRIMARY KEY,
    sname VARCHAR(50),
    rating INT,
    age INT
);

CREATE TABLE BOAT (
    bid INT PRIMARY KEY,
    bname VARCHAR(50),
    color VARCHAR(20)
);

CREATE TABLE RESERVES (
    sid INT,
    bid INT,
    date DATE,
    PRIMARY KEY (sid, bid, date),
    FOREIGN KEY (sid) REFERENCES SAILORS(sid),
    FOREIGN KEY (bid) REFERENCES BOAT(bid)
);

-- Insert data into SAILORS table
INSERT INTO SAILORS (sid, sname, rating, age)
VALUES
    (101, 'John', 5, 25),
    (102, 'Jane', 3, 22),
    (103, 'Mike', 4, 28),
    (104, 'Lisa', 2, 21),
    (105, 'David', 5, 24);

-- Insert data into BOAT table
INSERT INTO BOAT (bid, bname, color)
VALUES
    (201, 'Sailboat 1', 'Blue'),
    (202, 'Canoe 1', 'Red'),
    (203, 'Kayak 1', 'Green'),
    (204, 'Yacht 1', 'White'),
    (205, 'Speedboat 1', 'Yellow');

-- Insert data into RESERVES table
INSERT INTO RESERVES (sid, bid, date)
VALUES
    (101, 201, '2023-05-10'),
    (102, 202, '2023-06-15'),
    (103, 203, '2023-07-20'),
    (104, 204, '2023-08-25'),
    (105, 205, '2023-09-30');

-- Alterations
-- Add a new field "email" to the SAILORS table
ALTER TABLE SAILORS
ADD email VARCHAR(100);

-- Drop the "rating" field from the SAILORS table
ALTER TABLE SAILORS
DROP rating;

-- Adding and Dropping Constraints
-- Add a unique constraint to the "email" field in the SAILORS table
ALTER TABLE SAILORS
ADD CONSTRAINT unique_email UNIQUE (email);

-- Drop the unique constraint on the "email" field in the SAILORS table
ALTER TABLE SAILORS
DROP CONSTRAINT unique_email;

-- Add a check constraint to the "age" field in the SAILORS table
ALTER TABLE SAILORS
ADD CONSTRAINT check_age CHECK (age >= 18 AND age <= 60);

-- Drop the check constraint on the "age" field in the SAILORS table
ALTER TABLE SAILORS
DROP CONSTRAINT check_age;

-- Add a new field "description" to the BOAT table
ALTER TABLE BOAT
ADD description VARCHAR(255);

-- Drop the "color" field from the BOAT table
ALTER TABLE BOAT
DROP color;

-- Add a NOT NULL constraint to the "date" field in the RESERVES table
ALTER TABLE RESERVES
MODIFY date DATE NOT NULL;

-- Display data from the tables
SELECT * FROM SAILORS;
SELECT * FROM BOAT;
SELECT * FROM RESERVES;

-- Select with WHERE clause:
-- Retrieve sailors with a rating greater than 4.0:
SELECT * FROM SAILORS WHERE rating > 4.0;

-- Retrieve boats with a color like 'White':(Not case sensitive)
SELECT * FROM BOAT WHERE color LIKE '%White%';


-- Order by:
--Retrieve sailors ordered by age in descending order:
SELECT * FROM SAILORS ORDER BY age DESC;

-- Retrieve boats ordered by boat name in ascending order:
SELECT * FROM BOAT ORDER BY bname;


-- Set Operations:
-- Retrieve sailors who have reserved a boat OR have a rating greater than 4:
SELECT sid FROM SAILORS WHERE rating >= 4
UNION
SELECT sid FROM RESERVES WHERE bid = 202;


-- Join Operations:
-- Retrieve information about sailors and the boats they have reserved:
SELECT s.sid, s.sname, r.bid, b.bname
FROM SAILORS s
JOIN RESERVES r ON s.sid = r.sid
JOIN BOAT b ON r.bid = b.bid;


-- Aggregate Functions and Group By:
-- Retrieve the average rating for each boat color:
SELECT color, AVG(rating) as avg_rating
FROM SAILORS s
JOIN RESERVES r ON s.sid = r.sid
JOIN BOAT b ON r.bid = b.bid
GROUP BY color;


-- Group By Having:
-- Retrieve boat colors with an average rating greater than 4:
SELECT color, AVG(rating) as avg_rating
FROM SAILORS s
JOIN RESERVES r ON s.sid = r.sid
JOIN BOAT b ON r.bid = b.bid
GROUP BY color
HAVING AVG(rating) > 4;


-- Nested Queries:
-- Retrieve sailors who have not reserved any boat:
SELECT * FROM SAILORS
WHERE NOT EXISTS (
    SELECT 1 FROM RESERVES WHERE RESERVES.sid = SAILORS.sid
);


-- Grant and Revoke Permissions (DCL):
-- Grant SELECT permission on the Sailors table to a specific user:
GRANT SELECT ON SAILORS TO username;

-- Revoke UPDATE permission on the Boat table from a specific user:
REVOKE UPDATE ON BOAT FROM username;




-- Exam Questions
-- 1)Find the colours of boats reserved by Albert
select b.color
from Boat b, Sailors s,reserves r
where b.bid=r.bid and s.sid=r.sid
and s.sname like "Albert";

-- 2)Find all sailor id’s of sailors who have a rating of at least 8 or reserved boat 103
select DISTINCT s.sid
from Sailors s,reserves r
where s.sid=r.sid
and (s.rating>=8.0 or r.bid=103);
-- bracket is important

-- 3)Find the names of sailors who have not reserved a boat whose name contains the string “storm”. Order the names in ascending order.
select s.sname
from Sailors s 
where s.sid not in
(select distinct r.sid from reserves r)
and s.sname like "%storm%"
order by s.sname asc;

-- 4)Find the names of sailors who have reserved all boats
select s.sname from Sailors s where not exists
  (select * from Boat b where not exists(
      select * from reserves r where r.bid=b.bid and s.sid=r.sid));
      
-- 5)Find the name and age of the oldest sailor
select sname,age
from Sailors 
where age in (select max(age) from Sailors);

-- 6)For each boat which was reserved by at least 5 sailors with age >= 40, find the boat id and the average age of such sailors.
select b.bid, avg(s.age)
from Sailors s,Boat b, reserves r
where s.sid=r.sid and b.bid=r.bid
and s.age>=40
group by b.bid having count(distinct r.sid)>=2;

-- 7)Create a view that shows the names and colours of all the boats that have been reserved by a sailor with a specific rating
create view boatDetails as 
select b.color,b.bname
from Boat b
join reserves r on b.bid = r.bid
join Sailors s on s.sid = r.sid
where s.rating=5;
select * from boatDetails;

-- 8)A trigger that prevents boats from being deleted If they have active reservations
DELIMITER //
create or replace trigger CheckAndDelete
before delete on Boat
for each row
BEGIN
	IF EXISTS (select * from reserves where reserves.bid=old.bid) THEN
		SIGNAL SQLSTATE '45000' SET message_text='Boat is reserved and hence cannot be deleted';
	END IF;
END;//

DELIMITER ;
