-- Create Database
CREATE DATABASE CompanyDB;

-- Use Database
USE CompanyDB;

-- Create Employee Table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert Sample Records

INSERT INTO Employee VALUES
(101, 'Rahul', 30000),
(102, 'Priya', 35000),
(103, 'Amit', 40000),
(104, 'Sneha', 45000);

-- Change Delimiter

DELIMITER $$

-- Create Procedure

CREATE PROCEDURE DisplayEmployeeDetails()
BEGIN
    -- Variables to store fetched data
    DECLARE emp_name VARCHAR(50);
    DECLARE emp_salary DECIMAL(10,2);

    -- Variable to check end of records
    DECLARE done INT DEFAULT FALSE;

    -- Cursor to fetch employee details
    DECLARE emp_cursor CURSOR FOR
        SELECT EmpName, Salary
        FROM Employee;

    -- Handler when no more rows are available
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;

    -- Open Cursor
    OPEN emp_cursor;

    read_data: LOOP

        -- Fetch one row at a time
        FETCH emp_cursor INTO emp_name, emp_salary;

        -- Exit loop if all rows are read
        IF done THEN
            LEAVE read_data;
        END IF;

        -- Display employee details
        SELECT
            emp_name AS Employee_Name,
            emp_salary AS Salary;

    END LOOP;

    -- Close Cursor
    CLOSE emp_cursor;

END $$

DELIMITER ;

-- Execute Procedure
CALL DisplayEmployeeDetails();