-- ============================================================
-- PL/SQL BLOCKS
-- ============================================================

-- ─────────────────────────────────────────────
 BASIC PL/SQL BLOCK
-- ─────────────────────────────────────────────

DECLARE
    v_name   EMPLOYEE.Emp_Name%TYPE;
    v_salary EMPLOYEE.Salary%TYPE;
    v_emp_id NUMBER := 101;
BEGIN
    SELECT Emp_Name, Salary
    INTO v_name, v_salary
    FROM EMPLOYEE
    WHERE Emp_ID = v_emp_id;

    IF v_salary > 50000 THEN
        DBMS_OUTPUT.PUT_LINE(v_name || ' is a high earner: ' || v_salary);
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_name || ' earns: ' || v_salary);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- ─────────────────────────────────────────────
-- EXPLICIT CURSOR
-- ─────────────────────────────────────────────

DECLARE
    CURSOR emp_cur IS
        SELECT Emp_ID, Emp_Name, Salary FROM EMPLOYEE ORDER BY Salary DESC;
    v_id   EMPLOYEE.Emp_ID%TYPE;
    v_name EMPLOYEE.Emp_Name%TYPE;
    v_sal  EMPLOYEE.Salary%TYPE;
BEGIN
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO v_id, v_name, v_sal;
        EXIT WHEN emp_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_id || '  ' || v_name || '  ' || v_sal);
    END LOOP;
    CLOSE emp_cur;
END;
/

-- ─────────────────────────────────────────────
--  CURSOR FOR LOOP (Simpler syntax)
-- ─────────────────────────────────────────────

BEGIN
    FOR rec IN (SELECT Emp_Name, Salary FROM EMPLOYEE WHERE Dept_ID = 10) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.Emp_Name || ' -> ' || rec.Salary);
    END LOOP;
END;
/

-- ─────────────────────────────────────────────
--  PROCEDURE — Give bonus to a department
-- ─────────────────────────────────────────────

CREATE OR REPLACE PROCEDURE give_bonus (
    p_dept_id IN NUMBER,
    p_percent IN NUMBER
) AS
BEGIN
    UPDATE EMPLOYEE
    SET Salary = Salary + (Salary * p_percent / 100)
    WHERE Dept_ID = p_dept_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Bonus of ' || p_percent || '% applied to Dept ' || p_dept_id);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Execute procedure
EXEC give_bonus(10, 10);

-- ─────────────────────────────────────────────
--  FUNCTION — Return total salary of dept
-- ─────────────────────────────────────────────

CREATE OR REPLACE FUNCTION dept_total_salary (
    p_dept_id IN NUMBER
) RETURN NUMBER AS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(Salary), 0)
    INTO v_total
    FROM EMPLOYEE
    WHERE Dept_ID = p_dept_id;
    RETURN v_total;
EXCEPTION
    WHEN OTHERS THEN
        RETURN -1;
END;
/

-- Call function
SELECT dept_total_salary(10) AS Total_Salary FROM DUAL;

-- ─────────────────────────────────────────────
--  STUDENT ATTENDANCE PL/SQL
-- ─────────────────────────────────────────────

-- Create table
CREATE TABLE STUDENT_ATTENDANCE (
    Stud_ID      NUMBER PRIMARY KEY,
    Stud_Name    VARCHAR2(50),
    Present_Days NUMBER,
    Total_Days   NUMBER
);

-- PL/SQL Block: Check attendance eligibility
DECLARE
    CURSOR stud_cur IS
        SELECT Stud_ID, Stud_Name,
               ROUND((Present_Days / Total_Days) * 100, 2) AS Pct
        FROM STUDENT_ATTENDANCE;
BEGIN
    FOR rec IN stud_cur LOOP
        IF rec.Pct < 75 THEN
            DBMS_OUTPUT.PUT_LINE(rec.Stud_Name ||
                ' [DETAINED] Attendance: ' || rec.Pct || '%');
        ELSE
            DBMS_OUTPUT.PUT_LINE(rec.Stud_Name ||
                ' [ELIGIBLE] Attendance: ' || rec.Pct || '%');
        END IF;
    END LOOP;
END;
/

-- ─────────────────────────────────────────────
--  HOTEL ROOM BOOKING PL/SQL PROCEDURE
-- ─────────────────────────────────────────────

CREATE TABLE ROOM (
    Room_No    NUMBER PRIMARY KEY,
    Room_Type  VARCHAR2(20),
    Price      NUMBER,
    Status     VARCHAR2(20) DEFAULT 'AVAILABLE'
);

CREATE TABLE BOOKING (
    Booking_ID NUMBER PRIMARY KEY,
    Room_No    NUMBER REFERENCES ROOM(Room_No),
    Guest_Name VARCHAR2(50),
    Check_In   DATE,
    Check_Out  DATE
);

CREATE SEQUENCE SEQ_BOOK START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE book_room (
    p_room_no   IN NUMBER,
    p_guest     IN VARCHAR2,
    p_check_in  IN DATE,
    p_check_out IN DATE
) AS
    v_status VARCHAR2(20);
BEGIN
    SELECT Status INTO v_status
    FROM ROOM WHERE Room_No = p_room_no;

    IF v_status = 'AVAILABLE' THEN
        INSERT INTO BOOKING VALUES
            (SEQ_BOOK.NEXTVAL, p_room_no, p_guest, p_check_in, p_check_out);
        UPDATE ROOM SET Status = 'BOOKED'
        WHERE Room_No = p_room_no;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Room ' || p_room_no || ' booked for ' || p_guest);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Room ' || p_room_no || ' is NOT available.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Room ' || p_room_no || ' does not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Execute
EXEC book_room(101, 'Rahul Sharma', SYSDATE, SYSDATE + 3);

-- ─────────────────────────────────────────────
--  LOOP TYPES IN PL/SQL
-- ─────────────────────────────────────────────

-- Simple LOOP
DECLARE
    i NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('Count: ' || i);
        i := i + 1;
        EXIT WHEN i > 5;
    END LOOP;
END;
/

-- WHILE LOOP
DECLARE
    i NUMBER := 1;
BEGIN
    WHILE i <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE('While Count: ' || i);
        i := i + 1;
    END LOOP;
END;
/

-- FOR LOOP
BEGIN
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('For Count: ' || i);
    END LOOP;
END;
/

-- ─────────────────────────────────────────────
--  EXCEPTION HANDLING
-- ─────────────────────────────────────────────

DECLARE
    v_salary EMPLOYEE.Salary%TYPE;
BEGIN
    SELECT Salary INTO v_salary
    FROM EMPLOYEE WHERE Emp_ID = 9999;  -- non-existent

    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found with that ID.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Multiple rows returned.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/

-- User-defined exception
DECLARE
    e_low_salary EXCEPTION;
    v_salary NUMBER := 5000;
BEGIN
    IF v_salary < 10000 THEN
        RAISE e_low_salary;
    END IF;
EXCEPTION
    WHEN e_low_salary THEN
        DBMS_OUTPUT.PUT_LINE('Salary below minimum threshold!');
END;
/
