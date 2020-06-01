-- number 1
create or replace function fn_monthHire
    (hire_date IN DATE)
    return varchar2
is
    hire_month varchar2(30);
begin
    if EXTRACT(MONTH FROM hire_date) = 1 then
        hire_month := 'Januari';
    else
        hire_month := 'Bukan Januari';
    end if;

    return hire_month;
end;

select EMPLOYEE_ID, LAST_NAME, HIRE_DATE, fn_monthHire(HIRE_DATE) from EMPLOYEES;


-- number 2

create or replace function fn_info
    (employee_code in employees.employee_id%type)
    return varchar2
is
    salary_result employees.salary%type := 0;
    increase number := 0;
    info varchar2(200) := 'Tidak ada kenaikan gaji';
begin
    select SALARY, DECODE(DEPARTMENT_ID, 10, 5, 50, 5, 110, 5, 60, 10, 20, 15, 60, 15, 0)
    into salary_result, increase
    from EMPLOYEES where EMPLOYEE_ID = employee_code;

    if increase != 0 then
        info := 'Kenaikan ' || increase || '%, gaji awal ' || salary_result || ', gaji sekarang ' ||
                (salary_result + (increase / 100 * salary_result));
    end if;

    return info;
end;

select EMPLOYEE_ID, LAST_NAME, DEPARTMENT_ID, fn_info(EMPLOYEE_ID)
from EMPLOYEES