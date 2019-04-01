/* Orden by */
/* Ordena los registros seleccionados en funcion de un campo */
SELECT * FROM producto WHERE seccion='desportes' or seccion='ceramica';
SELECT * FROM producto where seccion='deportes'or seccion='ceramica' ORDER BY seccion,precio; -- ordena por seccion y luego ordena por precio


/* Consulta de agrupacion o consultas totales */
/* Realizan calculos por grupos */
/* Funciones de agregado  */
/*  AVG  calcula el promedio de un campo
    COUNT Cuenta los registros de un campo 
    SUM suma los valores de un campo
    MAX devuelve el m{aximo de un campo
    MIN devuelve el mínimo de un campo*/
/* Campo de agrupacion y el campo del calculo */
SELECT seccion , SUM(precio) AS TOTAL FROM producto GROUP BY seccion ORDER BY TOTAL ; -- O SUMA(PRECIO);
/* eL HAVING SUSTITUYE AL WHERE PERO SOLO EN LAS CONSULTAS DE AGRUPACION O TOTALES */
SELECT seccion ,AVG(precio) AS promedio_precio FROM producto GROUP BY seccion HAVING seccion='deportes' or seccion='confeccion' as ORDER BY promedio_precio;
SELECT poblacion ,COUNT(id_clientes) AS clientes_totales FROM clientes GROUP BY poblacion ORDER BY clientes_totales DESC ;
SELECT seccion , MAX(precio) AS maximo_precio from where seccion='deportes' producto GROUP by seccion;
/*maxima y minima poblacion en total*/

/* Calculos de consulta */
/* Se usa para registros individuales */
/* Funciones frecuentes */
now()
datediff() -- diferencia entre dos fechas
date_format() --formatear
concat() -- concatenar 
round(expresion,2)
truncate
SELECT nombre_articulo,seccion,precio,round(precio*1.21,2) as ivg from productos;

SELECT nombre_articulo,seccion,precio,round(precio*7.21,2) as ivg ,datediff(now(),fecha) AS diferencia from productos where seccion='deportes';
/* modificar el formato d un campo fecha */
date_format(espresion,'%D-%M-%Y')
-- pendiente


/* CONSULTA MULTITABLA -- CONSULTAS DE UNION*/
/* 
    - UNION EXTERNA
        - UNION
        - UNION ALL

        - NO SOPORTA MYSQL
        - EXCEPT
        - INTERSECT
        - MINUS
    - UNION INTERNA
        - A INNER JOIN B on (condicion) devuelve el conjuneto de registros de AXB que cumplne la condicion 
        - A LEFT JOIN B on (condicion) para cada A,devuelve los de B que cumplan la condicion.Si no hay ningun 
                registro en B que cumpla la condicion , se devuelve un registro con los campos de B a NULL
        - A RIGHT JOIN B igual pero del otro lado

 */
ISNULL(EXPRESION,"NO HAY")
/* Una subconsulta es un consulta dentro de otra consulta */
/*  Subconsultas escalonadas .- un campo y un registro(este es el que se utiliza para filtrar o compara con 
        la instruccion padre)
    subconsulta de lista --esta devulve una lista de registro aqui se utiliza los operadors (ANY(cualquiera) IN ALL)
    subconsulta correlacionada
*/
/* Subconsulta escalonada */
 /* PRIMERO OBTENGO LA CONSULTA QUE CALCULE LA MEDIA */
SELECT nombre_articulo ,seccion from Productos where precio > (SELECT AVG(precio)  FROM Produco); 
/* Subconsulta de lista */
SELECT * FROM Productos where precio > ALL(SELECT precio FROM Productos WHERE seccion='ceramica');

/* subconsulta correlacionada */
select nombre_articulo , precio from Produco
where codigo_articulo in(select codigo_articulo from
producto_pedidos where unidades>20)
/* 
    Referencias Externas

    A menudo , es necesario , dentro del curso de una subconsulta , hacer referencia al valor de una columna en la fila actual de la consulta principal , ese nombre de la columna se denomina referencia externa.
    Una referencia externa es un nombre de columna que estando en la subconsulta , no se refiere a ninguna columna de las tablas designadas
    SELECT numemp, nombre, (SELECT MIN(fechapedido) FROM pedidos WHERE rep = numemp)
    FROM empleados;



    Anidar subconsultas
    SELECT numemp, nombre
    FROM empleados
    WHERE numemp = (SELECT rep FROM pedidos WHERE clie = (SELECT numclie FROM clientes WHERE nombre = 'Julia Antequera'))

    SELECT numemp, nombre, oficina
    FROM empleados
    WHERE EXISTS (SELECT * FROM oficinas WHERE region = 'este' AND empleados.oficina = oficinas.oficina)
    Cuando se trabaja con tablas muy voluminosas el test EXISTS suele dar mejor rendimiento que el test IN.
 */





/* Triggers o disparadores 
    Son como eventos es decir que cuando al realizar un accion en concreto se desencadena una accion en la base de datos 
    Un trigger es un objeto que se crea en la base de datos, las consultas o las vistas son objetos , las consultas son objetos , el objeto trigger siempre esta asociado a una tabla es decir que este trigger desencadenara algo cuando este asociado a esta tabla
    Estos eventos son lo siguientes 
        insertar
        eliminar
        actualizar

    Objetivo - Tareas de matenimiento y administracion de base de datos
    Pero lo mas importante es asignarle cuando debe desencadenarse esta accion : before or after


    Primero se pone el nombre de la tabla en la que esta asociado A after o B de before
*/
CREATE TABLE registro_producto (codigo_articulo VARCHAR(4) , nombre_articulo VARCHAR(30) , precio DECIMAL(10,2),insertado DATETIME);

CREATE TRIGGER producto_AI AFTER INSERT  ON Productos FOR EACH ROW INSERT INTO registro_producto(codigo_articulo,nombre_articulo,precio,insertado) VALUES (NEW.codigo_articulo,NEW.nombre_articulo,NEW.precio,NOW());

/* RESPALDO PRODUCTO */
CREATE TABLE productos_actualizados (anterior_codigo_articulo VARCHAR(4),anterior_nombre_articulo ...,usuario,f_modif)

CREATE TRIGGER actualiza_producto_BU BEFORE UPDATE ON Productos FOR EACH ROW INSERT INTO productos_actualizados(anterior_codigo_articulo, anterior_codigo_articulo,...,nuevo_codigo_articulo, nuevo_codigo_articulo,...,usuario,f_modif) VALUES(OLD.codigo_articulo,...,NEW.codigo_articulo,CURRENT_USER(),NOW())


create table prod_eliminados(c_arti varchar(5),nombre varchar(15),seccion varchar(15), precio integer , pais_origen varchar(15));
create trigger elimprod_AD after delete on productos for each row 
insert into prod_eliminados(c_arti,nombre ,seccion , precio , pais_origen)
values (old.codigo_articulo,old.nombre_articulo,old.paisOrigen,old.precio,old.seccion)


/* Modificar el trigger entonces modificar la tabla prod_eliminados */
alter table prod_eliminados add column (usuario varchar(15),fecha_modif date)

/* No existe codigo para modificar un trigger lo que se hace es eliminar el y luego crear */
drop trigger if EXISTS elimprod_AD;
create trigger elimprod_AD after delete on productos for each row 
insert into prod_eliminados(c_arti,nombre ,seccion , precio , pais_origen,usuario,fecha_modif)
values (old.codigo_articulo,old.nombre_articulo,old.paisOrigen,old.precio,old.seccion,current_user(),now())

/* Procedimientos alamacenados
    eficiencia , seguridad

    Consiste en alamcenar en u procedimiento operaciones repetitivas que se ejecutan desde diferenctes aplicaciones
    Esto se almacenara en el servidor 

    
*/

CREATE PROCEDURE muestra_cliente()
SELECT * FROM WHERE problacion="madrid"
;
call muestra_cliente(); -- sirve para llamaer al procedimiento

/* Procedimiento almacenado que actualice productos */
create procedure actializa_producto(new_precio int,codigo varchar(4))
update producto set precio = new_precio where codigo_articulo=codigo;
call actializa_producto(12,'1234');



/* Declarar variables en procedimientos alamcenados */
/* Procedimietno alamacenado que sea capaz de calcular la edad en funcion del año de nacimiento que pasaremos por parametro */
delimiter // -- $$
CREATE PROCEDURE calcula_edad(Year_nacimiento int)
    BEGIN
        DECLARE anio_actual int default 2018 ;
        DECLARE edad int ; --el punto y coma significa el delimitador por defecto y otra cosa es el delimitador de bloque
        SET edad=anio_actual-Year_nacimiento; -- delimitador
        SELECT edad ;
    END ;// -- delimitador de bloque

-- luego me obligara que resetee el delimitador de bloque
delimiter ; -- volviendo a su estado normal

call calcula_edad(1974);


/* triggers condicionales */
delimiter //
create trigger revisa_precio_BU before update  on Productos for each row 
    begin 
        if(new.precio <0 ) then 
            set new.precio=0; --old.precio
        else if (new.precio >1000) then
            set new.precio=1000; --old.precio
        end if;

    end ;//
delimiter ;

/* Vistas */
/*  VENTAJAS : 
    privacidad de la informacion --OCULTAR LAS TABLAS A UN GRUPO DE USUARIOS
    optimizacion de la bbdd -- 
    Entorno de pruebas
*/
CREATE VIEW vista_art_deportes AS
    SELECT  nombre_articulos , seccion , precio FROM Producto
    WHERE seccion = 'Deportes'

select * from art_deportes;

drop view art_deportes;

alter view vista_art_deportes as 
    SELECT nombre_articulo ,seccion ,paisOrigen from Productos
    where paisOrigen='España'



/* Vistas son como tablas virtuales que contienen los resultados de una consulta PERO SOLO SE GUARDARAN LA CONSULTA MAS
NO LAS REFERENCIAS A LOS DATOS*/
create view vista_producto_categoria as 
    select p.id , p.nombre,o.precio,p.existencia , c.nombre  as  nombre_categoria
    from Producto as p inner join Categoria as c  on p.idCat = c.id ;

create view vista_producot_escaso as 
    select * from Producto where existencias< 10 ;

show create view vista_producot_escaso;


delimiter //  --$$
create PROCEDURE productoXcategoria (in id int)
    begin
        SELECT* FROM Producto WHERE idCaegoria = id;
    END //

delimiter ; 

delimiter |
CREATE TRIGGER tempTrigge_BI BEFORE INSERT on Categoria for each row 
    BEGIN 
        INSERT INTO tem(nombre) VALUE (new.nombre);
    END |  

/*

muy utilizada para las transacciones , 
*/

-- Administracion de usarios

-- creando usuario sin privilegios
grant usage on *.* cajero identified by 'cajero1234'; 

-- privilegios
grant select ,update on tiendita.producto to cajero ;
-- en ocaciones los privilegios no cargan
flush privileges ;

-- quitando privilegios
revoke select on tiendita.* from cajero;
-- Para ver los privilegios que tiene el usuario
show grant for cajero;

drop user cajero ;

select author , SUM (sales) as VENTAS 
from books
where author is not null 
group by author
having suma(sales)> @promedio 
order by VENTAS desc ;
set @promedio  = (select AVG(sales) from books) -- variable

delimiter //
CREATE FUNCTION full_name(firstname varchar(50),lastname varchar(50))
    returns varchar(50)
    begin 
        return concat('Hola ',firstname," ",lastname);
    end //
delimiter ; 

select full_name('Eduardo','Garcia');


-- Transacciones 
start transaction ;
-- operaciones
commit ; -- persistir de forma permanente todos los cambios que se hicieron en la transaccion (finalizamos las transaccciones)


start transaction;
--operaciones
rollback; --revertir los cambios que ocurrieron en la transaccion



