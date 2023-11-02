# DBMS Lab Readme

## Queries Executed at DBMS Lab in MYSQL during the 5th Semester at SJCE, JSS STU

### Lab 1: File Operations with C/C++
1. Consider a structure named Student with attributes as SID, NAME, BRANCH, SEMESTER, ADDRESS.  
   Write a program in C/C++ and perform the following operations using the concept of files.
   a. Insert a new student
   b. Modify the address of the student based on SID
   c. Delete a student
   d. List all the students
   e. List all the students of CSE branch
   f. List all the students of CSE branch and reside in Kuvempunagar.

### Lab 2: SQL Operations
2. Create a table for the structure Student with attributes as SID, NAME, BRANCH, SEMESTER, ADDRESS, PHONE, EMAIL, Insert at least 10 tuples and perform the following operations using SQL.
   a. Insert a new student
   b. Modify the address of the student based on SID
   c. Delete a student
   d. List all the students
   e. List all the students of CSE branch
   f. List all the students of CSE branch and reside in Kuvempunagar.

### Lab 3, 4, 5, 6: Data Definition Language (DDL) Commands
3. Consider the database schemas given below. Write ER diagram and schema diagram, create tables, enter data, alter tables, add/drop constraints, and perform delete/update operations.
   a. Sailors Database
      SAILORS (sid, sname, rating, age)
      BOAT(bid, bname, color)
      RSERVERS (sid, bid, date)
   b. Insurance Database
      PERSON (driver id#: string, name: string, address: string)
      CAR (regno: string, model: string, year: int)
      ACCIDENT (report_ number: int, acc_date: date, location: string)
      OWNS (driver id#: string, regno: string)
      PARTICIPATED(driver id#:string, regno:string, report_ number: int,damage_amount: int)
   c. Order Processing Database
      Customer (Cust#:int, cname: string, city: string)
      Order (order#:int, odate: date, cust#: int, order-amt: int)
      Order-item (order#:int, Item#: int, qty: int)
      Item (item#:int, unitprice: int)
      Shipment (order#:int, warehouse#: int, ship-date: date)
      Warehouse (warehouse#:int, city: string)

   d. Student Enrollment in Courses and Books Adopted for Each Course
      STUDENT (regno: string, name: string, major: string, bdate: date)
      COURSE (course#:int, cname: string, dept: string)
      ENROLL(regno:string, course#: int,sem: int,marks: int)
      BOOK-ADOPTION (course#:int, sem: int, book-ISBN: int)
      TEXT (book-ISBN: int, book-title: string, publisher: string,author: string)
   e. Company Database
      EMPLOYEE (SSN, Name, Address, Sex, Salary, SuperSSN, DNo)
      DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate)
      DLOCATION (DNo,DLoc)
      PROJECT (PNo, PName, PLocation, DNo)
      WORKS_ON (SSN, PNo, Hours)

### Lab 7, 8, 9, 10: Data Manipulation Language (DML) and Data Control Language (DCL)
7. Write valid DML statements to retrieve tuples from the databases. The queries may contain appropriate DML and DCL commands, such as select with like, between, where clause, order by, set operations, exists and not exists, join operations, aggregate functions, group by, group by having, nested and correlated nested queries, grant, and revoke permissions.

### Lab 11 and 12: Views and Triggers
11. Views: Creation and manipulating content.
12. Triggers: Creation and execution of database triggers on every insert, delete, and update operation.
