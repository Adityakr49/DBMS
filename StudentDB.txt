-- Create the Student table
CREATE TABLE Student (
    SID INT PRIMARY KEY,
    NAME VARCHAR(50),
    BRANCH VARCHAR(50),
    SEMESTER INT,
    ADDRESS VARCHAR(100),
    PHONE VARCHAR(15),
    EMAIL VARCHAR(50)
);

-- Insert 10 sample records
INSERT INTO Student (SID, NAME, BRANCH, SEMESTER, ADDRESS, PHONE, EMAIL)
VALUES
    (1, 'Alice', 'CSE', 4, '123 Main St', '123-456-7890', 'alice@example.com'),
    (2, 'Bob', 'ECE', 3, '456 Elm St', '234-567-8901', 'bob@example.com'),
    (3, 'Charlie', 'CSE', 5, '789 Oak St', '345-678-9012', 'charlie@example.com'),
    (4, 'David', 'MECH', 2, '101 Pine St', '456-789-0123', 'david@example.com'),
    (5, 'Eve', 'CSE', 4, '234 Birch St', '567-890-1234', 'eve@example.com'),
    (6, 'Frank', 'ECE', 3, '567 Cedar St', '678-901-2345', 'frank@example.com'),
    (7, 'Grace', 'CSE', 5, '890 Willow St', '789-012-3456', 'grace@example.com'),
    (8, 'Hannah', 'MECH', 2, '345 Maple St', '890-123-4567', 'hannah@example.com'),
    (9, 'Isaac', 'CSE', 4, '678 Elm St', '901-234-5678', 'isaac@example.com'),
    (10, 'Jack', 'ECE', 3, '123 Oak St', '012-345-6789', 'jack@example.com');

-- a. Insert a new student
INSERT INTO Student (SID, NAME, BRANCH, SEMESTER, ADDRESS, PHONE, EMAIL)
VALUES (11, 'Karen', 'CSE', 4, '456 Willow St', '123-234-5678', 'karen@example.com');

-- b. Modify the address of the student based on SID (e.g., SID 2)
UPDATE Student
SET ADDRESS = '789 Cedar St'
WHERE SID = 2;

-- c. Delete a student (e.g., SID 8)
DELETE FROM Student
WHERE SID = 8;

-- d. List all the students
SELECT * FROM Student;

-- e. List all the students of the CSE branch
SELECT * FROM Student
WHERE BRANCH = 'CSE';

-- f. List all the students of CSE branch residing in Kuvempunagar
SELECT * FROM Student
WHERE BRANCH = 'CSE' AND ADDRESS LIKE '%Kuvempunagar%';

