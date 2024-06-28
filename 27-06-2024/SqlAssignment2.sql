Create Database SqlAssignment2
use SqlAssignment2

CREATE TABLE books
(
    book_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INT NOT NULL,
    genre VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE authors
(
    author_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    birth_year INT NOT NULL
);

CREATE TABLE sales
(
    sale_id INT PRIMARY KEY,
    book_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO authors
    (author_id, name, country, birth_year)
VALUES
    (1, 'George Orwell', 'UK', 1903),
    (2, 'J.K. Rowling', 'UK', 1965),
    (3, 'Mark Twain', 'USA', 1835),
    (4, 'Jane Austen', 'UK', 1775),
    (5, 'Ernest Hemingway', 'USA', 1899);

INSERT INTO books
    (book_id, title, author_id, genre, price)
VALUES
    (1, '1984', 1, 'Dystopian', 15.99),
    (2, 'Harry Potter and the Philosophers Stone', 2, 'Fantasy', 20.00),
    (3, 'Adventures of Huckleberry Finn', 3, 'Fiction', 10.00),
    (4, 'Pride and Prejudice', 4, 'Romance', 12.00),
    (5, 'The Old Man and the Sea', 5, 'Fiction', 8.99);

INSERT INTO sales
    (sale_id, book_id, sale_date, quantity, total_amount)
VALUES
    (1, 1, '2024-01-15', 3, 47.97),
    (2, 2, '2024-02-10', 2, 40.00),
    (3, 3, '2024-03-05', 5, 50.00),
    (4, 4, '2024-04-20', 1, 12.00),
    (5, 5, '2024-05-25', 4, 35.96);

-- Section 1: Questions

-- Task 1
-- Write a query to display authors who have written books 
-- in multiple genres and group the results by author name.

SELECT a.author_id, a.name, COUNT(distinct b.genre) as genre
FROM authors a
    JOIN books b ON a.author_id = b.author_id
GROUP BY a.author_id,a.name
HAVING COUNT(b.genre) > 1

-- Task 2
-- Write a query to find the books that have the highest sale total 
-- for each genre and group the results by genre.

with
    gross
    as
    (
        select b.book_id , b.title , b.genre, s.total_amount,
            Rank() Over(partition by b.genre order by s.total_amount desc) as ranking
        from books b join sales s on b.book_id = s.book_id
    )
select *
from gross
where ranking = 1;

-- Task 3
-- Write a query to find the average price of books for each author 
-- and group the results by author name, only including authors whose 
-- average book price is higher than the overall average book price.

SELECT name, AVG(price)
FROM authors a
    JOIN books b ON a.author_id = b.author_id
GROUP BY a.name
HAVING AVG(price) > (select avg(price)
from books)
ORDER BY AVG(price) DESC

-- Task 4
-- Write a query to find authors who have sold more books than the 
-- average number of books sold per author and group the results by country.


SELECT name, country, SUM(quantity)
FROM authors a
    JOIN books b ON a.author_id = b.author_id
    JOIN sales s ON b.book_id = s.book_id
GROUP BY country,name
HAVING SUM(quantity) > (select SUM(quantity)
FROM sales)
ORDER BY SUM(quantity) DESC

-- Task 5
-- Write a query to find the top 2 highest-priced books and 
-- the total quantity sold for each, grouped by book title.

SELECT top(2)
    b.title, b.price, SUM(s.quantity) AS total_quantity
FROM books b
    JOIN sales s ON b.book_id = s.book_id
GROUP BY b.title,b.price
ORDER BY b.price DESC

-- Task 6
-- Write a query to display authors whose birth year is earlier than 
-- the average birth year of authors from their country and rank them 
-- within their country.

SELECT name, country, birth_year,
    RANK() OVER (partition by country order by birth_year) as ranking
from authors o
where birth_year > (select avg(birth_year)
from authors i
where i.country = o.country )

-- Task 7
-- Write a query to find the authors who have written books in both 
-- 'Fiction' and 'Romance' genres and group the results by author name.

SELECT a.name, b.genre
FROM authors a
    join books b on a.author_id = b.author_id
WHERE genre in ('Fiction', 'Romance')
GROUP BY a.name,b.genre
HAVING COUNT(distinct b.genre) = 2

-- Task 8
-- Write a query to find authors who have never written a book in the 
-- 'Fantasy' genre and group the results by country.

SELECT a.name, a.country, b.genre
FROM authors a
    join books b on a.author_id = b.author_id
WHERE genre not in ('Fantasy')
GROUP BY a.name,b.genre,a.country

-- Task 9
-- Write a query to find the books that have been sold in both January 
-- and February 2024 and group the results by book title.

SELECT b.title, s.sale_date
FROM books b
    JOIN sales s ON b.book_id = s.book_id
WHERE MONTH(sale_date) in (1,2) and YEAR(sale_date) = 2024
GROUP BY title,sale_date
ORDER BY sale_date

-- Task 10
-- Write a query to display the authors whose average book price is 
-- higher than every book price in the 'Fiction' genre and 
-- group the results by author name.

SELECT name, AVG(price)
FROM authors a
    JOIN books b ON a.author_id = b.author_id
GROUP BY a.name
HAVING AVG(price) > (select max(price)
from books
WHERE genre = 'Fiction')
ORDER BY AVG(price) DESC

-- Section 2: Questions
-- Task 1: Stored Procedure for Total Sales by Author
-- Create a stored procedure to get the total sales amount for a 
-- specific author and write a query to call the procedure for 
-- 'J.K. Rowling'.

go
ALTER PROCEDURE spTotalSaleByJKRowling
    @AuthorName VARCHAR(100)
AS
BEGIN
    SELECT a.name, SUM(total_amount) as TotalSales
    FROM authors a
        join books b ON a.author_id = b.author_id
        join sales s ON b.book_id = s.book_id
    where name = @AuthorName
    group by name
END
GO

EXEC spTotalSaleByJKRowling 'J.K. Rowling'

-- Task 2: Function to Calculate Total Quantity Sold for a Book
-- Create a function to calculate the total quantity sold for a 
-- given book title and write a query to use this function for '1984'.

SELECT *
FROM books
SELECT *
FROM authors
SELECT *
FROM sales

go
CREATE FUNCTION fnTotalQtySold()
RETURNS INT
BEGIN
    RETURN
    SELECT s.quantity
    from sales s
END
GO
-- Task 3: View for Best-Selling Books
-- Create a view to show the best-selling books 
-- (those with total sales amount above $30) and write a query to 
-- select from this view.

-- Task 4: Stored Procedure for Average Book Price by Author
-- Create a stored procedure to get the average price of books for a 
-- specific author and write a query to call the procedure for 
-- 'Mark Twain'.

-- Task 5: Function to Calculate Total Sales in a Month
-- Create a function to calculate the total sales amount in a given 
-- month and year, and write a query to use this function for 
-- January 2024.

-- Task 6: View for Authors with Multiple Genres
-- Create a view to show authors who have written books in multiple 
-- genres and write a query to select from this view.

-- Task 7: Ranking Authors by Total Sales
-- Write a query to rank authors by their total sales amount and 
-- display the top 3 authors.

-- Task 8: Stored Procedure for Top-Selling Book in a Genre
-- Create a stored procedure to get the top-selling book in a 
-- specific genre and write a query to call the procedure for 'Fantasy'.

-- Task 9: Function to Calculate Average Sales Per Genre
-- Create a function to calculate the average sales amount for 
-- books in a given genre and write a query to use this function 
-- for 'Romance'.