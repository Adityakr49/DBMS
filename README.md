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
   ## a. Sailors Database

### SAILORS
- `sid` (int): Sailor ID
- `sname` (string): Sailor's Name
- `rating` (int): Rating
- `age` (int): Age

### BOAT
- `bid` (int): Boat ID
- `bname` (string): Boat Name
- `color` (string): Boat Color

### RESERVERS
- `sid` (int): Sailor ID
- `bid` (int): Boat ID
- `date` (date): Reservation Date

## b. Insurance Database

### PERSON
- `driver id#` (string): Driver ID
- `name` (string): Name
- `address` (string): Address

### CAR
- `regno` (string): Registration Number
- `model` (string): Car Model
- `year` (int): Car Year

### ACCIDENT
- `report_number` (int): Accident Report Number
- `acc_date` (date): Accident Date
- `location` (string): Accident Location

### OWNS
- `driver id#` (string): Driver ID
- `regno` (string): Registration Number

### PARTICIPATED
- `driver id#` (string): Driver ID
- `regno` (string): Registration Number
- `report_number` (int): Report Number
- `damage_amount` (int): Damage Amount

## c. Order Processing Database

### Customer
- `Cust#` (int): Customer Number
- `cname` (string): Customer Name
- `city` (string): City

### Order
- `order#` (int): Order Number
- `odate` (date): Order Date
- `cust#` (int): Customer Number
- `order-amt` (int): Order Amount

### Order-item
- `order#` (int): Order Number
- `Item#` (int): Item Number
- `qty` (int): Quantity

### Item
- `item#` (int): Item Number
- `unitprice` (int): Unit Price

### Shipment
- `order#` (int): Order Number
- `warehouse#` (int): Warehouse Number
- `ship-date` (date): Shipment Date

### Warehouse
- `warehouse#` (int): Warehouse Number
- `city` (string): City

## d. Student Enrollment in Courses and Books Adopted for Each Course

### STUDENT
- `regno` (string): Registration Number
- `name` (string): Name
- `major` (string): Major
- `bdate` (date): Birth Date

### COURSE
- `course#` (int): Course Number
- `cname` (string): Course Name
- `dept` (string): Department

### ENROLL
- `regno` (string): Registration Number
- `course#` (int): Course Number
- `sem` (int): Semester
- `marks` (int): Marks

### BOOK-ADOPTION
- `course#` (int): Course Number
- `sem` (int): Semester
- `book-ISBN` (int): Book ISBN

### TEXT
- `book-ISBN` (int): Book ISBN
- `book-title` (string): Book Title
- `publisher` (string): Publisher
- `author` (string): Author

## e. Company Database

### EMPLOYEE
- `SSN` (string): Social Security Number
- `Name` (string): Employee Name
- `Address` (string): Address
- `Sex` (string): Gender
- `Salary` (int): Salary
- `SuperSSN` (string): Supervisor's Social Security Number
- `DNo` (int): Department Number

### DEPARTMENT
- `DNo` (int): Department Number
- `DName` (string): Department Name
- `MgrSSN` (string): Manager's Social Security Number
- `MgrStartDate` (date): Manager's Start Date

### DLOCATION
- `DNo` (int): Department Number
- `DLoc` (string): Location

### PROJECT
- `PNo` (int): Project Number
- `PName` (string): Project Name
- `PLocation` (string): Project Location
- `DNo` (int): Department Number

### WORKS_ON
- `SSN` (string): Social Security Number
- `PNo` (int): Project Number
- `Hours` (int): Work Hours

### Lab 7, 8, 9, 10: Data Manipulation Language (DML) and Data Control Language (DCL)
7. Write valid DML statements to retrieve tuples from the databases. The queries may contain appropriate DML and DCL commands, such as select with like, between, where clause, order by, set operations, exists and not exists, join operations, aggregate functions, group by, group by having, nested and correlated nested queries, grant, and revoke permissions.

### Lab 11 and 12: Views and Triggers
11. Views: Creation and manipulating content.
12. Triggers: Creation and execution of database triggers on every insert, delete, and update operation.
