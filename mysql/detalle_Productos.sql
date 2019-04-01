USE mall;
SHOW COLUMNS FROM Detalle_Producto_Proveedor;
-- DROP TABLE IF EXISTS usuarios ;
CREATE TABLE Proveedor(
    idProveedor int auto_increment primary key,
    nombre varchar(50) not null
);
CREATE TABLE Producto(
    idProducto int auto_increment primary key,
    nombre varchar(50) not null,
    precio decimal(10,2) not null,
    fecha date default '0000-00-00'
);
USE mall;
show columns from Producto;
CREATE TABLE Categoria (
    idCategoria INT PRIMARY KEY  AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

ALTER TABLE Producto ADD idCate int not null ;
ALTER TABLE Producto ADD CONSTRAINT fk_proCate FOREIGN KEY (idCate) REFERENCES Categoria(idCategoria)
on DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE Detalle_Producto_Proveedor(
    idDetalle int auto_increment primary key,
    idProducto int not null,
    idProveedor int not null
);

/* AGREGANDO LLAVE FORANEA  */
ALTER TABLE Detalle_Producto_Proveedor ADD 
CONSTRAINT fk_DetalleProducto FOREIGN KEY (idProducto) 
REFERENCES Producto(idProducto) ON DELETE CASCADE ON UPDATE CASCADE ;  

/* aGREGANDO SEGUNDA LLAVE FORANEA */

ALTER TABLE Detalle_Producto_Proveedor ADD CONSTRAINT
fk_DetalleProveedor FOREIGN KEY (idProveedor) 
REFERENCES Proveedor(idProveedor) ON DELETE CASCADE ON UPDATE CASCADE ;  

/* Agregando a mis tablas fuertes */
INSERT INTO Categoria(nombre) VALUES('Bebidas');

/* Actualiando atributos a mi tabla fuerte */
UPDATE Categoria SET nombre='Verduras' WHERE idCategoria=2;



/* Seguimos insertando */

INSERT INTO  Categoria(nombre) VALUES
                                    ('Aceite'),
                                    ('Detergente'),
                                    ('Ceriales'),
                                    ('Limpieza');

INSERT INTO Categoria SET nombre='Frituras';

select fecha from Producto;
select * from Categoria;

INSERT INTO Producto(nombre,precio,idCate) VALUES
                                    ('Coca Cola',2.00,1),
                                    ('Doritos',1.00,7),
                                    ('Arroz',5.00,5);

/* ACTUALIZANDO FEHCAS DE MIS PRODUCTOS */
UPDATE Producto SET fecha='2018-10-10' where idProducto=1;
UPDATE Producto SET fecha='2018-09-12' where idProducto=2;
UPDATE Producto SET fecha='2018-07-12' where idProducto=3;

INSERT INTO Producto(nombre,precio,idCate,fecha) VALUES ('Clorox',2.5,6,'2018-01-01');
INSERT INTO Producto(nombre,precio,idCate,fecha)
VALUES('Chetos',1.5,7,CURDATE()); -- curdate nos dira la fecha del servidor

select * from Producto;
select * from Categoria;
select * from Detalle_Producto_Proveedor;
select * from Proveedor;

/* Actualizaciones de tabla debil */
UPDATE Producto set nombre='Papitas lay',precio='5' where idProducto=5;

/* Modificacion con operaciones */
ALTER TABLE Producto ADD COLUMN exitencia int not null ; 
UPDATE Producto SET exitencia = exitencia + 5 where idProducto=1;
UPDATE Producto SET exitencia = exitencia - 2 where idProducto=1;


UPDATE Producto SET precio=REPLACE(precio,5,6); -- esto quiere decir
-- que todos los precios que tengan 5 se remplaran por 6

/* UPDATE Producto set nombre=REPLACE(nombre,'leta','letita'); */


DELETE FROM Producto WHERE idProducto=5 ; 

insert into Producto(nombre,precio,idCate,fecha)
    values('Papilas lay',5,7,CURDATE());
    

/* Eliminacion para reiniciar la tabla BORRANDO TODO, pero esta misma 
es tipo debil, asi que se tiene que desactivar la llave foranea 
momentaneamente*/

SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE Producto;
SET FOREIGN_KEY_CHECKS=1;

/* CONSULTAS */
DESCRIBE Producto ; -- para ver la estructura de la tabla

-- COLOCANDO ALIAS TEMPORALES
SELECT nombre AS Nombre, MAX(precio) from Producto;
select nombre AS Nombre, MIN(precio) from Producto;


/*SubConsultas*/
use mall;
SELECT idProducto, nombre,precio From Producto as con,
(SELECT MIN(precio) as mini , MAX(precio) as maxi from Producto)
as sub where sub.maxi=con.precio or sub.mini=con.precio;

INSERT INTO Producto(nombre,precio,fecha,idCate) values
('Maiz',5,CURDATE(),5);
/* TAMBIEN PODEMOS HACER AGRUPACIONES ...  QUIERO QUE ME
AGRUPE TODOS LOS ARTICULOS QUE SON DE UNA CATEGORIA*/

SELECT idCate as ID_Categoria ,COUNT(idProducto) as Cantidad from Producto group by idCate;


/*VER LOS DOS PRIMEROS PRODUCTOS*/

select * from Producto LIMIT 2;

/*SI QUEREMOS CON RANGOS */
SELECT * FROM Producto LIMIT 1,2 ; 


/*CONSULTAR CON ORDEN*/

select * from Producto order by nombre ASC ;
select * from Producto order by nombre DESC ;

select * from Producto ORDER BY precio ASC ;


/*operadores*/
select * from Producto where idCate=5 and precio=5;
select * from Producto where precio is not null ;

select * from Producto where precio BETWEEN 2 AND 5; 

SELECT * FROM Producto WHERE precio NOT BETWEEN 2 AND 5 ; 

SELECT * FROM Producto WHERE precio IN(2,5); -- SI LE PONEMOS NOT
-- NO LO TRAEREMOS


/*BETWEEN CON FECHAS*/
SELECT * FROM Producto WHERE DATE(fecha) BETWEEN  '2018-07-12' AND '2018-10-10' ;
SELECT * FROM Producto WHERE nombre LIKE 'DORITOS';

SELECT * FROM Producto where nombre like '%Arroz%';


/*Consultas multitablas*/
/* select * from Producto,Categoria where idCate=idCategoria; */
select pro.idProducto,pro.nombre,pro.precio,pro.fecha,pro.idCate,cat.nombre as 
Nombre_Cat from Producto as pro INNER JOIN Categoria as cat
on pro.idCate=cat.idCategoria;

CREATE TABLE Temporal(
    idTemporal int auto_increment primary key,
    nombre varchar(50) not null
);
INSERT INTO Temporal(nombre) values ('Uno'),('Dos');

select p.nombre,p.precio,c.nombre as Categoria from Producto as p INNER JOIN Categoria as c
on p.idCate=c.idCategoria;
select * from Producto;
/* left join primero consulta desde registros que esten primeros y luego une--  */
SELECT pro.idProducto,pro.nombre,pro.precio,pro.fecha,pro.idCate,tem.idTemporal,
tem.nombre FROM Producto as pro LEFT JOIN Temporal as tem 
on pro.idCate=tem.idTemporal;

/* right primero consulta de la ultima tabla y luego une con la primera */
SELECT pro.idProducto,pro.nombre,pro.precio,pro.fecha,pro.idCate,tem.idTemporal,
tem.nombre FROM Producto as pro RIGHT JOIN Temporal as tem 
on pro.idCate=tem.idTemporal;
USE mall;
/*  */
SELECT * from Categoria UNION SELECT idProducto,nombre from Producto;

SELECT p.nombre as Nombres ,c.nombre AS Categorias FROM Producto AS p INNER JOIN Categoria AS c on p.idCate=c.idCategoria;
SELECT p.nombre as producto , c.nombre as categoria ,
pv.nombre as proveedor from Producto as p
inner join Categoria as c on p.idCate=c.idCategoria
inner join Detalle_Producto_Proveedor as det on p.idProducto=det.id
inner join Proveedor as pv on det.id=pv.id 

select * from Proveedor;
