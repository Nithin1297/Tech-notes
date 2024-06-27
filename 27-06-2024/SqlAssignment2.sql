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

SELECT *
FROM books
SELECT *
FROM authors
SELECT *
FROM sales


SELECT name,country, SUM(quantity)
FROM authors a
    JOIN books b ON a.author_id = b.author_id
    JOIN sales s ON b.book_id = s.book_id
GROUP BY country,name
HAVING SUM(quantity) > (select SUM(quantity) FROM sales)
ORDER BY SUM(quantity) DESC
