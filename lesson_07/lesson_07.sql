USE shop;

-- ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.

SELECT
	u.id, u.name, o.id, o.created_at 
FROM
	users as u
	JOIN
	orders as o
ON
	u.id = o.user_id;
	

-- �������� ������ ������� products � �������� catalogs, ������� ������������� ������.

SELECT
	p.name, p.description, p.price, c.name 
FROM
	products as p
	JOIN 
	catalogs as c
ON
	p.catalog_id = c.id;
	
-- (�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). ���� from, to � label �������� ���������� �������� �������, ���� name � �������. �������� ������ ������ flights � �������� ���������� �������.

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	city_from VARCHAR(255) NOT NULL COMMENT 'Departure city',
	city_to VARCHAR(255) NOT NULL COMMENT 'Destination city'
) COMMENT = 'Flights';

INSERT INTO flights (city_from, city_to)
VALUES
	('moscow', 'omsk'),
	('novgorod', 'kazan'),
	('irkutsk', 'moscow'),
	('omsk', 'irkutsk'),
	('moscow', 'kazan');

SELECT * FROM flights;

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	id SERIAL PRIMARY KEY,
	name_en VARCHAR(255) NOT NULL,
	name_ru VARCHAR(255) NOT NULL
) COMMENT 'cities';

INSERT INTO cities (name_en, name_ru)
VALUES
	('moscow', '������'),
	('irkutsk', '�������'),
	('novgorod', '��������'),
	('kazan', '������'),
	('omsk', '����');
	
SELECT * FROM cities;

-- ������� 1
SELECT 
	(SELECT name_ru FROM cities c WHERE f.city_from = c.name_en) 'From',
	(SELECT name_ru FROM cities c WHERE f.city_to = c.name_en) 'To'
FROM flights f;

-- ������� 2
SELECT c1.name_ru 'From', c2.name_ru 'To'
FROM flights f, cities c1, cities c2
WHERE f.city_from = c1.name_en AND f.city_to = c2.name_en;

-- ������� 3
SELECT c1.name_ru 'From', c2.name_ru 'To'
FROM flights f
	INNER JOIN cities c1 ON f.city_from = c1.name_en
	INNER JOIN cities c2 ON f.city_to = c2.name_en;