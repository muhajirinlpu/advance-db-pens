CREATE TABLE top_dogs
(salary NUMBER(8,2));

-- Soal 2
SET SERVEROUTPUT ON
DEFINE n
DECLARE
v_n NUMBER(3);
v_sal employees.salary%TYPE;
CURSOR sal_cursor IS
	SELECT salary FROM employees GROUP BY salary
	ORDER BY salary DESC;
BEGIN
	DELETE top_dogs;
	OPEN sal_cursor;
	LOOP
		FETCH sal_cursor INTO v_sal;
		EXIT WHEN sal_cursor%ROWCOUNT > &n;
		INSERT INTO top_dogs VALUES(v_sal);
	END LOOP;
END;
/

SELECT * FROM top_dogs;

-- Soal 3
SET ECHO OFF
DEFINE p_department_id=10
DECLARE
CURSOR employees_cursor IS
SELECT last_name, salary, manager_id
FROM employees
WHERE department_id=&p_department_id;
employees_var employees_cursor%ROWTYPE;
BEGIN
	FOR employees_var IN employees_cursor LOOP
	IF employees_var.salary<5000 AND (employees_var.manager_id=101 OR employees_var.manager_id=124) THEN
		DBMS_OUTPUT.PUT_LINE(employees_var.last_name || ', gaji perlu dinaikkan');
	ELSE
		DBMS_OUTPUT.PUT_LINE(employees_var.last_name || ', gaji tidak perlu dinaikkan');
	END IF;
	END LOOP;
END;
/
