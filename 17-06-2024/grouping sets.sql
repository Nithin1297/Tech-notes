CREATE DATABASE groupingsets
use groupingsets

-- Creating the Sales Agents Table

CREATE TABLE sales_agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(50),
    region VARCHAR(50)
);

 
---
 
-- Inserting Data into Sales Agents Table

INSERT INTO sales_agents (agent_id, agent_name, region) VALUES
(101, 'John Doe', 'North'),
(102, 'Jane Smith', 'South'),
(103, 'Emily Johnson', 'North'),
(104, 'Chris Lee', 'South'),
(105, 'Alex Murray', 'East'),
(106, 'Linda Zhao', 'West'),
(107, 'Samuel Green', 'East'),
(108, 'Patricia Neal', 'West');

 
---
 
-- Creating the Sales Data Table

CREATE TABLE sales_data (
    sales_id INT PRIMARY KEY,
    region VARCHAR(50),
    product_type VARCHAR(50),
    sales_amount DECIMAL(10, 2),
    sales_date DATE
);

 

-- Inserting Data into Sales Data Table
 

INSERT INTO sales_data (sales_id, region, product_type, sales_amount, sales_date) VALUES
(1, 'North', 'Electronics', 1500.00, '2024-06-01'),
(2, 'South', 'Electronics', 1200.00, '2024-06-01'),
(3, 'North', 'Furniture', 500.00, '2024-06-02'),
(4, 'South', 'Furniture', 800.00, '2024-06-03'),
(5, 'North', 'Electronics', 300.00, '2024-06-04'),
(6, 'South', 'Electronics', 450.00, '2024-06-05'),
(7, 'North', 'Furniture', 700.00, '2024-06-05'),
(8, 'South', 'Furniture', 600.00, '2024-06-07'),
(9, 'East', 'Electronics', 2200.00, '2024-01-10'),
(10, 'East', 'Electronics', 1850.00, '2024-02-15'),
(11, 'West', 'Furniture', 960.00, '2024-03-05'),
(12, 'West', 'Electronics', 540.00, '2024-04-16'),
(13, 'East', 'Furniture', 1340.00, '2024-05-18'),
(14, 'West', 'Electronics', 1250.00, '2024-06-21'),
(15, 'East', 'Clothing', 830.00, '2024-07-22'),
(16, 'West', 'Clothing', 670.00, '2024-08-25'),
(17, 'North', 'Clothing', 920.00, '2024-09-15'),
(18, 'South', 'Clothing', 780.00, '2024-10-05'),
(19, 'North', 'Electronics', 2150.00, '2024-11-12'),
(20, 'South', 'Electronics', 1950.00, '2024-12-20'),
(21, 'East', 'Electronics', 2450.00, '2025-01-11'),
(22, 'West', 'Furniture', 2040.00, '2025-02-14'),
(23, 'East', 'Furniture', 1580.00, '2025-03-17'),
(24, 'West', 'Electronics', 1700.00, '2025-04-19'),
(25, 'East', 'Clothing', 500.00, '2025-05-21'),
(26, 'West', 'Clothing', 460.00, '2025-06-23'),
(27, 'North', 'Clothing', 1150.00, '2025-07-25'),
(28, 'South', 'Clothing', 890.00, '2025-08-27'),
(29, 'North', 'Electronics', 1850.00, '2025-09-29'),
(30, 'South', 'Electronics', 1600.00, '2025-10-31');

SELECT * FROM sales_agents
SELECT * FROM sales_data

-- 1.Determine the most popular product types by transaction count and total sales in each region.
SELECT region,product_type,count(product_type) as total,sum(sales_amount) as sumtotal
FROM sales_data
GROUP BY region,product_type
ORDER BY region,total desc

-- 2.Generate a detailed monthly sales report showing total sales, average sales, and total transactions by region and product type.

SELECT * 
FROM sales_agents
ORDER BY agent_id
OFFSET 2 ROWS
FETCH NEXT 3 ROWS ONLY;

-- 18th june

select region,product_type,sum(sales_amount) 
from sales_data
group by GROUPING sets (
(region),(product_type),(region,product_type)
)

select region,product_type,sum(sales_amount) 
from sales_data
group by grouping sets ((region,product_type))

-- Rollup
select region,product_type,sum(sales_amount) 
from sales_data
group by rollup (region,product_type)

-- cube
select region,product_type,sum(sales_amount) 
from sales_data
group by cube (region,product_type)

select region,product_type,sum(sales_amount) 
from sales_data
group by region,product_type
order by region,sum(sales_amount) desc

select region,product_type,sum(sales_amount) as totsales
from sales_data
where region = 'East'
group by region,product_type
order by sum(sales_amount) desc

-- Ranking functions
-- 1.rank
-- 2.dence rank
-- 3.row_number
-- 4.N

SELECT *
,Rank() OVER (ORDER BY sales_amount DESC)
FROM sales_data

SELECT *
,dense_Rank() OVER (ORDER BY sales_amount DESC)
FROM sales_data

SELECT *
,row_number() OVER (ORDER BY sales_amount DESC) 
FROM sales_data

-- Task 1: Region based ranking - Based on Total Sales (Don't skip ranks)

SELECT region,sum(sales_amount) 
,dense_Rank() OVER (ORDER BY sum(sales_amount) DESC)
FROM sales_data
group by region

-- Task 2: Region based ranking - Based on Total Sales & Total Transactions (Don't skip ranks)
SELECT region,sum(sales_amount) AS totSales,count(*) AS totTransact
,dense_Rank() OVER (ORDER BY count(*) DESC) AS transact_rank
,dense_Rank() OVER (ORDER BY sum(sales_amount) DESC) AS sales_rank
FROM sales_data
group by region

-- which product doing good in which region
SELECT region,product_type,sum(sales_amount) 
,Rank() OVER (PARTITION BY product_type ORDER BY sum(sales_amount) DESC)
FROM sales_data
group by region,product_type

-- In which region which product doing good
SELECT region,product_type,sum(sales_amount) 
,Rank() OVER (PARTITION BY region ORDER BY sum(sales_amount) DESC)
FROM sales_data
group by region,product_type;

-- Common Table Expression
WITH salesCte 
	AS
	(
	SELECT  region,
			product_type,
			sum(sales_amount) as Total_sales,
			Rank() OVER (PARTITION BY region ORDER BY sum(sales_amount) DESC) AS Sales_Rank
	FROM sales_data
	GROUP BY region,product_type
	)
SELECT *
FROM salesCte
WHERE Sales_Rank = 1


-- Running total

SELECT sales_id,region,product_type,sales_amount,
SUM(sales_amount) OVER  ( ORDER BY sales_id ) AS [Running Total],
avg(sales_amount) OVER  ( ORDER BY sales_id ) AS [Average Total],
count(sales_amount) OVER  ( ORDER BY sales_id ) AS [count Total]
FROM sales_data


SELECT * FROM sales_agents
SELECT * FROM sales_data

select region,product_type,
		sum(sales_amount) as summation,
		avg(sales_amount) as average,
		COUNT(*) as total, 
		format(sales_date,'yyyy-MM') as monthly
from sales_data
group by format(sales_date,'yyyy-MM'), region,product_type
order by monthly,summation desc

SELECT CAST('23.7' AS varchar) AS int, CAST(23.7 AS int) AS decimal;

SELECT CONVERT(VARCHAR, '23.7') AS int, CONVERT(int, 23.7) AS decimal;

SELECT CAST(20 as varchar)

SELECT CONVERT(VARCHAR, GETDATE(),010)
