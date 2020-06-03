CREATE OR REPLACE PACKAGE akuntansi IS
    PROCEDURE tambah_gaji(emp_no in EMPLOYEES.EMPLOYEE_ID%TYPE, percentage_inc in NUMBER);
    FUNCTION hitung_pajak(emp_no in EMPLOYEES.EMPLOYEE_ID%TYPE);
END akuntansi;

CREATE OR REPLACE PACKAGE BODY akuntansi IS
    PROCEDURE tambah_gaji(emp_no IN EMPLOYEES.EMPLOYEE_ID%TYPE, percentage_inc IN NUMBER)
    IS
        e_invalid_emp_no EXCEPTION;
        e_name employees.LAST_NAME%type := '';
    BEGIN
        UPDATE EMPLOYEES
            SET SALARY = SALARY + (percentage_inc / 100 * SALARY)
        WHERE EMPLOYEE_ID = emp_no RETURNING LAST_NAME INTO e_name;

        IF SQL%NOTFOUND THEN
          RAISE e_invalid_emp_no;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Pegawai dengan nomor pegawai ' || emp_no || ' nama ' || e_name ||
                             ' telah dinaikkan gajinya sebesar ' || percentage_inc || '%');
        END IF;

        EXCEPTION
            WHEN e_invalid_emp_no THEN
              DBMS_OUTPUT.PUT_LINE('ERROR: ' || emp_no || ' is an invalid emp_no.');
    END tambah_gaji;

    FUNCTION hitung_pajak(emp_no in EMPLOYEES.EMPLOYEE_ID%type)
    RETURN NUMBER IS
        salary NUMBER := 0;
        tax NUMBER := 0;
    BEGIN
        select SALARY, case
                   when SALARY <= 5000 then 15
                   when SALARY <= 10000 then 20
                   else 25
                end
        into salary, tax
        from EMPLOYEES
        where EMPLOYEE_ID = emp_no;

        RETURN (tax / 100 * salary);
    END hitung_pajak;
END akuntansi;
