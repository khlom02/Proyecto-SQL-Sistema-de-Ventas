DELIMITER //
CREATE TRIGGER tr_stock_negativo
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
    IF NEW.stock < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock no puede ser negativo';
    END IF;
END;
//
DELIMITER ;