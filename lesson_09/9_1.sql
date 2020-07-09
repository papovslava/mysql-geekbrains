-- ������������ ������� �� ���� ��������� ��������� � �������, ��������"
-- 1. �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����.
-- � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".

DROP FUNCTION IF EXISTS hello;

DELIMITER //

CREATE FUNCTION hello(v TIME)
  RETURNS VARCHAR(20) NO SQL

  BEGIN
    DECLARE r VARCHAR(20);
--     DECLARE v TIME DEFAULT '00:00:01';

    IF v > '18:00:00' THEN SET r = '������ �����';
    ELSEIF v > '12:00:00' THEN SET r = '������ ����';
    ELSEIF v > '06:00:00' THEN SET r = '����� ����';
    ELSE SET r = '������ ����';
    END IF;

    RETURN r;
  END //

DELIMITER ;


SELECT '00:00:01', hello('00:00:01') as 'Greeting';
SELECT '06:00:01', hello('06:00:01') as 'Greeting';
SELECT '12:00:01', hello('12:00:01') as 'Greeting';
SELECT '18:00:01', hello('18:00:01') as 'Greeting';