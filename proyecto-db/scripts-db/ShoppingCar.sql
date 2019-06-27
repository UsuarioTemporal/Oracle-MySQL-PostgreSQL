-- TABLAS INDEPENDIENTES
create table profile
(
    profile_id number primary key not null,
    profile_name varchar2(20) not null,
    constraint uk_profile_name UNIQUE(profile_name)
);


CREATE TABLE CATEGORY
(
    category_id INTEGER,
    NAME VARCHAR2(50) NOT NULL,
    PRIMARY KEY(category_id)
);

CREATE TABLE TYPE_OF_MEASURE
(
    measure_id INTEGER,
    name VARCHAR2(2) NOT NULL,
    PRIMARY KEY (measure_id)
);

CREATE TABLE COLOR
(
    color_id integer primary key,
    internal_color varchar2(50),
    external_color varchar2(50)
);

create table canto
(
    canto_id integer primary key,
    name varchar2(20) not null
);

-- TABLAS DEPENDIENTES
create table user_table
(
    user_id number,
    name VARCHAR2(50) NOT NULL,
    paternal_surname VARCHAR2(50) NOT NULL,
    maternal_surname VARCHAR2(50) NOT NULL,
    dni VARCHAR2(8) unique not null check(length(dni)=8),
    phone_number VARCHAR2(9) unique not null check(length(phone_number)=9),
    email varchar2(100) unique not null
);

alter table user_table add constraint pk_user_id PRIMARY KEY(user_id);
alter table user_table add password varchar2(100) not null;

CREATE TABLE RETOUCHING
(
    retouching_id INTEGER PRIMARY KEY,
    canto_id integer,
    color_id integer,
    constraint fk_color_retouching 
    FOREIGN KEY (color_id) references color(color_id) on delete cascade ,
    constraint fk_canto_retoucing
    foreign key (canto_id) references canto(canto_id) on delete cascade
);

create table product
(
    product_id integer primary key,
    name varchar2(50) not null,
    price number(6,2) check(price>0),
    retouching_id integer,
    category_id integer,
    measure_id integer,
    height number not null check(height>0),
    width number not null check(width>0),
    length_product number not null check(length_product>0),
    constraint fk_retouching_product foreign key(retouching_id) references retouching(retouching_id)
    on delete cascade,
    constraint fk_category_product foreign key(category_id) references category(category_id)
    on delete cascade,
    constraint fk_measure_product foreign key(measure_id) references TYPE_OF_MEASURE(measure_id)
    on delete cascade
);
alter table product add quantity number not null check(quantity>=0);
alter table product add moisture_resistant number default 0 check(moisture_resistant in(1,0)) ;


/*
* Aclaraciones sobre la integridad referencial en este proyecto para los 
* compa�eros que lean este script
*
* En que consiste la integridad referencial , la integridad consiste en que una 
* llave foreanea exista en su tabla principal , esta se activa cuando creamos
* llaves foraneas y a aprtir de ese moemento se comprueba cada vez que se modifican
* los datos que puedan alterarla


Cuando se pueden producir errores en los datos ? 
	- Cuando insertamos una nueva fila en la tabla secundaria y el valor de la clave for�nea 
    no exita en la tabla principal
	- Cuando modificamos el valor de la clave principal de un registro que tiene
    hijos

*
*/

create table bill
(
    bill_id integer primary key,
    user_id integer,
    bill_date date ,
    constraint fk_user_bill foreign key(user_id) 
    references user_table(user_id) on delete cascade
);

create table detail
(
    detail_id integer primary key,
    bill_id integer,
    product_id integer,
    quantity number check(quantity>=0),
    price number(6,2) check(price>0),
    constraint fk_product_datail foreign key(product_id) 
    references product(product_id) on delete cascade,
    constraint fk_bill_detail foreign key(bill_id) 
    references bill(bill_id) on delete cascade
);


-- SEQUENCIAS
set SERVEROUTPUT on
create or replace procedure creative_of_sequences
as
    type type_sq_array is varray
(11) of varchar2
(11);
    sq_array type_sq_array;
    length_ integer;
begin
    sq_array:
    =type_sq_array
    ('product','detail','user','category','bill','retouching','MEASURE','color','canto','audit','profile');
length_:
=sq_array.count;
    for sq_name in 1..length_ loop
execute immediate 'CREATE SEQUENCE sq_'
||to_char
(sq_array
(sq_name))||' start with 1 increment by 1 NOCYCLE';
end loop;
end;
/

exec creative_of_sequences;

--- 

alter table bill modify bill_date date default sysdate not null;


--- creando la tabla auditoria

create table audit_table
(
    audit_id NUMBER primary key,
    audit_date TIMESTAMP DEFAULT SYSDATE NOT NULL,
    user_id NUMBER,
    action VARCHAR2(20) NOT NULL,
    name_table VARCHAR2(20) NOT NULL,
    previous_data varchar2(1000) not null ,
    new_data varchar2(1000) ,
    constraint fk_user_audit foreign key (user_id) 
    references user_table(user_id) on delete cascade
);
select *
from audit_table;
create table mode_product
(
    mode_id number primary key not null,
    name_mode varchar2(1) unique not null
);

alter table product add mode_id number not null;
alter table product add constraint fk_mode_product foreign key(mode_id)
references mode_product(mode_id);


alter table user_table add profile_id number not null;
alter table user_table add constraint fk_profile_user 
foreign key(profile_id) references profile(profile_id) on delete cascade;


insert into profile
values
    (sq_profile.nextval, 'Administrador');

insert into profile
values
    (sq_profile.nextval, 'cliente');

select *
from profile;

--funcion para encriptar la contrase�a 
create or replace function md5Hash
(input_string in varchar2)
return varchar2
is
begin
    return DBMS_OBFUSCATION_TOOLKIT.md5 (input
    => UTL_RAW.cast_to_raw
    (input_string));
end;
/
SELECT md5Hash('thom') md5_val
FROM DUAL;

insert into user_table
    (user_id,name,paternal_surname,maternal_surname,dni,phone_number,email,password,profile_id)
values
    (SQ_user.nextval, 'Thom', 'Roman', 'Aguilar', '72847964', '987654321', 'thomtwd@gmail.com', md5Hash('thom'), 1);

insert into user_table
    (user_id,name,paternal_surname,maternal_surname,dni,phone_number,email,password,profile_id)
values
    (SQ_user.nextval, 'Erick', 'Huaranca', 'Rivas', '78654321', '944121369', 'erick@gmail.com', md5Hash('chavo'), 2);

select *
from user_table;
--select * from v$version;

commit;

--ingresando color
insert into color
values(SQ_COLOR.nextval, 'blanco', 'blanco');
insert into color
values(SQ_COLOR.nextval, 'blanco', 'color');



--ingresando canto
insert into canto
values(SQ_CANTO.nextval, 'delgado');
insert into canto
values(SQ_CANTO.nextval, 'grueso');
insert into canto
values(SQ_CANTO.nextval, 'T alumnio');

--ingresando retouching
insert into retouching
values(SQ_RETOUCHING.nextval, 1, 1);
insert into retouching
values(SQ_RETOUCHING.nextval, 2, 1);
insert into retouching
values(SQ_RETOUCHING.nextval, 3, 1);
insert into retouching
values(SQ_RETOUCHING.nextval, 1, 2);
insert into retouching
values(SQ_RETOUCHING.nextval, 2, 2);
insert into retouching
values(SQ_RETOUCHING.nextval, 3, 2);

commit ;
-- ingresnado dimensiones
insert into type_of_measure
values(SQ_MEASURE.nextval, 'ML');
insert into type_of_measure
values(SQ_MEASURE.nextval, 'M3');


-- ingresando categoria
insert into category
values(SQ_CATEGORY.nextval, 'sin puertas');
insert into category
values(SQ_CATEGORY.nextval, 'puertas batientes');
insert into category
values(SQ_CATEGORY.nextval, 'puertas corredizas');
insert into category
values(SQ_CATEGORY.nextval, 'parte alta');
insert into category
values(SQ_CATEGORY.nextval, 'parte baja');
insert into category
values(SQ_CATEGORY.nextval, 'torre');

insert into mode_product
values(1, 'A');
insert into mode_product
values(2, 'B');
insert into mode_product
values(3, 'Z');

select *
from RETOUCHING;
select *
from canto;
select *
from color;
select *
from category;
select *
from type_of_measure;
select *
from moisture_resistant;
select *
from mode_product;
select *
from product;
-- ingresando productos
commit;
--COCINA
-- Parte Alta
-- En milimetros
insert into product
values
    (sq_product.nextval, 'cocina', 350.00, 1, 4, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 340.00, 1, 4, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 330.00, 1, 4, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 370.00, 3, 4, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 360.00, 3, 4, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 350.00, 3, 4, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 390.00, 4, 4, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 380.00, 4, 4, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 370.00, 4, 4, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 370.00, 5, 4, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 360.00, 5, 4, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 350.00, 5, 4, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 390.00, 2, 4, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 380.00, 2, 4, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 370.00, 2, 4, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 410.00, 6, 4, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 400.00, 6, 4, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 390.00, 6, 4, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 390.00, 1, 4, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 380.00, 1, 4, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 370.00, 1, 4, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 410.00, 3, 4, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 400.00, 3, 4, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 390.00, 3, 4, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 430.00, 4, 4, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 420.00, 4, 4, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 410.00, 4, 4, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 410.00, 5, 4, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 400.00, 5, 4, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 390.00, 5, 4, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 430.00, 2, 4, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 420.00, 2, 4, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 410.00, 2, 4, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 450.00, 6, 4, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 440.00, 6, 4, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 430.00, 6, 4, 1, 20, 20, 20, 10000, 1, 3);
-- En metros cúbicos
insert into product
values
    (sq_product.nextval, 'cocina', 1562.50, 1, 4, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1517.86, 1, 4, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1473.21, 1, 4, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1651.79, 3, 4, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1607.14, 3, 4, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1562.50, 3, 4, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1741.07, 4, 4, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1696.43, 4, 4, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1651.79, 4, 4, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1651.79, 5, 4, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1607.14, 5, 4, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1562.50, 5, 4, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1741.07, 2, 4, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1696.43, 2, 4, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1651.79, 2, 4, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1830.36, 6, 4, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1785.71, 6, 4, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1741.07, 6, 4, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1741.07, 1, 4, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1696.43, 1, 4, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1651.79, 1, 4, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1830.36, 3, 4, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1785.71, 3, 4, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1741.07, 3, 4, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1919.64, 4, 4, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1875.00, 4, 4, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1830.36, 4, 4, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1830.36, 5, 4, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1785.71, 5, 4, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1741.07, 5, 4, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1919.64, 2, 4, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1875.00, 2, 4, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1830.36, 2, 4, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 2008.93, 6, 4, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1964.29, 6, 4, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1919.64, 6, 4, 2, 20, 20, 20, 10000, 1, 3);
-- Parte Baja
-- En milimetros
insert into product
values
    (sq_product.nextval, 'cocina', 550.00, 1, 5, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 540.00, 1, 5, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 530.00, 1, 5, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 570.00, 3, 5, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 560.00, 3, 5, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 550.00, 3, 5, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 590.00, 4, 5, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 580.00, 4, 5, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 570.00, 4, 5, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 570.00, 5, 5, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 560.00, 5, 5, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 550.00, 5, 5, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 590.00, 2, 5, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 580.00, 2, 5, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 570.00, 2, 5, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 610.00, 6, 5, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 600.00, 6, 5, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 590.00, 6, 5, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 590.00, 1, 5, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 580.00, 1, 5, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 570.00, 1, 5, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 610.00, 3, 5, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 600.00, 3, 5, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 590.00, 3, 5, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 630.00, 4, 5, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 620.00, 4, 5, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 610.00, 4, 5, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 610.00, 5, 5, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 600.00, 5, 5, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 590.00, 5, 5, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 630.00, 2, 5, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 620.00, 2, 5, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 610.00, 2, 5, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 650.00, 6, 5, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 640.00, 6, 5, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 630.00, 6, 5, 1, 20, 20, 20, 10000, 1, 3);
-- En metros cúbicos
insert into product
values
    (sq_product.nextval, 'cocina', 1103.53, 1, 5, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1083.47, 1, 5, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1063.40, 1, 5, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1143.66, 3, 5, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1123.60, 3, 5, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1103.53, 3, 5, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1183.79, 4, 5, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1163.72, 4, 5, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1143.66, 4, 5, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1143.66, 5, 5, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1123.60, 5, 5, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1103.53, 5, 5, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1183.79, 2, 5, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1163.72, 2, 5, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1143.66, 2, 5, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1223.92, 6, 5, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1203.85, 6, 5, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1183.79, 6, 5, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1183.79, 1, 5, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1163.72, 1, 5, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1143.66, 1, 5, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1223.92, 3, 5, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1203.85, 3, 5, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1183.79, 3, 5, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1264.04, 4, 5, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1243.98, 4, 5, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1223.92, 4, 5, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1223.92, 5, 5, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1203.85, 5, 5, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1183.79, 5, 5, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1264.04, 2, 5, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1243.98, 2, 5, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1223.92, 2, 5, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1304.17, 6, 5, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1284.11, 6, 5, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1264.04, 6, 5, 2, 20, 20, 20, 10000, 1, 3);
-- Torre
-- En milimetros
insert into product
values
    (sq_product.nextval, 'cocina', 925.00, 1, 5, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 907.50, 1, 5, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 890.00, 1, 5, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 960.00, 3, 5, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 942.50, 3, 5, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 925.00, 3, 5, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 995.00, 4, 5, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 977.50, 4, 5, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 960.00, 4, 5, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 960.00, 5, 5, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 942.50, 5, 5, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 925.00, 5, 5, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 995.00, 2, 5, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 977.50, 2, 5, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 960.00, 2, 5, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1030.00, 6, 5, 1, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1012.50, 6, 5, 1, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 995.00, 6, 5, 1, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 995.00, 1, 5, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 977.50, 1, 5, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 960.00, 1, 5, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1030.00, 3, 5, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1012.50, 3, 5, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 995.00, 3, 5, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1065.00, 4, 5, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1047.50, 4, 5, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1030.00, 4, 5, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1030.00, 5, 5, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1012.50, 5, 5, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 995.00, 5, 5, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1065.00, 2, 5, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1047.50, 2, 5, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1030.00, 2, 5, 1, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 1100.00, 6, 5, 1, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 1082.50, 6, 5, 1, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 1065.00, 6, 5, 1, 20, 20, 20, 10000, 1, 3);
-- En metros cúbicos
insert into product
values
    (sq_product.nextval, 'cocina', 750.81, 1, 5, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 736.51, 1, 5, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 722.40, 1, 5, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 779.22, 3, 5, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 765.02, 3, 5, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 750.81, 3, 5, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 807.63, 4, 5, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 793.43, 4, 5, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 779.22, 4, 5, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 779.22, 5, 5, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 765.02, 5, 5, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 750.81, 5, 5, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 807.63, 2, 5, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 793.43, 2, 5, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 779.22, 2, 5, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 836.04, 6, 5, 2, 20, 20, 20, 10000, 0, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 821.83, 6, 5, 2, 20, 20, 20, 10000, 0, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 807.63, 6, 5, 2, 20, 20, 20, 10000, 0, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 807.63, 1, 5, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 793.43, 1, 5, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 779.22, 1, 5, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 836.04, 3, 5, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 821.83, 3, 5, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 807.63, 3, 5, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 864.45, 4, 5, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 850.24, 4, 5, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 836.04, 4, 5, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 836.04, 5, 5, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 821.83, 5, 5, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 807.63, 5, 5, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 864.45, 2, 5, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 850.24, 2, 5, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 836.04, 2, 5, 2, 20, 20, 20, 10000, 1, 3);
insert into product
values
    (sq_product.nextval, 'cocina', 892.86, 6, 5, 2, 20, 20, 20, 10000, 1, 1);
insert into product
values
    (sq_product.nextval, 'cocina', 878.65, 6, 5, 2, 20, 20, 20, 10000, 1, 2);
insert into product
values
    (sq_product.nextval, 'cocina', 864.45, 6, 5, 2, 20, 20, 20, 10000, 1, 3);
commit;
select *
from product;

declare
    cur_prod product%rowtype;
begin
    select *
    into cur_prod
    from product
    where product_id=1;
--return cur_prod;
--DBMS_OUTPUT.put_line(cur_prod.product_id);
end;
/
set serveroutput on
DECLARE
    CURSOR nombre_cursor IS
SELECT *
FROM product;
-- empleados employees%ROWTYPE;
BEGIN
    FOR emp in nombre_cursor LOOP
        DBMS_OUTPUT.PUT_LINE
    (emp.name);
END
LOOP;
END;
/



create or replace function fn_get_proudcts
return SYS_REFCURSOR
AS
    my_cursor SYS_REFCURSOR;
BEGIN
    OPEN my_cursor
    FOR
    SELECT *
    FROM product;
    return my_cursor;
END
fn_get_proudcts;
/
select *
from product;
create or replace type product_type
as OBJECT
(
    product_id number,
    name varchar2
(50),
    price number
(6,2),
    retouching_id number,
    category_id number,
    measure_id number,
    height number,
    width number,
    length_product number,
    quantity number,
    moisture_resistant number,
    mode_id number
);
create or replace type product_table_type
as table of product_type;

create or replace function fn_get_product_table
return product_table_type
pipelined
as
begin
    for v_rec in
    (select *
    from product)
    loop
        pipe row
    (product_type
    (v_rec.product_id ,
                                v_rec.name,
                                v_rec.price,
                                v_rec.retouching_id,
                                v_rec.category_id,
                                v_rec.measure_id,
                                v_rec.height,v_rec.width,
                                v_rec.length_product,
                                v_rec.quantity,
                                v_rec.moisture_resistant,v_rec.mode_id
                                ));
end
loop;
return;
end;
/

select *
from table(fn_get_product_table());

-- funcion para autenticar al usuario

select *
from user_table;
create or replace type user_type
as OBJECT
(
    user_id number,
    name_n varchar2
(50),
    profile_id number
(6,2),
    profile_name varchar2
(50)
);

create or replace type user_table_type
as table of user_type;

create or replace function authenticationUser
(email_input in varchar2,pass in varchar2)
return user_table_type
pipelined
as
    cursor cur_user is
select us.user_id, us.name, pro.profile_id, pro.profile_name
from user_table us , profile pro
where us.email=email_input and us.password=md5Hash(pass) and pro.profile_id=us.profile_id;
count_users
number:
=-1;
    many_users exception;
    no_user exception;
begin
    for data_use in cur_user loop
    count_users:
    =count_users+1;
    if count_users>1 then
                raise many_users;
end
if;
            pipe row
(user_type
( data_use.user_id,data_use.name,data_use.profile_id,data_use.profile_name));
end loop;
if count_users=-1 then
            raise no_user;
        else
            return;
end
if;
        exception 
            when no_user then
                Raise_application_error
(-20010,'Usuario Incorrecto o contraseña incorrecta');
            when many_users then 
                Raise_application_error
(-20010,'base de datos fallando');

end;
/

select *
from detail;
alter table audit_table modify previous_data varchar2
(1000) default null;
select *
from table(authenticationUser('thomtwd@gmail.com','thom'));
select *
from audit_table;
alter table detail add user_id number not null;
alter table detail add constraint fk_user_detail foreign key(user_id)
references user_table(user_id) on delete cascade;
--trigger para la auditoria de productos
--'product_id :'||product_id||', price :'||price||', quantity :'||quantity
create or replace trigger trg_detail_AI before
insert on
detail
for
each
row
begin
    insert into audit_table
        (audit_id,audit_date,user_id,action,name_table,previous_data,new_data)
    values(SQ_AUDIT.nextval, Sysdate, :new.user_id, 'insert', 'detail', default, 'product_id : '||:new.product_id||', quantity:'||:new.quantity);
end;
/
select *
from audit_table;
select *
from detail;


--funcion de comprar

create or replace procedure to_buy
(product_ in number,quantity_ in number,price in number,user_ in number,bill_id number)
is
	cursor cur_val_prod is
select quantity
from product
where product_id=product_;
no_data exception ;
	quant number;
begin
    --

    for data_ in cur_val_prod loop
    quant:
    =data_.quantity;
end
loop;
if  quant < quantity_ then
		raise no_data;
	else 
		insert into detail
values
    (sq_detail.nextval, bill_id, product_, quantity_, price, user_);
update product set quantity=quantity-quantity_ where product_id=product_;

return;
end
if;
	
	exception 
		when no_data then
			raise_application_error
(-20010,'No hay sufuciente producto para comprar');
end;
/


create or replace procedure invoice_generator
(user_id in number)
as
begin
    insert into bill
    values
        (sq_bill.nextval, user_id, default);
end;
/



/*
drop table audit_table;
drop table bill;
drop table canto;
drop table category;
drop table client;
drop table color;
drop table detail;
drop table dimensions;
drop table product;
drop table profile;
drop table retouching;
*/
