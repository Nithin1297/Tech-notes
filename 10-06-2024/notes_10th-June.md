# 10th June

- [color space](https://mycolor.space/) website to pick gradient colors to our page
- Block level elements occupy entire width so they are in separate line eg. p,h etc.,
- inline-level elements occupy necessary width eg. a,img,span,strong etc.,
- [mask the image](https://bennettfeely.com/clippy/)

## OS

- linux is

1. free(open source)
2. Open source
3. secure
4. small footprint(less size)
5. everything we write in terminal(automation)

## Scaling

- vertical scaling -> increasing ram,processor etc.,
- Horizontal scaling -> adding more computers

## Features of Database software

- frequently asked it will have it in the ram
- querying becomes easier
- crud easy
- backups are inbuilt
- undo-easily(time limit)
- performance

## SQL VS NOSQL

### Relational Databases(SQL)

1. pl/sql
2. postgre sql
3. mysql
4. amazon rds

### Non - Relational Databases(NoSQL)

1. mondo DB
2. couch DB
3. redis
4. cassandra (netflix uses)
5. Dynamo DB
6. Neo4j

## Exercises

### Exercise 1 — Tasks

- Exercise 1
  ![Ex-1](./sql%20images/ex-1.png)

- Find the title of each film

```sql
SELECT title
FROM movies;
```

- Find the director of each film

```sql
SELECT director
FROM movies;
```

- Find the title and director of each film

```sql
SELECT title,director
FROM movies;
```

- Find the title and year of each film

```sql
SELECT title,year
FROM movies;
```

- Find all the information about each film

```sql
SELECT *
FROM movies;
```

### Exercise 2 — Tasks

- Exercise 2
  ![Ex-2](./sql%20images/ex-2.png)

- Find the movie with a row id of 6

```sql
SELECT title
FROM movies
WHERE id = 6;
```

- Find the movies released in the years between 2000 and 2010 ✓

```sql
SELECT title
FROM movies
WHERE year
between 2000 and 2010;
```

- Find the movies not released in the years BETWEEN 2000 and 2010

```sql
SELECT title
FROM movies
WHERE year
NOT BETWEEN 2000 and 2010;
```

- Find the first 5 Pixar movies and their release year ✓

```SQL
SELECT title,year
FROM movies
limit 5;
```

### Exercise 3 — Tasks

- Exercise 3
  ![Ex-3](./sql%20images/ex-3.png)

- Find all the Toy Story movies ✓

```sql
SELECT *
FROM movies where title like "%Toy%";
```

- Find all the movies directed by John Lasseter ✓

```sql
SELECT *
FROM movies where director like "%john%";
```

- Find all the movies (and director) not directed by John Lasseter ✓

```sql
SELECT title,director
FROM movies where not director = "John Lasseter";
```

- Find all the WALL-\* movies ✓

```sql

```

### Exercise 4 — Tasks

- Exercise 4
  ![Ex-4](./sql%20images/ex-4.png)

- List all directors of Pixar movies (alphabetically), without duplicates ✓

```sql
SELECT distinct director FROM movies order by director;
```

- List the last four Pixar movies released (ordered from most recent to least)

```sql
SELECT * FROM movies order by year desc limit 4;
```

- List the first five Pixar movies sorted alphabetically ✓

```sql
SELECT * FROM movies order by title limit 5 ;
```

- List the next five Pixar movies sorted alphabetically

```sql
SELECT * FROM movies order by title limit 5 offset 5;
```

### Exercise 5 — Tasks

- Exercise 5
  ![Ex-5](./sql%20images/ex-5.png)

- List all the Canadian cities and their populations ✓

```sql
SELECT city,population FROM north_american_cities where country = "Canada";
```

- Order all the cities in the United States by their latitude from north to south

```sql
SELECT * FROM north_american_cities where country = "United States" order by latitude desc;
```

- List all the cities west of Chicago, ordered from west to east

```sql
SELECT city, longitude FROM north_american_cities
WHERE longitude < -87.629798
ORDER BY longitude ASC;
```

- List the two largest cities in Mexico (by population)

```sql
SELECT city FROM north_american_cities
WHERE country = "Mexico"
ORDER BY population desc limit 2;
```

- List the third and fourth largest cities (by population) in the United States and their population

```sql
SELECT city,population FROM north_american_cities
WHERE country = "United States"
ORDER BY population desc limit 2 offset 2;
```

# 11th June

### Exercise 6 — Tasks

- Exercise 6
  ![Ex-6](./sql%20images/ex-6.png)

- Find the domestic and international sales for each movie

```sql
SELECT title,Domestic_sales,International_sales FROM movies m,boxoffice b where m.id = b.Movie_id;
```

- Show the sales numbers for each movie that did better internationally rather than domestically

```sql
SELECT * FROM movies m Inner join boxoffice b where m.id = b.Movie_id and b.International_sales > b.Domestic_sales;
```

- List all the movies by their ratings in descending order

```sql
SELECT * FROM movies m , boxoffice b where m.id = b.Movie_id order by b.Rating desc;
```

### Exercise 7 — Tasks

- Exercise 7
  ![Ex-7](./sql%20images/ex-7.png)
- Find the list of all buildings that have employees ✓

```SQL
SELECT  distinct Building_name
FROM Buildings b
OUTER JOIN Employees e
ON b.Building_name = e.Building;
```

- Find the list of all buildings and their capacity

```SQL
SELECT  *
FROM Buildings;
```

- List all buildings and the distinct employee roles in each building (including empty buildings)

```SQL
SELECT distinct Building_name,Role
FROM Buildings b
LEFT JOIN Employees e
ON b.Building_name = e.Building;
```

### Exercise 8 — Tasks

- Exercise 8
  ![Ex-8](./sql%20images/ex-8.png)
- Find the name and role of all employees who have not been assigned to a building ✓

```sql
SELECT Name,Role
FROM employees
where Building is null;
```

- Find the names of the buildings that hold no employees

```sql
SELECT Building_name
FROM Buildings b
LEFT JOIN Employees e
ON b.Building_name = e.Building
Where building is null;
```

### Exercise 9 — Tasks

- Exercise 9
  ![Ex-9](./sql%20images/ex-9.png)
- List all movies and their combined sales in millions of dollars ✓

```sql
SELECT Title,(Domestic_sales + International_sales)/1000000 AS sales
FROM Boxoffice b
INNER join Movies m
ON b.Movie_id = m.Id;
```

- List all movies and their ratings in percent

```sql
SELECT Title,Rating*10 AS Rating_percent
FROM Boxoffice b
INNER join Movies m
ON b.Movie_id = m.Id;
```

- List all movies that were released on even number years

```sql
SELECT Title
FROM Boxoffice b
INNER join Movies m
ON b.Movie_id = m.Id
WHERE m.Year % 2 = 0;
```

### Exercise 10 — Tasks

- Exercise 10
  ![Ex-10](./sql%20images/ex-10.png)
- Find the longest time that an employee has been at the studio ✓

```sql
SELECT max(Years_employed)
FROM employees;
```

- For each role, find the average number of years employed by employees in that role

```sql
SELECT distinct Role,avg(Years_employed)
FROM employees
GROUP BY Role;
```

- Find the total number of employee years worked in each building

```sql
SELECT Building,sum(Years_employed)
FROM employees
GROUP BY Building;
```

### Exercise 11 — Tasks

- Exercise 11
  ![Ex-11](./sql%20images/ex-11.png)
- Find the number of Artists in the studio (without a HAVING clause) ✓

```sql
SELECT COUNT(role)
FROM employees
WHERE role = 'Artist';
```

- Find the number of Employees of each role in the studio

```sql
SELECT *,COUNT(name)
FROM employees
GROUP BY role;
```

- Find the total number of years employed by all Engineers

```sql
SELECT SUM(Years_employed)
FROM employees
GROUP BY role
HAVING role = 'Engineer';
```

### Exercise 12 — Tasks

- Exercise 12
  ![Ex-12](./sql%20images/ex-12.png)
- Find the number of movies each director has directed ✓

```sql
SELECT director,count(title) FROM movies
GROUP BY Director;
```

- Find the total domestic and international sales that can be attributed to each director

```sql
SELECT director,SUM(Domestic_sales + International_sales) AS sales
FROM Boxoffice b
LEFT JOIN Movies m
ON m.id = b.Movie_id
GROUP BY Director;
```

### Exercise 13 — Tasks

- Exercise 13
  ![Ex-13](./sql%20images/ex-13.png)
- Add the studio's new production, Toy Story 4 to the list of movies (you can use any director) ✓

```sql
INSERT INTO Movies VALUES(15,'Toy Story 4','Nithin',2017,9);
```

- Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table.

```sql
INSERT INTO Boxoffice  VALUES(15,8.7,340000000,27000000);
```

### Exercise 14 — Tasks

- Exercise 14
  ![Ex-14](./sql%20images/ex-14.png)
- The director for A Bug's Life is incorrect, it was actually directed by John Lasseter ✓

```sql
UPDATE Movies
SET Director = "John Lasseter"
WHERE Title = "A Bug's Life";
```

- The year that Toy Story 2 was released is incorrect, it was actually released in 1999

```sql
UPDATE Movies
SET Year = 1999
WHERE Title = "Toy Story 2";
```

- Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich

```sql
UPDATE Movies
SET Title = "Toy Story 3",Director = "Lee Unkrich"
WHERE Title = "Toy Story 8";
```

### Exercise 15 — Tasks

- Exercise 15
  ![Ex-15](./sql%20images/ex-15.png)
- This database is getting too big, lets remove all movies that were released before 2005. ✓

```sql
DELETE FROM Movies
WHERE Year < 2005;
```

- Andrew Stanton has also left the studio, so please remove all movies directed by him.

```sql
DELETE FROM Movies
WHERE 	Director = "Andrew Stanton";
```

### Exercise 16 — Tasks

- Exercise 16
  ![Ex-16](./sql%20images/ex-16.png)
- Create a new table named Database with the following columns:
  – Name A string (text) describing the name of the database
  – Version A number (floating point) of the latest version of this database
  – Download_count An integer count of the number of times this database was downloaded
  This table has no constraints. ✓
  ```sql
  CREATE TABLE Database(Name varchar(20),Version int,Download_count int);
  ```

### Exercise 17 — Tasks

- Exercise 17
  ![Ex-17](./sql%20images/ex-17.png)
- Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in. ✓

```sql
ALTER TABLE Movies
ADD Aspect_ratio float;
```

- Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English.

```sql
ALTER TABLE Movies
ADD Language varchar
DEFAULT "English";
```

### Exercise 18 — Tasks

- Exercise 18
  ![Ex-18](./sql%20images/ex-18.png)
- We've sadly reached the end of our lessons, lets clean up by removing the Movies table ✓

```sql
DROP TABLE Movies;
```

- And drop the BoxOffice table as well

```sql
DROP TABLE BoxOffice;
```

# NORMALIZATION

- Normalization is done to improve the **Safety** of data

### First Normal Form

![First Normal Form](./sql%20images/1nf.png)

### Third Normal Form

![Third Normal Form](./sql%20images/3nf.png)

# Joins

![Joins](./sql%20images/joins.png)

# 12th June

- Completed **sqlbolt** tasks

```sql
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

select * from orders o
			where o.purch_amt > (select avg(purch_amt) from orders as i
									where i.customer_id = o.customer_id);


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
```

# 13 June

## Constraints

![constraints](./sql%20images/constraints1.png)

> Primary Key

> Foreign key

![Foreign key](./sql%20images/Forein_key.png)

> Integer and String Data type

![Int and string datatype](./sql%20images/Int_String_Datatype.png)

- int (-2b to 2b)
- small int (-32k to 32k)
- big int (-9*10^8 to 9*10^8)

> String

- varchar
- nvarchar

> Decimal

- decimal (exact) [Low performance]
- float (approx) [High performance]

> Date

- Date
- Time
- Date and Time

### Functions

> Aggregate Functions

- sum, max, avg, count, min

> String Functions

- len  
  `select Len('Madduri') AS nameLength;`
- left  
  `select LEFT('Nithin kumar',5) as lef;`
- right  
  `select RIGHT('Madduri',3) AS nameright;`
- substring  
  `select substring('Madduri',2,5) AS namesub;`
- upper  
  `select upper('Madduri') AS nameUpper;`
- lower  
  `select lower('Madduri') AS namelower;`
- ltrim  
  `select ltrim('     Madduri') AS namelrim;`
- rtrim  
  `select rtrim('Madduri      ') AS namertrim;`
- charindex  
  `select charindex('Nithin','Madduri Nithin Kumar') AS nameindex;`
- replace  
  `select replace('Nagella Pandu','Nagella','Madduri') AS namereplace;`
- concat  
  `select concat('Madduri ','Pandu') AS nameconcat;`
- Replicate - repeat  
  `select replicate('pandu ',5);`
- Reverse  
  `select Reverse('pandu');`

> Mathematical functions

- abs  
  `select abs(-2);`
- power  
  `select power(5,2);`
- round  
  `select round(58.2644,2);`
- ceiling  
  `select ceiling(58.2644);`
- floor  
  `select floor(58.2644);`

> Date Functions

- getdate  
  `select GETDATE() as today;`
- dateadd  
  `select dateadd(day, 10, getdate());`
- datediff  
  `select datediff(MONTH,getdate(),'2028-06-23');`
- format  
  `select GETDATE() as today;`
  `SELECT FORMAT(GETDATE(), 'MM/dd/yyyy');`
- datepart (Extracts the part from the date)  
  `select DATEPART(month,getdate());`
  `select DATEPART(day,getdate());`
