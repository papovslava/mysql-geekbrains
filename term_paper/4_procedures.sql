-- хранимые процедуры
-- дл€ таблицы reservations исправить даты от и до. ≈сли до меньше от, то до = сейчас

USE booking;

SELECT start_at, end_at FROM reservations;

DELIMITER //

DROP PROCEDURE IF EXISTS fix_reservations//
CREATE PROCEDURE fix_reservations ()
BEGIN
  UPDATE reservations SET end_at=NOW() WHERE start_at > end_at;
END//

DELIMITER ;

CALL fix_reservations();

SELECT start_at, end_at FROM reservations;