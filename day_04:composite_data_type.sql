-- Soal 1
SET SERVEROUTPUT ON
DEFINE p_country_id='CA'
SET VERIFY OFF
DECLARE TYPE record_type_country is record
(country_id CHAR(2), country_name VARCHAR2(50));
record_country record_type_country;
v_country_id CHAR(2);
BEGIN
FOR i in 1..4 LOOP
IF i=1 THEN v_country_id := '&p_country_id';
ELSIF i=2 THEN v_country_id :='DE';
ELSIF i=3 THEN v_country_id :='UK';
ELSIF i=4 THEN v_country_id :='US';
END IF;

SELECT country_id, country_name
INTO record_country.country_id, record_country.country_name
FROM countries
WHERE country_id = v_country_id;
DBMS_OUTPUT.PUT_LINE(record_country.country_id || ' ' ||
record_country.country_name);
END LOOP;
END;
/

-- Soal 2
DECLARE TYPE dept_table_type is table of departments.department_name%TYPE
INDEX BY BINARY_INTEGER;
my_dept_table dept_table_type;
v_deptno departments.department_id%TYPE;
BEGIN
	FOR i in 1..7 LOOP
    v_deptno := CASE i
      WHEN 1 THEN 10
      WHEN 2 THEN 20
      WHEN 3 THEN 50
      WHEN 4 THEN 60
      WHEN 5 THEN 80
      WHEN 6 THEN 90
      WHEN 7 THEN 110
    END;
    SELECT department_name
    INTO my_dept_table(i)
    FROM departments
    WHERE department_id = v_deptno;
	END LOOP;
	FOR i in 1..7 LOOP
		DBMS_OUTPUT.PUT_LINE(my_dept_table(i));
	END LOOP;
END;
/


-- Soal 3
DECLARE TYPE dept_table_type is table of departments%ROWTYPE
INDEX BY BINARY_INTEGER;
my_dept_table dept_table_type;
v_deptno departments.department_id%TYPE;
BEGIN
	FOR i in 1..7 LOOP
	v_deptno := CASE i
      WHEN 1 THEN 10
      WHEN 2 THEN 20
      WHEN 3 THEN 50
      WHEN 4 THEN 60
      WHEN 5 THEN 80
      WHEN 6 THEN 90
      WHEN 7 THEN 110
    END;
	SELECT *
	INTO my_dept_table(i)
	FROM departments
	WHERE department_id = v_deptno;
	END LOOP;
	FOR i in 1..7 LOOP
		DBMS_OUTPUT.PUT_LINE(
			my_dept_table(i).department_id|| ' ' ||
			my_dept_table(i).department_name|| ' ' ||
			my_dept_table(i).location_id);
	END LOOP;
END;
/

-- Soal 4
DECLARE TYPE manager_table_type IS TABLE OF
	departments.manager_id%TYPE
INDEX BY BINARY_INTEGER;
my_manager_table manager_table_type;
v_count NUMBER;
BEGIN
	SELECT manager_id BULK COLLECT 
	INTO my_manager_table FROM departments
	WHERE manager_id != NULL;
	v_count := SQL%ROWCOUNT;
	FOR i IN 1..v_count LOOP
		DELETE FROM employees WHERE employee_id = my_manager_table(i);
	END LOOP;
END;
/

SELECT COUNT(*) FROM employees;