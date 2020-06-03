-- soal 1
DECLARE
v_num NUMBER :=1;
BEGIN
LOOP
IF(v_num = 6) THEN
DBMS_OUTPUT.PUT_LINE('No Input');
ELSIF(v_num = 8) THEN
DBMS_OUTPUT.PUT_LINE('No Input');
ElSE
INSERT INTO messages(result) VALUES(v_num);
END IF;
v_num := v_num + 1;
EXIT WHEN v_num > 10;
END LOOP;
END;
/

-- soal 2
SET SERVEROUTPUT ON
SET VERIFY OFF
DEFINE p_empno = 100
DECLARE
v_sal NUMBER(10,2);
v_bonus NUMBER(10,2);
BEGIN
SELECT salary INTO v_sal FROM EMPLOYEES WHERE
employee_id = &p_empno;
IF (v_sal < 5000) THEN
v_bonus := v_sal * 0.1;
ELSIF (v_sal > BETWEEN 5000 AND 10000) THEN
v_bonus := v_sal * 0.15;
ELSIF (v_sal > 10000) THEN
v_bonus := v_sal * 0.2;
ELSE THEN
v_bonus := 0;
END IF;
DBMS_OUTPUT.PUT_LINE('Bonus yang diterima ' || to char(v_bonus));
END;
/

-- soal 3
ALTER TABLE emp ADD(stars VARCHAR2(50));

-- soal 4
DEFINE p_empno = 104;
DECLARE
v_sal NUMBER;
v_asterisk VARCHAR2(255) := NULL;
BEGIN
SELECT salary
INTO v_sal
FROM emp
WHERE employee_id = &p_empno;
v_sal := round(v_sal/1000);
FOR i in 1..v_sal LOOP
v_asterisk = concat(v_asterisk, '*');
END LOOP;
UPDATE emp SET stars = v_asterisk
WHERE employee_id = &p_empno;
COMMIT;
END;
/ 

SELECT * FROM emp WHERE employee_id = 104;