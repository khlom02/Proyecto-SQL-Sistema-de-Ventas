DELIMITER //
CREATE PROCEDURE registrar_venta(
    IN p_id_cliente INT,
    IN p_id_usuario INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_id_venta INT;
    
    -- Crear la venta
    INSERT INTO ventas (id_cliente, id_usuario) VALUES (p_id_cliente, p_id_usuario);
    SET v_id_venta = LAST_INSERT_ID();

    -- Insertar detalle
    INSERT INTO detalle_ventas (id_venta, id_producto, cantidad)
    VALUES (v_id_venta, p_id_producto, p_cantidad);

    -- Descontar stock
    UPDATE productos SET stock = stock - p_cantidad WHERE id_producto = p_id_producto;
END;
//
DELIMITER ;
