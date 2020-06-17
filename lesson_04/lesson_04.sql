-- http://filldb.info/dummy/step1
-- http://foxtools.ru/Text
-- win-1251 -> utf-8

-- Создание БД для социальной сети ВКонтакте
-- https://vk.com/geekbrainsru

-- Делаем её текущей
USE vk;


SHOW TABLES;
SELECT * FROM users LIMIT 10;
DESC users;
UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;

--
-- Table structure for table `user_statuses`
--

DROP TABLE IF EXISTS `user_statuses`;
CREATE TABLE `user_statuses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `user_statuses` VALUES (1,'active'),(2,'blocked'),(3,'deleted');

SELECT * FROM user_statuses;

ALTER TABLE users ADD status_id INT UNSIGNED AFTER phone;

UPDATE users SET status_id = 1;
UPDATE users SET status_id = 2 WHERE id IN (3, 32, 59, 34);
UPDATE users SET status_id = 3 WHERE id IN (33, 28, 52, 31, 90);

DESC users;

ALTER TABLE users MODIFY status_id INT UNSIGNED NOT NULL DEFAULT 1;

DESC profiles;

SELECT * FROM profiles LIMIT 10;

ALTER TABLE profiles ADD photo_id int UNSIGNED DEFAULT NULL;
ALTER TABLE profiles ADD is_private tinyint(1) UNSIGNED DEFAULT '0';

UPDATE profiles SET photo_id = FLOOR(1 + RAND() * 100);

CREATE TEMPORARY TABLE genders (name CHAR(1));

INSERT INTO genders VALUES ('m'), ('f');

SELECT * FROM genders;

UPDATE profiles SET gender = (SELECT name from genders ORDER BY RAND() LIMIT 1);

CREATE TEMPORARY TABLE countries (name VARCHAR(150));

INSERT INTO countries VALUES ('Russian Federation'), ('Germany'), ('Belarus');

SELECT * FROM countries;

UPDATE profiles SET country = (SELECT name FROM countries ORDER BY RAND() LIMIT 1);

UPDATE profiles SET is_private = TRUE WHERE user_id > FLOOR(1 + RAND() * 100);

SHOW TABLES;

DESC MESSAGES;

SELECT * FROM messages LIMIT 10;

UPDATE messages SET
	from_user_id = FLOOR(1 + RAND() * 100),
	to_user_id = FLOOR(1 + RAND() * 100);

ALTER TABLE messages ADD media_id int UNSIGNED DEFAULT NULL;

UPDATE messages SET media_id = FLOOR(1 + RAND() * 100) WHERE from_user_id > FLOOR(1 + RAND() * 100);

DESC media;

SELECT * FROM media LIMIT 10;

SELECT * FROM media_types;

DELETE FROM media_types;

INSERT INTO media_types (name) VALUES
	('photo'),
	('video'),
	('audio');

TRUNCATE media_types;

UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);
UPDATE media SET user_id = FLOOR(1 + RAND() * 100);

CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png');

SELECT * FROM extensions;

UPDATE media SET filename = CONCAT('https://dropbox/vk/',
	filename,
	'.',
	(SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

UPDATE media SET size = FLOOR (10000 + (RAND() * 1000000)) WHERE size < 1000;

UPDATE media SET metadata = CONCAT('{"owner":"',
	(SELECT CONCAT(first_name, ' ', last_name) FROM users where id = user_id),
	'"}');

ALTER TABLE media MODIFY COLUMN metadata JSON;

DESC friendship;

SELECT * FROM friendship LIMIT 10;

UPDATE friendship SET
	user_id = FLOOR(1 + RAND() * 100),
	friend_id = FLOOR(1 + RAND() * 100);

UPDATE friendship SET friend_id = friend_id +1 WHERE user_id = friend_id;

SELECT * FROM friendship_statuses;

TRUNCATE friendship_statuses;

INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');
 
 UPDATE friendship SET status_id = FLOOR(1 + RAND() * 3);

DESC communities;

SELECT * FROM communities;

DELETE FROM communities WHERE id > 20;

SELECT * FROM communities_users;

UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 10);

-- HELP SELECT;

-- Документация
-- https://dev.mysql.com/doc/refman/8.0/en/
-- http://www.rldp.ru/mysql/mysql80/index.htm
