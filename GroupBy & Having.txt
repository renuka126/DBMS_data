
--Creatind table 

CREATE TABLE EMPLOYEE (
    Emp_ID    NUMBER        PRIMARY KEY,
    Emp_Name  VARCHAR2(50)  NOT NULL,
    Email     VARCHAR2(100) UNIQUE,
    Salary    NUMBER        CHECK (Salary >= 10000),
    Dept_ID   NUMBER        REFERENCES DEPARTMENT(Dept_ID),
    Join_Date DATE          DEFAULT SYSDATE
);
 

-- Count employees per department
SELECT Dept_ID, COUNT(*) AS Emp_Count, AVG(Salary) AS Avg_Salary
FROM EMPLOYEE
GROUP BY Dept_ID;

-- Only departments with more than 3 employees
SELECT Dept_ID, COUNT(*) AS Emp_Count
FROM EMPLOYEE
GROUP BY Dept_ID
HAVING COUNT(*) > 3;

-- Department with highest average salary
SELECT Dept_ID, AVG(Salary) AS Avg_Sal
FROM EMPLOYEE
GROUP BY Dept_ID
HAVING AVG(Salary) = (
    SELECT MAX(AVG(Salary)) FROM EMPLOYEE GROUP BY Dept_ID
);