create database business;
use business;

CREATE TABLE Employees(EmployeeID int primary key,FirstName	varchar(20),LastName varchar(20));
CREATE TABLE Products(ProductID	 int primary key,ProductName varchar(20),ProductDescription varchar(50));
CREATE TABLE SalesOrders (SalesOrderID	 int primary key,OrderDate datetime,TotalAmount decimal);
CREATE TABLE Customers(CustomerID int primary key,CustomerName	varchar(20),Address varchar(50));

drop table SalesOrders;

SELECT * FROM INFORMATION_SCHEMA.TABLES;

INSERT INTO Employees VALUES(1,'John ','Doe');
INSERT INTO Employees VALUES(2,'Jane ','Smith');
INSERT INTO Employees VALUES(3,'Alice ','Johnson');

INSERT INTO Products VALUES(101,'Widget A','A standard widget');
INSERT INTO Products VALUES(102,'Gadget B','A fancy new gadget');
INSERT INTO Products VALUES(103,'Thingamajig','A very useful tool');

INSERT INTO SalesOrders VALUES(1001,'2023-01-15 14:33:00',150.00);
INSERT INTO SalesOrders VALUES(1002,'2023-03-22 10:45:00',200.00);
INSERT INTO SalesOrders VALUES(1003,'2024-05-17 09:20:00',350.00);

INSERT INTO Customers  VALUES(201,'Acme Corp','123 Main St');
INSERT INTO Customers  VALUES(202,'Globex Inc','456 Elm St');
INSERT INTO Customers  VALUES(203,'Initech','789 Oak St');

SELECT * FROM Employees;
SELECT * FROM Products;
SELECT * FROM SalesOrders;
SELECT * FROM Customers;

-- TRUNCATE TABLE Employees;
-- exercise-1
select EmployeeID,upper(concat(FirstName,LastName)) AS FullName from Employees;

-- exercise-2
select ProductID,ProductName,len(ProductDescription) AS DescriptionLength from Products;

-- exercise-3
select SalesOrderID,format(OrderDate, 'yyyy-MM-dd') AS FormattedOrderDate from SalesOrders;

-- exercise-4
select CustomerID,CustomerName,rtrim(ltrim(Address)) as CleanedAddress from Customers;

-- exercise-5
select datepart(year,OrderDate) as Year,sum(TotalAmount) as TotalSales 
from SalesOrders 
group by datepart(year,OrderDate);


CREATE TABLE Departments (
  DepartmentID INT,
  DepartmentName VARCHAR(255)
);




-- Add CustomerID column to SalesOrders table
ALTER TABLE SalesOrders
ADD CustomerID INT;

-- Update CustomerID values based on SalesOrderID
UPDATE SalesOrders
SET CustomerID = (
  SELECT CustomerID
  FROM Customers
  WHERE Customers.CustomerID = SalesOrders.CustomerID
);
truncate table SalesOrders;
-- Insert sample data into SalesOrders table
INSERT INTO SalesOrders (SalesOrderID, CustomerID, OrderDate, TotalAmount)
VALUES
  (1001, 201, '2023-01-15 14:33:00', 150.00),
  (1002, 202, '2023-03-22 10:45:00', 200.00),
  (1003, 201, '2024-05-17 09:20:00', 350.00);

  select s.CustomerID,c.CustomerName,datepart(year,s.OrderDate) as Year,s.TotalAmount as TotalSales from SalesOrders s,Customers c 
  where s.CustomerID = c.CustomerID ;


  -- 5th
    select s.SalesOrderID,c.CustomerName,FORMAT(s.OrderDate, 'yyyy-MM-dd') as FormattedOrderDate,s.TotalAmount from SalesOrders s,Customers c 
  where s.CustomerID = c.CustomerID ;

  -- 4th
  SELECT 
  p.ProductID,
  p.ProductName,
  REPLACE(p.ProductDescription, 'useful', 'beneficial') AS ModifiedDescription
FROM 
  Products p
WHERE 
  p.ProductDescription LIKE '%useful%';

  -- 1st
  CREATE TABLE DepartmentTable (
  DepartmentID INT PRIMARY KEY,
  DepartmentName VARCHAR(50)
);

INSERT INTO DepartmentTable VALUES
  (101, 'Sales'),
  (102, 'Engineering'),
  (103, 'Marketing');

ALTER TABLE Employees
ADD DepartmentID INT;

ALTER TABLE Employees
ADD CONSTRAINT FK_EmpTable_DepartmentTable
FOREIGN KEY (DepartmentID)
REFERENCES DepartmentTable(DepartmentID);

UPDATE Employees
SET DepartmentID = 101
WHERE EmployeeID IN (1);

UPDATE Employees
SET DepartmentID = 102
WHERE EmployeeID IN (2);

UPDATE Employees
SET DepartmentID = 103
WHERE EmployeeID IN (3);


SELECT 
  e.EmployeeID,
  CONCAT(UPPER(e.FirstName), ' ', UPPER(e.LastName)) AS FullName,
  LOWER(d.DepartmentName) AS DepartmentName
FROM 
  Employees e
JOIN 
  DepartmentTable d ON e.DepartmentID = d.DepartmentID

  -- 2nd
  select ProductID,ProductName,len(ProductDescription) as DescriptionLength,reverse(ProductDescription) from Products ;