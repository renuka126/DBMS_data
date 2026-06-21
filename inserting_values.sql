-- Insert students
INSERT INTO students (student_id, name, gender, age, attendance_percentage, study_hours_per_week, parental_education, internet_access)
VALUES
(1, 'Aarav Sharma', 'M', 20, 85.5, 10, 'Graduate', 'Yes'),
(2, 'Priya Singh', 'F', 21, 60.0, 4, 'High School', 'No'),
(3, 'Rohan Patel', 'M', 19, 95.0, 15, 'Postgraduate', 'Yes'),
(4, 'Sneha Iyer', 'F', 20, 45.0, 2, 'High School', 'Yes'),
(5, 'Vikram Joshi', 'M', 22, 70.0, 8, 'Graduate', 'No');

-- Insert subjects
INSERT INTO subjects (subject_id, subject_name)
VALUES
(1, 'Database Management'),
(2, 'Python for Data Science');

-- Insert marks
INSERT INTO marks (student_id, subject_id, internal_marks, assignment_marks, final_marks)
VALUES
(1, 1, 18, 9, 75),
(1, 2, 16, 8, 70),
(2, 1, 10, 5, 35),
(2, 2, 8, 4, 30),
(3, 1, 19, 10, 88),
(3, 2, 18, 9, 85),
(4, 1, 9, 4, 32),
(4, 2, 7, 3, 28),
(5, 1, 14, 7, 60),
(5, 2, 13, 6, 58);