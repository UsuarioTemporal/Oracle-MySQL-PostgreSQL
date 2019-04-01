DROP TABLE factura;
DROP TABLE usuarios;
DROP TABLE producto;
DROP DATABASE tienda_java;

CREATE DATABASE tienda_java CHARACTER SET utf8 COLLATE utf8_spanish_ci;

CREATE TABLE usuarios(
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_usuario VARCHAR(25) NOT NULL,
    pass VARCHAR(25) NOT NULL,
    correo VARCHAR(25) UNIQUE NOT NULL,
    dni_usuario VARCHAR(8) UNIQUE NOT NULL
);
/*
    PARA MODIFICAR EL NOMBRE DE LA TABLA
    RENAME TABLE usuarios TO usuario ;
    
*/


/*
    PARA AGREGAR NUEVOS ATRIBUTOS A LA TABLA
    ALTER TABLE usuarios ADD edad INT NOT NULL ;
*/

CREATE TABLE producto(
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(25) NOT NULL ,
    precio_producto DECIMAL(8,2) NOT NULL
);

-- TABLA QUE CONTENDRA LAS DOS LLAVES DE LAS TABLAS ANTERIOS 
/*
    Integridad referencial
*/
CREATE TABLE factura(
    id_factura INT PRIMARY KEY AUTO_INCREMENT,
    fecha_factura DATE NOT NULL,
    id_usuarios INT NOT NULL,
    id_productos INT NOT NULL,
    FOREIGN KEY(id_usuarios) REFERENCES usuarios(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE ,
    FOREIGN KEY(id_productos) REFERENCES producto(id_producto) ON DELETE RESTRICT ON UPDATE CASCADE
);

/*
    OTRA FORMA DE AGREGAR LLAVES FORANEAS

    ALTER TABLE factura ADD id_usuarios INT NOT NULL;
    ALTER TABLE factura ADD id_productos INT NOT NULL;

    ALTER TABLE factura ADD CONSTRAINT fk_factura_usuario 
    FOREIGN KEY(id_usuarios) REFERENCES usuarios(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE ;

    ALTER TABLE factura ADD CONSTRAINT fk_factura_producto 
    FOREIGN KEY(id_productos) REFERENCES producto(id_producto) ON DELETE RESTRICT ON UPDATE CASCADE;

*/

