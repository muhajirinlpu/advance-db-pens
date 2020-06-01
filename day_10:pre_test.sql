-- number 1
select JOBS.JOB_ID
from JOBS
inner join JOB_HISTORY JH on JOBS.JOB_ID = JH.JOB_ID
where EXTRACT(MONTH FROM JH.START_DATE) <= 6
  and (EXTRACT(YEAR FROM JH.START_DATE) = 1991 or EXTRACT(YEAR FROM JH.START_DATE) = 1990);

-- number 2
-- same as day 09

-- number 3
select LAST_NAME, SALARY
from EMPLOYEES
order by SALARY desc
fetch first 3 rows only;

-- number 4
select EMPLOYEE_ID, LAST_NAME
from EMPLOYEES
inner join DEPARTMENTS D on EMPLOYEES.DEPARTMENT_ID = D.DEPARTMENT_ID
inner join LOCATIONS L on D.LOCATION_ID = L.LOCATION_ID
where L.STATE_PROVINCE = 'California'
   or L.STATE_PROVINCE = 'Boston';

-- number 5
with temp as (
    select AVG(MAX_SALARY) as MAX_SAL_CALC from JOBS)
select JOB_TITLE, MAX_SALARY
from JOBS, temp
where MAX_SALARY > temp.MAX_SAL_CALC;

-- number 6
select LAST_NAME, JOB_ID, SALARY
from EMPLOYEES
where SALARY > (
    select MAX(SALARY)
    from EMPLOYEES
        inner join JOBS on JOBS.JOB_ID = EMPLOYEES.JOB_ID
    where JOBS.JOB_ID = 'SA_MAN')
order by SALARY desc;

-- number 7
select LAST_NAME
from EMPLOYEES E
where (select COUNT(*)
    from EMPLOYEES E2
    where
          E2.EMPLOYEE_ID = E.EMPLOYEE_ID
      and E2.HIRE_DATE < E.HIRE_DATE) > 1;

-- number 8
with temp as (select SUM(SALARY) as TOTAL, DEPARTMENT_ID from EMPLOYEES group by DEPARTMENT_ID)
select d.DEPARTMENT_NAME, t.TOTAL as TOTAL_SALARY
from DEPARTMENTS d, temp t
where d.DEPARTMENT_ID = t.DEPARTMENT_ID
group by t.TOTAL, d.DEPARTMENT_NAME
having t.TOTAL > (select sum(SALARY)/8 from EMPLOYEES);

-- number 9
select LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME = 'Executive');

-- number 10
select LPAD(LAST_NAME,LENGTH(LAST_NAME)+LEVEL,'_') as NAME, MANAGER_ID as MGR, DEPARTMENT_ID as DEPTNO
from EMPLOYEES
start with LAST_NAME = 'Kochhar'
connect by prior EMPLOYEE_ID = MANAGER_ID