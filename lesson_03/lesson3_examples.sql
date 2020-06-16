-- http://filldb.info/dummy/step1
-- http://foxtools.ru/Text
-- win-1251 -> utf-8

-- Создание БД для социальной сети ВКонтакте
-- https://vk.com/geekbrainsru

-- Создаём БД
drop database if exists vk;
CREATE DATABASE vk;

-- Делаем её текущей
USE vk;

-- Создаём таблицу пользователей
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";  

-- Таблица профилей
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
  gender CHAR(1) NOT NULL COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили"; 

-- Таблица сообщений
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки"
) COMMENT "Сообщения";

-- Таблица дружбы
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на инициатора дружеских отношений",
  friend_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя приглашения дружить",
  status_id INT UNSIGNED NOT NULL COMMENT "Ссылка на статус (текущее состояние) отношений",
  requested_at DATETIME DEFAULT NOW() COMMENT "Время отправления приглашения дружить",
  confirmed_at DATETIME COMMENT "Время подтверждения приглашения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",  
  PRIMARY KEY (user_id, friend_id) COMMENT "Составной первичный ключ"
) COMMENT "Таблица дружбы";

-- Таблица статусов дружеских отношений
CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Статусы дружбы";

-- Таблица групп
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сроки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название группы",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Группы";

-- Таблица связи пользователей и групп
-- готово
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (community_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Участники групп, связь между пользователями и группами";

-- Таблица медиафайлов
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который загрузил файл",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы";

-- Таблица типов медиафайлов
-- готово
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";


-- Рекомендуемый стиль написания кода SQL
-- https://www.sqlstyle.guide/ru/

-- Заполняем таблицы с учётом отношений 
-- на http://filldb.info

-- Документация
-- https://dev.mysql.com/doc/refman/8.0/en/
-- http://www.rldp.ru/mysql/mysql80/index.htm


INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (1, 'Zella', 'Leuschke', 'edd.lueilwitz@example.com', '04514618447', '2005-05-12 00:58:55', '1970-06-19 04:48:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (2, 'Kaelyn', 'Howe', 'mittie.monahan@example.net', '(782)861-4647', '1993-05-17 02:43:07', '1993-08-13 12:01:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (3, 'Wyman', 'Roberts', 'donnelly.elva@example.org', '269-846-1869', '1973-08-23 10:35:41', '1992-08-28 09:25:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (4, 'Gudrun', 'Yundt', 'aufderhar.henderson@example.net', '547-611-5620', '1974-08-05 17:46:24', '2004-06-02 21:26:00');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (5, 'Jayne', 'Schneider', 'dianna.douglas@example.org', '(400)273-8913x99118', '2008-11-10 19:16:50', '1997-10-24 21:21:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (6, 'Adriana', 'Sanford', 'o\'keefe.matilda@example.net', '(090)044-9192x0608', '1993-04-05 07:02:25', '1976-02-10 00:11:08');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (7, 'Giovani', 'Weissnat', 'georgianna.sporer@example.org', '09066803917', '2015-06-26 21:39:07', '2012-04-30 08:04:59');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (8, 'Zachery', 'Becker', 'baumbach.nelda@example.org', '1-452-170-1278x44009', '1995-08-18 22:39:00', '2006-11-22 20:54:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (9, 'Cathrine', 'Olson', 'suzanne.farrell@example.org', '1-518-153-2245', '1979-08-27 16:04:08', '1991-03-11 01:45:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (10, 'Franco', 'Carroll', 'chanel.kshlerin@example.org', '(474)470-2518', '1980-04-28 23:59:19', '1975-11-08 07:14:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (11, 'Kristy', 'Moore', 'lonzo32@example.org', '1-309-683-9173', '1994-01-09 03:27:15', '1993-05-20 03:16:14');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (12, 'Augustus', 'Cronin', 'kvolkman@example.org', '(864)841-4684', '1977-02-13 05:01:29', '2010-07-15 06:04:06');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (13, 'Barney', 'Torphy', 'qhills@example.org', '(097)964-1691', '2014-09-07 02:00:18', '1977-08-12 09:37:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (14, 'Muriel', 'Klocko', 'ffisher@example.net', '285-807-5019x5827', '2011-01-19 10:20:32', '1982-04-21 22:29:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (15, 'Hardy', 'Bartoletti', 'dillan.terry@example.com', '476-718-1561', '2002-09-14 22:37:27', '1973-07-17 07:39:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (16, 'Dashawn', 'Greenholt', 'jennings.price@example.net', '968.827.9263', '1991-05-24 03:22:13', '1977-08-26 01:25:38');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (17, 'Rosemarie', 'O\'Connell', 'natalie.gutmann@example.net', '095.755.0066x7479', '2003-10-14 19:33:33', '1990-09-23 00:24:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (18, 'Heather', 'Auer', 'gabriel48@example.net', '1-356-386-1322x7797', '1986-02-14 15:20:11', '1981-12-15 14:29:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (19, 'Geovanny', 'Zulauf', 'ywyman@example.com', '(129)650-8668', '1977-08-06 21:59:45', '1999-02-28 15:58:26');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (20, 'Demetrius', 'Grimes', 'hallie.baumbach@example.org', '197.454.1671x72304', '1974-07-20 00:27:26', '1976-02-08 05:56:25');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (21, 'Bennie', 'Jaskolski', 'ryan.mathias@example.org', '042.867.5177x935', '1973-08-02 15:36:45', '1985-09-12 13:42:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (22, 'Gilda', 'Auer', 'davonte92@example.org', '263.946.8877x3954', '1998-03-03 04:54:22', '1975-07-30 13:42:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (23, 'Idella', 'Harris', 'lyla40@example.org', '(784)629-1824', '2000-05-26 03:01:24', '1983-02-18 15:20:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (24, 'Ryleigh', 'Quitzon', 'eweissnat@example.net', '(645)989-8144x52900', '1982-09-15 09:55:57', '1971-09-06 06:35:14');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (25, 'Keanu', 'Maggio', 'barrows.liliane@example.net', '963-407-2853', '2010-12-26 13:08:47', '1974-01-28 13:53:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (26, 'Mazie', 'Brekke', 'moen.jeanne@example.org', '1-496-333-1604x6703', '1978-09-29 02:32:59', '1999-12-02 08:06:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (27, 'Okey', 'Kessler', 'obatz@example.com', '1-192-823-7514', '1996-05-22 13:03:28', '1985-07-16 10:10:56');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (28, 'Bertha', 'Heidenreich', 'krajcik.hal@example.org', '+62(9)3171695896', '2002-05-02 09:10:46', '1985-12-21 22:39:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (29, 'Lafayette', 'Lebsack', 'berneice.schmidt@example.org', '991.810.7876', '1990-12-11 02:43:28', '2015-10-19 07:19:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (30, 'Enoch', 'Breitenberg', 'ojerde@example.com', '954.478.1975x06334', '1973-04-25 14:48:16', '1985-12-18 13:07:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (31, 'Ayden', 'Rice', 'alec30@example.net', '05882252474', '2019-01-13 02:03:14', '2010-06-22 10:22:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (32, 'Marvin', 'Abshire', 'kennedy.koch@example.com', '844-840-4717x97350', '2013-09-05 23:25:27', '1997-12-27 10:05:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (33, 'Verna', 'Heidenreich', 'walter.albina@example.com', '464-777-0579x62366', '1977-11-21 18:20:17', '1990-08-02 19:04:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (34, 'Leon', 'Rempel', 'wrodriguez@example.com', '1-732-154-4235x88897', '2011-01-10 22:14:52', '2019-03-12 17:38:57');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (35, 'Aaliyah', 'Block', 'barry.von@example.com', '(156)839-8475', '1976-09-16 10:54:24', '1983-03-19 07:30:26');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (36, 'Esperanza', 'Anderson', 'kuhn.clemmie@example.net', '(764)386-0099x96527', '1999-02-18 07:55:49', '2007-06-10 08:58:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (37, 'Edyth', 'Gerhold', 'kirlin.monserrat@example.com', '(743)967-6286x614', '2004-03-02 16:33:45', '2013-12-02 06:45:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (38, 'Gillian', 'Weissnat', 'greyson.breitenberg@example.net', '(228)430-7848x9223', '2010-07-10 12:42:48', '2003-07-03 09:09:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (39, 'Kaleigh', 'Reilly', 'wehner.rafaela@example.com', '096-719-2087x3377', '2012-06-02 16:47:40', '2006-03-14 13:01:49');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (40, 'Velma', 'D\'Amore', 'hwill@example.net', '765-624-1093', '2003-07-28 17:12:40', '2010-07-01 15:41:15');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (41, 'Taryn', 'Eichmann', 'blick.hilario@example.net', '1-535-586-6589x675', '2018-08-06 20:30:07', '1975-09-26 23:14:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (42, 'Cayla', 'Dach', 'sswaniawski@example.net', '09513204043', '1975-11-16 20:02:16', '2016-07-25 01:37:45');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (43, 'Haylee', 'Kirlin', 'hudson.jannie@example.org', '(731)297-4416x09235', '2008-05-28 10:36:49', '2004-10-16 17:20:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (44, 'Rosalee', 'McDermott', 'brennon76@example.com', '461-697-8028x005', '1993-09-09 03:13:13', '1971-12-12 21:20:15');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (45, 'Bud', 'Rolfson', 'armstrong.vincenza@example.org', '855.765.2559x822', '1974-08-24 13:14:54', '1973-11-12 20:05:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (46, 'Cloyd', 'Konopelski', 'marisa.emmerich@example.org', '150-354-3479x912', '2019-11-24 20:21:36', '2016-05-13 23:05:28');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (47, 'Kurt', 'Bosco', 'keebler.nikolas@example.org', '1-789-792-8913x22187', '1988-08-12 09:20:10', '1988-06-04 17:33:59');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (48, 'Myles', 'Gottlieb', 'kathlyn46@example.org', '527.546.2259x955', '2014-12-04 07:29:08', '2014-03-01 10:55:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (49, 'Eva', 'Cole', 'richard09@example.com', '1-048-073-9333x9752', '2009-07-31 00:36:01', '2006-06-29 13:12:31');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (50, 'Kyleigh', 'Fisher', 'schneider.curt@example.com', '1-162-005-3806', '2007-12-13 02:34:32', '1989-05-12 02:14:15');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (51, 'Britney', 'Rau', 'ngleichner@example.net', '528-714-0776x5621', '1972-10-20 12:30:45', '2019-04-05 08:30:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (52, 'Myrna', 'Aufderhar', 'asa61@example.org', '+32(5)9211181177', '1982-05-31 11:51:21', '2002-03-05 14:42:00');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (53, 'Edmond', 'Botsford', 'solson@example.com', '(368)909-6224x4544', '2000-12-08 14:15:23', '1978-06-27 09:37:21');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (54, 'Estel', 'Hyatt', 'lemuel33@example.net', '879.010.3004x6216', '1984-08-30 02:07:21', '2009-05-31 14:00:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (55, 'Catalina', 'Cummings', 'langosh.lambert@example.org', '(816)273-5393x4060', '1990-02-02 23:15:15', '1991-09-17 22:48:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (56, 'Schuyler', 'Effertz', 'fadel.carole@example.net', '(296)214-2320', '1976-01-24 13:33:51', '1986-10-01 15:57:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (57, 'Carolina', 'D\'Amore', 'shanny.raynor@example.org', '1-329-513-2666x70525', '1978-05-04 15:38:12', '1991-12-20 09:51:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (58, 'Domenic', 'Schowalter', 'brannon.konopelski@example.com', '1-029-876-1792x92643', '1976-09-15 07:17:26', '1982-05-21 19:20:04');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (59, 'Nona', 'Considine', 'qhoppe@example.net', '100.277.5026x01139', '1974-07-16 17:38:09', '2006-04-01 23:12:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (60, 'Pietro', 'Cruickshank', 'catherine.larson@example.com', '1-138-492-7224', '1976-03-29 23:20:29', '1997-01-06 15:16:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (61, 'Jillian', 'Weissnat', 'shayne.wiegand@example.net', '(048)690-3766x293', '1972-04-07 20:48:14', '2006-09-12 21:13:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (62, 'Tiffany', 'Spencer', 'vivienne82@example.net', '+42(0)9662046252', '2003-08-15 03:24:36', '1980-05-03 09:50:00');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (63, 'Rahsaan', 'Oberbrunner', 'hettie67@example.net', '208-893-0764', '2011-08-30 18:35:53', '1987-03-30 09:36:57');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (64, 'Alexandrea', 'Labadie', 'white.marcellus@example.org', '(601)968-5538x33853', '2009-10-11 13:25:22', '2015-10-30 08:45:20');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (65, 'Lenora', 'Hills', 'qdicki@example.org', '(104)142-5694x50800', '2018-01-14 03:45:46', '1978-07-22 10:27:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (66, 'Dannie', 'Pollich', 'rbruen@example.org', '1-878-509-1914x5988', '2002-01-08 06:53:01', '2020-03-28 13:47:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (67, 'Einar', 'Collier', 'charles85@example.com', '02071918715', '2000-04-20 21:30:05', '1976-10-25 21:38:02');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (68, 'Keira', 'Rau', 'marta09@example.com', '06997755533', '1993-10-10 14:27:12', '1986-03-11 03:19:48');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (69, 'Jerod', 'Kovacek', 'nbatz@example.org', '+99(2)4074618423', '1978-06-07 05:15:12', '2006-02-14 05:56:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (70, 'Mina', 'Christiansen', 'genevieve48@example.com', '016.742.8962', '2013-07-27 07:32:19', '2016-12-28 09:50:38');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (71, 'Citlalli', 'Bartell', 'rickey21@example.net', '268.005.0448', '1977-01-06 16:29:45', '2018-03-21 19:10:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (72, 'Nicole', 'Marks', 'federico02@example.org', '05625544836', '1982-04-22 14:26:44', '2014-02-09 22:13:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (73, 'Clotilde', 'Kreiger', 'stark.lexie@example.com', '389.179.8636', '1999-07-27 02:06:10', '1978-03-18 11:45:39');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (74, 'Earl', 'Hudson', 'lisa83@example.org', '(190)401-4674x094', '1997-01-10 07:50:54', '1982-04-16 03:58:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (75, 'Johnathan', 'Kassulke', 'whessel@example.net', '1-573-543-2899', '1986-02-13 01:40:48', '1988-03-06 00:38:45');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (76, 'Robin', 'Casper', 'evie21@example.net', '870.278.2027x02953', '2017-12-18 01:39:56', '2009-10-10 17:13:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (77, 'Rocio', 'Baumbach', 'ugusikowski@example.com', '(646)182-8239', '1996-11-02 07:51:42', '1974-06-28 08:19:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (78, 'Madalyn', 'D\'Amore', 'terrence27@example.net', '711.958.9995', '1995-07-28 06:17:03', '2004-01-09 08:11:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (79, 'Jacynthe', 'Bergnaum', 'doyle.jess@example.com', '553.160.3379x4645', '1993-06-10 04:07:22', '1995-10-03 13:14:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (80, 'Magdalena', 'Hammes', 'rodrigo83@example.com', '(779)160-5126', '2011-10-27 03:52:31', '1993-07-24 02:14:28');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (81, 'Ken', 'Koss', 'olen30@example.com', '(832)675-4901x79461', '1972-03-10 16:08:14', '2015-12-12 19:13:05');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (82, 'Edwina', 'Corkery', 'd\'angelo.ward@example.net', '752-443-5021x233', '2017-07-20 15:40:05', '1973-08-19 19:12:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (83, 'Wilton', 'Vandervort', 'adele.schaefer@example.com', '(777)213-4672', '1974-01-18 18:28:42', '1976-12-20 07:47:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (84, 'Dudley', 'Renner', 'fcremin@example.org', '(302)977-2903', '1999-12-12 22:43:48', '1980-02-14 19:39:49');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (85, 'Eloisa', 'Krajcik', 'giuseppe86@example.org', '978.022.5366x7951', '2003-04-27 20:07:31', '2013-11-25 09:21:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (86, 'Davin', 'Murphy', 'merritt.bernier@example.com', '1-260-863-1204x951', '2018-10-14 22:55:31', '1991-02-18 16:39:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (87, 'Lavada', 'Heathcote', 'gblick@example.org', '116.112.9138', '2003-10-27 16:10:40', '2000-07-17 03:17:56');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (88, 'Hellen', 'Monahan', 'yrau@example.org', '07803822615', '1994-01-15 05:05:39', '2015-03-10 05:05:29');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (89, 'Bill', 'Koepp', 'wintheiser.craig@example.org', '1-234-677-9060x4830', '1995-10-19 08:59:29', '2000-08-29 18:12:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (90, 'Savion', 'Crist', 'ashley93@example.net', '507.516.7779x7762', '1975-04-25 11:01:44', '2011-01-20 01:17:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (91, 'Amya', 'Beer', 'gregorio41@example.org', '1-430-925-5820', '2016-09-13 05:58:03', '1970-02-01 17:03:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (92, 'Jackie', 'Cronin', 'flavie53@example.net', '1-191-266-2810', '2019-11-09 08:58:37', '1979-07-21 06:40:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (93, 'Brooklyn', 'DuBuque', 'hammes.cyril@example.net', '+46(1)9294528743', '2018-12-14 19:33:58', '2000-12-14 21:20:15');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (94, 'Earl', 'Grimes', 'iluettgen@example.com', '+70(8)3177693721', '2012-09-13 19:37:19', '1997-10-19 07:28:36');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (95, 'Keanu', 'Bins', 'antoinette51@example.org', '(181)809-2763x91834', '1971-09-10 18:59:03', '2009-06-14 19:52:25');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (96, 'Jalyn', 'Ullrich', 'treutel.eldora@example.org', '(496)955-0166', '1985-08-21 17:31:17', '1993-05-15 03:51:37');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (97, 'Lance', 'Nienow', 'yferry@example.com', '1-853-508-6098x65616', '2001-10-26 23:25:28', '1976-04-02 03:47:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (98, 'Tito', 'Schulist', 'wilford.vonrueden@example.net', '372.934.2427x97214', '2017-07-23 18:41:12', '2000-11-18 06:31:31');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (99, 'Keyon', 'Reichert', 'anthony59@example.org', '05652673822', '1970-11-13 22:06:19', '1973-09-23 03:33:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (100, 'Brendon', 'Corwin', 'ogibson@example.org', '790-419-1216x19481', '1973-01-28 04:17:42', '1985-03-12 01:15:25');


INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (1, 'M', '2002-03-08', 'West Iva', 'Jersey', '2007-12-26 23:06:10', '1999-09-01 09:46:50');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (2, 'F', '1975-01-12', 'North Stanfordhaven', 'Bangladesh', '2006-05-02 18:15:24', '1991-02-28 22:09:30');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (3, 'M', '1982-12-27', 'South Lloyd', 'Dominica', '1987-09-29 06:25:14', '2004-08-28 22:03:54');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (4, 'M', '2013-04-10', 'South Liza', 'Maldives', '1997-04-03 06:58:00', '1997-07-07 07:37:34');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (5, 'M', '1973-03-25', 'Cletusport', 'Jordan', '2004-12-16 11:41:35', '2000-02-18 03:00:30');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (6, 'F', '2007-07-01', 'Obieport', 'Marshall Islands', '1999-04-04 07:40:44', '1970-03-09 01:34:53');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (7, 'M', '1995-07-08', 'Deonfurt', 'Saint Helena', '1994-11-01 09:23:28', '2014-08-09 06:18:50');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (8, 'M', '2010-12-24', 'Elianmouth', 'Guinea', '2009-03-12 05:28:53', '2015-05-05 06:08:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (9, 'M', '2019-02-15', 'Port Maciport', 'Trinidad and Tobago', '1983-07-27 04:39:10', '1993-08-11 17:27:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (10, 'M', '1997-12-07', 'South Vivabury', 'Zambia', '1970-12-05 10:23:10', '1991-03-18 10:44:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (11, 'M', '2009-12-30', 'West Aleneborough', 'Argentina', '2012-06-23 13:19:34', '2008-09-14 09:20:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (12, 'F', '1989-10-13', 'East Allyshire', 'Bosnia and Herzegovina', '2018-11-21 05:04:54', '2009-02-20 06:19:08');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (13, 'F', '1976-12-19', 'Bogisichberg', 'Netherlands Antilles', '2000-06-12 13:05:25', '1998-03-31 16:38:53');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (14, 'F', '1973-10-12', 'Lake Erwinchester', 'Croatia', '2019-01-24 17:51:45', '1973-08-10 23:23:24');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (15, 'M', '1978-01-16', 'Murazikton', 'Tunisia', '2015-01-12 08:05:57', '1993-09-11 21:24:22');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (16, 'M', '1998-06-19', 'Hammestown', 'Haiti', '2008-09-10 23:54:56', '2002-04-19 23:25:25');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (17, 'M', '1977-03-02', 'Gradyberg', 'Wallis and Futuna', '1993-07-21 03:19:05', '2005-02-18 00:43:29');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (18, 'M', '1988-02-15', 'Wisokyside', 'Antarctica (the territory South of 60 deg S)', '2002-11-19 22:36:29', '2011-11-06 12:46:33');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (19, 'M', '2017-02-20', 'West Thea', 'Georgia', '1977-10-09 15:41:51', '2016-03-20 11:23:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (20, 'M', '2014-08-22', 'Ashleeville', 'Pitcairn Islands', '1978-05-12 23:29:09', '1980-01-11 12:13:00');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (21, 'F', '1971-11-05', 'New Austen', 'Mayotte', '2014-11-21 18:03:56', '1977-08-18 04:29:46');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (22, 'F', '2006-01-27', 'New Kamrynborough', 'Namibia', '1993-09-24 08:28:46', '2006-03-10 15:15:27');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (23, 'F', '1972-04-19', 'Carmellaview', 'Bosnia and Herzegovina', '1973-06-03 19:45:59', '1997-01-09 08:09:12');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (24, 'M', '1978-07-03', 'North Sventon', 'Denmark', '1989-10-12 06:22:51', '2001-02-04 04:15:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (25, 'F', '2016-02-15', 'West Garettshire', 'Nigeria', '1970-09-30 01:10:34', '2008-03-07 01:05:21');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (26, 'F', '1978-11-17', 'Jaedenfort', 'Austria', '2013-07-31 23:12:41', '1974-08-07 01:24:22');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (27, 'M', '1987-07-19', 'Lake Maritzaland', 'Belgium', '2010-11-17 11:46:44', '1984-08-20 08:50:32');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (28, 'M', '2008-08-19', 'South Coreneside', 'Austria', '1974-05-01 18:44:09', '1978-11-29 09:55:01');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (29, 'F', '2010-02-28', 'South Alejandra', 'Macedonia', '2000-12-09 17:43:29', '2016-09-24 00:48:08');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (30, 'M', '2001-05-27', 'South Maud', 'Honduras', '1991-07-02 15:23:25', '1971-07-21 04:08:52');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (31, 'F', '1993-11-16', 'East Braedenchester', 'Jordan', '1976-10-24 06:58:26', '1993-01-12 01:01:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (32, 'F', '2008-02-26', 'Stehrfurt', 'Kyrgyz Republic', '1976-02-25 03:59:37', '1971-04-26 05:31:18');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (33, 'M', '1970-05-18', 'Schimmelmouth', 'Kuwait', '2008-10-18 20:27:58', '1982-01-08 05:32:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (34, 'F', '2000-07-10', 'Lake Sage', 'Palau', '1996-12-25 19:16:55', '2016-12-15 17:04:41');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (35, 'F', '2017-02-09', 'Evansmouth', 'Israel', '2003-08-07 23:29:54', '2004-12-28 07:32:50');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (36, 'F', '1992-10-08', 'New Donny', 'Jamaica', '1974-08-31 11:19:43', '1997-09-18 11:40:22');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (37, 'F', '2001-10-01', 'West Antoniobury', 'Switzerland', '2011-10-02 16:50:03', '1977-11-01 00:24:24');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (38, 'F', '1975-05-02', 'Mitchellside', 'Russian Federation', '1979-01-31 06:11:30', '2003-04-29 00:16:10');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (39, 'F', '2000-06-13', 'Greenfelderchester', 'Botswana', '1982-01-12 09:14:51', '1979-08-18 05:21:41');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (40, 'F', '1981-12-10', 'Port Ken', 'Chad', '2003-07-22 23:34:39', '1997-04-10 14:31:02');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (41, 'M', '2013-10-29', 'Ratkeland', 'Malaysia', '1974-01-19 01:59:15', '2015-07-12 23:19:48');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (42, 'F', '1983-06-11', 'New Malliemouth', 'Latvia', '2008-08-31 05:27:18', '1995-05-24 05:23:06');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (43, 'F', '1991-04-17', 'Gianniberg', 'Indonesia', '2004-01-30 21:16:32', '2001-04-20 23:25:41');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (44, 'F', '1974-11-16', 'North Hayley', 'Honduras', '1979-11-10 13:55:48', '1978-03-16 18:30:20');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (45, 'F', '2004-02-04', 'Coymouth', 'Albania', '1982-02-01 08:57:17', '1993-11-01 11:10:21');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (46, 'F', '1991-12-30', 'West Zetta', 'Iraq', '1987-11-02 20:21:00', '2013-01-16 05:09:21');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (47, 'F', '2006-10-20', 'Eloisabury', 'Belgium', '1980-07-03 06:57:45', '1981-08-22 02:53:18');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (48, 'F', '2000-11-14', 'Lake Emmittshire', 'South Georgia and the South Sandwich Islands', '2020-04-15 18:08:48', '1999-05-15 22:53:06');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (49, 'M', '2008-03-13', 'Hegmannshire', 'France', '2014-10-13 17:15:22', '1991-06-20 17:02:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (50, 'M', '2018-11-03', 'Port Sydnee', 'Nigeria', '2020-01-28 20:38:18', '2000-10-05 04:26:34');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (51, 'F', '1988-05-12', 'Amieburgh', 'Ireland', '1989-12-28 19:50:43', '2006-07-11 15:47:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (52, 'M', '1981-10-06', 'Vonmouth', 'Fiji', '1995-09-09 02:04:55', '1989-03-13 04:40:02');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (53, 'F', '1993-04-08', 'Konopelskiport', 'Tokelau', '2015-05-27 01:56:13', '2017-11-20 03:34:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (54, 'F', '1985-10-21', 'Prohaskaland', 'Costa Rica', '2005-10-27 06:26:45', '1974-07-01 21:32:41');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (55, 'F', '1971-02-24', 'East Tyree', 'Korea', '1999-05-22 10:10:43', '1977-08-24 01:16:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (56, 'F', '2000-10-09', 'West Mekhi', 'Norfolk Island', '2005-01-26 23:00:16', '1992-11-26 10:20:51');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (57, 'M', '1982-10-07', 'Bodemouth', 'Kazakhstan', '2004-09-12 22:43:54', '1976-10-04 10:30:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (58, 'F', '1990-12-26', 'Antoinetteland', 'Tonga', '1989-01-20 00:05:37', '2017-01-21 03:06:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (59, 'F', '2015-05-01', 'Reichertside', 'Bhutan', '2016-12-29 13:54:24', '2019-03-06 20:50:03');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (60, 'M', '2007-01-23', 'Mabelburgh', 'Ghana', '2012-03-30 04:43:17', '1994-03-04 22:36:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (61, 'M', '2019-10-03', 'Bahringertown', 'Pitcairn Islands', '1978-03-28 08:48:56', '1985-10-15 01:05:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (62, 'F', '1988-05-23', 'Lenoraton', 'Hong Kong', '2017-08-19 21:17:33', '1987-07-03 17:06:52');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (63, 'M', '1976-03-27', 'Lake Revaland', 'Solomon Islands', '1983-05-14 03:22:33', '1974-08-03 05:58:35');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (64, 'F', '1972-12-25', 'Julianaside', 'Lesotho', '2014-09-09 08:29:44', '2008-03-12 05:39:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (65, 'F', '2009-03-05', 'Genesisfort', 'Honduras', '2008-08-23 00:07:38', '1982-09-27 16:10:18');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (66, 'M', '1995-07-01', 'Ebertberg', 'Bahrain', '1992-05-10 07:11:06', '1971-05-23 08:36:10');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (67, 'F', '2000-05-05', 'South Edgardo', 'Peru', '2011-01-14 23:57:05', '2013-02-15 02:09:25');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (68, 'F', '1999-09-09', 'Lake Johnton', 'Kenya', '1994-03-29 05:24:04', '2007-09-25 05:00:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (69, 'F', '1985-07-17', 'Hamillville', 'Hungary', '2004-12-22 22:52:31', '1989-09-17 00:48:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (70, 'M', '1979-04-22', 'New Madisenstad', 'Ecuador', '1970-04-19 00:33:56', '1983-07-23 05:52:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (71, 'M', '1996-08-04', 'West Reneemouth', 'Lithuania', '1999-01-26 06:55:21', '1990-10-02 16:39:22');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (72, 'F', '2001-07-29', 'Macejkovicborough', 'French Guiana', '1975-03-29 10:17:41', '1973-03-06 08:10:53');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (73, 'M', '1971-04-27', 'Faustochester', 'Brazil', '1975-09-19 21:10:19', '1997-08-18 07:15:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (74, 'M', '2011-04-06', 'North Jarred', 'Fiji', '1992-08-27 00:24:28', '1993-01-31 01:07:30');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (75, 'F', '1972-11-08', 'Lake Lela', 'Senegal', '1990-01-22 15:13:25', '1975-08-15 09:21:43');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (76, 'M', '1986-03-07', 'North Jammie', 'Faroe Islands', '1982-08-06 16:08:49', '2006-08-17 12:25:15');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (77, 'F', '1995-06-19', 'West Faustino', 'New Zealand', '1975-10-10 10:56:02', '1998-08-05 01:01:34');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (78, 'F', '1981-11-11', 'Wymanbury', 'Burkina Faso', '2013-12-24 22:49:34', '1978-07-09 16:37:03');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (79, 'F', '1981-12-11', 'Lake Nicole', 'Uganda', '1985-04-08 21:07:42', '1982-06-10 13:04:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (80, 'M', '1973-07-16', 'Clemmiefort', 'Tonga', '2000-07-13 21:14:22', '1992-07-19 10:25:06');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (81, 'M', '1988-10-10', 'New Jackelinemouth', 'Ethiopia', '1970-09-12 16:22:45', '2001-06-26 02:28:19');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (82, 'M', '2012-06-15', 'West Edport', 'Egypt', '1998-10-06 05:47:54', '1985-06-13 13:26:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (83, 'F', '2002-02-16', 'Opheliatown', 'Austria', '1987-08-20 03:21:44', '2012-07-11 02:06:52');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (84, 'F', '2002-07-18', 'Aufderharton', 'Barbados', '1986-05-22 18:56:22', '1988-05-12 08:58:06');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (85, 'F', '1975-10-21', 'Cronabury', 'Saudi Arabia', '1995-12-22 15:45:20', '2015-06-24 22:31:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (86, 'M', '2001-01-30', 'Lilianeview', 'Spain', '1988-01-19 22:56:33', '1970-09-06 14:19:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (87, 'M', '2013-01-06', 'Stuartstad', 'Saudi Arabia', '1978-06-03 23:58:24', '1987-07-13 03:40:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (88, 'F', '1992-04-12', 'Bernhardland', 'Syrian Arab Republic', '1986-06-19 05:37:17', '1995-04-07 20:38:44');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (89, 'M', '1973-01-14', 'New Rorymouth', 'Puerto Rico', '1989-12-03 09:58:08', '2000-10-05 06:46:25');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (90, 'F', '1994-11-02', 'Athenachester', 'Zambia', '1987-08-23 20:08:10', '2009-01-01 14:10:15');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (91, 'M', '2003-12-11', 'New Litzyside', 'Greece', '1980-10-13 15:05:17', '2002-09-10 19:55:44');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (92, 'F', '2008-07-12', 'West Eldon', 'Sri Lanka', '1983-12-24 18:53:24', '2014-03-19 06:33:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (93, 'M', '1982-12-21', 'Davisport', 'Timor-Leste', '2011-01-14 22:26:21', '1970-01-11 03:49:40');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (94, 'F', '1979-01-09', 'Schroedermouth', 'Sao Tome and Principe', '1985-04-22 18:17:20', '2018-04-22 02:59:48');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (95, 'F', '2007-10-28', 'Lake Ophelia', 'Martinique', '1983-09-13 00:36:11', '1974-07-09 08:11:26');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (96, 'F', '1980-05-09', 'Jammiefort', 'Faroe Islands', '1987-12-11 16:10:02', '2010-01-20 06:37:42');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (97, 'M', '1978-08-27', 'Dudleyside', 'China', '1974-07-10 13:41:30', '1989-07-16 18:35:34');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (98, 'F', '1998-04-30', 'Kyraberg', 'Poland', '2018-03-17 09:09:26', '1988-12-15 16:04:07');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (99, 'M', '1978-12-21', 'Port Stephaniaton', 'Jordan', '1987-02-26 13:14:53', '1982-11-11 21:42:42');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (100, 'F', '1982-02-22', 'Port Ellietown', 'Lao People\'s Democratic Republic', '2004-02-09 09:43:23', '2002-06-09 14:50:20');


INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (1, 6, 95, 'Nihil nemo at porro quas voluptatem expedita neque. Ducimus eaque voluptatem quos sapiente saepe dolorum sit. Voluptate repellat ducimus non saepe nulla quod.', 1, 0, '1994-01-10 17:48:44');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (2, 92, 56, 'Enim hic quidem id. Aut sint quasi officiis aperiam ut dolorem molestias culpa. At sequi suscipit voluptates rerum ipsa cumque. Magnam quaerat est voluptate aut explicabo sed autem.', 1, 1, '1970-08-19 07:03:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (3, 81, 29, 'Voluptatem et rerum nobis harum aut aspernatur quo voluptatum. Provident veniam quo omnis qui saepe dolores. Sed sit modi omnis amet. Maiores qui quod rerum totam pariatur labore eum harum.', 0, 1, '2010-05-18 08:15:35');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (4, 33, 1, 'Perspiciatis sunt mollitia deleniti nostrum. Repudiandae id consequatur corporis nemo accusantium et. Rerum et cum error cum qui perferendis iste.', 1, 1, '1989-01-26 15:59:54');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (5, 39, 88, 'Nam quae fuga vel. Magnam aliquam autem nostrum laudantium quae. Expedita quis nemo eos deleniti ipsum doloremque sint voluptas.', 0, 0, '2009-11-30 03:39:41');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (6, 32, 1, 'Deleniti labore doloribus ipsum sapiente. Veritatis suscipit omnis qui nulla. Ex voluptate odio libero explicabo eligendi. Dolorem itaque nemo velit molestias saepe.', 1, 0, '1991-07-15 06:02:27');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (7, 47, 66, 'Repellendus voluptatibus maiores ut fugit ad et voluptates. Nemo consequuntur voluptatem consequuntur. Et deserunt laboriosam reprehenderit. Est sed et optio veritatis. Esse dolorem enim sit non.', 0, 0, '2015-04-30 16:34:53');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (8, 42, 70, 'Commodi voluptatem rem sapiente qui quae. Explicabo neque hic debitis quidem deserunt. Qui qui dolores consequatur quia vel. Nesciunt ad quis est et ipsum aspernatur voluptatem.', 1, 1, '2013-02-17 20:34:34');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (9, 9, 57, 'Itaque numquam id nam totam excepturi mollitia placeat. Nihil repudiandae quis laborum. Qui quasi velit ad.', 1, 0, '1991-09-21 01:43:36');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (10, 59, 86, 'Vel et et dignissimos sapiente sed quia. Modi laborum sit accusamus minus maiores modi.', 1, 0, '1990-10-12 21:53:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (11, 6, 92, 'Autem porro qui odit doloremque provident. Nesciunt et accusamus voluptatum et eveniet nostrum. Quia quia amet voluptas quia officia.', 0, 1, '1984-01-28 23:52:28');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (12, 22, 70, 'Dignissimos enim impedit voluptatem deleniti temporibus quia. Aspernatur sit quae doloremque natus ut et. Voluptas quae iusto non incidunt. Est quidem reprehenderit et.', 0, 0, '1987-11-22 13:12:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (13, 13, 97, 'Aut enim consequatur fugit dolorem ad veniam libero. Qui autem perferendis vel repellendus fugit recusandae vel. Dolor ab est illo.', 1, 1, '1976-03-14 04:51:25');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (14, 8, 49, 'Aperiam quos voluptatem est dolores repellendus eum nihil. Accusantium deleniti error praesentium iusto pariatur quaerat. Qui similique nobis ut et optio ipsam.', 1, 0, '1974-08-30 14:19:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (15, 53, 71, 'Est minima quidem quisquam id voluptas harum. Animi sed ducimus sit omnis cumque fugiat quod. In fugit reprehenderit ad dolores ut dolorum amet numquam.', 0, 0, '2015-09-24 18:21:39');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (16, 78, 14, 'Doloremque provident repudiandae debitis quia accusamus. Magni consequatur quo odio sed. Illo sed libero tempore voluptatem at.', 1, 0, '1974-02-06 15:15:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (17, 60, 22, 'Ratione nostrum ea sunt quam rerum quaerat dolores non. Perspiciatis sit eius optio ut molestiae velit nobis. Dolores et aut rerum sunt et vel aut.', 0, 1, '1991-10-23 13:06:31');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (18, 68, 95, 'Culpa repudiandae voluptas autem id autem nisi. Delectus est temporibus velit autem. Mollitia vero nihil et deserunt tempora ipsum. Qui ullam iusto qui libero.', 0, 0, '1979-04-07 16:02:14');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (19, 70, 62, 'Qui non voluptas officiis adipisci voluptate perspiciatis. Omnis consequatur voluptas sed eius corrupti. Autem quos exercitationem vero minima. Illo et consequatur quia reiciendis at. Voluptas mollitia iste autem nulla odit dolor.', 1, 1, '2000-11-26 18:23:29');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (20, 23, 74, 'Dignissimos ut vel ullam qui veniam amet sapiente et. Eveniet atque culpa consequatur cumque at. Et porro maxime ea expedita accusantium.', 0, 0, '2016-11-30 16:28:00');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (21, 64, 52, 'Veritatis ea sit asperiores assumenda ut veritatis. Nobis reprehenderit eos magni labore fuga eligendi. Qui vel minima qui facilis voluptate. Repudiandae quos numquam saepe optio.', 1, 0, '1981-01-22 04:08:39');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (22, 10, 36, 'Possimus sequi voluptates quia voluptatem exercitationem quasi. Expedita corporis occaecati voluptatum quia cum non veniam. Rerum ducimus dolorum libero impedit.', 1, 0, '1990-11-21 11:11:50');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (23, 46, 73, 'Fugit iste autem nam voluptatem sint repellat. Non dolor corporis et reiciendis soluta. Sapiente tenetur explicabo aut omnis. Nobis nulla dignissimos odit ea.', 1, 0, '2003-03-29 00:05:10');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (24, 35, 15, 'Amet doloremque qui consequuntur dolor. Et architecto quis ad quod atque recusandae est. Quam totam incidunt aut aperiam.', 1, 0, '2007-07-19 02:33:58');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (25, 89, 71, 'Voluptas aut odit quaerat in odio delectus sapiente. Sit inventore repellat eos sit. Est voluptas et cupiditate voluptates corrupti.', 1, 1, '2009-11-05 06:16:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (26, 24, 77, 'Et beatae in veniam et illum. Possimus accusantium pariatur aut. Consequatur neque eveniet cumque vel ea deleniti quis dolor.', 0, 0, '1974-03-07 05:33:11');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (27, 13, 84, 'Et consequatur quos deleniti autem et animi. Et quidem autem rerum. Vitae et fugit maxime cumque facilis aut. Rerum ratione similique ut animi eos.', 1, 0, '1995-05-07 19:50:42');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (28, 97, 5, 'Atque laboriosam expedita quia amet sed sint asperiores facere. Illum at quas veniam. Alias iste aut repellat fuga recusandae nesciunt. Aut omnis iusto qui eveniet consequatur amet reiciendis.', 0, 1, '1990-05-08 08:47:02');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (29, 63, 76, 'Quod dolores rerum sunt. Aut quia porro asperiores dolor perferendis. Sint sit eos neque cumque quia iure debitis.', 1, 0, '2014-03-16 05:40:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (30, 82, 78, 'Et optio minus quia reprehenderit explicabo repudiandae minus. Ipsum reiciendis est voluptate. Sunt nisi voluptatem similique ut. Non quae aut tenetur enim et sit. Odit delectus dolorem et sint excepturi enim totam iste.', 0, 0, '1971-11-26 19:30:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (31, 1, 79, 'Ut provident rerum aut architecto ipsa ut. Magnam non ducimus et laboriosam repellendus. Aut molestiae qui tempora iste debitis inventore nulla. Est sapiente inventore quia nemo.', 0, 0, '1990-10-16 00:10:56');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (32, 12, 24, 'Aut fugiat nemo aliquid enim ea quaerat. Qui quas ad perspiciatis corrupti sint dolores. Reiciendis non temporibus cupiditate qui eos et tenetur debitis. Nostrum illo eum commodi.', 1, 1, '2010-07-04 03:39:22');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (33, 46, 52, 'Ipsa qui vitae deserunt dolore iure. Et qui cum et tempora omnis. Temporibus possimus rem deserunt neque perferendis magni.', 0, 1, '1989-08-25 22:31:44');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (34, 78, 52, 'Est minima maiores repellat atque repellat aut. Quis ut consequatur velit nam. Quis et praesentium modi molestiae minima qui. Porro harum ullam fuga dolorum sit maxime cupiditate. Id ut voluptatum et in ipsa quia veniam.', 1, 1, '1996-07-26 08:09:48');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (35, 31, 82, 'Voluptatem numquam at occaecati magni facere consectetur voluptatem et. Distinctio dolorum quas in qui. Eos dolor nobis quasi voluptatibus.', 0, 0, '2019-12-30 15:38:49');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (36, 18, 76, 'Aut aut nemo itaque pariatur accusamus. Repellat illum eius sunt harum eaque excepturi et. Sunt aperiam ullam qui sit soluta quo qui at. Voluptatem non quisquam totam omnis earum aut. Possimus libero neque perspiciatis unde cupiditate.', 0, 1, '2000-02-04 03:16:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (37, 64, 21, 'Voluptatem rerum rerum voluptatem facere eos. Et eum officiis quis cum optio eos delectus. Magnam officiis nihil sit.', 1, 1, '2006-07-15 04:19:21');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (38, 64, 66, 'Repellat aut distinctio quae est error. Voluptatem dolores quod corrupti eos laborum et non. Optio asperiores ullam deserunt repudiandae iure corporis ut. Incidunt quod dolor unde fugiat non.', 1, 0, '1980-05-07 00:07:13');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (39, 85, 15, 'Aut qui non necessitatibus omnis nisi nulla. Distinctio eius dicta blanditiis consequatur minus aspernatur rerum. Labore quasi doloremque laborum earum nostrum. Ut aut hic placeat incidunt nam qui asperiores. Voluptatem illum soluta magnam.', 1, 1, '2015-05-09 09:50:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (40, 14, 34, 'Et eligendi architecto iste quibusdam ab recusandae. Aut ut maiores deleniti eum et atque et. Impedit rem eligendi soluta.', 1, 1, '2001-02-21 20:55:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (41, 27, 16, 'Voluptatem et autem omnis nesciunt autem. At provident corporis natus. Voluptatem ea officiis recusandae ea dolor nihil eum inventore. Molestiae quis qui sed optio dolore dolorum sit.', 1, 0, '1983-05-24 08:10:39');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (42, 26, 54, 'Laborum in molestiae eius tempora recusandae qui aut. Reiciendis cum ea quo voluptatibus exercitationem.', 0, 0, '2007-05-25 09:01:02');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (43, 34, 22, 'Et totam corporis eveniet cumque. Nostrum culpa reiciendis culpa iusto beatae culpa quas. Ratione laudantium non placeat. Corrupti aut laudantium ipsam totam. Velit beatae porro voluptas doloribus enim totam unde ullam.', 0, 0, '2017-03-05 06:41:40');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (44, 4, 26, 'Id laborum animi velit ut. Aut non quos aut dolorem aut. Qui est qui sint adipisci quo sint fuga. Porro qui eum est ipsam aut nulla.', 0, 0, '2001-08-09 06:23:04');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (45, 99, 32, 'Vitae qui reiciendis aut quia. Eius culpa nostrum et dolorem. Odit excepturi numquam earum expedita eveniet sint.', 1, 1, '1990-01-27 07:05:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (46, 82, 7, 'Ut delectus saepe voluptas laboriosam autem. Vel velit aliquid non dolor quia iure est. Velit fugit dolorem non et.', 0, 0, '1982-02-16 23:33:36');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (47, 91, 34, 'Aspernatur enim at suscipit libero non ut. Id ipsum odio facere corrupti omnis fugit adipisci et.', 1, 1, '1979-09-10 22:42:20');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (48, 79, 34, 'Quo ut autem illum vel neque labore omnis. Nisi vitae sequi dolores vel dolorem repellendus ut quas. Reprehenderit voluptas consequatur est error omnis itaque.', 1, 1, '1983-12-01 16:26:29');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (49, 15, 85, 'Cum suscipit beatae incidunt quod perspiciatis error ut. Dignissimos fugiat consequatur molestiae ullam reiciendis corrupti autem. Harum maxime quam est rem esse quia enim.', 0, 1, '2001-05-25 06:37:25');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (50, 36, 68, 'Laboriosam nihil est placeat illo molestias ut exercitationem consequatur. Incidunt neque dolor reiciendis voluptatibus vel illo. Pariatur consequatur eius quo aut consequatur. Velit est placeat accusamus harum ex ipsum eaque.', 1, 1, '1972-10-11 08:08:13');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (51, 80, 42, 'Reiciendis incidunt libero tempore ipsum provident ad. Distinctio facere corporis et enim delectus ea exercitationem. Nesciunt voluptas est sunt qui. Neque consequatur laboriosam autem non.', 0, 1, '1988-04-05 23:30:11');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (52, 84, 89, 'Sint culpa et ipsam explicabo aut ea quasi aut. Quibusdam sit quia non in optio ipsam. Consectetur doloremque nisi ratione sapiente. Repellendus tempore occaecati provident et et.', 0, 1, '1987-03-17 04:51:27');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (53, 94, 54, 'Nihil dignissimos eius quaerat sit nobis cumque qui sint. Et non qui tempore exercitationem. Ipsam laborum quos quia alias distinctio. Et maiores nihil voluptatem aspernatur nihil ut expedita.', 0, 0, '1973-02-28 05:34:41');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (54, 39, 28, 'Rerum natus omnis facere fugit porro unde. Nisi laboriosam eius animi ducimus praesentium tempore. Quas ea alias omnis sapiente. Quibusdam reprehenderit numquam labore consequuntur at. Recusandae dolor qui saepe.', 0, 0, '2016-12-02 22:18:13');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (55, 46, 22, 'Asperiores omnis qui ex. Modi aliquid voluptatibus quae rerum. Voluptatem in deserunt quis dolore sed nemo maxime id.', 1, 1, '2002-01-12 17:40:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (56, 42, 74, 'Similique eligendi quia tempora. Voluptatum sequi laudantium ducimus explicabo. Facere delectus aut nostrum enim ut accusantium minus autem. Molestiae quisquam commodi omnis eligendi. Aut vitae facere est iure quisquam quos.', 1, 1, '2008-10-15 09:33:58');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (57, 31, 54, 'Aliquid sapiente dolores aut minima ut. Cum occaecati fugit ea et pariatur quae minus. Recusandae doloribus voluptatibus dolor minus suscipit. Culpa praesentium expedita accusamus quis optio non temporibus. Voluptatem earum quam assumenda rem.', 1, 0, '2007-03-29 16:15:34');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (58, 22, 52, 'Neque adipisci ab quibusdam quia nihil. Necessitatibus tempore facilis necessitatibus beatae dolorem officiis cumque ea. Molestias repudiandae occaecati ratione voluptatem aut quis. Iusto officia amet facilis laudantium omnis.', 1, 1, '1980-01-14 22:29:29');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (59, 81, 4, 'Voluptatibus dolor sunt debitis. Voluptatum eius illum sit voluptas dignissimos natus tenetur.', 0, 0, '1984-07-30 18:33:32');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (60, 26, 37, 'Totam libero doloremque sapiente ut soluta hic. Non et sit et consequuntur. Omnis sequi et omnis facilis. Omnis veritatis ipsa eum dolorum suscipit.', 1, 1, '1989-07-13 07:40:41');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (61, 80, 76, 'Dolorem qui sed necessitatibus vel qui. Quidem dolores recusandae et voluptatem iusto eaque. Consequuntur molestiae aut ad est quis fugiat.', 1, 0, '2006-03-31 02:51:25');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (62, 47, 12, 'Doloremque deserunt suscipit atque soluta deserunt distinctio accusantium sit. Quas mollitia rerum aut blanditiis omnis. Eos qui laudantium et distinctio aut. Rerum vel consequuntur sint in quas ut vitae adipisci. Quisquam odit illum et et.', 0, 0, '1997-04-07 15:16:44');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (63, 75, 95, 'Doloremque nulla laborum ut nisi consequatur quis saepe qui. Sint odio aut incidunt sint. Aspernatur modi voluptas reiciendis iste ducimus perspiciatis sit. Ad officia maxime corrupti temporibus. Omnis cumque sed a sed.', 1, 0, '1996-02-28 17:32:44');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (64, 69, 77, 'Aspernatur aspernatur nobis quis. Iusto cumque optio soluta eos et eveniet officiis necessitatibus. Nisi dolorem natus saepe. Occaecati nihil non id aut similique ullam et. Ratione eligendi error similique deleniti dolorem delectus.', 1, 0, '1970-01-15 15:03:23');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (65, 57, 35, 'Cupiditate iusto qui maxime velit dignissimos maxime eaque. Ea molestiae sunt aut neque facere minus vero. Repellendus qui aut occaecati accusamus qui qui voluptates.', 1, 0, '2003-04-24 09:50:27');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (66, 81, 22, 'Dicta qui distinctio consequatur exercitationem illo dolorem et. Officiis molestiae sed quaerat inventore ut ut. Voluptas voluptatem molestiae sint.', 1, 1, '2000-05-30 17:34:06');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (67, 35, 33, 'Perferendis voluptatem quidem et cupiditate. Rerum minus qui quasi et velit qui. Laboriosam perspiciatis quidem et doloribus. Possimus sit et facilis rerum quo.', 0, 1, '1990-06-19 13:28:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (68, 73, 82, 'Et magnam cupiditate earum vel sed. Est neque aliquam voluptas unde vel sequi. Dolor ad perferendis optio magnam.', 1, 0, '1972-08-04 22:48:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (69, 48, 26, 'Accusamus rerum omnis quisquam nam necessitatibus. Id sequi explicabo praesentium quidem. Sed et quia consequatur.', 1, 0, '1972-11-19 21:31:03');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (70, 10, 27, 'Non voluptatem ab quibusdam porro saepe sapiente corrupti aliquid. Perspiciatis quos ullam sit laudantium harum sint commodi. Voluptates ab est dolor provident ab quae.', 1, 1, '1976-02-15 03:54:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (71, 25, 94, 'Qui rerum quam labore in perspiciatis aperiam. Omnis rerum dolorum ut cumque repellendus aperiam natus. Natus iste dolorum aut. Aspernatur aut consequatur ducimus eum est et sit.', 1, 0, '2006-05-13 00:21:17');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (72, 6, 86, 'Enim rerum perferendis minima eligendi vel aspernatur. Vero ea necessitatibus et suscipit doloribus dolores quasi. Qui tempore quisquam omnis voluptate debitis sequi quos.', 0, 1, '1973-11-13 13:37:56');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (73, 53, 22, 'Ab voluptas molestias assumenda consequatur. Fugit sit vero mollitia autem nobis molestiae nam. Et consequatur aliquam consequatur ea.', 0, 1, '2000-08-16 06:51:00');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (74, 1, 33, 'Aut id quo et autem iusto. Animi saepe similique est tempore aliquam aspernatur voluptas. Dolorem distinctio commodi id quasi voluptatem velit. Doloribus ut ut et harum autem id.', 0, 0, '1988-09-26 06:39:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (75, 94, 92, 'Aut soluta voluptates quibusdam non vero. Iusto eum commodi nihil consectetur culpa. Necessitatibus dicta placeat cum dolore.', 0, 0, '2005-06-04 18:14:20');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (76, 41, 64, 'Eos quaerat dolorem nihil. Ad ab ut et a. Qui quos illo veritatis corporis.', 1, 1, '1977-11-12 14:46:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (77, 58, 13, 'Vel sit fugit modi laboriosam quos quasi. Aperiam quo asperiores sunt tempora mollitia. Nihil quis unde tempore consectetur. Et eligendi reprehenderit fugiat voluptatem omnis eum distinctio.', 1, 0, '2016-10-24 06:10:30');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (78, 19, 38, 'Modi quis sint ad rem et. Maxime voluptatem quia aperiam in omnis. Assumenda et error ut labore consequatur explicabo aliquam. Eveniet pariatur dicta et rerum.', 1, 1, '2005-12-01 13:50:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (79, 93, 91, 'Hic nostrum id eveniet beatae ex. Saepe qui delectus excepturi sunt nam. Omnis corporis quis qui architecto perspiciatis possimus.', 0, 1, '1981-04-18 05:30:00');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (80, 66, 34, 'Fugiat occaecati ratione dolorem ut. Qui maiores nesciunt ea ipsum ut. Id vel commodi vero omnis ratione nemo.', 1, 0, '1986-11-15 14:36:27');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (81, 88, 36, 'Eligendi laudantium est sit eos aliquam. Ipsam veniam assumenda quas quo aut. Quia nulla consequuntur quaerat rem sapiente vitae. Sit consequatur temporibus eos impedit ipsum.', 0, 1, '2010-07-12 02:59:27');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (82, 95, 31, 'Suscipit quis sit sed et illo minima dolor. Natus pariatur aut ea laborum rerum exercitationem non. Iste eum ut hic quos et.', 1, 1, '2012-02-20 17:30:17');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (83, 54, 84, 'Enim delectus esse voluptas ex vero debitis. Atque molestiae rerum nihil et sunt quis. Fugiat porro et sit eveniet vel. Ea dicta nulla ducimus quos. Rerum quo in eveniet sint non reiciendis.', 0, 0, '2013-06-19 01:02:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (84, 66, 78, 'Asperiores nesciunt aut ut alias. Dicta molestiae voluptas adipisci molestiae maxime quis. Voluptas consequuntur quibusdam repudiandae tempore. Architecto qui id ipsum omnis ut ut.', 1, 0, '1991-06-18 21:33:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (85, 82, 91, 'Ut quis voluptatem culpa animi harum et. Neque doloribus ullam ducimus et aspernatur eligendi. Odit et eius laboriosam.', 1, 0, '1986-07-14 00:24:07');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (86, 56, 42, 'Facilis accusamus qui ea cupiditate vero aliquid labore. Qui et et adipisci nemo. Eaque eveniet consequatur perspiciatis incidunt. Quod distinctio qui nisi earum.', 1, 0, '1974-06-28 18:02:10');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (87, 16, 46, 'Aut aliquid est reprehenderit et cupiditate officia. Possimus in quia deleniti aspernatur quia. Nam dolorem magnam dolor consequuntur iusto voluptas commodi eos.', 0, 0, '2003-11-06 17:39:02');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (88, 88, 60, 'Eaque ut perferendis et tempore. Officia laudantium et sed tempora assumenda. Officia rerum esse perferendis dolor fugiat est enim. Neque qui voluptas id placeat dolorum.', 1, 1, '2014-07-02 16:17:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (89, 22, 71, 'In est voluptates sint molestiae dicta asperiores et. Necessitatibus quis error qui sit.', 0, 0, '1971-05-29 22:07:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (90, 67, 27, 'Quia magnam in quo laboriosam nobis aut at. Ipsam et eligendi et autem. Qui et fugiat natus sequi id ut eveniet error. Dolor voluptatum nam tempore sit aut consequatur et.', 1, 0, '2005-08-25 06:53:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (91, 99, 29, 'Provident natus id id iure doloribus nesciunt. Et corrupti et fugiat odit. Voluptas voluptas rerum facere.', 0, 0, '2016-06-02 12:00:50');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (92, 89, 27, 'Omnis temporibus illo sunt provident ratione nam voluptatem suscipit. Dolores doloremque ab praesentium placeat iusto placeat.', 0, 0, '1975-01-31 17:59:54');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (93, 21, 15, 'Qui commodi sed qui enim. Aut molestiae aliquid accusantium exercitationem voluptatem recusandae est excepturi. Consequuntur dicta similique et facere expedita ullam eligendi. Non sint voluptas sed quod necessitatibus nam.', 1, 1, '2018-09-16 22:31:20');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (94, 57, 39, 'Aut quo quas aut dolorum ducimus dolorum incidunt consequatur. Et et porro culpa rerum. Asperiores voluptatem aut qui vel tenetur. Deserunt aliquid pariatur architecto aut cupiditate reprehenderit nam consequatur.', 0, 1, '1970-05-27 18:05:49');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (95, 75, 40, 'Quibusdam maiores in iste harum veritatis repellendus. Provident rerum minima nam eum. Hic cupiditate ut aut magnam et ducimus magnam. Ipsa accusamus dicta veritatis dolorum expedita fuga. Quo autem et voluptas consequatur deleniti.', 1, 1, '1991-10-09 03:49:34');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (96, 59, 38, 'Voluptatem saepe velit sed et voluptas totam. Corrupti in eos accusantium eaque doloremque quasi recusandae. Quis magni perferendis ipsa placeat ad odit inventore odio.', 0, 0, '2018-10-24 16:02:18');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (97, 97, 94, 'Consequuntur facilis cupiditate eaque voluptas labore qui. Vero aut harum culpa. Voluptatem eos optio asperiores illo praesentium.', 0, 1, '2020-03-19 05:21:50');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (98, 75, 4, 'Vitae nihil perferendis quo vitae fuga quos ut quas. Qui dolorem culpa sunt molestias qui architecto. Neque unde aut et tempore non. Accusantium inventore eos impedit suscipit sint.', 1, 1, '1987-06-17 20:13:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (99, 60, 53, 'Impedit modi molestias delectus atque voluptatem quos. Repellendus culpa possimus consequuntur aut quibusdam vero. Et nulla cumque voluptates. Quibusdam doloribus ducimus facere et eum quos.', 0, 0, '2013-10-02 04:05:09');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (100, 5, 85, 'Voluptatem consequatur praesentium accusantium consequatur dignissimos. Aut alias et enim est dolores dolorem. Est sint veniam ratione.', 1, 0, '1992-01-25 02:04:13');


INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (1, 'ratione', '2013-03-11 07:30:01', '1974-05-24 06:28:03');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (2, 'eos', '2015-07-04 17:56:25', '2002-11-05 11:05:24');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (3, 'quod', '1974-07-01 02:04:03', '2000-07-25 21:39:06');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (4, 'corrupti', '1978-08-21 10:18:02', '2001-04-24 17:52:08');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (5, 'cumque', '2009-12-17 19:15:31', '2009-11-28 10:35:46');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (6, 'odit', '1998-10-10 13:10:24', '2011-09-08 06:53:33');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (7, 'aliquam', '1973-12-22 17:27:07', '1982-05-19 04:51:15');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (8, 'voluptates', '1970-03-29 02:45:13', '1981-05-28 02:16:37');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (9, 'fuga', '1973-08-15 09:02:39', '1976-09-24 13:01:07');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (10, 'et', '1975-03-25 11:07:55', '1999-03-02 10:55:01');


INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (1, 23, '1986-09-20 18:34:41');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (1, 29, '2016-12-15 17:33:05');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (1, 33, '2013-10-10 02:56:17');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (1, 50, '2009-11-14 14:45:34');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (1, 58, '2001-01-13 11:22:04');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (1, 73, '1999-04-25 08:51:10');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (1, 74, '2001-11-03 13:27:01');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (1, 83, '1992-09-05 05:23:16');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (1, 90, '2019-12-08 08:19:47');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (1, 96, '1978-04-20 22:09:35');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (1, 98, '1980-08-31 20:50:58');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 2, '2004-04-11 19:25:59');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 6, '2010-05-06 19:30:58');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 7, '2012-02-07 23:37:04');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 27, '1980-02-04 00:10:31');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 40, '2010-11-12 03:40:40');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 42, '1981-04-16 06:39:52');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 45, '1989-06-03 23:37:07');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 46, '2007-04-06 07:40:54');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 53, '1994-02-05 09:48:58');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 54, '1980-11-29 17:14:00');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 58, '1992-08-05 00:43:05');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 66, '2009-03-29 15:29:19');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 74, '2015-10-16 18:53:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 79, '2000-05-03 07:07:29');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 94, '2017-02-10 01:46:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 99, '1986-01-21 07:53:55');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 5, '1978-04-02 03:32:39');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 6, '1998-09-26 14:15:26');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 12, '1982-02-17 11:57:50');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 13, '2019-07-09 22:40:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 17, '1987-08-29 11:19:01');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 27, '1986-09-06 19:25:03');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 31, '1999-02-03 00:33:44');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 37, '1982-05-28 10:38:04');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 38, '1977-02-19 16:22:17');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 43, '1984-10-21 01:23:38');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 47, '2018-12-27 23:29:52');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 51, '1992-08-20 20:42:54');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 66, '1991-12-01 15:11:30');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 68, '1988-12-14 09:10:32');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 69, '1975-10-30 13:10:48');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 80, '2003-08-01 05:36:15');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 81, '2003-01-09 08:09:23');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 91, '1992-01-18 13:13:03');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 92, '2004-11-08 06:25:35');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 98, '1978-12-25 17:01:26');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 1, '1994-04-18 03:33:40');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 6, '1996-02-18 21:37:33');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 11, '1986-04-20 08:28:36');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 12, '2010-09-17 01:26:33');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 14, '1970-09-23 20:57:40');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 19, '1989-06-21 18:08:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 20, '1986-04-17 05:21:04');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 24, '2002-01-09 06:08:52');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 29, '2015-01-11 01:59:47');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 35, '2005-06-02 00:06:49');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 38, '1990-12-30 08:08:16');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 47, '2001-04-20 12:51:03');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 50, '1979-09-22 05:12:58');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 53, '1979-09-02 21:22:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 68, '1981-04-19 04:24:21');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 84, '2010-02-26 15:51:00');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 86, '2016-06-08 12:35:03');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 91, '1987-10-20 18:10:28');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 97, '1981-07-04 18:11:39');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 99, '2002-08-08 03:25:02');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 3, '1979-01-10 22:56:00');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 22, '1985-11-29 02:21:52');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 35, '1993-04-21 15:50:07');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 41, '2016-08-16 05:10:40');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 44, '2005-11-17 11:29:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 47, '1971-11-10 19:35:54');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 49, '1987-01-22 19:05:08');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 54, '2014-10-24 04:37:46');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 61, '2016-12-27 03:03:04');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 65, '1997-09-18 14:19:31');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 68, '2011-03-26 07:34:29');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 77, '2006-06-04 16:32:55');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 85, '1993-06-01 00:55:46');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 87, '1980-11-16 22:06:56');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 98, '2001-06-14 22:30:56');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 1, '1986-06-06 13:36:10');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 5, '1977-01-30 05:32:16');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 10, '1998-02-11 06:29:00');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 12, '2015-05-25 16:30:50');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 24, '2012-10-06 04:08:17');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 37, '2006-04-25 17:52:11');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 38, '1976-08-04 02:20:45');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 41, '1999-03-24 09:48:00');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 50, '1996-07-14 06:54:44');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 62, '2003-11-18 06:13:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 67, '2010-08-10 12:23:56');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 84, '1996-12-25 15:14:24');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 94, '2011-10-22 03:54:19');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 95, '2012-11-02 01:18:35');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 14, '1992-07-10 11:48:35');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 19, '1991-02-20 20:38:30');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 20, '1999-07-03 06:56:54');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 23, '2008-10-31 14:03:44');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 29, '2003-06-04 21:13:06');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 30, '1973-07-31 03:49:10');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 33, '1976-07-16 10:31:00');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 37, '2015-03-25 23:42:52');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 39, '1997-09-10 16:34:09');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 42, '1992-03-30 12:55:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 43, '1973-01-21 16:08:46');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 46, '2001-03-13 00:52:07');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 55, '1996-03-14 23:06:43');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 58, '2018-12-11 14:10:51');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 68, '1982-04-01 19:01:55');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 80, '1979-11-17 10:14:11');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 83, '2017-02-20 06:49:58');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 85, '1995-01-09 23:02:18');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 91, '2002-01-25 17:35:27');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 93, '1993-01-28 02:38:04');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 5, '2011-09-04 04:55:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 10, '1986-10-24 14:23:42');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 13, '1989-09-03 15:46:54');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 16, '1996-05-01 10:15:43');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 19, '1971-03-08 16:28:44');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 23, '1988-01-26 00:33:04');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 25, '2016-02-24 21:39:03');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 28, '1996-07-07 15:49:10');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 29, '2008-11-23 14:41:50');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 30, '1988-10-01 00:15:06');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 50, '2002-01-18 03:22:13');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 51, '1999-04-17 00:46:36');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 54, '1984-11-14 19:00:59');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 63, '2010-10-01 23:20:08');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 64, '1988-06-08 16:34:52');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 70, '1979-06-19 11:56:06');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 73, '1991-02-11 16:30:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 83, '1971-11-25 09:25:59');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 84, '1977-11-18 07:18:48');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 88, '2010-08-30 03:52:21');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 92, '1984-08-15 00:32:11');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 95, '2000-12-28 10:38:32');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 96, '1973-01-17 13:07:50');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 8, '2019-02-24 02:51:25');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 12, '1998-05-24 03:28:30');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 15, '2012-03-29 23:08:01');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 24, '2000-09-28 01:47:31');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 25, '2005-06-28 13:01:20');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 26, '1988-03-20 17:51:24');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 28, '1993-06-06 01:34:00');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 33, '1990-05-11 14:10:29');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 36, '1990-05-03 17:41:05');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 37, '1975-04-25 09:50:58');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 40, '1979-08-25 16:56:07');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 53, '1983-07-22 01:36:09');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 56, '1974-08-25 00:34:53');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 57, '1985-11-15 15:31:32');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 63, '1975-10-16 06:40:03');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 68, '2017-03-09 00:02:49');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 69, '2001-12-28 10:34:29');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 74, '2012-08-08 17:36:40');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 77, '1971-06-07 12:19:33');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 80, '2000-07-01 05:22:30');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 83, '2015-03-19 14:42:21');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 90, '1981-10-13 07:16:22');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 91, '2019-12-14 10:35:10');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 98, '2000-06-18 03:19:31');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 12, '2014-03-21 16:09:25');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 17, '1971-07-19 22:00:56');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 19, '1985-07-19 21:28:29');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 24, '1996-07-04 10:55:57');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 27, '1988-09-26 14:21:03');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 34, '2009-04-02 07:45:33');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 35, '2004-04-19 02:31:03');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 46, '2018-01-30 04:58:41');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 51, '1991-03-03 18:58:33');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 53, '1971-03-08 05:07:17');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 57, '2013-08-19 08:54:49');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 58, '2009-02-04 15:38:25');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 64, '1989-01-25 15:32:24');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 72, '1973-01-25 06:50:00');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 77, '1998-10-15 08:17:06');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 80, '1971-04-22 11:30:52');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 81, '2008-08-29 09:56:27');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 90, '1998-05-20 00:22:55');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 95, '2020-03-03 12:45:45');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 98, '2017-12-29 15:39:08');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 99, '2001-06-21 06:14:22');


INSERT INTO `friendship_statuses` (`id`, `name`, `created_at`, `updated_at`) VALUES (1, 'ad', '2008-06-23 03:21:35', '2004-09-12 12:02:59');
INSERT INTO `friendship_statuses` (`id`, `name`, `created_at`, `updated_at`) VALUES (2, 'in', '1986-11-09 16:56:41', '1981-04-02 19:42:30');
INSERT INTO `friendship_statuses` (`id`, `name`, `created_at`, `updated_at`) VALUES (3, 'ducimus', '2020-02-20 21:15:38', '1990-02-08 09:51:49');
INSERT INTO `friendship_statuses` (`id`, `name`, `created_at`, `updated_at`) VALUES (4, 'est', '1978-05-18 14:37:52', '1971-10-24 04:07:52');
INSERT INTO `friendship_statuses` (`id`, `name`, `created_at`, `updated_at`) VALUES (5, 'eius', '1999-12-02 21:04:49', '2009-08-03 17:33:57');


INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (2, 26, 3, '1984-12-19 15:43:13', '1984-06-01 16:10:34', '1977-09-06 08:34:51', '1982-02-08 12:34:55');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (5, 20, 5, '2000-12-05 04:35:26', '1984-06-19 05:13:37', '2004-12-22 21:41:30', '2003-09-13 00:35:08');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (5, 21, 4, '1988-11-29 02:05:18', '1983-03-10 02:08:15', '2006-11-17 08:52:12', '1974-06-16 17:42:43');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (7, 78, 2, '2000-08-11 10:23:03', '1983-03-25 06:05:51', '1994-09-25 23:19:39', '2007-02-26 20:49:03');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (8, 27, 5, '2012-12-10 23:42:33', '2017-09-19 21:31:26', '2016-05-10 23:51:36', '1985-02-20 13:40:09');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (8, 81, 4, '1998-05-14 10:21:57', '1978-10-08 23:35:46', '1998-03-15 23:51:34', '1999-10-20 06:29:06');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (9, 28, 3, '1990-12-19 18:22:35', '1998-08-20 18:35:05', '1995-07-14 15:36:04', '2005-08-29 10:57:42');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (9, 78, 5, '2014-12-04 12:35:45', '1989-07-26 06:08:38', '1994-07-08 06:06:13', '1977-01-19 12:06:43');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (10, 79, 3, '1986-03-09 20:39:37', '1994-06-23 07:25:15', '1980-08-28 00:56:38', '1993-03-25 13:29:04');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (11, 57, 2, '2012-11-10 03:18:48', '1970-05-10 03:26:40', '1994-11-01 18:53:07', '2019-01-23 17:27:31');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (12, 98, 4, '2017-08-11 13:05:43', '1973-05-09 10:46:57', '1997-05-27 12:40:14', '1973-03-09 03:57:03');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (14, 58, 5, '2017-05-05 00:54:31', '1986-03-26 04:12:50', '2005-03-12 17:43:29', '1986-02-16 19:25:53');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (14, 71, 1, '1989-06-06 17:42:34', '2014-12-05 19:03:01', '2006-10-24 16:38:36', '1986-01-28 09:28:12');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (15, 43, 3, '1982-04-01 14:10:47', '1985-09-16 23:35:16', '1980-01-13 01:33:45', '1994-05-20 11:16:06');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (15, 66, 5, '2012-02-15 06:44:04', '2017-02-19 11:12:30', '1978-01-07 10:42:04', '2018-09-07 11:44:36');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (15, 92, 4, '2020-02-11 17:23:39', '1970-03-26 10:10:18', '1994-10-19 17:49:49', '1974-01-01 21:11:50');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (16, 2, 3, '2000-12-23 23:42:06', '1995-04-13 07:58:42', '1976-03-11 00:10:27', '1996-04-16 13:32:57');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (19, 17, 5, '1983-12-25 03:11:56', '2002-10-23 16:00:56', '2010-06-27 02:12:12', '1976-06-12 15:16:11');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (21, 65, 4, '1994-08-14 23:30:49', '2009-03-08 04:35:59', '1976-02-08 03:51:50', '1988-11-03 06:43:57');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (21, 96, 3, '2015-05-23 13:05:04', '2015-01-31 17:37:26', '1991-11-12 08:00:51', '1988-06-10 15:38:56');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (22, 34, 5, '1991-07-04 20:18:33', '2019-05-29 04:13:14', '2001-02-04 03:08:18', '2007-11-23 21:08:18');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (22, 94, 3, '1972-08-25 20:47:41', '2009-03-29 21:29:53', '1987-08-02 15:36:46', '1996-06-16 05:59:41');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (23, 55, 3, '1989-01-18 22:13:53', '1988-05-16 15:53:50', '2008-03-28 08:45:10', '1980-02-26 00:45:01');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (24, 13, 1, '1976-12-20 15:21:56', '1977-06-28 20:38:06', '1985-09-01 03:39:27', '1987-07-02 20:36:09');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (24, 14, 3, '1998-01-15 06:06:39', '1990-06-28 16:40:34', '2000-11-16 09:22:36', '1995-12-27 13:56:21');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (24, 66, 2, '2011-03-22 06:40:02', '2016-02-03 15:14:42', '1977-04-25 10:48:23', '2016-12-30 17:15:04');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (25, 76, 1, '1989-08-24 13:17:55', '2008-08-28 03:30:32', '2000-07-08 07:59:57', '1987-09-19 23:49:24');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (26, 99, 2, '2004-05-19 11:23:12', '2010-01-09 11:10:20', '1974-03-21 15:36:07', '2005-10-09 02:37:28');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (27, 20, 1, '2012-07-18 05:34:45', '1996-11-23 00:47:09', '1970-03-01 08:24:23', '2009-05-27 18:10:50');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (31, 67, 2, '1995-10-27 07:02:51', '2019-03-23 14:23:14', '1996-07-01 22:06:42', '2000-07-28 01:15:22');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (35, 63, 5, '1989-08-14 04:49:54', '1973-11-28 07:42:36', '1972-05-02 20:42:36', '1998-02-07 17:07:27');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (35, 95, 4, '1972-09-25 01:33:47', '1977-11-30 00:25:53', '1972-09-16 09:18:16', '2003-11-09 04:51:37');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (36, 61, 2, '1992-05-18 07:57:07', '2013-08-15 11:05:41', '1977-03-02 18:30:26', '2000-08-14 22:10:10');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (36, 100, 5, '1986-07-07 10:02:12', '1984-08-03 20:53:22', '2013-12-30 13:22:03', '2010-12-13 07:19:19');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (40, 71, 4, '2017-06-17 04:59:18', '1994-08-10 16:17:41', '2011-01-08 10:47:41', '2008-07-16 17:05:04');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (41, 36, 1, '1994-11-25 08:14:00', '1972-08-20 18:52:59', '1975-01-21 20:42:33', '1979-10-05 08:41:58');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (41, 65, 1, '1983-11-14 08:57:40', '1981-03-01 15:41:13', '1986-11-21 04:12:57', '2011-11-23 16:46:13');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (43, 11, 4, '2016-07-11 07:23:52', '1979-06-10 22:22:53', '2008-08-05 15:13:43', '2013-06-06 20:35:43');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (43, 72, 4, '2006-10-21 04:05:39', '1985-04-25 15:51:46', '2008-11-09 07:50:48', '1973-03-19 12:24:00');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (44, 86, 3, '1985-03-22 18:42:57', '1989-03-30 14:03:59', '2014-11-05 21:00:01', '1982-11-19 19:54:17');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (46, 49, 1, '1993-11-16 02:11:36', '2002-12-18 00:32:24', '1981-09-28 02:44:26', '1982-07-04 22:41:07');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (46, 75, 2, '2001-07-17 19:01:43', '1982-02-24 08:15:13', '1984-10-25 20:15:03', '2009-04-15 04:15:23');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (47, 88, 3, '1977-07-31 18:12:25', '2014-03-05 15:49:43', '2007-06-06 01:06:51', '1978-09-23 09:19:55');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (48, 56, 4, '2019-06-16 15:54:50', '2002-10-26 20:21:31', '2014-12-27 17:46:45', '1973-07-27 01:24:01');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (50, 46, 5, '1973-12-24 20:58:07', '1977-09-04 21:55:57', '2014-08-30 03:46:09', '1977-11-09 20:15:48');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (50, 80, 1, '1986-07-15 10:56:42', '2013-03-16 21:12:09', '2005-06-08 02:30:49', '2003-02-03 17:35:30');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (51, 33, 5, '2006-09-30 03:34:53', '1991-05-11 00:08:08', '1981-03-25 22:01:43', '2013-12-12 18:48:59');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (51, 74, 5, '2018-02-01 07:23:06', '1997-08-18 05:24:37', '1979-10-05 17:20:30', '2011-08-28 19:01:17');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (53, 11, 3, '2007-04-09 15:06:56', '2002-05-16 12:25:09', '1998-02-28 13:24:30', '2011-01-08 14:59:42');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (53, 36, 2, '1972-11-27 15:54:00', '1986-11-23 19:47:47', '2008-08-01 09:23:04', '2018-04-30 21:54:37');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (53, 71, 2, '1990-07-07 06:17:50', '1979-12-11 11:07:50', '1975-12-12 21:46:31', '2012-07-04 07:29:48');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (53, 72, 2, '1986-04-02 11:48:49', '1976-10-21 05:53:07', '2009-06-27 17:58:47', '1997-07-18 19:21:13');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (54, 91, 3, '1991-12-07 03:50:42', '1990-05-12 23:21:26', '1983-08-22 19:05:35', '2012-06-01 03:52:11');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (55, 15, 2, '2017-12-18 08:05:01', '1997-05-25 09:40:00', '1987-04-30 18:51:36', '1974-09-18 00:41:28');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (55, 32, 3, '2009-05-10 02:45:43', '1989-07-15 13:44:28', '2008-08-23 02:25:57', '2004-02-22 04:45:44');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (56, 30, 2, '1972-05-23 22:16:31', '1985-11-07 16:44:17', '2001-07-21 10:34:15', '1974-03-12 08:12:09');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (56, 62, 3, '1970-10-20 14:28:30', '2011-06-11 04:37:22', '1992-07-14 23:02:53', '1997-05-24 23:59:20');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (57, 19, 4, '1997-09-10 23:31:45', '1977-12-01 15:22:44', '1999-03-19 05:51:09', '1983-07-03 09:21:28');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (58, 59, 5, '2007-04-15 16:41:49', '1982-11-10 09:20:29', '1992-01-08 18:48:47', '2002-02-19 05:04:56');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (59, 1, 2, '2004-12-09 08:03:57', '2002-01-31 05:55:45', '1992-05-01 21:48:56', '1976-03-09 17:25:09');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (59, 86, 3, '2016-10-08 06:12:26', '2017-01-04 21:42:29', '1973-03-12 03:13:48', '1975-08-22 13:04:22');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (61, 15, 4, '2011-06-12 22:03:48', '1999-04-28 04:38:13', '2006-09-08 10:55:21', '1974-10-12 06:51:35');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (61, 19, 3, '2010-05-06 13:40:31', '1986-03-05 16:12:25', '1971-11-19 06:03:24', '2015-09-14 05:58:21');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (62, 11, 2, '2008-11-25 09:09:30', '1988-10-24 21:40:35', '2015-09-09 18:59:01', '2000-02-16 15:33:16');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (62, 45, 4, '2004-11-02 12:25:56', '1988-06-15 02:02:59', '1989-07-01 00:28:14', '1970-03-11 02:36:30');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (65, 96, 4, '2020-05-22 04:08:36', '1975-06-23 01:41:10', '1976-09-05 13:54:51', '1999-03-14 22:18:50');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (67, 59, 3, '2015-11-21 09:00:36', '2004-08-01 04:21:42', '2012-07-24 15:08:58', '1992-01-17 23:08:02');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (68, 2, 2, '2005-01-14 09:38:38', '1981-06-23 13:50:13', '2010-07-01 15:57:58', '2010-06-02 09:44:50');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (68, 98, 2, '2003-09-19 23:24:42', '1982-10-16 20:53:56', '1973-08-15 12:53:33', '1977-10-11 13:32:40');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (71, 3, 4, '2014-10-31 07:24:37', '2009-12-03 03:32:21', '1986-01-03 06:05:42', '1991-02-12 04:06:26');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (72, 39, 5, '1981-07-12 16:34:07', '2010-01-13 12:31:24', '2009-03-09 11:48:52', '1972-08-16 17:38:30');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (73, 60, 3, '2008-02-25 18:20:08', '1971-11-29 16:11:55', '2012-06-06 16:22:39', '1999-04-15 01:21:57');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (74, 86, 5, '1985-07-17 06:05:45', '1989-12-21 15:00:47', '1974-09-09 14:15:09', '1996-06-08 02:30:16');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (75, 22, 3, '2008-03-07 14:43:02', '2000-07-30 10:04:18', '2005-08-23 06:48:26', '1995-03-21 18:30:36');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (75, 46, 3, '1978-04-13 02:30:31', '1993-07-17 02:03:01', '1973-08-17 21:50:01', '2017-03-07 14:47:17');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (75, 50, 4, '1992-12-14 20:02:21', '2019-02-12 00:39:22', '1973-04-30 10:06:53', '1970-07-08 08:29:34');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (78, 68, 5, '2009-03-11 06:17:24', '1973-09-15 19:14:52', '2001-12-03 19:39:03', '2009-12-06 05:53:10');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (78, 78, 2, '1980-01-11 19:07:53', '2014-01-02 02:51:16', '1977-05-25 23:07:28', '1992-01-30 04:28:00');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (79, 11, 3, '1981-05-17 02:31:27', '2010-11-09 12:12:29', '1983-05-07 08:44:51', '1985-02-13 05:31:34');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (79, 34, 3, '2010-05-05 09:24:25', '2016-08-20 10:07:51', '1993-10-16 21:12:41', '1977-11-17 11:24:48');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (81, 66, 3, '2018-05-29 20:41:10', '1999-01-03 13:17:07', '2009-05-18 12:59:21', '2014-08-27 21:25:50');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (84, 22, 2, '2013-11-14 23:25:04', '1994-01-16 02:45:28', '1979-07-28 18:23:43', '2018-01-09 13:10:03');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (84, 98, 2, '1981-06-29 09:23:46', '2011-05-12 02:06:01', '1972-10-08 16:36:43', '1972-01-21 12:33:33');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (85, 50, 1, '2001-05-25 13:38:42', '1977-03-25 12:56:09', '2004-12-08 07:34:46', '1995-07-18 11:36:41');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (87, 77, 4, '2014-08-10 09:20:15', '1985-10-04 15:44:19', '1987-10-30 22:00:19', '2000-10-30 11:11:45');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (87, 85, 2, '1986-10-04 19:55:18', '1993-02-03 06:51:51', '1986-11-11 16:21:15', '1977-04-20 19:34:01');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (88, 19, 3, '2001-05-15 10:20:20', '2008-03-16 13:09:10', '2004-04-02 20:48:42', '1975-08-24 18:35:06');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (88, 54, 4, '1971-05-01 18:58:39', '1985-05-22 03:26:18', '1989-08-20 21:29:46', '1985-03-18 13:27:06');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (88, 82, 3, '1980-01-22 22:44:04', '2003-06-13 02:53:52', '1974-03-26 16:29:30', '1997-10-09 18:51:37');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (90, 63, 3, '1979-03-01 22:34:30', '2010-01-17 13:14:01', '2016-01-14 12:22:50', '1982-08-31 22:37:18');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (91, 66, 1, '2017-03-25 09:33:21', '1970-05-13 02:04:33', '2011-02-04 17:18:31', '1993-11-17 14:54:50');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (91, 82, 3, '1996-06-01 17:01:49', '2005-03-13 04:11:23', '1989-07-22 15:14:33', '1987-05-20 14:08:00');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (94, 58, 3, '2007-01-27 16:51:49', '1987-03-08 08:44:30', '2014-01-24 13:32:54', '1975-06-29 02:46:02');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (96, 4, 1, '1987-01-07 14:50:55', '2006-11-16 14:59:54', '2004-10-08 06:02:49', '1971-01-29 09:42:50');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (97, 70, 2, '1978-04-16 09:11:52', '1980-05-12 23:30:51', '1985-04-04 15:24:57', '1971-01-12 02:55:49');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (97, 96, 3, '1974-11-10 03:39:07', '1977-08-01 14:22:39', '1974-12-01 14:04:24', '1998-01-30 16:04:48');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (98, 8, 2, '2009-10-11 09:47:15', '1999-04-26 20:34:33', '2019-02-13 02:49:35', '1987-06-09 17:22:07');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (98, 23, 1, '1972-06-05 07:31:23', '1992-02-10 18:17:10', '1980-01-13 00:34:52', '2015-02-01 00:06:12');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (99, 38, 2, '1992-01-14 05:42:34', '2000-03-12 19:36:14', '2010-02-10 12:50:02', '1987-02-04 23:20:37');
INSERT INTO `friendship` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (99, 39, 4, '1970-07-03 16:11:53', '1980-06-07 02:44:18', '1987-08-08 03:32:03', '2011-01-18 19:39:23');


INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (1, 'voluptatum', '1983-05-10 13:16:39', '2013-01-15 06:41:23');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (2, 'illum', '2016-04-09 04:30:56', '2000-02-29 23:20:43');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (3, 'eos', '2014-07-18 05:01:32', '2016-08-22 00:46:23');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (4, 'qui', '2012-05-06 23:24:13', '1990-11-11 01:35:33');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (5, 'dolores', '1972-09-05 18:55:10', '2005-08-18 20:31:37');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (6, 'et', '2019-04-08 05:24:28', '2017-03-21 16:06:28');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (7, 'impedit', '1971-05-18 06:35:45', '1975-10-21 06:29:24');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (8, 'est', '1982-10-03 15:33:58', '1989-11-16 00:28:12');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (9, 'magnam', '2017-05-25 04:00:55', '1994-12-08 05:31:04');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (10, 'velit', '1997-09-22 18:15:41', '1992-09-09 14:53:33');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (11, 'cum', '1984-07-20 11:21:16', '1974-01-18 15:14:04');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (12, 'architecto', '1999-06-09 11:30:39', '1986-01-21 16:42:50');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (13, 'aliquid', '2014-08-08 11:48:50', '1980-06-29 16:08:49');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (14, 'mollitia', '1992-05-01 17:24:57', '1988-07-03 10:54:37');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (15, 'iusto', '1997-08-30 14:56:37', '1997-06-03 03:57:47');


INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (1, 55, 'officia', 0, NULL, 14, '1982-11-13 03:02:58', '1996-07-31 17:01:33');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (2, 15, 'nemo', 3401, NULL, 12, '1996-09-18 11:07:46', '2005-10-09 20:39:17');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (3, 43, 'occaecati', 34696, NULL, 5, '1980-06-22 21:05:53', '2008-01-26 00:30:51');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (4, 92, 'a', 0, NULL, 12, '1987-11-10 13:38:45', '2013-12-19 17:09:07');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (5, 1, 'tenetur', 90833770, NULL, 13, '1984-02-10 20:31:49', '1986-10-11 12:16:06');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (6, 13, 'odit', 2, NULL, 7, '1985-07-18 03:46:00', '1996-05-19 03:12:23');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (7, 95, 'adipisci', 76799042, NULL, 8, '2000-04-10 04:51:38', '1971-03-14 22:15:42');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (8, 58, 'dicta', 90118685, NULL, 12, '1994-07-26 10:19:19', '1981-01-04 03:21:54');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (9, 40, 'et', 771588618, NULL, 12, '1989-07-26 06:22:54', '2019-09-15 05:59:26');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (10, 72, 'ut', 69986358, NULL, 15, '2015-04-11 05:37:25', '2019-07-17 08:32:11');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (11, 59, 'illo', 5788, NULL, 9, '2015-10-19 05:34:07', '2013-03-24 16:02:37');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (12, 57, 'facere', 525177, NULL, 9, '2010-10-03 02:21:12', '1986-11-29 16:18:51');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (13, 50, 'dicta', 8, NULL, 6, '1999-07-27 19:48:43', '1983-01-30 07:43:19');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (14, 48, 'dolores', 72, NULL, 11, '1982-04-21 08:49:22', '2013-05-23 10:24:20');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (15, 23, 'voluptas', 1289379, NULL, 8, '2018-02-17 03:21:37', '1979-06-24 02:51:01');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (16, 95, 'sequi', 91147, NULL, 11, '2010-06-18 11:19:47', '1986-07-31 09:37:44');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (17, 29, 'doloribus', 90350875, NULL, 11, '2019-03-23 03:08:42', '2008-01-29 10:28:17');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (18, 43, 'ex', 0, NULL, 9, '1973-04-09 17:09:30', '1987-04-01 17:54:30');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (19, 24, 'quis', 1828, NULL, 15, '2018-01-30 20:20:06', '1986-12-22 06:16:20');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (20, 88, 'velit', 212097, NULL, 5, '1985-02-25 11:18:27', '2007-05-01 13:06:20');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (21, 20, 'velit', 588, NULL, 5, '1988-05-15 12:44:28', '1992-05-16 02:23:27');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (22, 12, 'ut', 4962, NULL, 11, '2002-12-24 22:09:53', '2016-12-25 10:59:36');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (23, 14, 'at', 7568, NULL, 1, '2018-05-10 02:58:53', '2011-04-13 18:55:09');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (24, 10, 'sit', 228865640, NULL, 4, '2012-10-13 19:03:33', '1978-09-13 08:14:15');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (25, 14, 'molestiae', 478617, NULL, 1, '1997-09-18 10:03:07', '2015-05-29 09:04:12');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (26, 79, 'ad', 939768, NULL, 13, '2005-11-29 13:53:15', '1985-10-26 23:02:25');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (27, 37, 'architecto', 0, NULL, 10, '1982-06-24 22:45:43', '1988-01-04 05:26:51');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (28, 18, 'voluptatum', 53, NULL, 11, '2007-10-29 01:06:37', '1999-04-30 20:49:45');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (29, 15, 'aut', 11, NULL, 5, '1980-10-16 17:24:02', '2020-01-17 21:31:38');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (30, 88, 'minus', 3022, NULL, 13, '1994-07-22 12:42:31', '2017-05-21 08:12:07');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (31, 87, 'saepe', 45276207, NULL, 8, '1998-12-17 17:14:46', '1993-05-31 10:49:08');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (32, 26, 'inventore', 960, NULL, 14, '1991-07-07 16:07:48', '1984-04-22 10:03:28');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (33, 3, 'sequi', 85287, NULL, 15, '2017-01-10 04:31:51', '1971-04-01 02:50:21');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (34, 47, 'in', 0, NULL, 14, '2001-05-23 12:55:13', '1981-04-07 18:05:10');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (35, 1, 'veniam', 987370372, NULL, 14, '2011-06-05 01:02:41', '1995-09-06 13:39:25');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (36, 35, 'aut', 59, NULL, 1, '1993-01-26 21:15:19', '2019-03-24 21:24:46');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (37, 79, 'saepe', 982, NULL, 11, '1996-04-15 23:10:44', '1996-06-28 20:45:58');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (38, 51, 'est', 0, NULL, 4, '2017-11-04 15:04:51', '2020-01-29 11:56:26');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (39, 87, 'aut', 1395343, NULL, 2, '1979-05-10 06:47:16', '1981-06-19 05:04:04');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (40, 18, 'quisquam', 3, NULL, 11, '2009-05-03 11:34:28', '2020-02-24 20:36:03');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (41, 26, 'et', 1441654, NULL, 5, '1984-10-04 12:07:50', '2009-02-05 10:51:54');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (42, 55, 'qui', 360, NULL, 9, '1972-08-04 11:48:07', '2009-07-06 11:40:08');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (43, 31, 'optio', 4128996, NULL, 11, '1996-01-28 00:50:59', '2004-06-13 16:17:05');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (44, 38, 'exercitationem', 74066672, NULL, 14, '2004-04-06 01:16:40', '1985-03-05 05:31:59');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (45, 3, 'quis', 213, NULL, 4, '1983-03-19 12:46:39', '2007-11-10 11:11:25');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (46, 96, 'ex', 952, NULL, 5, '1990-06-20 14:30:51', '2007-09-21 04:15:27');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (47, 4, 'et', 85090748, NULL, 12, '2013-06-20 18:00:09', '2002-04-09 17:52:56');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (48, 32, 'hic', 385520, NULL, 1, '1983-01-28 17:15:19', '1996-11-02 23:18:24');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (49, 8, 'ad', 82, NULL, 6, '2012-10-12 22:34:04', '2009-01-10 22:58:21');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (50, 89, 'voluptas', 17186240, NULL, 6, '1992-10-27 19:05:37', '1973-07-03 18:30:17');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (51, 91, 'id', 0, NULL, 10, '2006-08-04 11:17:34', '2008-08-31 00:38:22');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (52, 79, 'nihil', 73, NULL, 9, '2000-06-16 16:47:01', '2009-05-28 17:43:19');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (53, 87, 'sunt', 20832541, NULL, 5, '1997-12-19 08:30:45', '2006-05-06 13:29:40');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (54, 92, 'consectetur', 9, NULL, 9, '1982-09-25 22:53:38', '2001-11-25 06:26:52');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (55, 28, 'libero', 13, NULL, 11, '1991-10-04 07:34:58', '2019-02-24 12:27:38');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (56, 17, 'sit', 543498, NULL, 6, '1998-07-08 23:02:05', '1992-02-27 10:41:08');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (57, 54, 'id', 95, NULL, 8, '2015-07-24 15:21:34', '1975-06-09 23:57:41');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (58, 49, 'velit', 369, NULL, 7, '1979-10-12 19:19:21', '1975-09-02 08:31:05');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (59, 94, 'delectus', 4, NULL, 10, '2010-06-11 06:30:06', '1999-12-02 01:06:33');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (60, 41, 'itaque', 167, NULL, 14, '1977-12-01 03:26:46', '1982-07-15 04:22:17');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (61, 92, 'rem', 7987235, NULL, 2, '2010-10-25 21:47:59', '1990-09-20 14:44:21');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (62, 38, 'nostrum', 1, NULL, 11, '2003-01-19 20:21:11', '2014-04-20 16:14:46');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (63, 17, 'debitis', 518831459, NULL, 11, '1984-06-21 11:26:31', '1981-01-01 14:18:55');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (64, 35, 'ducimus', 84260524, NULL, 10, '2006-03-28 15:13:11', '1975-01-17 18:22:07');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (65, 30, 'fugiat', 53437232, NULL, 1, '2001-11-21 13:09:27', '1976-02-02 17:58:29');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (66, 23, 'inventore', 0, NULL, 6, '2016-07-07 12:30:23', '1972-03-19 15:07:39');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (67, 23, 'porro', 9123, NULL, 7, '1981-03-26 10:20:20', '2009-02-06 17:47:32');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (68, 54, 'voluptatem', 221317175, NULL, 13, '1983-08-12 03:34:06', '1986-02-08 12:29:16');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (69, 48, 'at', 59459008, NULL, 14, '2003-08-11 23:19:59', '1999-10-19 11:09:57');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (70, 21, 'iure', 883, NULL, 7, '1995-02-16 07:41:42', '1990-12-04 14:07:36');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (71, 35, 'nulla', 5439613, NULL, 7, '1990-05-27 14:24:50', '2014-04-22 06:15:11');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (72, 86, 'ut', 5510, NULL, 11, '1998-01-07 23:19:57', '2014-08-29 21:19:49');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (73, 53, 'ut', 2207680, NULL, 1, '1998-07-12 06:59:08', '2013-12-24 16:09:30');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (74, 1, 'velit', 342336, NULL, 14, '2003-12-23 07:03:57', '1997-03-21 01:59:11');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (75, 50, 'consectetur', 17567536, NULL, 15, '1970-11-09 17:52:40', '1998-11-26 18:59:30');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (76, 81, 'est', 6, NULL, 7, '1981-12-11 19:44:04', '1999-03-29 09:30:33');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (77, 19, 'quo', 1631, NULL, 12, '1995-07-29 11:08:36', '1995-05-15 23:59:05');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (78, 29, 'quos', 4332, NULL, 15, '1985-11-19 06:06:05', '2015-03-14 13:19:10');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (79, 77, 'sequi', 7586, NULL, 5, '2007-12-06 17:54:03', '1978-04-10 01:47:14');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (80, 72, 'ab', 46084555, NULL, 12, '2007-06-03 18:34:23', '2003-10-30 13:21:02');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (81, 23, 'cupiditate', 426, NULL, 6, '2001-06-14 09:51:19', '2019-10-17 10:56:37');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (82, 19, 'autem', 0, NULL, 8, '1978-03-19 19:55:59', '1973-12-11 15:17:26');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (83, 53, 'beatae', 0, NULL, 13, '1991-10-27 14:23:37', '1999-09-08 03:48:34');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (84, 89, 'corporis', 74, NULL, 6, '1983-01-20 10:58:42', '1986-02-24 08:00:49');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (85, 38, 'officiis', 45, NULL, 15, '2008-08-18 02:08:14', '1997-10-09 11:41:59');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (86, 74, 'reprehenderit', 6850661, NULL, 11, '1991-01-16 04:31:55', '1974-08-25 16:09:17');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (87, 46, 'maiores', 879, NULL, 8, '1982-01-04 12:06:31', '2007-06-11 05:02:29');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (88, 5, 'omnis', 9, NULL, 5, '1976-08-27 01:57:07', '1979-01-20 18:22:56');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (89, 34, 'deserunt', 79, NULL, 8, '2016-10-12 02:26:40', '1994-02-24 18:20:49');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (90, 53, 'iure', 1, NULL, 11, '2015-01-11 04:17:11', '2012-05-06 13:51:55');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (91, 78, 'rerum', 96, NULL, 9, '2000-09-18 03:58:12', '1978-06-20 23:45:30');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (92, 10, 'ipsam', 73705, NULL, 7, '1980-06-02 03:40:17', '1977-09-11 10:36:50');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (93, 94, 'nisi', 86154, NULL, 8, '1993-03-20 09:46:50', '1980-03-12 11:40:30');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (94, 25, 'aut', 78, NULL, 12, '1998-03-06 12:18:16', '2004-03-26 14:19:22');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (95, 18, 'ea', 0, NULL, 2, '1983-11-18 08:42:53', '1995-02-24 05:48:53');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (96, 65, 'voluptas', 6907, NULL, 12, '2008-12-12 21:24:04', '1978-02-12 09:03:17');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (97, 72, 'deserunt', 22, NULL, 12, '1995-04-28 17:20:37', '1996-07-08 06:20:10');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (98, 23, 'dolorem', 43, NULL, 8, '1984-11-20 13:01:08', '1994-03-23 13:13:45');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (99, 62, 'et', 4369888, NULL, 5, '2004-03-10 18:53:53', '1981-06-18 11:30:37');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (100, 93, 'illum', 0, NULL, 6, '2011-10-12 19:28:26', '1980-08-22 14:19:09');