USE vk;

-- Разбор ДЗ к уроку 6

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender
    FROM likes; 

-- Группируем и сортируем
SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender,
	COUNT(*) AS total
    FROM likes
    GROUP BY gender
    ORDER BY total DESC
    LIMIT 1;
   
 -- **************************** мой вариант с join
 SELECT
 		gender,
 		COUNT(*) as total
 	FROM likes l
 		JOIN profiles p 
 			ON p.user_id = l.user_id
	GROUP BY gender
	ORDER BY total DESC 
	LIMIT 1
 ;
 


-- 4. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
-- Вариант с подсчётом лайков за медиафайлы, посты и сообщения
SELECT birthday, user_id, (
  SELECT COUNT(*) FROM likes WHERE 
    (target_id IN (SELECT id FROM media WHERE media.user_id=profiles.user_id) AND target_type_id=3) OR 
    (target_id IN (SELECT id FROM posts WHERE posts.user_id=profiles.user_id) AND target_type_id=4) OR 
    (target_id IN (SELECT id FROM messages WHERE messages.from_user_id=profiles.user_id) AND target_type_id=1) OR
    (target_id=profiles.user_id AND target_type_id=2)
  ) AS likes  FROM profiles ORDER BY birthday DESC LIMIT 10; 

 -- **************************** мой вариант с join
 
SELECT p.birthday, p.user_id, COUNT(DISTINCT l.id) as likes
FROM profiles p
	LEFT JOIN media med
		ON p.user_id = med.user_id
	LEFT JOIN posts pos
		ON p.user_id = pos.user_id		
	LEFT JOIN messages mes
		ON p.user_id = mes.from_user_id	
	LEFT JOIN likes l
		ON (l.target_type_id = 2 AND p.user_id = l.target_id)
			OR (l.target_type_id = 3 AND med.id = l.target_id) 
			OR (l.target_type_id = 4 AND pos.id = l.target_id)
			OR (l.target_type_id = 1 AND mes.id = l.target_id) 
GROUP BY birthday
ORDER BY birthday DESC
LIMIT 10
;
	
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной 
-- сети.     
SELECT 
  id,
	CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS overall_activity 
	  FROM users
	  ORDER BY overall_activity ASC
	  LIMIT 10;

-- **************************** мой вариант с join
	  
SELECT 
	u.id, COUNT(DISTINCT l.id) + COUNT(DISTINCT m.id) + COUNT(DISTINCT m2.id) AS overall_activity 
FROM users u
	LEFT JOIN likes l 
		ON u.id = l.user_id 
	LEFT JOIN media m 
		ON u.id = m.user_id 
 	LEFT JOIN messages m2 
		ON u.id = m2.from_user_id
GROUP BY u.id
ORDER BY overall_activity ASC
LIMIT 10
;