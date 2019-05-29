-- TABLAS INDEPENDIENTES
create table client(
    client_id INTEGER,
    name VaRCHAR2(50) NOT NULL,
    paternal_surname VARCHAR2(50) NOT NULL,
    maternal_surname VARCHAR2(50) NOT NULL,
    dni VARCHAR2(8) unique not null check(length(dni)=8),
    phone_number VARCHAR2(9) unique not null check(length(phone_number)=9),
    email varchar2(100) unique not null
);

alter table client add constraint pk_client_id PRIMARY KEY(client_id);
alter table client add password varchar2(100) not null;

CREATE TABLE CATEGORY(
    category_id INTEGER,
    NAME VARCHAR2(50) NOT NULL,
    PRIMARY KEY(category_id)
);

CREATE TABLE DIMENSIONS(
    dimensions_id INTEGER,
    name VARCHAR2(2) NOT NULL,
    PRIMARY KEY (dimensions_id)
);

CREATE TABLE COLOR(
    color_id integer primary key,
    internal_color varchar2(50),
    external_color varchar2(50)
);

create table canto(
    canto_id integer primary key,
    name varchar2(20) not null
);

-- TABLAS DEPENDIENTES

CREATE TABLE RETOUCHING(
    retouching_id INTEGER PRIMARY KEY,
    canto_id integer,
    color_id integer,
    constraint fk_color_retouching 
    FOREIGN KEY (color_id) references color(color_id) on delete cascade ,
    constraint fk_canto_retoucing
    foreign key (canto_id) references canto(canto_id) on delete cascade
);

create table product(
    product_id integer primary key,
    name varchar2(50) not null,
    price number(6,2) check(price>0),
    retouching_id integer,
    category_id integer,
    dimensions_id integer,
    constraint fk_retouching_product foreign key(retouching_id) references retouching(retouching_id)
    on delete cascade,
    constraint fk_category_product foreign key(category_id) references category(category_id)
    on delete cascade,
    constraint fk_dimensions_product foreign key(dimensions_id) references dimensions(dimensions_id)
    on delete cascade
);

alter table product add moisture_resistant number default 0 check(moisture_resistant in(1,0)) ;

/*
* Aclaraciones sobre la integridad referencial en este proyecto para los 
* compañeros que lean este script
*
* En que consiste la integridad referencial , la integridad consiste en que una 
* llave foreanea exista en su tabla principal , esta se activa cuando creamos
* llaves foraneas y a aprtir de ese moemento se comprueba cada vez que se modifican
* los datos que puedan alterarla


Cuando se pueden producir errores en los datos ? 
	- Cuando insertamos una nueva fila en la tabla secundaria y el valor de la clave foránea 
    no exita en la tabla principal
	- Cuando modificamos el valor de la clave principal de un registro que tiene
    hijos

*
*/

create table bill(
    bill_id integer primary key,
    client_id integer,
    bill_date date ,
    constraint fk_client_bill foreign key(client_id) 
    references client(client_id) on delete cascade
);

create table detail(
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

create or replace procedure creative_of_sequences
as
begin
end;
/