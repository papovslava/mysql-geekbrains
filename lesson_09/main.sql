USE shop;

-- Практическое задание по теме “Транзакции, переменные, представления”
-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
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

-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
DESCRIBE products;
DESCRIBE catalogs;
SELECT p.name, c.name FROM products p JOIN catalogs c ON p.catalog_id = c.id;
CREATE VIEW products_catalogs AS SELECT p.name as p_name, c.name as c_name FROM products p JOIN catalogs c ON p.catalog_id = c.id;
SELECT * FROM products_catalogs;

-- 3. (по желанию) Пусть имеется таблица с календарным полем created_at. 
-- В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
CREATE TEMPORARY TABLE tbl ( value DATE );
INSERT INTO tbl VALUES ('2018-08-01'), ('2016-08-04'), ('2018-08-16'), ('2018-08-17');
SELECT * FROM tbl LIMIT 10;
CREATE TEMPORARY TABLE tbl_aug ( value VARCHAR(2) );
INSERT INTO tbl_aug VALUES ('01'), ('02'), ('03'), ('04'), ('05'), ('06'), ('07'), ('08'), ('09'), ('10'),  
	('11'), ('12'), ('13'), ('14'), ('15'), ('16'), ('17'), ('18'), ('19'), ('20'),
	('21'), ('22'), ('23'), ('24'), ('25'), ('26'), ('27'), ('28'), ('29'), ('30'), ('31');
SELECT * FROM tbl_aug;
SELECT CONCAT('2018-08-', tbl_aug.value) AS 'date', (SELECT COUNT(*) FROM tbl WHERE CONCAT('2018-08-', tbl_aug.value) = tbl.value) as 'F/T' FROM tbl_aug;

-- 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
CREATE TEMPORARY TABLE tbl_tmp ( created_at DATE );
INSERT INTO tbl_tmp VALUES ('2018-08-01'), ('2016-08-04'), ('2018-08-16'), ('2018-08-17'), ('2019-09-02'), ('2017-09-05'), ('2019-09-17'), ('2019-09-18');
SELECT * FROM tbl_tmp ORDER BY created_at DESC;
SELECT @threshold := (SELECT * FROM tbl_tmp ORDER BY created_at DESC LIMIT 4, 1);
SELECT @threshold;
DELETE FROM tbl_tmp as tt WHERE created_at < (SELECT @threshold);
SELECT * FROM tbl_tmp ORDER BY created_at DESC;
 
-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

-- решенеи cм. в файле 9_1.sql

-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них.
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

-- решенеи cм. в файле 9_2.sql

