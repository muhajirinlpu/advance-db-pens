-- Soal 1
DECLARE
CURSOR c_emp IS
SELECT job FROM emp GROUP BY job ORDER BY job;
BEGIN
FOR job in c_emp LOOP
DBMS_OUTPUT.PUT_LINE(chr(10) || 'Nama Pekerjaan : ' || job.job);
FOR emp IN (SELECT empno, ename FROM emp WHERE job = job.job) LOOP
DBMS_OUTPUT.PUT_LINE(emp.empno || ' ' || emp.ename);
END LOOP;
END LOOP;
END;

-- Soal 2
DECLARE
v_empno emp.empno%TYPE;
v_ename emp.ename%TYPE;
CURSOR c_emp IS
SELECT empno, ename FROM emp WHERE mgr = (
	SELECT empno FROM emp WHere ename = 'KING'
);
BEGIN
OPEN c_emp;
LOOP
FETCH c_emp INTO v_empno, v_ename;
EXIT WHEN c_emp%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_ename);
END LOOP;
CLOSE c_emp;
END;
/

DECLARE
CURSOR c_emp IS
SELECT empno, ename FROM emp WHERE mgr = (
	SELECT empno FROM emp WHere ename = 'KING'
);
BEGIN
FOR emp IN c_emp LOOP
DBMS_OUTPUT.PUT_LINE(emp.empno || ' ' || emp.ename);
END LOOP;
END;
/

DECLARE
v_empno emp.empno%TYPE;
v_ename emp.ename%TYPE;
CURSOR c_emp IS
SELECT empno, ename FROM emp WHERE mgr = (
	SELECT empno FROM emp WHere ename = 'KING'
);
BEGIN
OPEN c_emp;
FETCH c_emp INTO v_empno, v_ename;
WHILE c_emp%FOUND LOOP
DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_ename);
FETCH c_emp INTO v_empno, v_ename;
END LOOP;
END;
/

-- Soal 3
CREATE OR REPLACE PROCEDURE emp_info(p_ename emp.ename@TYPE)
IS
v_ename emp.ename%TYPE;
v_dname dept.dname%TYPE;
v_deptno emp.deptno%TYPE;
v_grade NUMBER;
v_sal emp.sal%TYPE;
v_stars VARCHAR2(200) := NULL;

BEGIN
SELECT emp.ename, dept.dname, emp.sal, emp.deptno INTO v_ename, v_dname, v_sal, v_deptno
FROM emp, dept WHERE emp.ename = p_ename ADN emp.deptno = dept.deptno;

v_grade := round(v_sal/1000);
FOR i in 1..v_grade LOOP
v_stars := v_stars || '*';
END LOOP;

DBMS_OUTPUT.PUT_LINE(
	'ENAME : ' || v_ename || chr(10) ||
	'DNAME : ' || v_dname || chr(10) ||
	'GRADE : ' || v_grade || chr(10) ||
	'GAJI : ' || v_sal || chr(10) ||
	'STARS : ' || v_stars || chr(10) ||
	'DEPTNO : ' || v_deptno 
);
END emp_info;