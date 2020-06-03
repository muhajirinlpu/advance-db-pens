-- Soal 1
CREATE OR REPLACE PROCEDURE add_job
(id jobs.job_id%TYPE, job_name jobs.job_title%TYPE) IS
BEGIN
INSERT INTO jobs(job_id, job_title)
VALUES(id, job_name);
END add_job;
/

BEGIN
add_job('IT_2D3A', 'Jul');
END;
/

-- Soal 2
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE upd_job
(kode jobs.job_id%TYPE, job_name jobs.job_title%TYPE) IS
null_ex EXCEPTION;
BEGIN
UPDATE jobs SET job_title=job_name WHERE job_id=kode;
IF SQL%NOTFOUND THEN
RAISE null_ex;
END IF;
EXCEPTION
WHEN null_ex THEN
DBMS_OUTPUT.PUT_LINE('Kode jobs tidak ada');
END upd_job;
/

SELECT * FROM jobs WHERE job_id='IT_PROG';
BEGIN
upd_job('IT_PROG', 'DBA Administrator');
END;
/

SELECT * FROM jobs WHERE job_id='IT_PROG';
BEGIN
upd_job('IT_WEB', 'Doc Administrator');
END;
/