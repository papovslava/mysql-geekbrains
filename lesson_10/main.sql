-- 1. ���������������� ����� ������� ����� ����������� �������� ����� � �������� ������ ���������� � �������� ����������� �������.
USE vk;
DESCRIBE communities;
CREATE INDEX communities_name_idx ON communities(name);
DESCRIBE communities_users; -- �����, ��� ������� ��� ���
DESCRIBE friendship; -- �����, ��� ������� ��� ����
DESCRIBE friendship_statuses;
CREATE INDEX friendship_statuses_name_idx ON friendship_statuses(name);
DESCRIBE likes; -- �����, ��� ������� ��� ����
DESCRIBE media; -- �����, ��� ������� ��� ����
DESCRIBE media_types; -- �����, ��� ������� ��� ����
DESCRIBE messages; -- �����, ��� ������� ��� ����
DESCRIBE posts;
CREATE INDEX posts_views_counter_idx ON posts(views_counter);
DESCRIBE profiles;
CREATE INDEX profiles_city_idx ON profiles(city);
DESCRIBE target_types; -- �����, ��� ������� ��� ����
DESCRIBE user_statuses ; -- �����, ��� ������� ��� ����
DESCRIBE users;
CREATE INDEX users_last_name_idx ON users(last_name);


-- 2. ������� �� ������� �������
-- ��������� ������, ������� ����� �������� ��������� �������:
-- ��� ������
-- ������� ���������� ������������� � �������
-- ����� ������� ������������ � ������
-- ����� ������� ������������ � ������
-- ����� ���������� ������������� � ������
-- ����� ������������� � �������
-- ��������� � ��������� (����� ���������� ������������� � ������ / ����� ������������� � �������) * 100

DESCRIBE communities;
DESCRIBE communities_users ;
DESCRIBE users;
DESCRIBE profiles;

SELECT DISTINCT users.email, communities.name,
  AVG(users.id) OVER w AS average, -- ������� ���������� ������������� � �������
  MIN(profiles.birthday) OVER w AS min, -- ����� ������� ������������ � ������
  MAX(profiles.birthday) OVER w AS max, -- ����� ������� ������������ � ������
  COUNT(users.id) OVER w AS total_usr_cat, -- ����� ���������� ������������� � ������
  (SELECT COUNT(*) FROM users) AS total_usr, -- ����� ������������� � �������
  COUNT(users.id) OVER w / (SELECT COUNT(*) FROM users) * 100 AS "%%" -- ��������� � ��������� (����� ���������� ������������� � ������ / ����� ������������� � �������) * 100
    FROM (communities
      JOIN communities_users
        ON communities.id = communities_users.community_id
      JOIN users
      	ON users.id = communities_users.user_id
      JOIN profiles
      	ON users.id = profiles.user_id)
        WINDOW w AS (PARTITION BY communities.id);