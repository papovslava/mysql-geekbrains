-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение.
-- Агрегация данных
-- Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:
USE vk;
SHOW TABLES;

-- 1. Создать все необходимые внешние ключи и диаграмму отношений.
-- 2. Создать и заполнить таблицы лайков и постов.
DESC communities_users;

ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
    	ON DELETE SET NULL,
  ADD CONSTRAINT communities_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
   		ON DELETE SET NULL;


DESC friendship;

ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    	ON DELETE CASCADE,
  ADD CONSTRAINT friendship_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id)
    	ON DELETE CASCADE,
  ADD CONSTRAINT friendship_status_id_fk 
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
   		ON DELETE CASCADE;

DESC friendship_statuses;
DESC likes;

INSERT INTO posts
	(user_id, community_id, head, body, media_id, is_public, is_archived, views_counter)
VALUES
	(1 + RAND() * 100, 1 + RAND() * 10, 'HEAD', 'BODY', 1 + RAND() * 100, TRUE, FALSE, 1 + RAND() * 1000),
	(1 + RAND() * 100, 1 + RAND() * 10, 'HEAD', 'BODY', 1 + RAND() * 100, TRUE, FALSE, 1 + RAND() * 1000),
	(1 + RAND() * 100, 1 + RAND() * 10, 'HEAD', 'BODY', 1 + RAND() * 100, TRUE, FALSE, 1 + RAND() * 1000),
	(1 + RAND() * 100, 1 + RAND() * 10, 'HEAD', 'BODY', 1 + RAND() * 100, TRUE, FALSE, 1 + RAND() * 1000),
	(1 + RAND() * 100, 1 + RAND() * 10, 'HEAD', 'BODY', 1 + RAND() * 100, TRUE, FALSE, 1 + RAND() * 1000),
	(1 + RAND() * 100, 1 + RAND() * 10, 'HEAD', 'BODY', 1 + RAND() * 100, TRUE, FALSE, 1 + RAND() * 1000),
	(1 + RAND() * 100, 1 + RAND() * 10, 'HEAD', 'BODY', 1 + RAND() * 100, TRUE, FALSE, 1 + RAND() * 1000),
	(1 + RAND() * 100, 1 + RAND() * 10, 'HEAD', 'BODY', 1 + RAND() * 100, TRUE, FALSE, 1 + RAND() * 1000),
	(1 + RAND() * 100, 1 + RAND() * 10, 'HEAD', 'BODY', 1 + RAND() * 100, TRUE, FALSE, 1 + RAND() * 1000);

SELECT COUNT(*) FROM posts;

ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    	ON DELETE CASCADE,
  ADD CONSTRAINT likes_target_id_fk 
    FOREIGN KEY (target_id) REFERENCES posts(id)
    	ON DELETE CASCADE,
  ADD CONSTRAINT likes_target_type_id_fk 
    FOREIGN KEY (target_type_id) REFERENCES target_types(id)
   		ON DELETE CASCADE;
 

ALTER TABLE likes DROP FOREIGN KEY likes_target_id_fk;
ALTER TABLE likes
  ADD CONSTRAINT likes_target_id_fk 
    FOREIGN KEY (target_id) REFERENCES users(id)
    	ON DELETE CASCADE;

DESC media;

ALTER TABLE media
	ADD CONSTRAINT media_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT media_media_type_id_fk
		FOREIGN KEY (media_type_id) REFERENCES media_types(id)
			ON DELETE CASCADE;

DESC media_types;

DESC messages;

DESC posts;

UPDATE posts SET community_id = 1 + RAND() * 9 WHERE community_id > 10;

ALTER TABLE posts
	ADD CONSTRAINT posts_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT posts_community_id_fk
		FOREIGN KEY (community_id) REFERENCES communities(id)
			ON DELETE SET NULL,
	ADD CONSTRAINT posts_media_id_fk
		FOREIGN KEY (media_id) REFERENCES media(id)
			ON DELETE SET NULL;

DESC profiles;

-- ALTER TABLE profiles
-- 	ADD CONSTRAINT profiles_user_id_fk
-- 		FOREIGN KEY (user_id) REFERENCES users(id)
-- 			ON DELETE CASCADE,
-- 	ADD CONSTRAINT profiles_photo_id_fk
-- 		FOREIGN KEY (photo_id) REFERENCES media(id)
-- 			ON DELETE SET NULL;

DESC target_types;

DESC user_statuses;

DESC users;

ALTER TABLE users
	ADD CONSTRAINT users_status_id_fk
		FOREIGN KEY (status_id) REFERENCES user_statuses(id)
			ON DELETE CASCADE;

SHOW TABLES;
   	

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
DESC likes;
DESC profiles;

SELECT
	COUNT(*) AS total,
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) as gender
	FROM likes
	GROUP BY gender;


-- 4. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).
DESC likes;
DESC users;
DESC profiles;

SELECT SUM(total) AS summary
	FROM (
		SELECT
				COUNT(*) AS total,
				(SELECT birthday FROM profiles WHERE user_id = likes.target_id) AS dob
			FROM likes
			GROUP BY dob
			ORDER BY dob DESC
			LIMIT 10
) AS A;

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).

DESC users;
SHOW tables;
DESC posts;
DESC likes;
-- пользователей, которые проявляют наименьшую активность: пользователи с наименьшим количеством постов и лайков
SELECT id, num_posts + num_likes AS activity
	FROM (
		SELECT
				id,
				(SELECT COUNT(*) FROM posts WHERE posts.user_id = users.id ORDER BY id) as num_posts,
				(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id ORDER BY id) as num_likes
			FROM users
) AS A 
	ORDER BY activity
	LIMIT 10;
	