-- 1. ѕроанализировать какие запросы могут выполн€тьс€ наиболее часто в процессе работы приложени€ и добавить необходимые индексы.
USE vk;
DESCRIBE communities;
CREATE INDEX communities_name_idx ON communities(name);
DESCRIBE communities_users; -- думаю, что индексы все ест
DESCRIBE friendship; -- думаю, что индексы все есть
DESCRIBE friendship_statuses;
CREATE INDEX friendship_statuses_name_idx ON friendship_statuses(name);
DESCRIBE likes; -- думаю, что индексы все есть
DESCRIBE media; -- думаю, что индексы все есть
DESCRIBE media_types; -- думаю, что индексы все есть
DESCRIBE messages; -- думаю, что индексы все есть
DESCRIBE posts;
CREATE INDEX posts_views_counter_idx ON posts(views_counter);
DESCRIBE profiles;
CREATE INDEX profiles_city_idx ON profiles(city);
DESCRIBE target_types; -- думаю, что индексы все есть
DESCRIBE user_statuses ; -- думаю, что индексы все есть
DESCRIBE users;
CREATE INDEX users_last_name_idx ON users(last_name);


-- 2. «адание на оконные функции
-- ѕостроить запрос, который будет выводить следующие столбцы:
-- им€ группы
-- среднее количество пользователей в группах
-- самый молодой пользователь в группе
-- самый старший пользователь в группе
-- общее количество пользователей в группе
-- всего пользователей в системе
-- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100

DESCRIBE communities;
DESCRIBE communities_users ;
DESCRIBE users;
DESCRIBE profiles;

SELECT DISTINCT users.email, communities.name,
  AVG(users.id) OVER w AS average, -- среднее количество пользователей в группах
  MIN(profiles.birthday) OVER w AS min, -- самый молодой пользователь в группе
  MAX(profiles.birthday) OVER w AS max, -- самый старший пользователь в группе
  COUNT(users.id) OVER w AS total_usr_cat, -- общее количество пользователей в группе
  (SELECT COUNT(*) FROM users) AS total_usr, -- всего пользователей в системе
  COUNT(users.id) OVER w / (SELECT COUNT(*) FROM users) * 100 AS "%%" -- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100
    FROM (communities
      JOIN communities_users
        ON communities.id = communities_users.community_id
      JOIN users
      	ON users.id = communities_users.user_id
      JOIN profiles
      	ON users.id = profiles.user_id)
        WINDOW w AS (PARTITION BY communities.id);