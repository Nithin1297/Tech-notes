create database multijoins
use multijoins

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(50),
    DepartmentID INT
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(50),
    LocationID INT
);

CREATE TABLE Locations (
    LocationID INT PRIMARY KEY,
    LocationName NVARCHAR(50)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName NVARCHAR(50),
    EmployeeID INT
);

CREATE TABLE Salaries (
    EmployeeID INT PRIMARY KEY,
    AnnualSalary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID) VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 103);

INSERT INTO Departments (DepartmentID, DepartmentName, LocationID) VALUES
(101, 'HR', 201),
(102, 'Engineering', 202),
(103, 'Marketing', 203);

INSERT INTO Locations (LocationID, LocationName) VALUES
(201, 'New York'),
(202, 'San Francisco'),
(203, 'Chicago');

INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(501, 'Project Alpha', 1),
(502, 'Project Beta', 2),
(503, 'Project Gamma', 3);

INSERT INTO Salaries (EmployeeID, AnnualSalary) VALUES
(1, 60000),
(2, 80000),
(3, 75000);

select * from Employees
select * from Departments
select * from Locations
select * from Projects
select * from Salaries

-- Exercise 1: Get employee names, their department, location, and salary

select EmployeeName,DepartmentName,LocationName,AnnualSalary 
from Employees e 
join Departments d  on d.DepartmentID = e.DepartmentID  
join Locations l on l.LocationID = d.LocationID
join Salaries s on e.EmployeeID = s.EmployeeID;

-- Exercise 2: Get all employees, their departments, their project details, and location

select * from Employees
select * from Departments
select * from Locations
select * from Projects

select e.EmployeeID,EmployeeName,d.DepartmentID,DepartmentName,l.LocationID,LocationName,ProjectID,ProjectName
from Employees e 
join Departments d  on d.DepartmentID = e.DepartmentID  
join Locations l on l.LocationID = d.LocationID
join Projects p on e.EmployeeID = p.EmployeeID;

-- Exercise 3: Get the total salary expenditure per department
select * from Employees
select * from Departments
select * from Locations
select * from Projects
select * from Salaries

select d.DepartmentID,DepartmentName,AnnualSalary as Expenditure
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
join Salaries s on e.EmployeeID = s.EmployeeID;

-- Exercise 4: List employees and their projects, including those without projects, along with their department and location

select * from Employees
select * from Departments
select * from Locations
select * from Projects

select e.EmployeeID,EmployeeName,d.DepartmentID,DepartmentName,l.LocationID,LocationName,ProjectID,ProjectName
from Employees e 
join Departments d  on d.DepartmentID = e.DepartmentID  
join Locations l on l.LocationID = d.LocationID
join Projects p on e.EmployeeID = p.EmployeeID
where p.ProjectID is null or p.ProjectID is not null;


-- Exercise 5:  Get the list of employees working in 'San Francisco' and their projects

select * from Employees
select * from Departments
select * from Locations
select * from Projects

select e.EmployeeID,EmployeeName,ProjectID,ProjectName 
from Employees e 
join Projects p on e.EmployeeID = p.EmployeeID
join Departments d on d.DepartmentID = e.DepartmentID
join Locations l on l.LocationID = d.LocationID
where l.LocationName = 'San Francisco'
