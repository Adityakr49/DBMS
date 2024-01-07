-- Create tables
CREATE TABLE STUDENT (
    regno VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    major VARCHAR(50),
    bdate DATE
);

CREATE TABLE COURSE (
    course INT PRIMARY KEY,
    cname VARCHAR(100),
    dept VARCHAR(50)
);

CREATE TABLE ENROLL (
    regno VARCHAR(10),
    course INT,
    sem INT,
    marks INT,
    PRIMARY KEY (regno, course, sem),
    FOREIGN KEY (regno) REFERENCES STUDENT(regno),
    FOREIGN KEY (course) REFERENCES COURSE(course)
);

CREATE TABLE TEXT (
    book_ISBN INT PRIMARY KEY,
    book_title VARCHAR(100),
    publisher VARCHAR(100),
    author VARCHAR(50)
);

CREATE TABLE BOOK_ADOPTION (
    course INT,
    sem INT,
    book_ISBN INT,
    PRIMARY KEY (course, sem, book_ISBN),
    FOREIGN KEY (course) REFERENCES COURSE(course),
    FOREIGN KEY (book_ISBN) REFERENCES TEXT(book_ISBN)
);

-- Insert data
INSERT INTO STUDENT (regno, name, major, bdate)
VALUES
    ('S001', 'John Doe', 'Computer Science', '2000-01-15'),
    ('S002', 'Jane Smith', 'Engineering', '1999-05-20'),
    ('S003', 'Mike Johnson', 'Biology', '2001-03-10'),
    ('S004', 'Lisa Brown', 'Mathematics', '2002-07-05'),
    ('S005', 'David Lee', 'Physics', '2000-12-30');

SELECT * FROM STUDENT;

INSERT INTO COURSE (course, cname, dept)
VALUES
    (101, 'Introduction to Programming', 'Computer Science'),
    (201, 'Engineering Mechanics', 'Engineering'),
    (301, 'Cell Biology', 'Biology'),
    (401, 'Linear Algebra', 'Mathematics'),
    (501, 'Quantum Mechanics', 'Physics');

SELECT * FROM COURSE;

INSERT INTO ENROLL (regno, course, sem, marks)
VALUES
    ('S001', 101, 1, 85),
    ('S002', 201, 2, 78),
    ('S003', 301, 1, 92),
    ('S004', 401, 2, 88),
    ('S005', 501, 1, 90);

SELECT * FROM ENROLL;

INSERT INTO TEXT (book_ISBN, book_title, publisher, author)
VALUES
    (1001, 'Introduction to Programming', 'ABC Publishing', 'John Smith'),
    (2002, 'Engineering Mechanics', 'XYZ Publishers', 'Alice Johnson'),
    (3003, 'Cell Biology', 'Science Books', 'Robert Clark'),
    (4004, 'Linear Algebra', 'Mathematics Press', 'Emily Davis'),
    (5005, 'Quantum Mechanics', 'Physics World', 'Michael Brown');

SELECT * FROM TEXT;

INSERT INTO BOOK_ADOPTION (course, sem, book_ISBN)
VALUES
    (101, 1, 1001),
    (201, 2, 2002),
    (301, 1, 3003),
    (401, 2, 4004),
    (501, 1, 5005);

SELECT * FROM BOOK_ADOPTION;

-- Alterations
ALTER TABLE STUDENT
ADD email VARCHAR(100);

SELECT * FROM STUDENT;

ALTER TABLE COURSE
ADD instructor VARCHAR(50);

SELECT * FROM COURSE;

-- Adding and Dropping Constraints
ALTER TABLE STUDENT
ADD CONSTRAINT unique_email UNIQUE (email);

ALTER TABLE STUDENT
DROP CONSTRAINT unique_email;

-- Create INSTRUCTOR table
CREATE TABLE INSTRUCTOR (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Add a new field and foreign key constraint to the COURSE table
ALTER TABLE COURSE
ADD instructor_id INT;

ALTER TABLE COURSE
ADD CONSTRAINT fk_instructor FOREIGN KEY (instructor_id) REFERENCES INSTRUCTOR(instructor_id);

ALTER TABLE COURSE
DROP CONSTRAINT fk_instructor;

-- Add a check constraint to the ENROLL table
ALTER TABLE ENROLL
ADD CONSTRAINT check_marks CHECK (marks >= 0 AND marks <= 100);

ALTER TABLE ENROLL
DROP CONSTRAINT check_marks;

-- Drop the "instructor" field from the COURSE table
ALTER TABLE COURSE
DROP instructor;




-- 1. Select with %LIKE, BETWEEN, WHERE Clause:
-- Retrieve students with names starting with 'J'
SELECT *
FROM STUDENT
WHERE name LIKE 'J%';

-- Retrieve courses with course numbers between 200 and 400
SELECT *
FROM COURSE
WHERE course BETWEEN 200 AND 400;
-- 2. Order By:
-- Retrieve students ordered by their birthdate in ascending order
SELECT *
FROM STUDENT
ORDER BY bdate ASC;
-- 3. Set Operations:
-- Retrieve a list of distinct majors from students and departments from courses
SELECT major FROM STUDENT
UNION
SELECT dept FROM COURSE;
-- 4. EXISTS and NOT EXISTS:
-- Retrieve students who have enrolled in at least one course
SELECT *
FROM STUDENT
WHERE EXISTS (
    SELECT 1
    FROM ENROLL
    WHERE STUDENT.regno = ENROLL.regno
);

-- Retrieve courses with no textbook adoption
SELECT *
FROM COURSE
WHERE NOT EXISTS (
    SELECT 1
    FROM BOOK_ADOPTION
    WHERE COURSE.course = BOOK_ADOPTION.course
);
-- 5. Join Operations:
-- Retrieve student enrollments with detailed information (student name, course name)
SELECT STUDENT.name, COURSE.cname, ENROLL.sem, ENROLL.marks
FROM ENROLL
JOIN STUDENT ON ENROLL.regno = STUDENT.regno
JOIN COURSE ON ENROLL.course = COURSE.course;
-- 6. Aggregate Functions, GROUP BY, GROUP BY HAVING:
-- Retrieve the average marks for each course
SELECT course, AVG(marks) AS avg_marks
FROM ENROLL
GROUP BY course
HAVING AVG(marks) > 85;
-- 7. Nested and Correlated Nested Queries:
-- Retrieve students who have enrolled in a course with a specific textbook author
SELECT name
FROM STUDENT
WHERE regno IN (
    SELECT regno
    FROM ENROLL
    WHERE course IN (
        SELECT course
        FROM BOOK_ADOPTION
        WHERE book_ISBN IN (
            SELECT book_ISBN
            FROM TEXT
            WHERE author = 'John Smith'
        )
    )
);
-- 8. Grant and Revoke Permissions:
-- Grant SELECT permission on STUDENT table to a specific user
GRANT SELECT ON STUDENT TO username;

-- Revoke UPDATE permission on ENROLL table from a specific user
REVOKE UPDATE ON ENROLL FROM username;


-- Exam Questions

-- 1)Demonstrate how you add a new text book to the database and make this book be adopted by some department
insert into TextBook values
(123456, "The World Affairs", "Pearson", "Prashant Dhawan");
insert into BookAdoption values
(001, 5, 123456);

-- 2)Produce a list of text books (include Course #, Book-ISBN, Book-title) in the alphabetical order for courses offered by the ‘CS’ department that use more than two books. 
select b.course, b.bookIsbn, t.book_title
from BookAdoption b
join TextBook t on b.bookIsbn=t.bookIsbn
join Course c on b.course=c.course
where c.dept like "%CS%";

-- 3)List any department that has all its adopted books published by a specific publisher.
SELECT DISTINCT c.dept
     FROM Course c
     WHERE c.dept IN
     ( SELECT c.dept
     FROM Course c,BookAdoption b,TextBook t
     WHERE c.course=b.course
     AND t.bookIsbn=b.bookIsbn
     AND t.publisher='PEARSON')
     AND c.dept NOT IN
     ( SELECT c.dept
     FROM Course c, BookAdoption b, TextBook t
     WHERE c.course=b.course
     AND t.bookIsbn=b.bookIsbn
     AND t.publisher!='PEARSON');
     
-- 4)List the students who have scored maximum marks in ‘DBMS’ course.
select s.name,e.regno
from Enroll e
join Student s on e.regno=s.regno
join Course c on e.course=c.course
where c.cname like "%DBMS%"
and e.marks in (select max(marks) from Enroll e1
join Course c1 on c1.course=e1.course
where c1.cname='DBMS');

-- 5)Create a view to display all the courses opted by a student along with marks obtained
create view CourseOpted as
select c.cname,e.marks
from Course c, Enroll e
where c.course=e.course
and e.regno = '01HF235';
select * from CourseOpted;

-- 6)Create a trigger that prevents a student from enrolling in a course if the marks prerequisite is less than 40.
delimiter //
create trigger preventEnrollment
before insert on Enroll
for each row
begin
  if (new.marks<10) then 
    signal sqlstate '45000' set message_text='marks below threshold';
  end if;
end;
//
delimiter ;
