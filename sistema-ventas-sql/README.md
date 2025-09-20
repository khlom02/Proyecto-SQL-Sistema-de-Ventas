# 🛒 Proyecto SQL: Sistema de Ventas

Este proyecto implementa un **sistema de ventas** utilizando **MySQL**.  
Está diseñado como un ejercicio de **modelado de bases de datos relacionales** a nivel intermedio-avanzado, incluyendo:

- Creación de tablas con claves primarias y foráneas.
- Inserción de datos de prueba.
- Consultas SQL para reportes de negocio.
- Vistas, procedimientos almacenados y triggers.
- Diagrama EER generado en MySQL Workbench.
- Optimización mediante índices.

---

## 📂 Estructura del repositorio

sistema-ventas-sql/
│── README.md
│── modelo-eer.png # Diagrama EER exportado desde MySQL Workbench
│── scripts/
│ ├── 01_create_db.sql # Script de creación de la BD y tablas
│ ├── 02_insert_data.sql # Datos de prueba
│ ├── 03_queries.sql # Consultas SQL
│ ├── 04_views.sql # Vistas
│ ├── 05_procedures.sql # Procedimientos almacenados
│ ├── 06_triggers.sql # Triggers
│ └── 07_indexes.sql # Índices


---

## 🗄️ Modelo de datos

El sistema está compuesto por las siguientes entidades:

- **Clientes** → Personas que realizan compras.  
- **Productos** → Catálogo de artículos disponibles.  
- **Usuarios** → Empleados del sistema (admins y vendedores).  
- **Ventas** → Registro de cada transacción.  
- **Detalle de ventas** → Productos asociados a cada venta.  

📌 Diagrama EER:  

![Modelo EER](./Modelo-EER.png)

---

## ⚙️ Instalación y uso

1. Clonar este repositorio:
   ```bash
   git clone https://github.com/TU-USUARIO/sistema-ventas-sql.git
   cd sistema-ventas-sql

Abrir MySQL Workbench.

Ejecutar los scripts en el siguiente orden:

scripts/01_create_db.sql

scripts/02_insert_data.sql

scripts/03_queries.sql (para probar consultas)

scripts/04_views.sql

scripts/05_procedures.sql

scripts/06_triggers.sql

scripts/07_indexes.sql

----------------------------------------------------------------------------------------------------------
🔍 Consultas de ejemplo
Total gastado por cliente:

SELECT c.nombre, SUM(d.cantidad * p.precio) AS total
FROM clientes c
JOIN ventas v ON c.id_cliente = v.id_cliente
JOIN detalle_ventas d ON v.id_venta = d.id_venta
JOIN productos p ON d.id_producto = p.id_producto
GROUP BY c.nombre
ORDER BY total DESC;

------------------------------------------------------------------------------------------------------------

Productos más vendidos:

SELECT p.nombre, SUM(d.cantidad) AS total_vendidos
FROM productos p
JOIN detalle_ventas d ON p.id_producto = d.id_producto
GROUP BY p.nombre
ORDER BY total_vendidos DESC;

-------------------------------------------------------------------------------------------------------------

🚀 Características avanzadas

✔️ Vistas para reportes de ventas.
✔️ Procedimientos almacenados para registrar ventas automáticamente.
✔️ Triggers que validan reglas de negocio (ej. evitar stock negativo).
✔️ Índices para mejorar el rendimiento de consultas.
Autor

Proyecto desarrollado por @Khalom_Dev como práctica de modelado SQL y gestión de bases de datos.

Si te gusta, ¡no olvides dejar una ⭐ en el repo!