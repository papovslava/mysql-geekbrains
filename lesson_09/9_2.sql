-- 2. � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. ��������� ����������� ����� ����� ��� ���� �� ���.
-- ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������.
-- ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.

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