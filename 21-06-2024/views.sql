create database viewdb
use viewdb

CREATE TABLE Movies
(
    MovieID INT PRIMARY KEY,
    Title NVARCHAR(100),
    ReleaseYear INT,
    Director NVARCHAR(100),
    Genre NVARCHAR(50),
    Budget DECIMAL(18, 2),
    BoxOffice DECIMAL(18, 2)
);

CREATE TABLE Actors
(
    ActorID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    BirthDate DATE
);

CREATE TABLE MovieActors
(
    MovieID INT,
    ActorID INT,
    Role NVARCHAR(100),
    PRIMARY KEY (MovieID, ActorID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (ActorID) REFERENCES Actors(ActorID)
);
-- Movies
INSERT INTO Movies
    (MovieID, Title, ReleaseYear, Director, Genre, Budget, BoxOffice)
VALUES
    (1, 'Baahubali: The Beginning', 2015, 'S. S. Rajamouli', 'Action', 1800000000, 6500000000),
    (2, 'Baahubali: The Conclusion', 2017, 'S. S. Rajamouli', 'Action', 2500000000, 18000000000),
    (3, 'Sye', 2004, 'S. S. Rajamouli', 'Sports Drama', 120000000, 250000000),
    (4, 'Magadheera', 2009, 'S. S. Rajamouli', 'Fantasy', 400000000, 1500000000),
    (5, 'Arjun Reddy', 2017, 'Sandeep Reddy Vanga', 'Romance', 50000000, 510000000),
    (6, 'Rangasthalam', 2018, 'Sukumar', 'Drama', 60000000, 2160000000),
    (7, 'Maharshi', 2019, 'Vamsi Paidipally', 'Drama', 100000000, 1750000000),
    (8, 'Geetha Govindam', 2018, 'Parasuram', 'Romantic Comedy', 15000000, 1300000000),
    (9, 'Ala Vaikunthapurramuloo', 2020, 'Trivikram Srinivas', 'Action Comedy', 100000000, 2620000000),
    (10, 'Sarileru Neekevvaru', 2020, 'Anil Ravipudi', 'Action', 75000000, 2600000000);

-- Actors
INSERT INTO Actors
    (ActorID, FirstName, LastName, BirthDate)
VALUES
    (1, 'Prabhas', 'Raju', '1979-10-23'),
    (2, 'Rana', 'Daggubati', '1984-12-14'),
    (3, 'Ram', 'Charan', '1985-03-27'),
    (4, 'Vijay', 'Deverakonda', '1989-05-09'),
    (5, 'Mahesh', 'Babu', '1975-08-09'),
    (6, 'Allu', 'Arjun', '1983-04-08'),
    (7, 'Samantha', 'Akkineni', '1987-04-28'),
    (8, 'Pooja', 'Hegde', '1990-10-13'),
    (9, 'Rashmika', 'Mandanna', '1996-04-05'),
    (10, 'Anushka', 'Shetty', '1981-11-07');

-- MovieActors
INSERT INTO MovieActors
    (MovieID, ActorID, Role)
VALUES
    (1, 1, 'Baahubali'),
    (1, 2, 'Bhallaladeva'),
    (2, 1, 'Baahubali'),
    (2, 2, 'Bhallaladeva'),
    (4, 3, 'Kala Bhairava'),
    (5, 4, 'Arjun Reddy'),
    (7, 5, 'Rishi'),
    (9, 6, 'Bantu'),
    (10, 5, 'Ajay Krishna'),
    (9, 8, 'Ammu');


select *
from Movies
select *
from Actors
select *
from MovieActors

-- Exercise 1: View for Movies Released After 2015
-- Task: Create a view named ViewMoviesAfter2015 that selects movies released after the year 2015.

create view ViewMoviesAfter2015
AS
    Select *
    from Movies
    where ReleaseYear > 2015

select *
from ViewMoviesAfter2015
order by ReleaseYear

-- Exercise 2: View for High Box Office Movies
-- Task: Create a view named ViewHighBoxOfficeMovies that selects movies with a box office collection 
--greater than 1 billion.

create view ViewHighBoxOfficeMovies
as
    select *
    from Movies
    where BoxOffice > 1000000000

select *
from ViewHighBoxOfficeMovies

-- Exercise 3: View for Actor Details in Movies
-- Task: Create a view named ViewActorDetailsInMovies that joins Movies and Actors through MovieActors 
-- and shows movie titles and actor names.

create view ViewActorDetailsInMovies
as
    select Title, concat(FirstName,' ',LastName) as Names
    from Movies m
        Join MovieActors ma On m.MovieID = ma.MovieID
        Join Actors a on a.ActorID = ma.ActorID

select *
from ViewActorDetailsInMovies

-- Exercise 4: View for Top Grossing Movies per Genre
-- Task: Create a view named ViewTopGrossingMoviesPerGenre that shows the highest-grossing movie in each genre.

select *
from Movies

create view ViewTopGrossingMoviesPerGenre
as
    With
        gross
        AS
        (
            SELECT Title, Genre, Budget
, Rank() OVER(PARTITION BY Genre ORDER BY BoxOffice DESC) as ranking
            from Movies
        )
    select *
    from gross
    where ranking = 1


select Title, Genre, Budget
from ViewTopGrossingMoviesPerGenre

-- Exercise 5: View for Actor's Total Box Office Collection
-- Task: Create a view named ViewActorTotalBoxOffice that shows the total box office collection for each actor 
--across all their movies.
GO
Create view ViewActorTotalBoxOffice
as
    select concat(a.FirstName,' ',a.LastName) as Names , sum(m.BoxOffice) as TotalBoxoffice
    from Movies m
        Join MovieActors ma ON m.MovieID = ma.MovieID
        Join Actors a ON a.ActorID = ma.ActorID
    group by concat(a.FirstName,' ',a.LastName)
GO
select *
from ViewActorTotalBoxOffice

-- Exercise 6: View for Actor's Age and Movie Roles
-- Task: Create a view named ViewActorAgeAndRoles that shows each actor's age when acted that movie 
-- & also their current age and the roles they played in different movies.
GO
create function ActorAgeAtRelease(@releaseyear int , @age date)
returns int
begin
    return @releaseyear - year(@age)
end
GO
create function ActorAgeAtPresent(@dob date)
returns int
begin
    return year(getdate()) - year(@dob)
end
GO
drop function ActorAgeAtRelease
drop function ActorAgeAtPresent
GO
create view ViewActorAgeAndRoles
as
    select concat(a.FirstName,' ',a.LastName) as Names,
        m.ReleaseYear,
        dbo.ActorAgeAtRelease(m.ReleaseYear,a.BirthDate) as ActorAgeAtRelease,
        dbo.ActorAgeAtPresent(a.BirthDate) as ActorAgeAtPresent,
        m.Title,
        ma.Role
    from Movies m
        Join MovieActors ma ON m.MovieID = ma.MovieID
        Join Actors a ON a.ActorID = ma.ActorID
GO
select *
from ViewActorAgeAndRoles

select *
from Movies
select *
from Actors
select *
from MovieActors

-- Exercise 1: Scalar Function to Calculate Movie Age
-- Task: Create a scalar function named dbo.CalculateMovieAge that takes a MovieID and returns the age of the movie in years.
GO
create function CalculateMovieAge(@id int)
returns int
begin
    declare @releaseyear int
    select @releaseyear = ReleaseYear
    from Movies
    where MovieID = @id
    return year(getdate()) - @releaseyear
end
GO
select Title, ReleaseYear, dbo.CalculateMovieAge(MovieID) as [Movie Age]
from Movies

-- Exercise 2: Inline Table-Valued Function for Movies within Budget Range
-- Task: Create an inline table-valued function named dbo.GetMoviesByBudgetRange 
-- that takes MinBudget and MaxBudget and returns movies within that budget range.
go
create function GetMoviesByBudgetRange(@min Decimal(18,2),@max Decimal(18,2))
returns Table
As
RETURN(
    select *
from Movies
WHERE budget BETWEEN @min AND @max
);
GO

select *
from dbo.GetMoviesByBudgetRange(50000000,200000000)
-- Exercise 3: Multi-Statement Table-Valued Function for Top Actors by Movie Count
-- Task: Create a multi-statement table-valued function named dbo.GetTopActorsByMovieCount 
-- that returns actors who have acted in more than 2 movies.
GO
CREATE FUNCTION dbo.GetTopActorsByMovieCount()
RETURNS @TopActorsTable TABLE
(
    ActorID INT,
    FirstName NVARCHAR(30),
    LastName NVARCHAR(30),
    MovieCount int
)
AS
BEGIN

    insert into @TopActorsTable
    select a.ActorID, COUNT(*) as TotalCount, a.FirstName, a.LastName
    FROM Movies m
        Join MovieActors ma ON m.MovieID = ma.MovieID
        join Actors a on ma.ActorID = a.ActorID
    GROUP by a.ActorID, a.FirstName, a.LastName
    HAVING COUNT(*) = 2

    RETURN
END
GO
DROP FUNCTION dbo.GetTopActorsByMovieCount

SELECT *
FROM dbo.GetTopActorsByMovieCount()

SELECT *
FROM MovieActors
SELECT *
FROM Actors


-- Ex - 5
SELECT MovieID, a.ActorID, a.FirstName, a.LastName, COUNT(ma.Role) as TotRoles
from MovieActors ma
    JOIN Actors a ON a.ActorID = ma.ActorID
GROUP BY MovieID,a.ActorID,a.FirstName,a.LastName
HAVING COUNT(ma.Role) > 1

-- 1. Scalar
Go
Create Function dbo.CalculateAge(@ReleaseDate Int)
Returns Int
As
Begin
    Return Year(GetDate()) - @ReleaseDate;
End
Go

Select dbo.CalculateAge(2000);
 
 
-- 2. ITVF - Inline
Go
Create Function dbo.GetMovieByGenre(@Genre nvarchar(30))
returns table
As
Return(
Select *
from Movies
Where Genre = @Genre
)
Go

-- 3. MTVF
GO
Create Function dbo.GetMoviesAfter2015()
Returns @LatestDecadeMovies Table(Title varchar(100),
    ReleaseYear Int,
    Genre varchar(20))
As
Begin
    Insert Into @LatestDecadeMovies
    Select Title, ReleaseYear, Genre
    from Movies
    where ReleaseYear > 2015

    -- updates

    -- delete
    Return;
End
GO
Select *
from dbo.GetMoviesAfter2015()

Select *
from dbo.GetMovieByGenre('Action')
Select *
from dbo.GetMovieByGenre('Action Comedy')

select * ,
    case 
	when ReleaseYear >= 2020 then 'Latest'
	when ReleaseYear between 2010 and 2020 then 'Medium'
	when ReleaseYear < 2010 then 'Vintage'
	else 'old'
	end as Category
from Movies


-- Task 1: Categorize Movies Based on Box Office Collections
-- Task: Create a query to categorize movies into three groups based on their 
-- box office collections: 'Blockbuster', 'Hit', and 'Average'. Use the following criteria:

-- Blockbuster: BoxOffice > 10,000,000,000
-- Hit: BoxOffice between 1,000,000,000 and 10,000,000,000
-- Average: BoxOffice < 1,000,000,000

select Title , BoxOffice,
    case 
	when BoxOffice >= 10000000000 then 'Blockbuster'
	when BoxOffice between 1000000000 and 10000000000 then 'Hit'
	when BoxOffice <  1000000000 then 'Average'
	else 'Flop'
	end as Category
from Movies

-- Task 2: Determine Actor's Age Group
-- Task: Create a query to determine the age group of each actor based on their birth date. 
-- The age groups are 'Young' (age < 30), 'Middle-aged' (age between 30 and 50), and 'Senior' (age > 50).
select *
from Actors

GO
CREATE FUNCTION age(@BirthDate date)
RETURNS INT
BEGIN
    declare @days int,@result INT
    set @days = datediff(day,day(GETDATE()), @BirthDate)
    set @result floor(@days / 365)

    RETURN case 
	when @result < 30 then 'Young'
	when @result between 30 and 50 then 'Middle-aged'
	when @result >  50 then 'Senior'
	end
END
GO
drop function age

select concat(FirstName,' ',LastName) as Name, (GETDATE() - BirthDate) As age,
    case 
	when dbo.age(BirthDate) < 30 then 'Young'
	when dbo.age(BirthDate) between 30 and 50 then 'Middle-aged'
	when dbo.age(BirthDate) >  50 then 'Senior'
	end as Seniority
from Actors

select dbo.age('2002-05-30')

-- Task 3: Evaluate Movie Profitability
-- Task: Create a query to evaluate the profitability of each movie. 
-- Consider a movie 'Profitable' if BoxOffice > Budget and 'Not Profitable' if BoxOffice <= Budget.

select Title , Budget, BoxOffice,
    case 
	when BoxOffice > Budget then 'Profitable'
	when BoxOffice <= Budget then 'Not Profitable'
	end as Category
from Movies


select datediff(Year,GETDATE(),'2023-05-20')

-- Stored Procedures

Declare @OrderAmount Decimal(10, 2) = 1500.00

If @OrderAmount > 1000

Begin

    Print 'Applying 10% discount'

End

Else

Begin

    Print 'No Discount'

End

Declare @Counter Int = 10

While @Counter > 0

Begin

    Print @Counter

    Set @Counter = @Counter - 1

End
GO
CREATE PROCEDURE spGetMoviesByGenre
    @Genre VARCHAR(20)
as
BEGIN
    SELECT *
    FROM Movies
    WHERE Genre = @Genre
END

EXEC spGetMoviesByGenre 'Action'

EXECUTE spGetMoviesByGenre 'Action'
GO


-- 24th June 
-- Takes 2 mins to execute
Create Table Employees
(
    Id int primary key identity,
    [Name] nvarchar(50),
    Email nvarchar(50),
    Department nvarchar(50)
)
Go
SET NOCOUNT ON
Declare @counter int = 1
While(@counter <= 1000000)
Begin
    Declare @Name nvarchar(50) = 'ABC ' + RTRIM(@counter)
    Declare @Email nvarchar(50) = 'abc' + RTRIM(@counter) + '@proclink.com'
    Declare @Dept nvarchar(10) = 'Dept ' + RTRIM(@counter)
    Insert into Employees
    values
        (@Name, @Email, @Dept)
    Set @counter = @counter +1
    If(@Counter%100000 = 0)
		Print RTRIM(@Counter) + ' rows inserted'
End
--
SELECT *
FROM Employees
WHERE id = 789829
-- Index seek 1 row

SELECT *
FROM Employees
WHERE [Name] = 'ABC 893939'
-- Index scan all rows

EXEC sp_helpindex Employees

-- clustered (pk) (Decides table order)
-- 1. (pk)
-- 2. (decides table order)
-- 3. (only one per table)

-- non clustered 
-- 1. ( non pk)
-- 2. (not decides table order)
-- 3. (Many per table)


SELECT *
FROM Employees
WHERE [Name] = 'ABC 893939'
-- 10.68

CREATE INDEX inx on Employees(Name)

SELECT *
FROM Employees
WHERE [Name] = 'ABC 893939'
-- 0.0032

-- DROP INDEX inx on Employees

CREATE TABLE [tblEmployee]
(
    [Id] int Primary Key,
    [Name] nvarchar(50),
    [Salary] int,
    [Gender] nvarchar(10),
    [City] nvarchar(50)
)

Insert into tblEmployee
Values(3, 'John', 4500, 'Male', 'New York')
Insert into tblEmployee
Values(1, 'Sam', 2500, 'Male', 'London')
Insert into tblEmployee
Values(4, 'Sara', 5500, 'Female', 'Tokyo')
Insert into tblEmployee
Values(5, 'Todd', 3100, 'Male', 'Toronto')
Insert into tblEmployee
Values(2, 'Pam', 6500, 'Female', 'Sydney')

Select *
from tblEmployee

Create Clustered Index IX_tblEmployee_Gender_Salary
ON tblEmployee(Gender DESC, Salary ASC)

exec sp_helpindex tblEmployee

select
    Rank() over(Partition by Gender order by Salary desc) AS Ranking,
    *
from tblEmployee
order by Salary desc

-- Unique vs non-Unique Index

-- Select rows from a Table or View 'TableOrViewName' in schema 'SchemaName'
SELECT *
FROM Actors

BEGIN TRANSACTION
Update Actors 
set FirstName = 'Darling Prabhas'
WHERE ActorID = 11
COMMIT TRANSACTION

select *
from Actors
