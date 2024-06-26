create database team

CREATE TABLE products
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE orders
(
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    grade INT NOT NULL
);

INSERT INTO products
    (product_id, product_name, price)
VALUES
    (1, 'Laptop', 1000.00),
    (2, 'Smartphone', 700.00),
    (3, 'Tablet', 300.00),
    (4, 'Monitor', 150.00);

INSERT INTO customers
    (customer_id, customer_name, city, grade)
VALUES
    (1, 'Alice', 'New York', 1),
    (2, 'Bob', 'London', 2),
    (3, 'Charlie', 'Paris', 3),
    (4, 'David', 'New York', 4),
    (5, 'Eve', 'Berlin', 5);

INSERT INTO orders
    (order_id, order_date, customer_id, product_id, quantity, total_price)
VALUES
    (1, '2024-01-15', 1, 1, 1, 1000.00),
    (2, '2024-02-10', 2, 2, 2, 1400.00),
    (3, '2024-03-05', 3, 3, 3, 900.00),
    (4, '2024-04-20', 4, 4, 1, 150.00),
    (5, '2024-05-25', 5, 1, 2, 2000.00);

SELECT *
from products
SELECT *
from customers
SELECT *
from orders

-- 1.Write a query to find all orders with a 
--total price smaller than any order's total price for a 
--customer in London, and group the results by customer_id.

-- 2. Write a query to find all unique products 
-- names that have never been ordered by any customer

SELECT DISTINCT product_name
FROM products
WHERE product_id IN (
      SELECT product_id
    FROM products
EXCEPT
    SELECT DISTINCT product_id
    FROM orders
);

SELECT DISTINCT product_name
FROM products
WHERE  not EXISTS product_id in (SELECT DISTINCT product_id
FROM orders)

SELECT DISTINCT p.product_name
FROM products p
WHERE NOT EXISTS (
  SELECT o.product_id
FROM orders o
WHERE p.product_id = o.product_id
);


-- Write a query to display the top 3 customers 
-- with the highest total order amount in each city
With orderscte
As
( 
select o.customer_id, customer_name, city,Count(order_id) as ct,
DENSE_RANk() over (partition by city order by Count(order_id) desc) as rankof
from orders o
Join customers c
on o.customer_id=c.customer_id
group by o.customer_id,customer_name,city
)
Select * 
From orderscte
Where rankof In (1,2,3)

-- Write a query to find the products that have been 
-- ordered by customers in both 'New York' and 'London'


SELECT *
from products
SELECT *
from customers
SELECT *
from orders

SELECT p.product_name
FROM products p
WHERE p.product_id IN (
  SELECT DISTINCT product_id
  FROM orders
  WHERE customer_id IN (
    SELECT customer_id
    FROM customers
    WHERE city = 'New York'
  )
)
INTERSECT
SELECT p.product_name
FROM products p
WHERE p.product_id IN (
  SELECT DISTINCT product_id
  FROM orders
  WHERE customer_id IN (
    SELECT customer_id
    FROM customers
    WHERE city = 'London'
  )
);
