use jun14;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);


INSERT INTO departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'HR'),
(3, 'IT'),
(4, 'Finance');

INSERT INTO employees (employee_id, first_name, last_name, salary, department_id, manager_id) VALUES
(1, 'John', 'Doe', 60000, 1, NULL),
(2, 'Jane', 'Smith', 75000, 1, 1),
(3, 'Emily', 'Jones', 50000, 2, NULL),
(4, 'Michael', 'Brown', 55000, 2, 3),
(5, 'Chris', 'Wilson', 95000, 3, NULL),
(6, 'Sarah', 'Taylor', 40000, 3, 5),
(7, 'David', 'Lee', 105000, 3, 5),
(8, 'Paul', 'Walker', 120000, 4, NULL),
(9, 'Laura', 'Hall', 110000, 4, 8);

select * from employees;
select * from departments;

-- find all the employees who earn more than all employees in the 'sales' department
select employee_id,concat(first_name, last_name) as employee_name, salary from employees 
where salary > (select max(salary) from employees where department_id = (select department_id from departments where department_name = 'Sales'))
;

select employee_id,concat(first_name, last_name) as employee_name, salary from employees 
where salary > ALL(select salary from employees where department_id = (select department_id from departments where department_name = 'Sales'))
;

-- find all employees who earn more than any employee in the 'HR' department.

select * from employees;
select * from departments;

select employee_id,concat(first_name, last_name) as employee_name, salary from employees 
where salary > (select min(salary) from employees where department_id = (select department_id from departments where department_name = 'HR'))
;

 
-- Task: List all departments that have at least one employee with a salary greater than $50,000.

select distinct department_name from employees e inner join departments d
on d.department_id = e.department_id
where salary > 50000;
 
-- Task: Find employees whose salary is higher than the average salary of all employees in their department.

select * from employees;
select * from departments;
select department_id,avg(Salary) from employees group by department_id

select * from employees o 
where salary > all(select avg(Salary) 
						from employees as i 
							where i.department_id = o.department_id) 
 
-- Task: List all employees who have a manager in the same department.
select * from employees;

select employee_id,concat(first_name,' ', last_name) as employee_name,salary,department_id from employees

select * from employees where manager_id is not null

SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.manager_id IS NOT NULL
  AND e.department_id = (
    SELECT department_id
    FROM employees
    WHERE employee_id = e.manager_id
  );
