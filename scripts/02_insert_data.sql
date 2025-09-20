INSERT INTO clientes (nombre, email) VALUES
('Carlos Perez', 'carlos@gmail.com'), 
('Ana Lopez', 'ana@gmail.com'),
('Maria Gomez', 'maria@gmail.com'); 

INSERT INTO productos (nombre, precio, stock) VALUES
('lapto', 750.00,10),
('mouse', 20.00,100),
('teclado', 30.00,50),
('monitor', 200.00,25);

INSERT INTO usuarios (nombre, rol) VALUES
('Juan Admin', 'admin'),
('Pedro Vendedor', 'vendedor');

-- Simulación de ventas

INSERT INTO ventas(id_cliente, id_usuario) VALUES 
(1,2),
(2,2);

INSERT INTO detalle_ventas (id_venta, id_producto, cantidad) VALUES
(1, 1, 1),  -- Laptop
(1, 2, 2),  -- 2 Mouse
(2, 3, 1),  -- Teclado
(2, 4, 1);  -- Monitor