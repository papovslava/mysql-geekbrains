-- https://docs.google.com/document/d/1yE0wn1m-EwqcJ458ga3eCptvBJcSIi1HaBp48OlT5ZI/edit#

USE shop;

-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
SELECT * FROM users LIMIT 10;


-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
ALTER TABLE users MODIFY COLUMN created_at DATETIME;

ALTER TABLE users MODIFY COLUMN updated_at DATETIME;

UPDATE users SET created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP;


-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10".
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
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


-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
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


-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')
SELECT * FROM users LIMIT 10;

SELECT name, birthday_at FROM users WHERE birthday_at RLIKE '-05-' OR birthday_at RLIKE '-08-';


-- 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY field(id, 5, 1, 2);


-- Практическое задание теме “Агрегация данных”
-- 1. Подсчитайте средний возраст пользователей в таблице users
SELECT * FROM users;

SELECT AVG(DATEDIFF(NOW(), birthday_at) DIV 365) FROM users;


-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий-2', '1990-10-05'),
  ('Наталья-2', '1984-11-12'),
  ('Александр-2', '1985-05-20'),
  ('Наталья-3', '1984-11-12'),
  ('Александр-3', '1985-05-20'),
  ('Александр-4', '1985-05-20');

 SELECT 
	COUNT(*) AS total, 
	DAYNAME(CONCAT(EXTRACT(YEAR FROM NOW()), '-', EXTRACT(MONTH FROM birthday_at), '-', EXTRACT(DAY FROM birthday_at))) AS dob 
FROM 
	users
GROUP BY 
	dob 
ORDER BY
	total;


-- 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы
CREATE TEMPORARY TABLE tbl (value INT);

INSERT INTO tbl VALUES (1), (2), (3), (4); 

SELECT * FROM tbl;

SELECT ROUND(EXP(SUM(LOG(value))), 1)
FROM tbl
WHERE value != 0;