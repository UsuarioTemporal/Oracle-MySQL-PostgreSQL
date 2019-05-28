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
    FOREIGN KEY (canto_id) references canto(canto_id)
);

/*
* Aclaraciones sobre la integridad refencial en este proyecto
*
*
*/
