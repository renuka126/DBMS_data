-- 1. AUDIT TRIGGER: Log every grade change in Enrollments
CREATE TABLE Enrollment_Audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT NOT NULL,
    old_grade CHAR(2),
    new_grade CHAR(2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER trg_grade_update
AFTER UPDATE ON Enrollments
FOR EACH ROW
BEGIN
    IF OLD.grade <> NEW.grade THEN
        INSERT INTO Enrollment_Audit (enrollment_id, old_grade, new_grade)
        VALUES (NEW.enrollment_id, OLD.grade, NEW.grade);
    END IF;
END //
DELIMITER ;


-- 2. VALIDATION TRIGGER: Prevent enrolling a student in the same course twice in one semester
DELIMITER //
CREATE TRIGGER trg_prevent_duplicate_enrollment
BEFORE INSERT ON Enrollments
FOR EACH ROW
BEGIN
    DECLARE existing_count INT;
    
    SELECT COUNT(*) INTO existing_count
    FROM Enrollments
    WHERE student_id = NEW.student_id
      AND course_id = NEW.course_id
      AND semester = NEW.semester;
    
    IF existing_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student is already enrolled in this course for this semester';
    END IF;
END //
DELIMITER ;


-- 3. AUTO-TIMESTAMP TRIGGER: Stamp enrollment_date automatically before insert
DELIMITER //
CREATE TRIGGER trg_set_enrollment_date
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
    IF NEW.enrollment_date IS NULL THEN
        SET NEW.enrollment_date = CURDATE();
    END IF;
END //
DELIMITER ;


-- 4. CASCADE LOGIC TRIGGER: Prevent deleting a department that still has courses
DELIMITER //
CREATE TRIGGER trg_prevent_department_delete
BEFORE DELETE ON Departments
FOR EACH ROW
BEGIN
    DECLARE course_count INT;
    
    SELECT COUNT(*) INTO course_count
    FROM Courses
    WHERE department_id = OLD.department_id;
    
    IF course_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete department with existing courses';
    END IF;
END //
DELIMITER ;


--Simple Examples

-- ─────────────────────────────────────────────
 AUDIT TABLE + BEFORE UPDATE TRIGGER
-- ─────────────────────────────────────────────

-- Create audit table
CREATE TABLE Salary_Audit (
    Audit_ID   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Emp_ID     NUMBER,
    Old_Salary NUMBER,
    New_Salary NUMBER,
    Changed_On DATE,
    Changed_By VARCHAR2(50)
);

-- Trigger: preserve old salary before update
CREATE OR REPLACE TRIGGER trg_salary_backup
BEFORE UPDATE OF Salary ON EMPLOYEE
FOR EACH ROW
BEGIN
    INSERT INTO Salary_Audit (Emp_ID, Old_Salary, New_Salary, Changed_On, Changed_By)
    VALUES (:OLD.Emp_ID, :OLD.Salary, :NEW.Salary, SYSDATE, USER);
END;
/

-- ─────────────────────────────────────────────
 AFTER INSERT TRIGGER
-- ─────────────────────────────────────────────

CREATE OR REPLACE TRIGGER trg_after_insert_emp
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('New employee added: ' || :NEW.Emp_Name
        || ' with ID ' || :NEW.Emp_ID);
END;
/

-- ─────────────────────────────────────────────
 BEFORE DELETE TRIGGER (prevent deletion)
-- ─────────────────────────────────────────────

CREATE OR REPLACE TRIGGER trg_prevent_delete
BEFORE DELETE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF :OLD.Salary > 100000 THEN
        RAISE_APPLICATION_ERROR(-20001,
            'Cannot delete high-salary employee: ' || :OLD.Emp_Name);
    END IF;
END;
/
