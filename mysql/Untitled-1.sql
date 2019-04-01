DROP TABLE IF EXISTS comidas;
DROP DATABASE IF EXISTS restaurante;


CREATE DATABASE IF NOT EXISTS restaurante;

CREATE TABLE IF NOT EXISTS comidas(
		id_comida SMALLINT PRIMARY KEY AUTO_INCREMENT, 
		nombre VARCHAR(30) NOT NULL,
		precio DECIMAL(4,2) NOT NULL 
);
CREATE TABLE IF NOT EXISTS postres(
		id_postre SMALLINT AUTO_INCREMENT PRIMARY key,
		nombre VARCHAR(30) NOT NULL,
		precio DECIMAL(4,2) NOT NULL
);

 insert into comidas values(default,'milanesa y fritas',3.4);
 insert into comidas values(default,'arroz primavera',2.5);
 insert into comidas values(default,'pollo',2.8);

 insert into postres values(default,'flan',1);
 insert into postres values(default,'porcion de torta',2.1);
 insert into postres values(default,'gelatina',0.9);

-- cross join
SELECT  c.nombre as Almuerzo , p.nombre as Postre, (c.precio+p.precio) as total FROM comidas as c CROSS JOIN postres as p;

select * from postres;
select * from comidas;

SELECT  c.nombre as Almuerzo , p.nombre as Postre FROM comidas as c JOIN postres as p ON c.precio=p.precio;

select nombre, IF (precio>2.7,'Caro','Barato') AS resultado FROM comidas;

CREATE TABLE IF NOT EXISTS publishers(
		id_publishers SMALLINT PRIMARY key AUTO_INCREMENT,
		name VARCHAR(500) NOT NULL
);

CREATE TABLE IF NOT EXISTS books(
		id_books SMALLINT PRIMARY KEY AUTO_INCREMENT,
		id_publishers SMALLINT NOT NULL,
		title VARCHAR(50) NOT NULL,
		price DECIMAL(5,2) NOT NULL,
		FOREIGN KEY (id_publishers) REFERENCES publishers(id_publishers)
);

ALTER TABLE books ADD  author VARCHAR(50) NOT NULL;

 insert into publishers (name) values('Planeta');
 insert into publishers (name) values('Emece');
 insert into publishers (name) values('Paidos');
 insert into publishers (name) values('Sudamericana');

 insert into books (title, author,id_publishers,price)
	values('El Aleph','Borges',1,43.5);
 insert into books (title, author,id_publishers,price)
	values('Alicia en el pais de las maravillas','Lewis Carroll',2,33.5);
 insert into books (title, author,id_publishers,price)
	values('Martin Fierro','Jose Hernandez',1,55.8);

	SELECT b.title ,b.price,p.name FROM publishers as p NATURAL left JOIN books as b;
	SELECT b.title ,b.price,p.name FROM publishers as p NATURAL right JOIN books as b;
	SELECT b.title ,b.price,p.name FROM publishers as p NATURAL inner JOIN books as b;
	SELECT b.title ,b.price,p.name FROM publishers as p NATURAL  JOIN books as b;

SELECT ('Hola mundo') AS First_query;
SELECT (7+1) as Suma;

SELECT NOW() AS fecha;
SELECT CURDATE() AS sin_hora;
SELECT CURTIME() AS hora;

SELECT MONTH(now()) AS mes;
SELECT YEAR(NOW()) AS year;
SELECT DAY(NOW()) AS day;
SELECT TIME(NOW()) as tiempo;


SELECT MONTHNAME(now()) as mes;


SELECT DATEDIFF(NOW(),'2002-11-02') ; # dias
select Date_format(now(),'%Y-%m-%d %h:%i:%s %p');

SELECT nombre ,valor FROM colores WHERE upper(nombre) = upper('azul');

SELECT * FROM productos WHERE vencimiento BETWEEN '2016-07-01' AND '2016-07-31';

SELECT * FROM colores WHERE nombre IN ('azul',...); 

SELECT * FROM otrosColores WHERE color_a IN (SELECT nombre FROM colores);


SELECT * FROM colores WHERE EXISTS (SELECT * FROM nombre);



CASE -- nos permite verificar que una condicion se cumpla para mostrar un tipo de dato especifico


SELECT * FROM books;
SELECT * FROM publishers;

SELECT *,
		(CASE
				WHEN price > 45.0 THEN 'Caro'
				ELSE 'Economico'
		END ) as Resultado
FROM books; # igual que postgres

# ahora imaginemos que es cansado escribir la misma variable

SELECT *,
		CASE price 
				WHEN 100 THEN 'sdadasda'
				WHEN 1200 THEN 'ASDASD'
				ELSE 'nO SE' END AS resulta
		FROM books;

-- into me permite crear una tabla apartir de una consulta


DROP DATABASE IF EXISTS market;
CREATE DATABASE IF NOT EXISTS market;
CREATE TABLE IF NOT EXISTS products(
		id_product SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		name VARCHAR(50) NOT NULL,
		price DECIMAL(5,2) UNSIGNED
);
CREATE TABLE IF NOT EXISTS sales(
		id_sale SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,
		quantity INTEGER UNSIGNED, 
		id_product SMALLINT UNSIGNED,
		FOREIGN KEY(id_product) REFERENCES products(id_product) ON  DELETE RESTRICT ON UPDATE RESTRICT
);

INSERT INTO products VALUES
						(DEFAULT,'Papa',100),
						(DEFAULT,'Yuca',75),
						(DEFAULT,'Platano',101),
						(DEFAULT,'Carne',2000);

INSERT INTO sales VALUES
						(DEFAULT,10,1),
						(DEFAULT,15,2),
						(DEFAULT,7,1),
						(DEFAULT,16,3),
						(DEFAULT,17,4),
						(DEFAULT,3,3),
						(DEFAULT,20,3),
						(DEFAULT,48,4);

SELECT * FROM sales;

SELECT * FROM sales NATURAL JOIN products;

SELECT * FROM products;

SELECT id_product ,SUM(quantity) as cantidad from sales group by id_product;


SELECT p.id_product ,p.name,p.price* v.cantidad as  total from products as p inner join (SELECT id_product ,SUM(quantity) as cantidad from sales group by id_product) as v on v.id_product= p.id_product ;



# where opera sobre registros individuales , mientras que having lo hace sobre un grupo de registros


CREATE TABLE IF NOT EXISTS films (
	id_film SMALLINT AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	director VARCHAR(30) NOT NULL DEFAULT 'Anonimo',
	relase_date DATE,
	gender VARCHAR(20),
	collection INTEGER,
	CONSTRAINT pk_films PRIMARY KEY (id_film)  
);
INSERT INTO films VALUES(1, 'Los juegos del Hambre', DEFAULT, '01-08-2014', 'Ciencia ficción', 1200000);
INSERT INTO films VALUES(2, 'Harry Potter y el Cáliz de Fuego', DEFAULT, '10-04-2012', 'Ciencia ficción', 6005400);
INSERT INTO films VALUES(3, 'Las Crónicas de Narnia', DEFAULT, '22-10-2008', 'Ciencia ficción', 5600098900);
INSERT INTO films VALUES(4, 'La lista de Schindler', 'Steven Spielberg', '22-03-1999', 'Drama', 456000120);
INSERT INTO films VALUES(5, 'La Pasión  de Cristo', 'Steven Spielberg', '19-08-2010', 'Drama', 456000120);
INSERT INTO films VALUES(6, 'Otra de Spielberg', 'Steven Spielberg', '07-11-2014', 'Drama', 456000120);
INSERT INTO films VALUES(7, 'La vida es bella', 'Roberto Benigni', '23-10-1998', 'Drama', 1256000000);
INSERT INTO films VALUES(8, 'Las posibles vidas de Mr. Nobody', 'Jaco Van Dormael', '06/11/2009', 'Ciencia ficción', 340009023);
INSERT INTO films VALUES(10, 'Buscando a Nemo', 'Andrew Stanton', '02-06-2007', 'Infantil', 780003400);
INSERT INTO films VALUES(11, 'Toy Story', 'Andrew Stanton', '22-12-2004', 'Infantil', 679000300);
INSERT INTO films VALUES(12, 'Toy Story 2', 'Andrew Stanton', '11-06-2007', 'Infantil', 5500300030);
INSERT INTO films VALUES(14, 'Toy Story 3', 'Andrew Stanton', '06-11-2012', 'Infantil', 880776000);
INSERT INTO films VALUES(15, 'Cars', 'Andrew Stanton', '14/05/2005', 'Infantil', 459000200);
INSERT INTO films VALUES(16, 'El viaje de Chihro', 'Hayao Miyazaki', '22-12-2004', 'Infantil', 456700000);
INSERT INTO films VALUES(17, 'Mi vecino Totoro', 'Hayao Miyazaki', '20-06-1992', 'Infantil', 5500300210);
INSERT INTO films VALUES(18, 'El viento se levanta', 'Hayao Miyazaki', '01-11-2013', 'Infantil', 990776000);
INSERT INTO films VALUES(19, 'Nausica del valle del viento', 'Hayao Miyazaki', '22-10-1989', 'Infantil', 669000200);

select * from films ;

-- truncate films;
SELECT gender, director, SUM(collection) AS TOTAL FROM films
	GROUP BY gender, director;

SELECT gender, director, SUM(collection) AS TOTAL FROM films
	GROUP BY gender, director HAVING SUM(collection)<2154689047;

	# http://carmoreno.github.io/sql/2017/02/09/Diferencia-entre-having-y-where/

	#Quizá te estés preguntando ¿cuándo usar HAVING o WHERE?, desde mi punto de vista, deberíamos usar HAVING solo cuando se vea implicado el uso de funciones de grupo (AVG, SUM, COUNT, MAX, MIN)

create table color (
	color1 varchar(10),
	color2 varchar(10)
);

insert into color values 
			('azul','azul'),
			('azul','rojo'),
			('rojo','rojo'),
			('negro','azul');

# evita los registros repetidos con respecto a la proyeccion
select distinct color1 ,color2 from color;
SELECT distinct director FROM films;

select distinct on (color_a) color_a , color_b FROM distintos; # ejm primera venta del cliente 
SELECT director FROM films GROUP BY director;


SELECT nombre , COUNT(*) AS cantidad 
FROM nombres 
GROUP BY nombre
HAVING COUNT(*)>1;

select director , COUNT(*) as cantidad
from films
group by director
HAVING COUNT(*)>1;

select * from tabla limit 5;
select * from tabla order by producto desc limit 5 ;

# los siguientes 5 productos
select * from tabla order by producto desc limit 5 OFFSET 5; # apartir de 6 el 5 es excluyente

SELECT * FROM films order by id_film limit 5 offset 0;
SELECT * FROM films order by id_film limit 5 offset 5;

# subconsultas en insert e update y delete


# Normalización

/*
	Eliminar los problemas :
		Redundancia
		Problemas de  :
			Insercion
			Actualización
			Eliminación
Es un proceso secuencial ciclico y repetitivo que consisite en aplicar a todas y caa una de las entidades del modelo unas reglas bien definidas con la finalidad de garantizar la integridad de los datos.
*/

/*
	Primera forma normal : 
		No de debe haber grupo repetidos
			nombre | materia 1 | materia 2
		Todos los elementos deben ser atomicos
		Los campos no clave deben identificase po la clave(dependecia funcional)

	Segunda forma normal : Forma de las dependencias funcionales
		Cada campo de la tabla debe depender de una clave unica, si tuvieramos alguna columna que se repite a lo largo de los registros, dichos datos deben atomizarse en una nueva tabla.
		Cero dependencia parcial.Todos los atributos que no son clave deben depender unicamente de una clave principal.
		En conclusion la segunda forma normal está basada en el concepto de dependencia completamentemete funcianal.

		Ejm :
			{DNI,ID_PROYECTO}->HORAS-TRABAJO
				sI ELIMINAMOS EL DNI no determinamos las horas y viceverza
			
			Dependencia parcial
			{DNI,ID_PROYECTO}->nombre_del_empleado

	Tercera forma normal :
	CEro transitivvidad
	Ningun campo no clave depende de ningun otro campo no clave
*/


DELIMITER //
CREATE FUNCTION fullname(firstname VARCHAR(250),lastname VARCHAR(250))
	RETURNS varchar(250)
	-- LOGICA
	BEGIN
		DECLARE message VARCHAR(50);
		SET message = 'asdasd';
		RETURN CONCAT('HOLA ',firstname,' ',lastname);
	END; //

delimiter ;
drop function fullname;
select fullname('thom','roman');
