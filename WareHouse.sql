-- Create tables
CREATE TABLE Customer (
    Cust INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    oid INT PRIMARY KEY,
    odate DATE,
    cust INT,
    oid_amt INT,
    FOREIGN KEY (cust) REFERENCES Customer(Cust)
);
CREATE TABLE Item (
    Item INT PRIMARY KEY,
    unitprice INT
);

CREATE TABLE OrderItem (
    oid INT,
    Item INT,
    qty INT,
    PRIMARY KEY (oid, Item),
    FOREIGN KEY (oid) REFERENCES Orders(oid),
    FOREIGN KEY (Item) REFERENCES Item(Item)
);

CREATE TABLE Warehouse (
    warehouse INT PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE Shipment (
    oid INT,
    warehouse INT,
    ship_date DATE,
    PRIMARY KEY (oid),
    FOREIGN KEY (oid) REFERENCES Orders(oid),
    FOREIGN KEY (warehouse) REFERENCES Warehouse(warehouse)
);


-- Insert data into Customer table
INSERT INTO Customer (Cust, cname, city)
VALUES
    (101, 'Customer 1', 'New York'),
    (102, 'Customer 2', 'Los Angeles'),
    (103, 'Customer 3', 'Chicago'),
    (104, 'Customer 4', 'Houston'),
    (105, 'Customer 5', 'Miami');

-- Insert data into Orders table
INSERT INTO Orders (oid, odate, cust, oid_amt)
VALUES
    (201, '2023-01-15', 101, 500),
    (202, '2023-02-20', 102, 600),
    (203, '2023-03-10', 103, 750),
    (204, '2023-04-05', 104, 400),
    (205, '2023-05-15', 105, 550);
    
-- Insert data into Item table
INSERT INTO Item (Item, unitprice)
VALUES
    (301, 50),
    (302, 60),
    (303, 75),
    (304, 40),
    (305, 55);

-- Insert data into OrderItem table
INSERT INTO OrderItem (oid, Item, qty)
VALUES
    (201, 301, 3),
    (202, 302, 4),
    (203, 303, 2),
    (204, 304, 5),
    (205, 305, 6);

-- Insert data into Warehouse table
INSERT INTO Warehouse (warehouse, city)
VALUES
    (401, 'New York'),
    (402, 'Los Angeles'),
    (403, 'Chicago'),
    (404, 'Houston'),
    (405, 'Miami');
    
-- Insert data into Shipment table
INSERT INTO Shipment (oid, warehouse, ship_date)
VALUES
    (201, 401, '2023-01-20'),
    (202, 402, '2023-02-25'),
    (203, 403, '2023-03-15'),
    (204, 404, '2023-04-10'),
    (205, 405, '2023-05-20');


-- Alterations
-- Add a new field "email" to the Customer table
ALTER TABLE Customer
ADD email VARCHAR(100);

-- Drop the "city" field from the Warehouse table
ALTER TABLE Warehouse
DROP city;

-- Adding and Dropping Constraints
-- Add a unique constraint to the "email" field in the Customer table
ALTER TABLE Customer
ADD CONSTRAINT unique_email UNIQUE (email);

-- Drop the unique constraint on the "email" field in the Customer table
ALTER TABLE Customer
DROP CONSTRAINT unique_email;

-- Add a check constraint to the "unitprice" field in the Item table
ALTER TABLE Item
ADD CONSTRAINT check_unitprice CHECK (unitprice > 0);

-- Drop the check constraint on the "unitprice" field in the Item table
ALTER TABLE Item
DROP CONSTRAINT check_unitprice;

-- Add a new field "item_description" to the Item table
ALTER TABLE Item
ADD item_description VARCHAR(255);

-- Drop the "oid_amt" field from the Orders table
ALTER TABLE Orders
DROP oid_amt;

-- Display data from the tables
SELECT * FROM Customer;
SELECT * FROM Orders;
SELECT * FROM OrderItem;
SELECT * FROM Item;
SELECT * FROM Shipment;
SELECT * FROM Warehouse;


--1. Select with %LIKE, BETWEEN, WHERE Clause:
-- Retrieve customers in cities starting with 'N'
SELECT *
FROM Customer
WHERE city LIKE 'N%';

-- Retrieve orders with order amounts between 500 and 700
SELECT *
FROM Orders
WHERE oid_amt BETWEEN 500 AND 700;


--2. Order By:
-- Retrieve orders ordered by order date in descending order
SELECT *
FROM Orders
ORDER BY odate DESC;


--3. Set Operations:
-- Retrieve a list of distinct cities from customers and warehouses
SELECT city FROM Customer
UNION
SELECT city FROM Warehouse;


--4. EXISTS and NOT EXISTS:
-- Retrieve orders with corresponding shipments
SELECT *
FROM Orders
WHERE EXISTS (
    SELECT 1
    FROM Shipment
    WHERE Orders.oid = Shipment.oid
);

-- Retrieve orders without corresponding shipments
SELECT *
FROM Orders
WHERE NOT EXISTS (
    SELECT 1
    FROM Shipment
    WHERE Orders.oid = Shipment.oid
);


--5. Join Operations:
-- Retrieve details of items in each order with order amounts
SELECT Orders.oid, Item.Item, Item.unitprice, OrderItem.qty, Orders.oid_amt
FROM Orders
JOIN OrderItem ON Orders.oid = OrderItem.oid
JOIN Item ON OrderItem.Item = Item.Item;


--6. Aggregate Functions, GROUP BY, GROUP BY HAVING:
-- Retrieve the total order amount for each customer
SELECT Customer.cust, Customer.cname, SUM(Orders.oid_amt) AS total_order_amount
FROM Customer
JOIN Orders ON Customer.cust = Orders.cust
GROUP BY Customer.cust, Customer.cname
HAVING SUM(Orders.oid_amt) > 600;


--7. Nested and Correlated Nested Queries:
-- Retrieve items with unit prices greater than the average unit price
SELECT Item, unitprice
FROM Item
WHERE unitprice > (
    SELECT AVG(unitprice)
    FROM Item
);


--8. Grant and Revoke Permissions:
-- Grant SELECT permission on Warehouse table to a specific user
GRANT SELECT ON Warehouse TO username;

-- Revoke UPDATE permission on Orders table from a specific user
REVOKE UPDATE ON Orders FROM username;



-- Exam Questions
-- 1)List the OrderId and Ship_date for all orders shipped from Warehouseid "W2" i.e 0002
select * from Shipments where warehouse_id=0002;

-- 2)List the Warehouse information from which the Customer named "Kumar" was supplied his orders. Produce a listing of Order#, Warehouse#
select w.warehouse_id,w.city
from Warehouses w
join Shipments s on s.warehouse_id=w.warehouse_id
join orders o on s.order_id=o.order_id
join Customers c on c.cust_id=o.cust_id
where c.cname like "%Kumar";

-- 3)Produce a listing: Cname, #ofOrders, Avg_Order_Amt, where the middle column is the total number of orders by the customer and the last column is the average order amount for that customer. (Use aggregate functions)
select c.cname, count(o.order_id), avg(o.order_amt)
from customers c
join orders o on o.cust_id=c.cust_id
group by c.cname;

-- 4)Delete all orders for customer named "Kumar".
Delete from orders where cust_id in (select cust_id from customers where cname like "%Kumar%");
select * from orders;

-- 5)Find the item with the maximum unit price
select max(unitprice) from Items;

-- 6)A trigger that updates order_amout based on quantity and unitprice of order_item
delimiter //
CREATE OR REPLACE TRIGGER hsh
AFTER INSERT ON OrderItems
FOR EACH ROW
BEGIN
    UPDATE Orders
    SET order_amt = NEW.qty * (
        SELECT i.unitprice FROM Items i WHERE i.item_id = NEW.item_id
    )
    WHERE order_id = NEW.order_id;
END;
//
delimiter ;

-- 7)Create a view to display orderID and shipment date of all orders shipped from a warehouse 5
Create view ShipmentDatesFromWarehouse as
select s.order_id, s.ship_date
from Shipments s
where s.warehouse_id=2;
select * from ShipmentDatesFromWarehouse;






