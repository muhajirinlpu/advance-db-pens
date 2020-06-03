CREATE OR REPLACE PACKAGE pegawai IS
    PROCEDURE cari_pegawai(dept_no in EMPLOYEES.DEPARTMENT_ID%type);
    PROCEDURE cari_pegawai(last_name_q in EMPLOYEES.LAST_NAME%type);
END pegawai;
/
CREATE OR REPLACE PACKAGE BODY pegawai IS
    PROCEDURE cari_pegawai(dept_no in EMPLOYEES.DEPARTMENT_ID%type) IS
    BEGIN
        for row in (select FIRST_NAME, LAST_NAME from EMPLOYEES where DEPARTMENT_ID = dept_no) loop
            dbms_output.put_line(row.FIRST_NAME||' '||row.LAST_NAME);
        end loop;
    END cari_pegawai;
    PROCEDURE cari_pegawai(last_name_q in EMPLOYEES.LAST_NAME%type) IS
    BEGIN
        for row in (select FIRST_NAME, LAST_NAME from EMPLOYEES where UPPER(LAST_NAME) like '%'||UPPER(last_name_q)||'%') loop
            dbms_output.put_line(row.FIRST_NAME||' '||row.LAST_NAME);
        end loop;
    END cari_pegawai;
END pegawai;