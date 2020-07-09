-- 2. ¬ таблице products есть два текстовых пол€: name с названием товара и description с его описанием. ƒопустимо присутствие обоих полей или одно из них.
-- —итуаци€, когда оба пол€ принимают неопределенное значение NULL неприемлема. »спользу€ триггеры, добейтесь того, чтобы одно из этих полей или оба пол€ были заполнены.
-- ѕри попытке присвоить пол€м NULL-значение необходимо отменить операцию.

USE shop;

DESCRIBE products;

DROP TRIGGER IF EXISTS products_name_description;

DELIMITER //

CREATE TRIGGER products_name_description BEFORE INSERT ON products
FOR EACH ROW BEGIN 
		IF NEW.name IS NULL OR NEW.description IS NULL THEN 
--   IF TRUE THEN 
	  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Either NAME or DESCRIPTION shouldn\'t be NULL';
  END IF;
END//

DELIMITER ;

-- INSERT INTO products (name, description, price, catalog_id) VALUES (NULL, NULL, 10, 1);
-- INSERT INTO products (name, description, price, catalog_id) VALUES (NULL, 'NULL', 10, 1);
-- INSERT INTO products (name, description, price, catalog_id) VALUES ('NULL', NULL, 10, 1);
INSERT INTO products (name, description, price, catalog_id) VALUES ('core i5', 'intel processor', 10, 1);
SELECT * FROM products;