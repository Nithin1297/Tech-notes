Create database proceduress
use proceduress
drop TABLE Employees

-- Create Departments table
CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(50)
);

-- Insert sample departments
INSERT INTO Departments
    (DepartmentID, DepartmentName)
VALUES
    (1, 'HR'),
    (2, 'IT'),
    (3, 'Finance'),
    (4, 'Marketing');

-- Create Employees table with a foreign key to Departments
CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    Salary DECIMAL(18, 2),
    HireDate DATE
);

-- Insert sample employees
INSERT INTO Employees
    (EmployeeID, FirstName, LastName, DepartmentID, Salary, HireDate)
VALUES
    (1, 'John', 'Doe', 1, 50000, '2020-01-01'),
    (2, 'Jane', 'Smith', 2, 75000, '2021-03-15'),
    (3, 'Jim', 'Brown', 3, 60000, '2019-07-23'),
    (4, 'Jake', 'White', 4, 45000, '2022-05-30'),
    (5, 'Jill', 'Black', 2, 80000, '2023-02-11');

SELECT *
FROM Departments
SELECT *
FROM Employees

-- Task-1: Check if the department exist first if no then error 'No such Department exists' 
-- if yes then commit the changes

GO
ALTER PROC AddEmployee
    @EmployeeID INT,
    @FirstName NVARCHAR(30),
    @LastName NVARCHAR(30),
    @DepartmentID INT,
    @Salary INT,
    @HireDate DATE
AS
BEGIN

    BEGIN TRANSACTION
    BEGIN TRY

    IF not EXISTS (SELECT 1
    FROM Departments
    WHERE DepartmentID = @DepartmentID)

    BEGIN
    THROW 50000, 'Department does not exist.', 1
    END

    INSERT into Employees
    VALUES(@EmployeeID , @FirstName , @LastName , @DepartmentID ,
            @Salary , @HireDate )
 
    END
    TRY

    BEGIN CATCH
    PRINT 'Department does not exist.'
    END CATCH
    COMMIT TRANSACTION
END
GO

EXEC AddEmployee @EmployeeID = 6, 
@FirstName = 'Anna', @LastName = 'Green', @DepartmentID = 1000, 
@Salary = 55000, @HireDate = '2024-06-01';


-- Task 2
-- Create a Stored Procedure to Update Employee Information 
-- with Salary Validation, Department Validation
 
-- Make sure the salary should only increase in the range of 10% to 30% 
-- of their current salary 

GO
ALTER PROC UpdateEmployeeInfo
    @EmployeeID INT,
    @NewFirstName NVARCHAR(30),
    @NewLastName NVARCHAR(30),
    @NewDepartmentID INT,
    @NewSalary INT
AS
BEGIN

    BEGIN TRY
    BEGIN TRANSACTION
    DECLARE @sal INT
    select @sal = Salary
    from Employees
    WHERE EmployeeID = @EmployeeID

    IF not EXISTS (SELECT 1
    FROM Employees
    WHERE EmployeeID = @EmployeeID)
        THROW 50000, 'Employee does not exist.', 1;

     IF not EXISTS (select *
    from Employees
    where @NewSalary BETWEEN (@sal + @sal * 0.1) and (@sal + @sal * 0.3))
     THROW 50000, 'Salary Increment is not in range of 10 and 30.', 1;

        UPDATE Employees
        SET FirstName =  @NewFirstName , LastName = @NewLastName ,DepartmentID = @NewDepartmentID ,
        Salary = @NewSalary 
        WHERE EmployeeID =  @EmployeeID
   COMMIT TRANSACTION
    END
    TRY

    BEGIN CATCH
     rollback TRANSACTION 
     print Error_message(); 
     print Error_state(); 
     print Error_number() ; 
    END CATCH

END
GO


EXEC UpdateEmployeeInfo @EmployeeID = 30, @NewFirstName = 'James', @NewLastName = 'Brown', @NewDepartmentID = 2, @NewSalary = 65000;


-- Task 3
-- Extening the logic of Task 2 also log the transfer that has happened 
-- incase of department change in Transfers table

Transfers
(EmployeeID, OldDepartmentID, NewDepartmentID, TransferDate)


GO
ALTER PROC UpdateEmployeeInfo
    @EmployeeID INT,
    @NewFirstName NVARCHAR(30),
    @NewLastName NVARCHAR(30),
    @NewDepartmentID INT,
    @NewSalary INT
AS
BEGIN


    BEGIN TRY
    BEGIN TRANSACTION
    DECLARE @sal INT
    select @sal = Salary
    from Employees
    WHERE EmployeeID = @EmployeeID

    IF not EXISTS (SELECT 1
    FROM Employees
    WHERE EmployeeID = @EmployeeID)
        THROW 50000, 'Employee does not exist.', 1;

     IF not EXISTS (select *
    from Employees
    where @NewSalary BETWEEN (@sal + @sal * 0.1) and (@sal + @sal * 0.3))
     THROW 50000, 'Salary Increment is not in range of 10 and 30.', 1;

     IF Exists (select *
    from Departments
    where @NewDepartmentID = DepartmentID)
      
DECLARE @oldDep INT
SET @oldDep = (select d.DepartmentID
    FROM Employees e
        JOIN Departments d on d.DepartmentID = e.DepartmentID
    WHERE e.EmployeeID = @EmployeeID)

 UPDATE Employees
        SET FirstName =  @NewFirstName , LastName = @NewLastName ,DepartmentID = @NewDepartmentID ,
        Salary = @NewSalary 
        WHERE EmployeeID =  @EmployeeID

    INSERT into Transfers
    VALUES(@EmployeeID, @oldDep, @NewDepartmentID, GETDATE())
   COMMIT TRANSACTION
    END
    TRY

    BEGIN CATCH
     rollback TRANSACTION 
     print Error_message(); 
     print Error_state(); 
     print Error_number() ; 
    END CATCH

END
GO

EXEC UpdateEmployeeInfo @EmployeeID = 3, @NewFirstName = 'James', @NewLastName = 'Brown', @NewDepartmentID = 2, @NewSalary = 70000;

SELECT *
FROM Employees
SELECT *
FROM Transfers
DROP TABLE Transfers

-- Task 4
-- Reverting an Employee Transfer




-- `EXEC RevertLastTransfer @EmployeeID = 2`


-- User defined Data types
create TYPE PhoneNumber FROM VARCHAR(15) NOT NULL

CREATE Table Customer
(
    ContactID int PRIMARY KEY,
    Name VARCHAR(50),
    Phone PhoneNumber
)

insert into Customer
VALUES(
        1, 'Nithin', '25463461'
)
SELECT *
FROM Customer

-- Querying the xml document without creating the table

DECLARE @xmlDoc INT;
DECLARE @xmlData NVARCHAR(MAX);

-- 1. Assign XML data to a variable
SET @xmlData = 
'<Books>
<Book id="1">
<Title>SQL for Beginners</Title>
<Author>John Doe</Author>
<Price>29.99</Price>
</Book>
<Book id="2">
<Title>Advanced SQL</Title>
<Author>Jane Smith</Author>
<Price>49.99</Price>
</Book>
</Books>';

-- 2. Parse the XML document
EXEC sp_xml_preparedocument @xmlDoc OUTPUT, @xmlData;

-- 3. Query the XML data using OPENXML
SELECT *
FROM OPENXML(@xmlDoc, '/Books/Book', 1)
WITH (
    id INT '@id',
    Title NVARCHAR(100) 'Title',
    Author NVARCHAR(100) 'Author',
    Price DECIMAL(10,2) 'Price'
);

-- Clear the memory
EXEC sp_xml_removedocument @xmlDoc;

