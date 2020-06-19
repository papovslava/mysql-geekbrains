-- https://docs.google.com/document/d/1yE0wn1m-EwqcJ458ga3eCptvBJcSIi1HaBp48OlT5ZI/edit#

USE shop;

-- ������������ ������� �� ���� ����������, ����������, ���������� � �����������
SELECT * FROM users LIMIT 10;


-- 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.
ALTER TABLE users MODIFY COLUMN created_at DATETIME;

ALTER TABLE users MODIFY COLUMN updated_at DATETIME;

UPDATE users SET created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP;


-- 2. ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10".
-- ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
ALTER TABLE users MODIFY COLUMN created_at VARCHAR(25);

ALTER TABLE users MODIFY COLUMN updated_at VARCHAR(25);

UPDATE users SET 
	created_at = CONCAT(ROUND(1 + RAND() * 28), '.', ROUND(1 + RAND() * 12), '.', ROUND(2000 + RAND() * 20), ' ', ROUND(RAND() * 24), ':', ROUND(RAND() * 59)),
	updated_at = CONCAT(ROUND(1 + RAND() * 28), '.', ROUND(1 + RAND() * 12), '.', ROUND(2000 + RAND() * 20), ' ', ROUND(RAND() * 24), ':', ROUND(RAND() * 59));

UPDATE users SET
	created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');

ALTER TABLE users MODIFY COLUMN created_at DATETIME;

ALTER TABLE users MODIFY COLUMN updated_at DATETIME;


-- 3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. 
-- ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. ������, ������� ������ ������ ���������� � �����, ����� ���� �������.
INSERT INTO storehouses_products 
	(storehouse_id, product_id, value)
VALUES
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5),
	(1 + RAND() * 10, 1 + RAND() * 7, RAND() * 5);

SELECT * FROM storehouses_products;

UPDATE storehouses_products 
	SET value = 0
	WHERE storehouse_id >= 9;

SELECT value, IF(value, FALSE, TRUE) as tmp FROM storehouses_products ORDER BY tmp, value;


-- 4. (�� �������) �� ������� users ���������� ������� �������������, ���������� � ������� � ���. ������ ������ � ���� ������ ���������� �������� ('may', 'august')
SELECT * FROM users LIMIT 10;

SELECT name, birthday_at FROM users WHERE birthday_at RLIKE '-05-' OR birthday_at RLIKE '-08-';


-- 5. (�� �������) �� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2); ������������ ������ � �������, �������� � ������ IN.
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY field(id, 5, 1, 2);


-- ������������ ������� ���� ���������� �������
-- 1. ����������� ������� ������� ������������� � ������� users
SELECT * FROM users;

SELECT AVG(DATEDIFF(NOW(), birthday_at) DIV 365) FROM users;


-- 2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.
INSERT INTO users (name, birthday_at) VALUES
  ('��������-2', '1990-10-05'),
  ('�������-2', '1984-11-12'),
  ('���������-2', '1985-05-20'),
  ('�������-3', '1984-11-12'),
  ('���������-3', '1985-05-20'),
  ('���������-4', '1985-05-20');

 SELECT 
	COUNT(*) AS total, 
	DAYNAME(CONCAT(EXTRACT(YEAR FROM NOW()), '-', EXTRACT(MONTH FROM birthday_at), '-', EXTRACT(DAY FROM birthday_at))) AS dob 
FROM 
	users
GROUP BY 
	dob 
ORDER BY
	total;


-- 3. (�� �������) ����������� ������������ ����� � ������� �������
CREATE TEMPORARY TABLE tbl (value INT);

INSERT INTO tbl VALUES (1), (2), (3), (4); 

SELECT * FROM tbl;

SELECT ROUND(EXP(SUM(LOG(value))), 1)
FROM tbl
WHERE value != 0;