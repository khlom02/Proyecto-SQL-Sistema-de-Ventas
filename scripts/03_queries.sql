-- Total gastado por cliente

SELECT c.nombre, SUM(d.cantidad * p.precio) AS total
FROM clientes c
JOIN ventas v ON c.id_cliente = v.id_cliente
JOIN detalle_ventas d ON v.id_venta = d.id_venta
JOIN productos p ON d.id_producto = p.id_producto
GROUP BY c.nombre
ORDER BY total DESC;

-- Top productos más vendidos
SELECT p.nombre, SUM(d.cantidad) AS total_vendidos
FROM productos p 
JOIN detalle_ventas d ON p.id_producto = d.id_producto
GROUP BY p.nombre
ORDER BY total_vendidos DESC;
