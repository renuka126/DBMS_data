

-- Step 1: Create the Students table
CREATE TABLE Students (
    StudentID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Age         INT,
    City        VARCHAR(30)
);

-- Step 2: Insert some records
INSERT INTO Students VALUES (1, 'Renuka', 20, 'Mumbai');
INSERT INTO Students VALUES (2, 'Amit',   22, 'Pune');
INSERT INTO Students VALUES (3, 'Sara',   21, 'Nagpur');
INSERT INTO Students VALUES (4, 'Rohan',  23, 'Mumbai');
INSERT INTO Students VALUES (5, 'Priya',  20, 'Nashik');

SELECT * FROM Students;

-- Adding a new column Marks to the table
ALTER TABLE Students ADD Marks DECIMAL(5,2);

SELECT * FROM Students;

-- Marks column size feels small, lets increase it
ALTER TABLE Students MODIFY Marks DECIMAL(6,2);

-- Also Age as SMALLINT is enough, no need for INT
ALTER TABLE Students MODIFY Age SMALLINT;

-- City is a vague name, Location makes more sense
ALTER TABLE Students RENAME COLUMN City TO Location;

SELECT * FROM Students;

-- Students below 18 should not be enrolled
ALTER TABLE Students ADD CONSTRAINT chk_age CHECK (Age >= 18);

-- Marks column is not needed anymore, removing it
ALTER TABLE Students DROP COLUMN Marks;

SELECT * FROM Students;