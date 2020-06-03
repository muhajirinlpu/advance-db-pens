SET SERVEROUTPUT ON
DECLARE
CURSOR dept_cursor IS
SELECT department_id, department_name
FROM departments
WHERE department_id<100;

CURSOR emp_cursor(p_id_dept departments.department_id%TYPE) IS
SELECT last_name, job_id, hire_date, salary
FROM employees
WHERE employee_id<120 AND department_id=p_id_dept;

v_dept dept_cursor%ROWTYPE;
v_emp emp_cursor%ROWTYPE;

BEGIN
IF NOT dept_cursor%ISOPEN
	THEN OPEN dept_cursor;
END IF;
LOOP
	FETCH dept_cursor INTO v_dept;
	EXIT WHEN dept_cursor%NOTFOUND;
	DBMS_OUTPUT.PUT_LINE('No Dept ' || v_dept.department_id || ' is ' || v_dept.department_name);
END LOOP;

CLOSE dept_cursor;
IF NOT emp_cursor%ISOPEN
	THEN OPEN emp_cursor(v_dept.department_id);
END IF;

LOOP
	FETCH emp_cursor INTO v_emp;
	EXIT WHEN emp_cursor%NOTFOUND;
	DBMS_OUTPUT.PUT_LINE(v_emp.last_name || ' is ' || v_emp.job_id
		|| ' masuk ' || v_emp.hire_date || ' gaji ' || v_emp.salary);
END LOOP;
CLOSE emp_cursor;
END;
/


-- Soal 2
DECLARE
CURSOR star_cursor(v_id emp.employee_id%TYPE) IS
SELECT employee_id, salary, stars
FROM emp
WHERE employee_id = v_id
FOR UPDATE of stars NOWAIT;
c_star star_cursor%ROWTYPE;
v_hasil NUMBER;
v_star emp.stars%TYPE;

BEGIN
OPEN star_cursor(104);
FETCH star_cursor INTO c_star;
v_hasil := ROUND(c_star.salary/1000);
FOR i IN 1..v_hasil LOOP
v_star := v_star || '*';
END LOOP;

UPDATE emp
SET stars = v_star
WHERE CURRENT OF star_cursor;
DBMS_OUTPUT.PUT_LINE('no_id ' || c_star.employee_id ||
' gajinya ' || c_star.salary || ' , jumlah bintang' ||
c_star.stars);
CLOSE star_cursor;

v_star := null;

OPEN star_cursor(176);
FETCH star_cursor INTO c_star;
v_hasil := ROUND(c_star.salary/1000);
FOR i IN 1..v_hasil LOOP
v_star := v_star || '*';
END LOOP;

UPDATE emp
SET stars = v_star
WHERE CURRENT OF star_cursor;
DBMS_OUTPUT.PUT_LINE('no_id ' || c_star.employee_id ||
' gajinya ' || c_star.salary || ' , jumlah bintang' ||
c_star.stars);
CLOSE star_cursor;

v_star := null;

OPEN star_cursor(174);
FETCH star_cursor INTO c_star;
v_hasil := ROUND(c_star.salary/1000);
FOR i IN 1..v_hasil LOOP
v_star := v_star || '*';
END LOOP;

UPDATE emp
SET stars = v_star
WHERE CURRENT OF star_cursor;
DBMS_OUTPUT.PUT_LINE('no_id ' || c_star.employee_id ||
' gajinya ' || c_star.salary || ' , jumlah bintang' ||
c_star.stars);
CLOSE star_cursor;

v_star := null;
END;
/