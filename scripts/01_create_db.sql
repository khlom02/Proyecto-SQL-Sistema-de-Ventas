CREATE DATABASE IF NOT EXISTS sistema_ventas;
USE sistema_ventas;

CREATE TABLE clientes (
id_cliente INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE,
fecha_registro DATETIME DEFAULT NOW()
);

CREATE TABLE productos(
id_producto INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nombre VARCHAR(100) NOT NULL,
precio DECIMAL(10,2) NOT NULL,
stock INT NOT NULL
);

CREATE TABLE usuarios(
id_usuario INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nombre VARCHAR(100) NOT NULL,
rol ENUM('admin','vendedor') DEFAULT 'vendedor'
);

CREATE TABLE ventas(
id_venta INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
id_cliente INT NOT NULL,
id_usuario INT NOT NULL,
fecha DATETIME DEFAULT NOW(),
FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE detalle_ventas(
id_detalle INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
id_venta INT NOT NULL,
id_producto INT NOT NULL,
cantidad INT NOT NULL,
FOREIGN KEY(id_venta) REFERENCES ventas(id_venta),
FOREIGN KEY(id_producto) REFERENCES productos(id_producto)
);