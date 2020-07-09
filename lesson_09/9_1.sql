-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;

DELIMITER //

CREATE FUNCTION hello(v TIME)
  RETURNS VARCHAR(20) NO SQL

  BEGIN
    DECLARE r VARCHAR(20);
--     DECLARE v TIME DEFAULT '00:00:01';

    IF v > '18:00:00' THEN SET r = 'Добрый вечер';
    ELSEIF v > '12:00:00' THEN SET r = 'Добрый день';
    ELSEIF v > '06:00:00' THEN SET r = 'Добро утро';
    ELSE SET r = 'Доброй ночи';
    END IF;

    RETURN r;
  END //

DELIMITER ;


SELECT '00:00:01', hello('00:00:01') as 'Greeting';
SELECT '06:00:01', hello('06:00:01') as 'Greeting';
SELECT '12:00:01', hello('12:00:01') as 'Greeting';
SELECT '18:00:01', hello('18:00:01') as 'Greeting';