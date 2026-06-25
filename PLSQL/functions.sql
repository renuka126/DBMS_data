

CREATE DATABASE college;
USE college;

CREATE TABLE student(
    id INT,
    name VARCHAR(30),
    marks INT
);

INSERT INTO student VALUES
(1,'Rahul',85),
(2,'Priya',92),
(3,'Amit',76),
(4,'Neha',88);

DELIMITER $$

CREATE FUNCTION get_grade(marks INT)
RETURNS VARCHAR(5)
DETERMINISTIC
BEGIN
    DECLARE grade VARCHAR(5);

    IF marks >= 90 THEN
        SET grade = 'A';
    ELSEIF marks >= 80 THEN
        SET grade = 'B';
    ELSEIF marks >= 70 THEN
        SET grade = 'C';
    ELSE
        SET grade = 'D';
    END IF;

    RETURN grade;
END $$

DELIMITER ;

SELECT id, name, marks, get_grade(marks) AS Grade
FROM student;