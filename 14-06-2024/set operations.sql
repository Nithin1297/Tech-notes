create database jun14_
use jun14_

CREATE TABLE Employees (
    EmployeeID INT,
    Name NVARCHAR(50),
    Department NVARCHAR(50),
    Role NVARCHAR(50)
);

CREATE TABLE Projects (
    ProjectID INT,
    ProjectName NVARCHAR(50),
    ProjectManagerID INT,
    Department NVARCHAR(50)
); 

CREATE TABLE Participations (
    EmployeeID INT,
    ProjectID INT
);

CREATE TABLE Contractors (
    ContractorID INT,
    Name NVARCHAR(50),
    Department NVARCHAR(50)
);

-- Insert Employees
INSERT INTO Employees (EmployeeID, Name, Department, Role) VALUES
(1, 'Alice', 'HR', 'Manager'),
(2, 'Bob', 'Engineering', 'Developer'),
(3, 'Charlie', 'Engineering', 'Manager'),
(4, 'David', 'HR', 'Recruiter'),
(5, 'Eve', 'Marketing', 'Designer'),
(6, 'Frank', 'Marketing', 'Manager');

-- Insert Projects
INSERT INTO Projects (ProjectID, ProjectName, ProjectManagerID, Department) VALUES
(101, 'HR Transformation', 1, 'HR'),
(102, 'Product Development', 2, 'Engineering'),
(103, 'Market Research', 6, 'Marketing'),
(104, 'Employee Onboarding', 1, 'HR');

-- Insert Participations
INSERT INTO Participations (EmployeeID, ProjectID) VALUES
(1, 101), (2, 102), (3, 102), (4, 104), (5, 103), (6, 103), (2, 104);

INSERT INTO Contractors (ContractorID, Name, Department) VALUES
(3, 'Charlie', 'Engineering'),
(4, 'David', 'Marketing'),
(5, 'Eve', 'Engineering'),
(6, 'Frank', 'HR');


select * from Projects
select * from Participations
select * from Employees
select * from Contractors

select EmployeeID,Name,Department from Employees
intersect
select ContractorID,Name,Department from Contractors

select "Name" from Employees
intersect
select "Name" from Contractors

select * from Employees
select * from Contractors
select "Name" from Employees
union
select "Name" from Contractors

select "Name" from Employees
union all
select "Name" from Contractors

select * from Employees
select * from Contractors
select "Name" from Employees
except
select "Name" from Contractors


select "Name" from Contractors
except
select "Name" from Employees

select * from Employees
select * from Participations
select * from Projects
select * from Contractors

select e.EmployeeID,e.Name,pa.ProjectID,pr.Department from Employees e
join Participations pa on e.EmployeeID = pa.EmployeeID
join Projects pr on pa.ProjectID = pr.ProjectID
where e.Name = 'Alice'

-- EMployees participating in the projects only with their departments

