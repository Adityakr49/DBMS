DATABASE INSURANCE

USE ADITYA_007;

CREATE TABLE PERSON (
driver_id VARCHAR(255) NOT NULL,
name TEXT NOT NULL,
address TEXT NOT NULL,
PRIMARY KEY (driver_id)
);

CREATE TABLE CAR (
reg_no VARCHAR(255) NOT NULL,
model TEXT NOT NULL,
year INTEGER,
PRIMARY KEY (reg_no)
);

CREATE TABLE ACCIDENT (
report_no INTEGER NOT NULL,
acc_date DATE,
location TEXT,
PRIMARY KEY (report_no)
);

CREATE TABLE OWNS (
driver_id VARCHAR(255) NOT NULL,
reg_no VARCHAR(255) NOT NULL,
FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id) ON DELETE CASCADE,
FOREIGN KEY (reg_no) REFERENCES CAR(reg_no) ON DELETE CASCADE
);

CREATE TABLE PARTICIPATED (
driver_id VARCHAR(255) NOT NULL,
reg_no VARCHAR(255) NOT NULL,
report_no INTEGER NOT NULL,
damage_amount FLOAT NOT NULL,
FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id) ON DELETE CASCADE,
FOREIGN KEY (reg_no) REFERENCES CAR(reg_no) ON DELETE CASCADE,
FOREIGN KEY (report_no) REFERENCES ACCIDENT(report_no)
);

INSERT INTO PERSON VALUES
("DA1B2", "VERSTAPPEN", "BELGIUM"),
("DC3D4", "HAMILTON", "UK"),
("DE5F6", "SAINZ", "SPAIN"),
("DG7H8", "PIASTRI", "AUS"),
("DI9J9", "GASLY", "FRANCE");

INSERT INTO CAR VALUES
("F1-4223", "REDBULL", 2023),
("F1-5674", "MERCEDES", 2023),
("F1-5473", "FERRARI", 2023),
("F1-4728", "MCLAREN", 2023),
("F1-1234", "ALPINE", 2023);

INSERT INTO ACCIDENT VALUES
(43627, "2020-04-05", "Monaco"),
(56345, "2019-12-16", "Silverstone"),
(63744, "2020-05-14", "Villeneuve"),
(54634, "2019-08-30", "Hungaroring"),
(65738, "2021-01-21", "Suzuka"),
(66666, "2021-01-21", "Zandvoort");

INSERT INTO OWNS VALUES
("DA1B2", "F1-4223"),
("DC3D4", "F1-5674"),
("DE5F6", "F1-5473"),
("DG7H8", "F1-4728"),
("DI9J9", "F1-1234");

INSERT INTO PARTICIPATED VALUES
("DA1B2", "F1-4223", 43627, 2000000),
("DC3D4", "F1-5674", 56345, 4900500),
("DE5F6", "F1-5473", 63744, 1005000),
("DG7H8", "F1-4728", 54634, 5000000),
("DI9J9", "F1-1234", 65738, 2005000);



-- Find the total number of people who owned a car that were involved in accidents in 2019

select COUNT(driver_id)
from PARTICIPATED p, ACCIDENT a
where p.report_no=a.report_no and a.accident_date like "2019%";

-- Find the number of accident in which cars belonging to lewis was involved

select COUNT(distinct a.report_no)
from ACCIDENT a
where exists 
(select * from PERSON p, PARTICIPATED ptd where p.driver_id=ptd.driver_id and name="HAMILTON" and a.report_no=ptd.report_no);

-- Add a new accident to the database

insert into ACCIDENT values
(45562, "2024-04-05", "TOKYO");

insert into PARTICIPATED values
("DC3D4", "F1-4728", 45562, 5200000);


-- Delete the ALPINE belonging to GASLY

delete from CAR
where model="ALPINE" and reg_no in
(select CAR.reg_no from PERSON p, OWNS o where p.driver_id=o.driver_id and o.reg_no=CAR.reg_no and p.name="GASLY");


-- Update the damage amount for the car with reg_no of F1-1234 in the accident with report_no 65738

update PARTICIPATED set damage_amount=10000 where report_no=65738 and reg_no="F1-1234";

-- View that shows models and years of car that are involved in accident

create view CarsInAccident as
select distinct model, year
from CAR c, PARTICIPATED p
where c.reg_no=p.reg_no;

select * from CarsInAccident;

-- Create a view that shows name and address of drivers who own a car.

create view DriversWithCar as
select name, address
from PERSON p, OWNS o
where p.driver_id=o.driver_id;

select * from DriversWithCar;


-- Create a view that shows the names of the drivers who a participated in a accident in a specific place.

create view DriversWithAccidentInPlace as
select name
from PERSON p, ACCIDENT a, PARTICIPATED ptd
where p.driver_id = ptd.driver_id and a.report_no = ptd.report_no and a.location="Hungaroring";

select * from DriversWithAccidentInPlace;

INSERT INTO participated VALUES
("DC3D4", "F1-4223", 66666, 2000000);

-- Select with WHERE clause:
-- Retrieve drivers from Belgium:
SELECT * FROM PERSON WHERE address = 'BELGIUM';

-- Retrieve cars with a model containing 'RE':
SELECT * FROM CAR WHERE model LIKE '%RE%';


-- Order by:
-- Retrieve accidents ordered by accident date in descending order:
SELECT * FROM ACCIDENT ORDER BY acc_date DESC;

-- Retrieve persons ordered by name in ascending order:
SELECT * FROM PERSON ORDER BY name;


-- Set Operations:
-- Retrieve drivers who own a car OR participated in an accident:
SELECT driver_id FROM OWNS
UNION
SELECT driver_id FROM PARTICIPATED;


-- Exists and Not Exists:
-- Retrieve drivers who participated in an accident:
SELECT DISTINCT driver_id FROM PARTICIPATED
WHERE EXISTS (
    SELECT 1 FROM ACCIDENT WHERE ACCIDENT.report_no = PARTICIPATED.report_no
);

-- Retrieve cars that were not involved in any accidents:
SELECT * FROM CAR
WHERE NOT EXISTS (
    SELECT 1 FROM PARTICIPATED WHERE PARTICIPATED.reg_no = CAR.reg_no
);

-- Join Operations:
-- Retrieve information about drivers, their cars, and accidents they participated in:
SELECT P.name, O.reg_no, A.report_no
FROM OWNS O
JOIN PERSON P ON O.driver_id = P.driver_id
LEFT JOIN PARTICIPATED A ON O.driver_id = A.driver_id AND O.reg_no = A.reg_no;


-- Aggregate Functions and Group By:
-- Retrieve the total damage amount for each driver:
SELECT driver_id, SUM(damage_amount) as total_damage
FROM PARTICIPATED
GROUP BY driver_id;
Group By Having:

-- Retrieve drivers with a total damage amount greater than 1 million:
SELECT driver_id, SUM(damage_amount) as total_damage
FROM PARTICIPATED
GROUP BY driver_id
HAVING SUM(damage_amount) > 1000000;

-- Nested Queries:
-- Retrieve drivers who own a car and participated in an accident:
SELECT * FROM PERSON
WHERE driver_id IN (
    SELECT driver_id FROM OWNS
    INTERSECT
    SELECT driver_id FROM PARTICIPATED
);


-- Grant and Revoke Permissions (DCL):
-- Grant SELECT permission on the PERSON table to a specific user:
GRANT SELECT ON PERSON TO username;

-- Revoke INSERT permission on the ACCIDENT table from a specific user:
REVOKE INSERT ON ACCIDENT FROM username;

-- Exam Questions

-- 1)Find the total number of people who owned cars that were involved in accidents in 2021
select count(p.driver_id)
from participated p
join accident a on a.report_no=p.report_no
where a.accident_date like "%2021%"

-- 2)Find the number of accidents in which the cars belonging to “Smith” were involved
select count(p.report_no)
from participated p
join person pe on pe.driver_id=p.driver_id
and pe.driver_name like "%smith%";

-- 3)Add a new accident to the database; assume any values for required attributes
insert into accident values
(45562, "2024-04-05", "Mandya");

insert into participated values
("D222", "KA-21-BD-4728", 45562, 50000);

-- 4)Delete the Mazda belonging to “Smith”
delete from car
where model="Mazda" and reg_no in
(select car.reg_no from person p, owns o where p.driver_id=o.driver_id and o.reg_no=car.reg_no and p.driver_name="Smith");

-- 5)Update the damage amount for the car with license number “KA09MA1234” in the accident with report
Update participated set damage_amount=12030 where reg_no like "%KA-09-MA-1234%";
select * from participated;

-- 6)A view that shows models and year of cars that are involved in accident
create view carsInAccident as
select c.model, c.c_year
from car c
join participated p on c.reg_no=p.reg_no;
select * from carsInAccident;

-- 7)A trigger that prevents a driver from participating in more than 3 accidents in a given year
DELIMITER //
create trigger PreventParticipation
before insert on participated
for each row
BEGIN
	IF 2<=(select count(*) from participated where driver_id=new.driver_id) THEN
		signal sqlstate '45000' set message_text='Driver has already participated in 2 accidents';
	END IF;
END;//
DELIMITER ;
