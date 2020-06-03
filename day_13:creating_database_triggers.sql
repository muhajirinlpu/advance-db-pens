-- Soal 1
CREATE TABLE barang(
	id_barang NUMBER(10) NOT NULL,
	nama VARCHAR2(50) NOT NULL,
	spesifikasi VARCHAR2(200) NOT NULL,
	jumlah NUMBER(5) NOT NULL,
	harga NUMBER(20) NOT NULL,
	satuan VARCHAR2(20) NOT NULL
);
/

DESC barang;
/

CREATE TABLE transaksi(
	nomor_transaksi NUMBER(10) NOT NULL,
	id_barang NUMBER(10) NOT NULL,
	tanggal DATE NOT NULL,
	jumlah NUMBER(5) NOT NULL,
);
/

DESC transaksi;
/

CREATE TABLE history(
	id_barang NUMBER(10) NOT NULL,
	tanggal DATE NOT NULL,
	stock NUMBER(10) NOT NULL,
	type_transaksi VARCHAR2(20) NOT NULL,
);
/

DESC history;
/

-- Soal 2
CREATE OR REPLACE TRIGGER catathistory 
BEFORE
INSERT OR UPDATE OR DELETE ON transaksi FOR EACH ROW
DECLARE
UPDATE barang set jumlah=jumlah-(:new.jumlah) WHERE
id_barang = :new.id_barang;
IF inserting THEN
INSERT into history(id_barang, tanggal, stock, type_transaksi)
VALUES(:new.id_barang, :new.tanggal, :new.jumlah, 'tambah data');
ELSIF updating THEN
INSERT into history(id_barang, tanggal, stock, type_transaksi)
VALUES(:new.id_barang, :new.tanggal, :new.jumlah, 'ubah data');
ELSIF deleting THEN
INSERT into history(id_barang, tanggal, stock, type_transaksi)
VALUES(:new.id_barang, :new.tanggal, :new.jumlah, 'hapus data');
END IF;
END;
/

SELECT * FROM barang;
/

INSERT INTO barang(id_barang, nama, spesifik, jumlah, harga, satuan)
VALUES(1, 'buku', 'buku tulis', 50, 3000. 'buah');
/

INSERT INTO barang(id_barang, nama, spesifik, jumlah, harga, satuan)
VALUES(2, 'ballpoint', 'ballpoint', 30, 1500. 'buah');
/

INSERT INTO barang(id_barang, nama, spesifik, jumlah, harga, satuan)
VALUES(3, 'penghapus', 'penghapus', 20, 500. 'buah');
/

SELECT * FROM barang;
/

INSERT INTO transaksi(nomor_transaksi, id_barang, tanggal, jumlah)
VALUES(1, 1, '11-JUN-2017', 15);
/

INSERT INTO transaksi(nomor_transaksi, id_barang, tanggal, jumlah)
VALUES(2, 3, '11-JUN-2017', 7);
/

SELECT * FROM transaksi;
