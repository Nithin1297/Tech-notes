Create DATABASE JSON_Data;
Go
USE JSON_Data;
Go
CREATE TABLE Employees
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeInfo NVARCHAR(MAX)
    -- This column will store JSON data
);
INSERT INTO Employees
    (EmployeeInfo)
VALUES
    (N'{"name": "John Doe 😁", "age": 30, "skills": ["SQL", "C#"] }'),
    (N'{"name": "Jane Smith", "age": 25, "skills": ["JavaScript", "HTML"] }'),
    (N'{"name": "Jim Beam", "age": 40, "skills": ["Management", "SQL"] }');


SELECT JSON_VALUE(EmployeeInfo, '$.name') AS Name,
    JSON_VALUE(EmployeeInfo, '$.age') AS Age,
    JSON_QUERY(EmployeeInfo, '$.skills') AS Skills
from Employees
where JSON_VALUE(EmployeeInfo, '$.age') > 30
 

 select * from Employees

 UPDATE Employees
 SET EmployeeInfo = JSON_MODIFY(EmployeeInfo, '$.age', 36)
 WHERE JSON_VALUE(EmployeeInfo, '$.name') = 'Jane Smith'
 