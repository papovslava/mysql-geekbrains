SYSTEM cls;

-- Создайте базу данных example, разместите в ней таблицу users, 
-- состоящую из двух столбцов, числового id и строкового name.

CREATE DATABASE IF NOT EXISTS example;
SHOW DATABASES;

USE example

CREATE TABLE users (
	id INT UNSIGNED, 
	name CHAR(10) DEFAULT 'ananymous'
);
INSERT INTO users VALUES (1, DEFAULT);
INSERT INTO users VALUES (2, 'John Doe');

SHOW TABLES;
SELECT * FROM users;

-- Создайте дамп базы данных example из предыдущего задания, 
-- разверните содержимое дампа в новую базу данных sample.

SYSTEM mysqldump example > example.sql
-- SYSTEM mysqladmin create sample
-- SYSTEM cmd.exe /c "mysql sample < example.sql".
CREATE DATABASE IF NOT EXISTS sample;
USE sample;
source example.sql;

SHOW TABLES;
SELECT * FROM users;

DROP DATABASE example;
DROP DATABASE sample;
-- SHOW DATABASES;
SYSTEM del example.sql;

-- (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump.
-- Создайте дамп единственной таблицы help_keyword базы данных mysql
-- Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
 
USE mysql;
SELECT COUNT(*) FROM help_keyword;

CREATE DATABASE IF NOT EXISTS sample;
USE sample;
CREATE TABLE help_keyword_copy AS SELECT * FROM mysql.help_keyword;

SYSTEM mysqldump sample help_keyword_copy --where="help_keyword_id<100" > help_keyword.sql
DROP DATABASE sample;

CREATE DATABASE IF NOT EXISTS sample;
USE sample;
source help_keyword.sql;
select count(*) from help_keyword_copy;
-- show tables;

DROP DATABASE sample;
SYSTEM del help_keyword.sql;