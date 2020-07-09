USE shop;

-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs(
	ref__table_name VARCHAR(255) NOT NULL,
	ref__pr_key BIGINT UNSIGNED NOT NULL,
	ref__name VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP	
) ENGINE=ARCHIVE;

-- users, catalogs и products

DELIMITER //
DROP TRIGGER IF EXISTS users_logs//
CREATE TRIGGER users_logs AFTER INSERT ON users
FOR EACH ROW BEGIN 
	INSERT 
		INTO logs (ref__table_name, ref__pr_key, ref__name)
		VALUES ('users', NEW.id, NEW.name);
END//

DROP TRIGGER IF EXISTS catalogs_logs//
CREATE TRIGGER catalogs_logs AFTER INSERT ON catalogs
FOR EACH ROW BEGIN 
	INSERT 
		INTO logs (ref__table_name, ref__pr_key, ref__name)
		VALUES ('catalogs', NEW.id, NEW.name);
END//

DROP TRIGGER IF EXISTS products_logs//
CREATE TRIGGER products_logs AFTER INSERT ON products
FOR EACH ROW BEGIN 
	INSERT 
		INTO logs (ref__table_name, ref__pr_key, ref__name)
		VALUES ('products', NEW.id, NEW.name);
END//
DELIMITER ;

DELETE FROM users WHERE name='Ivan Ivanov';
INSERT INTO users (name, birthday_at)
  VALUES ('Ivan Ivanov', '1990-10-05');
 
DELETE FROM catalogs WHERE name='Supercomputers';
INSERT INTO catalogs (name)
  VALUES ('Supercomputers');
 
DELETE FROM users WHERE name='Syberia-1000';
INSERT INTO products (name, description, price, catalog_id)
	VALUES ('Syberia-1000', 'Designed by TNBU', 1000000, 1);
 
SELECT * FROM logs;

-- (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

DROP PROCEDURE IF EXISTS generate_users;
DELIMITER //
CREATE PROCEDURE generate_users()
BEGIN
	DECLARE i INT DEFAULT 0;
  WHILE i < 1000000 DO
  	INSERT INTO users (name, birthday_at ) VALUES ('Ivan Ivanov', '1990-10-05');
		SET i = i + 1;
	END WHILE;
END//
DELIMITER ;

CALL generate_users(); -- Execute time (ms)	8270697

SELECT COUNT(*) AS 'TOTAL_USERS' FROM users;
SELECT * FROM users LIMIT 10;


USE shop;
SHOW TABLES;
DESCRIBE catalogs;
DESCRIBE products;
SELECT * FROM catalogs c ;
SELECT * FROM products;