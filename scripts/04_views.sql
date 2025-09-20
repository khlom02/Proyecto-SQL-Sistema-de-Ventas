CREATE VIEW vista_ventas AS
SELECT v.id_venta, c.nombre AS cliente, u.nombre AS vendedor,
       SUM(d.cantidad * p.precio) AS total
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
JOIN usuarios u ON v.id_usuario = u.id_usuario
JOIN detalle_ventas d ON v.id_venta = d.id_venta
JOIN productos p ON d.id_producto = p.id_producto
GROUP BY v.id_venta;

