CREATE DATABASE tienda CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE tienda;
CREATE TABLE productos(
	idProducto int auto_increment primary key,
    nombreProdcuto varchar(50) not null,
    precio decimal(10,2) not null,
    fecha date default '0000-00-00'
);

select * from productos ;

show columns from productos;


show create table productos ; /*ESTA INSTRUCCION SE USA PARA VER
COMO SE CREO  ESA INSTRUCCION*/


-- para ver que tablas tenemos 
show tables;

rename table productos to producto ; 
ALTER TABLE producto add existencias int not null ; 

USE tienda;
show columns from producto ;
alter table producto drop column existencias ; 

alter table producto change precios precio decimal(18,2) not null ;

/*eliminando tablas drop table*/

select * from producto;
-- RELACION ENTRE TABLAS

create table categoria (
	idCategoria int primary key auto_increment ,
    nombre varchar(50) not null
);

alter table producto add idCategoria int not null ; 


-- agregando la clave foranea

alter table producto add constraint fk_catPro foreign key (idCategoria) references categoria(idCategoria)
;


