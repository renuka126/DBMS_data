
CREATE TABLE student(
    roll_no INT PRIMARY KEY,
    name VARCHAR(30),
    marks INT
);

INSERT INTO student VALUES
(1,'Amit',85),
(2,'Neha',90),
(3,'Rahul',78);

-- Create User
CREATE USER 'student_user'@'localhost'
IDENTIFIED BY 'pass123';

-- Grant Permissions
GRANT SELECT, INSERT
ON college.student
TO 'student_user'@'localhost';

SHOW GRANTS FOR 'student_user'@'localhost';

-- Revoke Permission
REVOKE INSERT
ON college.student
FROM 'student_user'@'localhost';

SHOW GRANTS FOR 'student_user'@'localhost';