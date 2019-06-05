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
* compaï¿½eros que lean este script
*
* En que consiste la integridad referencial , la integridad consiste en que una 
* llave foreanea exista en su tabla principal , esta se activa cuando creamos
* llaves foraneas y a aprtir de ese moemento se comprueba cada vez que se modifican
* los datos que puedan alterarla


Cuando se pueden producir errores en los datos ? 
	- Cuando insertamos una nueva fila en la tabla secundaria y el valor de la clave forï¿½nea 
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
set SERVEROUTPUT on
create or replace procedure creative_of_sequences
as
    type type_sq_array is varray(9) of varchar2(10);
    sq_array type_sq_array;
    length_ integer;
begin
    --sq_array:=type_sq_array('product','detail','client','category','bill','retouching','dimensions','color','canto');
    sq_array:=type_sq_array('audit','profile');
    length_:=sq_array.count;
    for sq_name in 1..length_ loop
        execute immediate 'CREATE SEQUENCE sq_'||to_char(sq_array(sq_name))||' start with 1 increment by 1 NOCYCLE';
        --DBMS_OUTPUT.PUT_LINE('CREATE SEQUENCE sq_'||to_char(sq_array(sq_name))||' start with 1 increment by 1 NOCYCLE');
    end loop;
end;
/

exec creative_of_sequences;

--- 

alter table bill modify bill_date date default sysdate not null;


--- creando la tabla auditoria

create table audit_table(
    audit_id NUMBER primary key,
    audit_date TIMESTAMP  DEFAULT SYSDATE NOT NULL,
    client_id NUMBER,
    action VARCHAR2(20) NOT NULL,
    name_table VARCHAR2(20) NOT NULL,
    previous_data varchar2(1000) not null ,
    new_data varchar2(1000) ,
    constraint fk_client_audit foreign key (client_id) 
    references client(client_id) on delete cascade
);
select * from audit_table;

create table profile(
    profile_id number primary key not null,
    profile_name varchar2(20) not null,
    constraint uk_profile_name UNIQUE(profile_name)
);

alter table client add profile_id number not null;
alter table client add constraint fk_profile_client 
foreign key(profile_id) references profile(profile_id) on delete cascade;


insert into profile values (sq_profile.nextval,'Administrador');

insert into profile values (sq_profile.nextval,'cliente');

select * from profile;

--funcion para encriptar la contraseña 
create or replace function md5Hash(input_string in varchar2) return varchar2 is
begin
    return DBMS_OBFUSCATION_TOOLKIT.md5 (input => UTL_RAW.cast_to_raw(input_string));
end;
/
SELECT md5Hash('thom') md5_val
  FROM DUAL;

insert into client(client_id,name,paternal_surname,maternal_surname,dni,phone_number,email,password,profile_id) 
values (SQ_CLIENT.nextval,'Thom','Roman','Aguilar','72847964','987654321','thomtwd@gmail.com',md5Hash('thom'),1);

--select * from v$version;



