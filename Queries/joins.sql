--Create table 
CREATE TABLE DEPARTMENT (
    Dept_ID   NUMBER       PRIMARY KEY,
    Dept_Name VARCHAR2(50) NOT NULL,
    Location  VARCHAR2(50)
);

CREATE TABLE EMPLOYEE (
    Emp_ID    NUMBER        PRIMARY KEY,
    Emp_Name  VARCHAR2(50)  NOT NULL,
    Email     VARCHAR2(100) UNIQUE,
    Salary    NUMBER        CHECK (Salary >= 10000),
    Dept_ID   NUMBER        REFERENCES DEPARTMENT(Dept_ID),
    Join_Date DATE          DEFAULT SYSDATE
);


-- INNER JOIN
SELECT E.Emp_Name, D.Dept_Name
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON E.Dept_ID = D.Dept_ID;

-- LEFT JOIN (all employees even without department)
SELECT E.Emp_Name, D.Dept_Name
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON E.Dept_ID = D.Dept_ID;

-- RIGHT JOIN
SELECT E.Emp_Name, D.Dept_Name
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D ON E.Dept_ID = D.Dept_ID;

-- FULL OUTER JOIN
SELECT E.Emp_Name, D.Dept_Name
FROM EMPLOYEE E
FULL OUTER JOIN DEPARTMENT D ON E.Dept_ID = D.Dept_ID;

-- SELF JOIN (find employees in same department)
SELECT A.Emp_Name AS Emp1, B.Emp_Name AS Emp2, A.Dept_ID
FROM EMPLOYEE A, EMPLOYEE B
WHERE A.Dept_ID = B.Dept_ID AND A.Emp_ID <> B.Emp_ID;