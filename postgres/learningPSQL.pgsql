/*ojo que para pode r hacer esto se require de estar conectado a una base de datos*/
select 'hola mundo';
select char_length('hola mundo');

-- cuando se indica una atributo como varchar postgres internamente lo cambia a character varying(n)

-- fechas
SELECT now();
INSERT INTO vehiculos VALUES('asd','asd',4)
SELECT * FROM vehiculos;

CREATE TABLE IF NOT EXISTS cellphones(model VARCHAR(20),value SMALLINT);

INSERT INTO cellphones VALUES   ('Nokia',10),
  ('Samsumg',45),
  ('Apple',45);

SELECT * FROM cellphones;

-- sequence (secuencia)

create SEQUENCE seq_cellphones;
ALTER TABLE cellphones ADD COLUMN consecutivo SMALLINT;
insert into cellphones values('otrro',10,NEXTVAL('seq_cellphones'));
insert into cellphones values('otrro2',1,NEXTVAL('seq_cellphones'));

select NEXTVAL('seq_cellphones'); -- esto aumenta y cuando insertamos tambien aumetara en la tabla

-- para saber la secuencia actual sin alterar

SELECT currval('seq_cellphones'); -- esto solo se puede hacer despues de un nextval -- hasta el momneto esto solo funciona en terminal

/*
    Principios : 

    DDL : crear(CREATE) modificar(ALTER) borrar(DROP) 

    DML : insertar(INSERT) consultar(SELECT) actualizar(UPDATE) eliminar(DELETE)

    DCL


*/
-- \db para ver los tablespace
-- CREATE USER name PASSWORD 'password123'
create user thom PASSWORD 'thom'; -- role

-- create DATABASE nombre owner = usuario tablaspace = el_tablaspace

CREATE DATABASE mi_base_de_datos OWNER = thom;


CREATE TABLE IF NOT EXISTS tabla (
  columna1 VARCHAR(4) NOT  NULL,
  columna2 BOOLEAN NOT NULL,
  revisado BOOLEAN DEFAULT FALSE
  secuencia SERIAL,
  CONSTRAINT edades CHECK (columna>valor and columna<valor)--RESTRICCIONES

);


create DATABASE nueva_db;


create table if not exists propietarios(
  identificacion varchar(12),
  nom_nombres varchar(100) not null,
  nom_apellidos varchar(100) not null,
  email varchar(200),
  CONSTRAINT  pk_identificacion PRIMARY KEY (identificacion)

);

CREATE TABLE IF NOT EXISTS telefonos(
  identificacion VARCHAR(12),
  telefono VARCHAR(20),
  CONSTRAINT pk_telefonos PRIMARY KEY (identificacion,telefono),
  CONSTRAINT fk_telefonos_propietarios FOREIGN KEY (identificacion)
              REFERENCES propietarios (identificacion)
              ON UPDATE RESTRICT  ON DELETE RESTRICT
);


CREATE TABLE IF NOT EXISTS departamentos(
  codigo SMALLSERIAL,
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT pk_departamentos PRIMARY KEY (codigo)
);
CREATE TABLE if not exists ciudades(
  nombre VARCHAR(100),
  codigo SMALLSERIAL,
  departamento SMALLINT NOT NULL,
  CONSTRAINT pk_ciudades PRIMARY KEY (codigo),
  CONSTRAINT fk_ciudades_departamentos FOREIGN KEY (departamento)
  REFERENCES departamentos(codigo) ON DELETE RESTRICT ON UPDATE RESTRICT
);


ALTER USER pablo PASSWORD 'otro'

ALTER DATABASE nombre RENAME TO nuevo_nombre
ALTER DATABASE nombre OWNER TO nuevo_usuario

ALTER DATABASE nombre SET TABLESPACE nuevo_tablespace;
ALTER TABLE nmobre RENAME to nuevo_nombre

ALTER TABLE nombre ADD COLUMN campo tipo
ALTER TABLE nombre DROP column campoN
alter table nombre alter column campo set not null


ALTER TABLE nombre ADD CONSTRAINT nombre_constraint FOREIGN KEY (...)
REFERENCES OTRA_TABLA(...) ON DELETE RESTRICT ON UPDATE RESTRICT

ALTER TABLE TABLA drop CONSTRAINT NOMBRE_CONSTRIAT

ALTER TABLE TABLA ALTER COLUMN CAMPO SET DEFAULT VALORXDEFERCTO
ALTER TABLE TABLA ALTER COLUMN CAMPO drop default

alter table nombre alter column campo type nuevo_tipo(tamño)

alter table tabla rename column campo to nuevo_nombre_campo

-- dcl
grant : Permite realizar una accion sobre un objeto
grant  accion  on objeto to usuario


GRANT CONNECT ON DATABASE basededatos TO pablo
GRANT SELECT on tabla to pablo

rekove : restringe el realizar accion sobre un objeto 
revoke accion on objeto from usuario

REVOKE SELECT ON ciudades FROM pablo;
revoke connect on database from pablo;


select * from departamentos order by codigo;


-- elimna la informacion de la tabla
TRUNCATE departamentos;
delete from departamentos; 
pg_dump --host localhost --port 5432 --username postgres --verbose --file backup_25454.backup algebra
pg_dump --host localhost --port 5432 --username postgres --verbose   --inserts --column-inserts --file backup_25454.backup algebra

solo el esquema
agregar : --schema-only

para contar el numero de registros en una tabla
SELECT COUNT(*) FROM ventas_contado;
/*

Cuando hablos una instancia de una base de datos se habla del estado de la base de datos(backup incremental1)
  Algebra relacional

  PROYECCION :
    Permite filtrar las columnas / atributos que se quieren mostrar de una relacion

    SELECT campo_1,campo_2 FROM tabla;

  RENOMBRAR
  
  UNIÓN :
    Dos relaciones son compatibles en unión si sus dominios coinciden en número(cantidad) y en orden(tipo) , Y es la disyuncion de los conjuntos.Es decir , el elemento está en uno o en el otro conjunto.
*/
  select campo1,campo2 ... campoN FROM tabla1 UNION select otro1,otro2... otroN FROM tabla2

union(valores desitintos) , union all (valores repetidos)

/*
  Interseccion :
  Dos relaciones son compatibles en interseccion si sus dominios coinciden en numero y orden , es decir se encuentra en ambas relaciones
*/
  select campo1,campo2 ... campoN FROM tabla1 INTERSECT select otro1,otro2... otroN FROM tabla2

  -- EQUIVALENCIA

  SELECT campo1,campo2 ... ,campoN FROM tabla1 WHERE(campo1,campo2 ... ,campoN) IN (SELECT otro1,otro2,..otroN FROM tabla2)

/*
  DIFERENCIA
*/
SELECT campo1,campo2,...campoN
  FROM tabla1
  EXCEPT
  SELECT otro1 ,otro2,...,otroN
  from tabla2

   -- EQUIVALENCIA

  SELECT campo1,campo2 ... ,campoN FROM tabla1 WHERE(campo1,campo2 ... ,campoN) NOT IN (SELECT otro1,otro2,..otroN FROM tabla2)

-- combinacion relacional join producto cartesiano

-- cross JOIN
  /*
    Es el resultado del producto cartesiano de las relaciones que intervienen en la combinacion
  */
  select v.numero , v.fecha,v.valor,v.identificacion,c.identificacion,c.nombre FROM ventas_contado as v CROSS JOIN clientes as c;

  /*El croos join hace combianasciones de todo ... la primera fila se combina con todas las filas de la otra tabla , luego la segunda fila se combina con todas las filas de la segunda tabla y asi*/ 

-- natural join

/*Combina dos relaciones de manera natural entre la clave primaria de una y la llave foranea de otra*/

-- inner JOIN
  /*
    Combina dos relaiones cuando se necesitan especificar como se combinanran
  */
  SELECT b.title ,b.price,p.name FROM publishers as p  inner JOIN books as b on p.campo=b.campo;


SELECT date_part('MONTH',now())


SELECT p.id_product ,p.name,p.price* v.cantidad as  total into tm_consulta from products as p inner join (SELECT id_product ,SUM(quantity) as cantidad from sales group by id_product) as v on v.id_product= p.id_product ;

-- Los lenguajes procedurales nos sirven para poder ejecutar funciones desde la misma base de datos para no depender de un lenguaje de programacion

-- funciones (devulven un unico valor o ninguno)
CREATE FUNCTION saludar()
RETURNS VARCHAR(50) -- CHARACTER VARYING
AS -- DESPUES VA EL CUERPO DE LA FUNCION
$$
  DECLARE -- EN ESTE BLOQUE SE DECLARARA TODAS LAS VARIABLES DE MI FUNCION
    name VARCHAR(50);
  BEGIN
    RETURN 'hOLA MUNDO';
  END;
$$
LANGUAGE plpgsql;

select saludar() as saludo;
select nombre,valor,saludar() from colores;

-- crear una funcion que se llamne descuento

CREATE OR REPLACE FUNCTION descuentoFijo(_valor INTEGER,_descuento INTEGER)
  RETURNS REAL AS
  $BODY$
    DECLARE
        new_value REAL;
    BEGIN
      new_value = _valor*_descuento/100;
      RETURN new_value;
    END
  $BODY$
LANGUAGE plpgsql; 

-- crear funcion de alarma de vencimiento
CREATE OR REPLACE FUNCTION alarma_vencimiento(_fecha DATE)
RETURNS varchar(20) AS 
$BODY$
  DECLARE
    days INTEGER;
  BEGIN
    days = DATE_PART('DAYS',AGE(_fecha,now()))+DATE_PART('MONTH',AGE(_fecha,now()))*30;
    IF days<60 THEN
      RETURN 'cuidados !! se vence en dos meses';
    ELSE
      RETURN 'AUN HAY TIEMPO';
    --elsif
    END IF;
  END;
$BODY$
LANGUAGE plpgsql;

SELECT alarma_vencimiento('2019/03/22');

-- concatenar 
  'hola ' || ' como estas'

select ('hola' || ' mundo');

-- nombres de los lenguajes procedudares 
postgres plpgsql,pljava,plperl,plpython
oracle plsql

-- crear una funcion que nos permita paginar los resultados de una consulta

-- para sacer el offset #registros*pagina que se quiere ver - # registros

CREATE OR REPLACE FUNCTION paginacion(_registosPorPagina INTEGER,_paginaActual INTEGER) --FIRMA DE UNA FUNCION
RETURNS SETOF ventas AS
$BODY$
  DECLARE
    _offset INTEGER;
  BEGIN
  _offset = _registosPorPagina*_paginaActual-_registosPorPagina;
  RETURN QUERY SELECT * FROM ventas LIMIT _registosPorPagina OFFSET _offset;
  END;
$BODY$
LANGUAGE plpgsql;


select * from paginacion(4,3);


DECLARE
  mi_var productos.nombre%TYPE; -- COPIARA EL TIPO DE DATO EXACCTO DE UNA COLUMNA
  mi_fila productos%ROWTYPE; -- SE USA PARA DECLARAR UN REGISTRO CON LOS MISMOS TIPOS DE LA TABLA , VISTA O CURSOR DE LA BASE DE DATOS
  -- var_fecha = mi_fila.fecha; -- 2019-2-8 (NO LO SE)

-- ciclos

--for while
CREATE OR REPLACE FUNCTION repetir_for()
RETURNS VOID AS
$BODY$
  DECLARE 
    _loop INTEGER;
  BEGIN
    FOR _loop IN 1..10 LOOP
      RAISE NOTICE 'VOY EN LA ITERACION %',_loop;  
    END LOOP
  END;
$BODY$
LANGUAGE plpgsql;

SELECT repetir_for();

-- crear funcion para recorrer un select

CREATE OR REPLACE FUNCTION obtener_ventas()
RETURNS SETOF ventas as
$BODY$
  DECLARE
    fila ventas%ROWTYPE;
  BEGIN
    FOR fila IN SELECT * FROM ventas LOOP
      RETURN NEXT fila;
    END LOOP
  END;
$BODY$
LANGUAGE plpgsql;

select * from obtener_ventas();


create or replace function mientras()
returns void as
$BODY$
  DECLARE
    value INTEGER;
  BEGIN
    value = 5
    WHILE value<8 LOOP
      RAISE NOTICE 'voy en el valor %',valor;
      valor= valor+2;
    END LOOP;
  END;
$BODY$
LANGUAGE plpgsql;

select * from mientras();

create table auditoria(
  consecutivo smallserial,
  nombre VARCHAR(20),
  accion VARCHAR(50),
  fecha TIMESTAMP default now()
);

CREATE OR REPLACE FUNCTION fn_mostrar_ventas(_nombre VARCHAR(20))
RETURN SETOF ventas AS 
$BODY$
  BEGIN
  --registrar la autoria
    INSERT INTO auditoria values(default,_nombre,'consulta ventas',default);

    RETURN QUERY SELECT * FROM ventas;
  END;
$BODY$
LANGUAGE plpgsql;

select * from fn_mostrar_ventas('thom');
-- la mayor difeencia entre un procemiento almacenado }y  una funcion alamcenada es el mdodo de trabajo , el procedimietno alamcenao está orientado a cubrir una funcionalidad completa y una funcion estáq orientado para cubrir una parte


-- TRIGGER

create table producto(
  name varchar(20),
  quantity smallint,
  price smallint,
  ultima_modificacion TIMESTAMP,
  ultimo_usuario_db text
);

create or replace function fn_valida_productos()
RETURNS TRIGGER AS
$BODY$
BEGIN
  -- NEW CONTIENE LA INFOMACIÓN EL NUEVO REGISTRO QUE SE ESTÉ TRABAJANDO
  -- OLD CONTIENE LA INFORMACION DEL REGISTRO ANTERIOR A LA OPERACION
  -- TG_OP CONTIENE LA OPERACION QUE ESTAMOS REALIZANDO

  IF NEW.name IS  NULL OR LENGTH(new.name)==0 THEN
    RAISE EXCEPTION 'El nombre debe contener alguna infomacion'
  END IF;
  IF NEW.quatity<0 THEN 
    RAISE EXCEPTION 'La cantidad no puede ser negativo'
  end if;
  if new.precio<0 then
    raise exception 'El precio no puede ser negativo'
  end if;
  new.ultima_modificacion= now()
  new.ultimo_usuario_db = user;
  return new;
END;
$BODY$
LANGUAGE plpgsql;
--creacion del TRIGGER

create trigger valida_productos BEFORE INSERT OR UPDATE
on productos FOR EACH ROW EXECUTE PROCEDURE fn_valida_productos();

create table auditoria_productos (
  accion varchar(20),
  fecha TIMESTAMP,
  name varchar(20),
  cantidad smallint,
  precio smallint
);

create or replace function fn_auditoria_productos()
returns trigger as
$BODY$
BEGIN
  if  tg_op = 'INSERT' then
    insert into auditoria_productos values ('insertar',now(),new.name,new.cantidad,new.precio);
    return new;
  elsif  tg_op = 'delete' THEN
    insert into auditoria_productos values ('delete',now(),old.name,old.cantidad,old.precio);
    return NULL;
  elsif  tg_op = 'UPDATE' THEN
    insert into auditoria_productos values ('ACTUALIZAR ANTES',now(),old.name,old.cantidad,old.precio);
    insert into auditoria_productos values ('ACTUALIZAR DESPUES',now(),NEW.name,NEW.cantidad,NEW.precio);
    return NEW;
  ELSIF  ;
END;
$BODY$
LANGUAGE plpgsql;

create trigger auditoria_pro after INSERT OR UPDATE or delete
on productos FOR EACH ROW EXECUTE PROCEDURE fn_auditoria_productos();

create table if not exists compras(
  consecutivo smallserial,
  fecha timestamp,
  name varchar(20),
  cantidad smallint,
  precio smallint
);

-- todo esto lo hara el vendedor
create or replace function compra_productos()
returns trigger AS
$$
  BEGIN
    PERFORM SELECT name FROM productos WHERE name= new.name;
    IF FOUND THEN
      UPDATE productos SET cantidad = cantidad+new.cantidad,precio =new.precio where name= new.name;
    else 
      insert into productos values (new.name,new.cantidad,new.precio);
    end ELSE
    return new;
  END
$$
language plpgsql;

create table if not exists ventas(
  consecutivo smallserial,
  fecha timestamp,
  name varchar(20),
  cantidad smallint,
  precio smallint
);

CREATE OR REPLACE FUNCTION fn_ventas_productos() RETURNS trigger AS $$
DECLARE
  producto productos%rowtype;
BEGIN
  -- perform name from productos where name = new.name;
  select * into producto from productos where nombre = new.nombre;
  if found THEN -- si el select anteriror o el perform anterior devuelve informacion
    if producto.cantidad >=new.cantidad THEN
      update productos
      set cantidad=cantidad-new.cantidad
      where nombre = new.nombre;
    else 
      raise exception 'No hay suficiente cantidad para la venta %',producto.cantidad ;
    end if;
  return new;
  else 
    raise exception 'No existe el producto a vender %',new.nombre;
  end if;
END;
$$ LANGUAGE plpgsql;

create trigger compra_productos after insert on compras for each row EXECUTE procedure compra_productos();

create trigger ventas_produtos before insert on ventas for each rwo execute procedure venta_productos();


select * from productos;
select * from auditoria_productos;
select * from compras;
select * from ventas;

--  comprandop un prodcuto existente
insert into compras(fecha,nombre,cantidad,precio) values(now(),'yuca',2,2000);

-- comprando un producto que no existe
insert into compras(fecha,nombre,cantidad,precio) values(now(),'papa',1,1500);

-- vendiendo un producto que no existe
insert into compras(fecha,nombre,cantidad,precio) values(now(),'mora',1,1500);
-- vendiendo un producto que existe
insert into compras(fecha,nombre,cantidad,precio) values(now(),'yuca',1,2000);

