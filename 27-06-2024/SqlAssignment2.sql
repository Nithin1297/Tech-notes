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

-- drop table sales
-- drop TABLE books
-- drop TABLE authors

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

GO
CREATE FUNCTION GetTotalQuantitySold
    (@BookTitle VARCHAR(200))
RETURNS INT
AS
BEGIN
    DECLARE @TotalQuantity INT;
    SELECT @TotalQuantity = SUM(s.quantity)
    FROM books b
        JOIN sales s ON b.book_id = s.book_id
    WHERE b.title = @BookTitle;
    RETURN @TotalQuantity;
END;
GO

SELECT dbo.GetTotalQuantitySold('1984');

-- Task 3: View for Best-Selling Books
-- Create a view to show the best-selling books 
-- (those with total sales amount above $30) and write a query to 
-- select from this view.

GO
CREATE VIEW vwBestSellingBooks
AS
    SELECT b.title, SUM(s.total_amount) AS TotalSalesAmount
    from books b
        JOIN sales s ON b.book_id = s.book_id
    GROUP BY b.title
    HAVING SUM(s.total_amount) > 30
GO

SELECT *
FROM vwBestSellingBooks

-- Task 4: Stored Procedure for Average Book Price by Author
-- Create a stored procedure to get the average price of books for a 
-- specific author and write a query to call the procedure for 
-- 'Mark Twain'.

GO
ALTER PROC spAverageBookPricebyAuthor
    @Author VARCHAR(100)
AS
BEGIN
    SELECT a.name, AVG(b.price) AS AverageBookPrice
    FROM books b
        JOIN authors a ON a.author_id = b.author_id
    WHERE a.name = @Author
    GROUP BY a.name
END
GO

EXEC spAverageBookPricebyAuthor 'Mark Twain'

-- Task 5: Function to Calculate Total Sales in a Month
-- Create a function to calculate the total sales amount in a given 
-- month and year, and write a query to use this function for 
-- January 2024.

GO
ALTER FUNCTION calculatethetotalsalesamount(@month INT,@year INT)
RETURNS INT
AS
BEGIN
    DECLARE @Totalsales INT
    SELECT @Totalsales = SUM(s.total_amount)
    FROM sales s
    WHERE MONTH(s.sale_date) = @month AND YEAR(s.sale_date) = @year
    RETURN @Totalsales
END
GO

SELECT dbo.calculatethetotalsalesamount(1,2024)

-- Task 6: View for Authors with Multiple Genres
-- Create a view to show authors who have written books in multiple 
-- genres and write a query to select from this view.

GO
CREATE VIEW vwAuthorswithMultipleGenres
AS
    SELECT a.name, b.genre
    FROM authors a
        JOIN books b ON a.author_id = b.author_id
    GROUP BY a.name, b.genre
    HAVING COUNT(DISTINCT b.genre) > 1;
GO

SELECT *
FROM vwAuthorswithMultipleGenres

-- Task 7: Ranking Authors by Total Sales
-- Write a query to rank authors by their total sales amount and 
-- display the top 3 authors.

GO
WITH
    RankingAuthorsbyTotalSales
    AS
    (
        SELECT a.name, SUM(s.total_amount) AS totalamount,
            DENSE_RANK() OVER (order by SUM(s.total_amount) desc) AS Ranking
        FROM authors a
            JOIN books b ON a.author_id = b.author_id
            JOIN sales s ON b.book_id = s.book_id
        GROUP BY a.name
    )
GO

SELECT *
FROM RankingAuthorsbyTotalSales
WHERE Ranking IN(1,2,3)

-- Task 8: Stored Procedure for Top-Selling Book in a Genre
-- Create a stored procedure to get the top-selling book in a 
-- specific genre and write a query to call the procedure for 'Fantasy'.

GO
CREATE PROC spTopSellingBookinaGenre
    @genre VARCHAR(100)
AS
BEGIN
    SELECT Top(1)
        b.title, SUM(s.total_amount) AS total_sales
    from authors a
        JOIN books b ON a.author_id = b.author_id
        JOIN sales s ON b.book_id = s.book_id
    WHERE b.genre = @genre
    GROUP BY b.title
    ORDER by SUM(s.total_amount) DESC
END
GO

EXEC spTopSellingBookinaGenre 'Fantasy'

-- Task 9: Function to Calculate Average Sales Per Genre
-- Create a function to calculate the average sales amount for 
-- books in a given genre and write a query to use this function 
-- for 'Romance'.

GO
ALTER FUNCTION GetAverageSalesPerGenre
    (@Genre VARCHAR(50))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @AverageSales DECIMAL(10,2);
    SELECT @AverageSales = AVG(s.total_amount)
    FROM books b
        JOIN sales s ON b.book_id = s.book_id
    WHERE b.genre = @Genre
    GROUP BY b.title
    RETURN @AverageSales;
END;
GO

SELECT dbo.GetAverageSalesPerGenre('Romance');

-- Section 3: Stored Procedures with Transactions and Validations

-- 1.Add New Book and Update Author's Average Price

-- Create a stored procedure that adds a new book and updates the 
-- average price of books for the author. Ensure the price is positive, 
-- use transactions to ensure data integrity, and return the new 
-- average price.

GO
ALTER PROC spAddNewBookAndUpdateAuthorPrice
    @book_id INT,
    @title VARCHAR(50),
    @author_id INT,
    @genre VARCHAR(50),
    @price DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
    SET NOCOUNT ON;
    IF (@price <= 0)
        THROW 50000,'Price Must Be Grater than 0.',1;
    BEGIN TRANSACTION
    INSERT into books
    VALUES(@book_id, @title, @author_id, @genre, @price)

    DECLARE @NewAveragePrice DECIMAL(10,2);
    SELECT @NewAveragePrice = AVG(price)
    FROM books
    WHERE author_id = @author_id;
    COMMIT TRANSACTION
    END TRY

    BEGIN CATCH
    SELECT
        ERROR_NUMBER() AS ErrorNumber   
        , ERROR_STATE() AS ErrorState 
        , ERROR_MESSAGE() AS ErrorMessage;  
    END CATCH

    SELECT @NewAveragePrice AS new_average_price;
END
GO

EXEC spAddNewBookAndUpdateAuthorPrice 6,'Kalki',2,'Mythology',50

-- 2.Delete Book and Update Author's Total Sales

-- Create a stored procedure that deletes a book and updates the 
-- author's total sales. Ensure the book exists, use transactions 
-- to ensure data integrity, and return the new total sales for the author.

GO
ALTER PROC spDeleteBookandUpdateAuthorsTotalSales
    @BookId INT
AS
BEGIN
    BEGIN TRY

    SET NOCOUNT ON;
    DECLARE @AuthorId INT,@TotalSales DECIMAL(10,2);

    BEGIN TRANSACTION

    SELECT @AuthorId = author_id
    FROM books
    WHERE book_id = @BookId;
    IF @AuthorId IS NULL
    THROW 50000,'Book not exist.',1;
    
    Delete from sales 
    WHERE book_id = @BookId

    DELETE from books 
    WHERE book_id = @BookId

    SELECT @TotalSales = SUM(s.total_amount)
    FROM sales s
        JOIN books b ON s.book_id = b.book_id
    WHERE b.author_id = @AuthorId;

    COMMIT TRANSACTION
    END TRY

    BEGIN CATCH
    SELECT
        ERROR_NUMBER() AS ErrorNumber   
        , ERROR_STATE() AS ErrorState 
        , ERROR_MESSAGE() AS ErrorMessage;  
    END CATCH

    SELECT @TotalSales AS TotalSalesOfAuthor
END
GO

EXEC spDeleteBookandUpdateAuthorsTotalSales 5

-- 3.Transfer Book Sales to Another Book

-- Create a stored procedure that transfers sales from one book to 
-- another and updates the total sales for both books. Ensure 
-- both books exist, use transactions to ensure data integrity, 
-- and return the new total sales for both books.

go
CREATE PROCEDURE TransferBookSales
    @SourceBookId INT,
    @TargetBookId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SourceAuthorId INT, @TargetAuthorId INT;

    BEGIN TRANSACTION;

    SELECT @SourceAuthorId = author_id
    FROM books
    WHERE book_id = @SourceBookId;

    SELECT @TargetAuthorId = author_id
    FROM books
    WHERE book_id = @TargetBookId;

    IF @SourceAuthorId IS NULL OR @TargetAuthorId IS NULL
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('One or both books do not exist', 16, 1);
        RETURN;
    END;

    UPDATE sales
    SET book_id = @TargetBookId
    WHERE book_id = @SourceBookId;

    DECLARE @SourceTotalSales DECIMAL(10,2), @TargetTotalSales DECIMAL(10,2);

    SELECT @SourceTotalSales = SUM(s.total_amount)
    FROM sales s
        JOIN books b ON s.book_id = b.book_id
    WHERE b.book_id = @SourceBookId;

    SELECT @TargetTotalSales = SUM(s.total_amount)
    FROM sales s
        JOIN books b ON s.book_id = b.book_id
    WHERE b.book_id = @TargetBookId;

    COMMIT TRANSACTION;

    SELECT @SourceTotalSales AS source_total_sales, @TargetTotalSales AS target_total_sales;
END;
GO

EXEC TransferBookSales 1,2

-- 4.Add Sale and Update Book Quantity

-- Create a stored procedure that adds a sale and updates the total 
-- quantity sold for the book. Ensure the quantity is positive, 
-- use transactions to ensure data integrity, and return the new 
-- total quantity sold for the book.

go
ALTER procedure spupdatebookquantity
    @book_id int,
    @quantity int
as
begin
    Begin Transaction;
    begin try
     if @quantity<=0
	  Throw 60000,'quantity is negative',2;
	 update sales
	 set quantity = quantity + @quantity
	 where book_id = @book_id

     DECLARE @price DECIMAL(10,2)
     select @price = price
    from books
    WHERE book_id = @book_id
     
     update sales
	 set total_amount = quantity * @price
	 where book_id = @book_id
commit Transaction;
	SELECT *
    FROM sales
    WHERE book_id = @book_id;
end try
begin catch
  Rollback Transaction;
  print concat('error message',Error_message());
end catch
end;
GO

Exec spupdatebookquantity @book_id = 2,@quantity =1

 

-- 5.Update Book Price and Recalculate Author's Average Price

-- Create a stored procedure that updates the price of a book and 
-- recalculates the average price of books for the author. Ensure 
-- the price is positive, use transactions to ensure data integrity, 
-- and return the new average price.

 go
create procedure upt_price_cal_avg
    @newbookid int ,
    @newprice decimal(10,2) ,
    @newauthorid int
as
begin
    begin Transaction;
    begin try
  if @newprice<0
    Throw 60000,'price is negative',1;
   update books
   set price = @newprice
   where book_id = @newbookid
 
commit Transaction;
   select a.author_id , avg(b.price)
    from authors a
        join books b
        on a.author_id = b.author_id
    where a.author_id = @newauthorid
    group by a.author_id;
end try
begin catch
Rollback Transaction;
print concat('error message',Error_message());
end catch
end;
GO

EXEC upt_price_cal_avg @newbookid = 2, @newprice = 40.00, @newauthorid = 2;


-- Section 4: Advanced SQL Concepts
-- 1.Inline Table-Valued Function (iTVF)

-- Create an inline table-valued function that returns the total sales amount 
-- for each book and use it in a query to display the results.

GO
CREATE FUNCTION returnsthetotalsalesamount()
RETURNS TABLE
AS
RETURN
(
    SELECT b.title, SUM(s.total_amount) AS total_sales
FROM books b
    JOIN sales s ON b.book_id = s.book_id
GROUP BY b.title
);
GO

SELECT *
FROM returnsthetotalsalesamount();

-- 2.Multi-Statement Table-Valued Function (MTVF)

-- Create a multi-statement table-valued function that returns the 
-- total quantity sold for each genre and use it in a query to display the results.

GO
CREATE FUNCTION returnsthetotalsalesamount1()
RETURNS @GenreSales TABLE(
    genre VARCHAR(50),
    Toatl_Quantity INT
)
AS
BEGIN
    INSERT into @GenreSales
    SELECT b.genre, SUM(s.quantity) AS Toatl_Quantity
    FROM books b
        JOIN sales s ON b.book_id = s.book_id
    GROUP BY b.genre
    RETURN
END
GO

SELECT *
FROM dbo.returnsthetotalsalesamount1()

-- 3.Scalar Function

-- Create a scalar function that returns the average price of books for a 
-- given author and use it in a query to display the average price for 'Jane Austen'.

GO
CREATE FUNCTION averagepriceofbooks(@AuthorName VARCHAR(30))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @AvgPrice DECIMAL(10,2)
    SELECT @AvgPrice = AVG(price)
    FROM books b
        JOIN authors a ON a.author_id = b.author_id
    WHERE a.name = @AuthorName

    RETURN @AvgPrice;
end
GO

SELECT dbo.averagepriceofbooks('Jane Austen')

-- 4.Stored Procedure for Books with Minimum Sales

-- Create a stored procedure that returns books with total sales above a 
-- specified amount and use it to display books with total sales above $40.

go
CREATE PROC GetBooksWithMinimumSales
    @Amount INT
AS
BEGIN
    SELECT title, SUM(s.total_amount) as TotalSales
    from books b
        JOIN sales s ON b.book_id = s.book_id
    GROUP BY title
    HAVING SUM(s.total_amount) > @Amount
END
GO

Exec GetBooksWithMinimumSales 40

-- 5.Indexing for Performance Improvement

-- Create an index on the sales table to improve query performance for 
-- queries filtering by book_id.

CREATE INDEX IX_Sales_BookId ON sales(book_id);

-- 6.Export Data as XML

-- Write a query to export the authors and their books as XML.

SELECT
    a.name AS [@name],
    a.country AS [@country],
    a.birth_year AS [@birth_year],
    (
        SELECT
        b.title AS [book]
    FROM books b
    WHERE b.author_id = a.author_id
    FOR XML PATH(''), TYPE
    ) AS books
FROM authors a
-- FOR XML PATH('author'), ROOT('authors');

-- 7.Export Data as JSON

-- Write a query to export the authors and their books as JSON.



SELECT
    a.name AS [@name],
    a.country AS [@country],
    a.birth_year AS [@birth_year],
    (
SELECT
        b.title AS [book]
    FROM books b
    WHERE b.author_id = a.author_id
    FOR json PATH
) AS books
FROM authors a
-- FOR JSON PATH, ROOT('authors');


-- 8.Scalar Function for Total Sales in a Year

-- Create a scalar function that returns the total sales amount in a 
-- given year and use it in a query to display the total sales for 2024.

GO
CREATE FUNCTION TotalSalesinaYear(@Yearr int)
RETURNS DECIMAL(10,3)
AS
BEGIN
    DECLARE @TotalSales DECIMAL(10,3)
    SELECT @TotalSales = sum(total_amount)
    FROM sales
    WHERE YEAR(sale_date) = @Yearr
    RETURN @TotalSales
END
GO

SELECT dbo.TotalSalesinaYear(2024)
-- 9.Stored Procedure for Genre Sales Report

-- Create a stored procedure that returns a sales report for a specific genre, 
-- including total sales and average sales, and use it to display the 
-- report for 'Fiction'.

GO
CREATE PROCEDURE GenreSalesReport
    @genre VARCHAR(30)
AS
SELECT genre, SUM(total_amount) as summation, AVG(total_amount) as average
FROM sales s
    JOIN books b ON b.book_id = s.book_id
WHERE genre = @genre
GROUP BY genre
GO

EXEC GenreSalesReport 'Fiction'
-- 10.Ranking Books by Average Rating (assuming a ratings table)

-- Write a query to rank books by their average rating and display the top 3 books. 
-- Assume a ratings table with book_id and rating columns.

create table ratings
(
    ratings int,
    book_id int,
    foreign key(book_id) references books(book_id)
)
insert into ratings
values(4, 1),
    (5, 2),
    (3, 3),
    (4, 4);
insert into ratings
values(5, 1);

SELECT *
FROM books
SELECT *
FROM ratings

select Top 3
    book_id ,
    DENSE_RANK() over(order by avg(ratings) desc) as ranking
from ratings
group by book_id;

-- Section 5: Questions for Running Total and Running Average with OVER Clause
-- Running Total of Sales Amount by Book

-- 1.Create a view that displays each sale for a book along with the running total 
-- of the sales amount using the OVER clause.
-- Running Total of Sales Quantity by Author

go
CREATE VIEW BookSalesRunningTotal
AS
    SELECT b.title, s.total_amount,
        SUM(s.total_amount) OVER (PARTITION BY b.book_id ORDER BY b.title ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as Running_Total
    from books b
        JOIN sales s on b.book_id = s.book_id
go

SELECT *
FROM BookSalesRunningTotal

-- 2.Create a view that displays each sale for an author along with the running total 
-- of the sales quantity using the OVER clause.
-- Running Total and Running Average of Sales Amount by Genre

go
CREATE VIEW AuthorSalesRunningTotal
AS
    SELECT name,
        sum(quantity) OVER (partition by name ORDER BY quantity DESC) AS Qty_Total,
        sum(total_amount) OVER (partition by name ORDER BY total_amount DESC) AS total_amount,
        avg(total_amount) OVER (partition by name ORDER BY total_amount DESC) AS AVG_total_amount
    FROM authors a
        JOIN books b ON a.author_id = b.author_id
        JOIN sales s ON b.book_id = s.book_id
GO

SELECT
    *
FROM AuthorSalesRunningTotal

-- 3.Create a view that displays each sale for a genre along with both the 
-- running total and the running average of the sales amount using the OVER clause.

go
CREATE VIEW GenreSalesRunningTotalAndAverage
AS
    SELECT genre,
        sum(total_amount) OVER (partition by genre ORDER BY total_amount DESC) AS total_amount,
        avg(total_amount) OVER (partition by genre ORDER BY total_amount DESC) AS AVG_total_amount
    FROM authors a
        JOIN books b ON a.author_id = b.author_id
        JOIN sales s ON b.book_id = s.book_id
GO

SELECT *
FROM GenreSalesRunningTotalAndAverage

-- Section 6: Triggers
-- 1.Trigger to Update Total Sales After Insert on Sales Table

-- Create a trigger that updates the total sales for a book in the books table 
-- after a new record is inserted into the sales table.
GO
create trigger t_sales_upd
on sales
after insert 
as
begin
    update b
set b.price = i.total_amount/i.quantity
from books b
        join inserted i
        on b.book_id = i.book_id
end
GO

select*
from books;

select*
from sales;

insert into sales
values(11, 1, '2024-01-09', 4, 120);

select*
from books;

-- 2.Trigger to Log Deletions from the Sales Table

-- Create a trigger that logs deletions from the sales table into a sales_log table 
-- with the sale_id, book_id, and the delete_date.

CREATE TABLE sales_log
(
    sale_id INT,
    book_id int,
    delete_date date
)
SELECT *
FROM sales_log

go
CREATE TRIGGER LogSalesDelete
ON sales
After DELETE
as
BEGIN
    SET NOCOUNT ON;
    INSERT into sales_log
    SELECT d.sale_id, d.book_id, GETDATE()
    FROM deleted d;
END
GO

DELETE from sales WHERE sale_id = 5

-- 3.Trigger to Prevent Negative Quantity on Update

-- Create a trigger that prevents updates to the sales table if the new quantity 
-- is negative.

SELECT *
FROM books
SELECT *
FROM authors
SELECT *
FROM sales

go
ALTER TRIGGER PreventNegativeQuantity
ON sales
for update
as
BEGIN
    IF exists (SELECT 1
    FROM sales
    WHERE quantity < 0)
    RAISERROR('Quantity cannot be negative ', 16, 1);
    ROLLBACK TRANSACTION;
END
GO

UPDATE sales
set quantity = -10
WHERE sale_id = 4