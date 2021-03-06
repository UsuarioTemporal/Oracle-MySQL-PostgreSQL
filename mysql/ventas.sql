DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS cliente;
DROP DATABASE IF EXISTS ventas;
CREATE DATABASE IF NOT EXISTS ventas CHARACTER SET UTF8 COLLATE UTF8_SPANISH_CI;
CREATE TABLE IF NOT EXISTS producto(
    id_producto INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_produccion DATE NOT NULL,
    pais VARCHAR(30) NOT NULL
);
CREATE TABLE IF NOT EXISTS proveedor(
    id_proveedor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
    ruc VARCHAR(11) NOT NULL,
    nombre_proveedor VARCHAR(50) NOT NULL,
    telefono VARCHAR(9) UNIQUE NOT NULL 
);

CREATE TABLE IF NOT EXISTS cliente(
    id_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
    nombre_cliente VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    direccion_cliente VARCHAR(20) NOT NULL,
    telefono VARCHAR(9) UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    ciudad VARCHAR(20) NOT NULL
);
