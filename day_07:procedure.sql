SET SERVEROUTPUT ON

VARIABLE p_gaji
DECLARE
v_gaji emp.sal%TYPE := &p_gaji;
tampung emp.ename%TYPE;

BEGIN
	SELECT ename INTO tampung FROM emp WHERE sal=v_gaji;
	DBMS_OUTPUT.PUT_LINE('Gaji tersebut dimiliki oleh pegawai bernama ' ||
		tampung);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Tidak Ada Data');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('Lebih dari satu pegawai punya gaji itu');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Terjadi suatu kesalahan');
END;
/