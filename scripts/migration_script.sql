-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: sistema_ventas
-- Source Schemata: sistema_ventas
-- Created: Sat Sep 20 16:51:40 2025
-- Workbench Version: 8.0.43
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema sistema_ventas
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `sistema_ventas` ;
CREATE SCHEMA IF NOT EXISTS `sistema_ventas` ;

-- ----------------------------------------------------------------------------
-- Table sistema_ventas.clientes
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_ventas`.`clientes` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `fecha_registro` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------------------------------------------------------
-- Table sistema_ventas.detalle_ventas
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_ventas`.`detalle_ventas` (
  `id_detalle` INT NOT NULL AUTO_INCREMENT,
  `id_venta` INT NOT NULL,
  `id_producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id_detalle`),
  INDEX `id_venta` (`id_venta` ASC) VISIBLE,
  INDEX `idx_producto` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `detalle_ventas_ibfk_1`
    FOREIGN KEY (`id_venta`)
    REFERENCES `sistema_ventas`.`ventas` (`id_venta`),
  CONSTRAINT `detalle_ventas_ibfk_2`
    FOREIGN KEY (`id_producto`)
    REFERENCES `sistema_ventas`.`productos` (`id_producto`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------------------------------------------------------
-- Table sistema_ventas.productos
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_ventas`.`productos` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `stock` INT NOT NULL,
  PRIMARY KEY (`id_producto`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------------------------------------------------------
-- Table sistema_ventas.usuarios
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_ventas`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `rol` ENUM('admin', 'vendedor') NULL DEFAULT 'vendedor',
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------------------------------------------------------
-- Table sistema_ventas.ventas
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_ventas`.`ventas` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `fecha` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_venta`),
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  INDEX `idx_cliente` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `ventas_ibfk_1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `sistema_ventas`.`clientes` (`id_cliente`),
  CONSTRAINT `ventas_ibfk_2`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `sistema_ventas`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------------------------------------------------------
-- View sistema_ventas.vista_ventas
-- ----------------------------------------------------------------------------
USE `sistema_ventas`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sistema_ventas`.`vista_ventas` AS select `v`.`id_venta` AS `id_venta`,`c`.`nombre` AS `cliente`,`u`.`nombre` AS `vendedor`,sum((`d`.`cantidad` * `p`.`precio`)) AS `total` from ((((`sistema_ventas`.`ventas` `v` join `sistema_ventas`.`clientes` `c` on((`v`.`id_cliente` = `c`.`id_cliente`))) join `sistema_ventas`.`usuarios` `u` on((`v`.`id_usuario` = `u`.`id_usuario`))) join `sistema_ventas`.`detalle_ventas` `d` on((`v`.`id_venta` = `d`.`id_venta`))) join `sistema_ventas`.`productos` `p` on((`d`.`id_producto` = `p`.`id_producto`))) group by `v`.`id_venta`;

-- ----------------------------------------------------------------------------
-- Routine sistema_ventas.registrar_venta
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `sistema_ventas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_venta`(
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
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Trigger sistema_ventas.tr_stock_negativo
-- ----------------------------------------------------------------------------
DELIMITER $$
USE `sistema_ventas`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `tr_stock_negativo` BEFORE UPDATE ON `productos` FOR EACH ROW BEGIN
    IF NEW.stock < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock no puede ser negativo';
    END IF;
END;
SET FOREIGN_KEY_CHECKS = 1;
