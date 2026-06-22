CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

CREATE TABLE students (
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  department VARCHAR(50),
  enrollment_year INT
);

CREATE TABLE courses (
  course_id INT PRIMARY KEY AUTO_INCREMENT,
  course_name VARCHAR(100),
  credits INT
);

CREATE TABLE enrollments (
  enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT,
  course_id INT,
  grade VARCHAR(2),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

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
