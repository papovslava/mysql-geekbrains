USE shop;

-- ������������ ������� �� ���� �����������, ����������, ��������������
-- 1. � ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.
DESCRIBE users;
DROP TABLE IF EXISTS sample;
CREATE TABLE sample (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	birthday_at DATETIME,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

SELECT * FROM users;
SELECT * FROM sample;

INSERT INTO sample SELECT * FROM users WHERE id = 1;

-- 2. �������� �������������, ������� ������� �������� name �������� ������� �� ������� products � ��������������� �������� �������� name �� ������� catalogs.
DESCRIBE products;
DESCRIBE catalogs;
SELECT p.name, c.name FROM products p JOIN catalogs c ON p.catalog_id = c.id;
CREATE VIEW products_catalogs AS SELECT p.name as p_name, c.name as c_name FROM products p JOIN catalogs c ON p.catalog_id = c.id;
SELECT * FROM products_catalogs;

-- 3. (�� �������) ����� ������� ������� � ����������� ����� created_at. 
-- � ��� ��������� ���������� ����������� ������ �� ������ 2018 ���� '2018-08-01', '2016-08-04', '2018-08-16' � 2018-08-17.
-- ��������� ������, ������� ������� ������ ������ ��� �� ������, ��������� � �������� ���� �������� 1, ���� ���� ������������ � �������� ������� � 0, ���� ��� �����������.
CREATE TEMPORARY TABLE tbl ( value DATE );
INSERT INTO tbl VALUES ('2018-08-01'), ('2016-08-04'), ('2018-08-16'), ('2018-08-17');
SELECT * FROM tbl LIMIT 10;
CREATE TEMPORARY TABLE tbl_aug ( value VARCHAR(2) );
INSERT INTO tbl_aug VALUES ('01'), ('02'), ('03'), ('04'), ('05'), ('06'), ('07'), ('08'), ('09'), ('10'),  
	('11'), ('12'), ('13'), ('14'), ('15'), ('16'), ('17'), ('18'), ('19'), ('20'),
	('21'), ('22'), ('23'), ('24'), ('25'), ('26'), ('27'), ('28'), ('29'), ('30'), ('31');
SELECT * FROM tbl_aug;
SELECT CONCAT('2018-08-', tbl_aug.value) AS 'date', (SELECT COUNT(*) FROM tbl WHERE CONCAT('2018-08-', tbl_aug.value) = tbl.value) as 'F/T' FROM tbl_aug;

-- 4. (�� �������) ����� ������� ����� ������� � ����������� ����� created_at. �������� ������, ������� ������� ���������� ������ �� �������, �������� ������ 5 ����� ������ �������.
CREATE TEMPORARY TABLE tbl_tmp ( created_at DATE );
INSERT INTO tbl_tmp VALUES ('2018-08-01'), ('2016-08-04'), ('2018-08-16'), ('2018-08-17'), ('2019-09-02'), ('2017-09-05'), ('2019-09-17'), ('2019-09-18');
SELECT * FROM tbl_tmp ORDER BY created_at DESC;
SELECT @threshold := (SELECT * FROM tbl_tmp ORDER BY created_at DESC LIMIT 4, 1);
SELECT @threshold;
DELETE FROM tbl_tmp as tt WHERE created_at < (SELECT @threshold);
SELECT * FROM tbl_tmp ORDER BY created_at DESC;
 
-- ������������ ������� �� ���� ��������� ��������� � �������, ��������"
-- 1. �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����.
-- � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".

-- ������� c�. � ����� 9_1.sql

-- 2. � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. ��������� ����������� ����� ����� ��� ���� �� ���.
-- ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������.
-- ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.

-- ������� c�. � ����� 9_2.sql

