CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255),
    commission DECIMAL(4, 2)
);


Select * from salesman


INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15), -- Print
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11), -- Print
(5006, 'Mc Lyon', 'Paris', 0.14), -- Print
(5003, 'Lauson Hen', NULL, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13); -- Print

select * from salesman;

-- TASK 1 -Find the average commision of a saleman from Paris
select avg(commission) as avgcommission
from salesman
where city = 'Paris'
;

-- TASK 2 -Find out if there are cities with only one salesman and list them | No nulls
-- Clue: Having
select city
from salesman
group by city
having count(city) = 1;

-- TASK 3
CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);


INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007),
(70013, 3045.6, '2012-04-25', 3002, 5001);

Select * from salesman;
Select * from orders;

-- Task 3 - Sub-Query
-- Write a query to display all the orders from the orders table issued by the salesman 'Paul Adam'.
SELECT s.salesman_id,s.name,o.ord_no from salesman s 
inner join orders o 
ON s.salesman_id = o.salesman_id
where s.name = 'Paul Adam';

select ord_no from orders
where salesman_id = (select salesman_id from salesman where name = 'Paul Adam') ;

-- Task 4
-- Write a query to display all the orders which values are greater than the average order value for 10th October 2012
select ord_no 
from orders
where ord_date = '2012-10-10' and purch_amt > (select avg(purch_amt) from orders);

Select * from orders;
-- Task 5 (Challenging)
-- Write a query to find all orders with order amounts which are above-average amounts for their customers.

select * from (select customer_id,avg(purch_amt) as avge from orders group by customer_id) as hii 
inner join orders o
on o.customer_id = hii.customer_id
where purch_amt > avge;

select customer_id,avg(purch_amt) as avge from orders group by customer_id;


-- Task 6
-- Write a query to find all orders attributed to a salesman in 'Paris'
-- Clue: In operator
select o.ord_no from salesman s, orders o
where city = 'Paris' and s.salesman_id = o.salesman_id;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade INT NULL,
    salesman_id INT
);
INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007);

Select * from orders;
Select * from salesman;
select * from customer;

-- Task 7
-- Write a query to find the name and id of all salesmen who had more than one customer
select s.name , c.salesman_id from salesman s Inner join customer c
On s.salesman_id = c.salesman_id
group by c.salesman_id,s.name
having count(c.salesman_id) > 1;




CREATE DATABASE shop;
use shop;

-- len
select Len('Madduri') AS nameLength;
-- left
select LEFT('Nithin kumar',5) as lef;
-- right
select RIGHT('Madduri',3) AS nameright;
-- substring
select substring('Madduri',2,5) AS namesub;
-- upper
select upper('Madduri') AS nameUpper;
-- lower
select lower('Madduri') AS namelower;

-- ltrim
select ltrim('     Madduri') AS namelrim;
-- rtrim
select rtrim('Madduri      ') AS namertrim;
-- charindex
select charindex('Nithin','Madduri Nithin Kumar') AS nameindex;
-- replace
select replace('Nagella Pandu','Nagella','Madduri') AS namereplace;
-- concat
select concat('Madduri ','Pandu') AS nameconcat;
-- Replicate - repeat
select replicate('pandu ',5);
-- Reverse
select Reverse('pandu');

-- Mathematical functions
-- abs
select abs(-2);
-- power
select power(5.5,2);
-- round
select round(58.2644,2) as r;
-- ceiling
select ceiling(58.2644);
-- floor
select floor(58.2644);

-- Date Functions
-- getdate
select GETDATE() as today;
-- dateadd
select dateadd(month, 6, getdate());
-- datediff
select datediff(year,'2002-05-30',getdate());
-- format
select GETDATE() as today;
SELECT FORMAT(GETDATE(), 'MM/dd/yyyy');
-- datepart (Extracts the part from the date)
select DATEPART(month,getdate());
select DATEPART(day,getdate());

