
-- Table for student details
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    gender TEXT,
    age INTEGER,
    attendance_percentage REAL,
    study_hours_per_week REAL,
    parental_education TEXT,
    internet_access TEXT
);


-- Insert students
INSERT INTO students (student_id, name, gender, age, attendance_percentage, study_hours_per_week, parental_education, internet_access)
VALUES
(1, 'Aarav Sharma', 'M', 20, 85.5, 10, 'Graduate', 'Yes'),
(2, 'Priya Singh', 'F', 21, 60.0, 4, 'High School', 'No'),
(3, 'Rohan Patel', 'M', 19, 95.0, 15, 'Postgraduate', 'Yes'),
(4, 'Sneha Iyer', 'F', 20, 45.0, 2, 'High School', 'Yes'),
(5, 'Vikram Joshi', 'M', 22, 70.0, 8, 'Graduate', 'No');

-- Students who scored above the overall average final marks
SELECT s.name, m.final_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.final_marks > (SELECT AVG(final_marks) FROM marks);

-- Students who failed in any subject (final_marks < 40)
SELECT name
FROM students
WHERE student_id IN (
    SELECT student_id FROM marks WHERE final_marks < 40
);

-- Subquery in FROM: find the top scorer overall
SELECT name, total_marks
FROM (
    SELECT s.name, SUM(m.final_marks) AS total_marks
    FROM students s
    JOIN marks m ON s.student_id = m.student_id
    GROUP BY s.student_id, s.name
) AS student_totals
ORDER BY total_marks DESC
LIMIT 1;

-- Correlated subquery: students above their gender's average attendance
SELECT s1.name, s1.gender, s1.attendance_percentage
FROM students s1
WHERE s1.attendance_percentage > (
    SELECT AVG(s2.attendance_percentage)
    FROM students s2
    WHERE s2.gender = s1.gender
);

-- Students who have never failed any subject
SELECT name
FROM students
WHERE student_id NOT IN (
    SELECT student_id FROM marks WHERE final_marks < 40
);

-- EXISTS subquery: students who have at least one mark record
SELECT name
FROM students s
WHERE EXISTS (
    SELECT 1 FROM marks m WHERE m.student_id = s.student_id
);
