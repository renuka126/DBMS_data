-- Creating Employee table

CREATE TABLE Employee
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary INT,
    Department VARCHAR(30)
);

-- Inserting records

INSERT INTO Employee VALUES (1, 'Arjun', 25000, 'HR');
INSERT INTO Employee VALUES (2, 'Karan', 30000, 'IT');
INSERT INTO Employee VALUES (3, 'Meera', 28000, 'Sales');
INSERT INTO Employee VALUES (4, 'Anjali', 35000, 'Finance');

-- Displaying original data

SELECT * FROM Employee;


-- Updating salary of employee with ID 2

UPDATE Employee
SET Salary = 35000
WHERE EmpID = 2;


-- Changing department of employee with ID 3

UPDATE Employee
SET Department = 'Marketing'
WHERE EmpID = 3;

-- Displaying updated data

SELECT * FROM Employee;