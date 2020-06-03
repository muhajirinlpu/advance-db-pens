-- Soal 1
VARIABLE g_max_deptno NUMBER
BEGIN
SELECT MAX(department_id)
INTO :g_max_deptno
FROM departments;
DBMS_OUTPUT.PUT_LINE('MAX ID = ' || :g_max_deptno);
END;
/

-- Soal 2
VARIABLE g_max_deptno NUMBER
VARIABLE p_dept_name VARCHAR2(30)
DEFINE p_dept_name = 'Education'
SET VERIFY OFF
DECLARE
v_id NUMBER;
v_name VARCHAR2(30);
v_dept_name departments.department_name%TYPE := '&p_dept_name';
BEGIN
SELECT MAX(department_id)
INTO :g_max_deptno
FROM departments;
DBMS_OUTPUT.PUT_LINE('MAX ID = ' || :g_max_deptno);

INSERT INTO departments
(department_id, department_name, location_id)
VALUES (:g_max_deptno+10, v_dept_name, NULL);
DBMS_OUTPUT.PUT_LINE('Sukses');

SELECT department_id, department_name
INTO v_id, v_name
FROM departments
WHERE department_id = 280;
DBMS_OUTPUT.PUT_LINE('ID : ' || to_char(v_id));
DBMS_OUTPUT.PUT_LINE('NAMA : ' || to_char(v_name));
END;
/

-- soal 3
DECLARE
v_deptno departments.department_id%TYPE := 280;
v_location departments.location_id%TYPE := 1700;
BEGIN
UPDATE departments
SET location_id = v_location
WHERE department_id = v_deptno;
END;
/

SELECT * FROM departments WHERE department_id = 280;

-- soal 4
VARIABLE rows_deleted VARCHAR2(30)
DECLARE
v_deptno departments.department_id%TYPE := 280;
BEGIN
DELETE FROM departments
WHERE department_id = v_deptno;
:rows_deleted := (SQL%ROWCOUNT || ' row deleted');
END;
/

PRINT rows_deleted;

