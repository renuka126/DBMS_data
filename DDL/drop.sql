
-- Create the Students table
CREATE TABLE Students (
    StudentID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Age         INT,
    City        VARCHAR(30)
);

-- Insert some records
INSERT INTO Students VALUES (1, 'Renuka', 20, 'Mumbai');
INSERT INTO Students VALUES (2, 'Amit',   22, 'Pune');
INSERT INTO Students VALUES (3, 'Sara',   21, 'Nagpur');
INSERT INTO Students VALUES (4, 'Rohan',  23, 'Mumbai');
INSERT INTO Students VALUES (5, 'Priya',  20, 'Nashik');

SELECT * FROM Students;

-- Students table is no longer needed, dropping it completely
DROP TABLE Students;

-- Trying to select after drop will throw an error
-- SELECT * FROM Students;
-- ERROR : Table 'Students' doesn't exist