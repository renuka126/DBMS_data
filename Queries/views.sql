-- Create Table

CREATE TABLE EMPLOYEE (
    Emp_ID    NUMBER        PRIMARY KEY,
    Emp_Name  VARCHAR2(50)  NOT NULL,
    Email     VARCHAR2(100) UNIQUE,
    Salary    NUMBER        CHECK (Salary >= 10000),
    Dept_ID   NUMBER        REFERENCES DEPARTMENT(Dept_ID),
    Join_Date DATE          DEFAULT SYSDATE
);

-- Create a view
CREATE VIEW High_Earners AS
SELECT Emp_Name, Salary, Dept_ID
FROM EMPLOYEE
WHERE Salary > 50000;

-- Use view like a table
SELECT * FROM High_Earners WHERE Dept_ID = 10;

-- View with JOIN
CREATE VIEW Emp_Dept_View AS
SELECT E.Emp_ID, E.Emp_Name, E.Salary, D.Dept_Name
FROM EMPLOYEE E JOIN DEPARTMENT D ON E.Dept_ID = D.Dept_ID;

-- Drop view

DROP VIEW High_Earners;
