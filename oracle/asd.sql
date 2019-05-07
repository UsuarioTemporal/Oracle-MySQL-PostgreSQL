-- sqlplus "/as sysdba"
create user db_roman identified by "123"
default tablEspace "USERS"
TEMPORARY TABLESPACE "TEMP";
grant all privileges to db_roman;
conn db_roman/123;

create sequence sq_cusro_roman 
    increment by 1
    start with 1
    minvalue 1
    nocycle;
create sequence sq_docente_roman 
    increment by 1
    start with 1
    minvalue 1
    nocycle;
create sequence sq_ep_roman 
    increment by 1
    start with 1
    minvalue 1
    nocycle;

create table curso_roman(
    id_curso NUMBER,
    nombre VARCHAR2(30),
    horas NUMBER,
    creditos NUMBER,
    estado VARCHAR2(1),
    PRIMARY KEY(id_curso)
);


create table docente_roman(
    id_docente NUMBER,
    nombre VARCHAR2(40),
    grado_academico VARCHAR2(20),
    estado VARCHAR2(1),
    PRIMARY KEY(id_docente)
);
create table ep_roman(
    id_ep NUMBER,
    nombre VARCHAR2(40),
    nombre_corto VARCHAR2(5),
    PRIMARY KEY(id_ep)
);

INSERT INTO curso_roman VALUES (sq_cusro_roman.NEXTVAL,'Diseño de base de datos',6,4,'A');
INSERT INTO curso_roman VALUES (sq_cusro_roman.NEXTVAL,'Lenguage de programacion',6,3,'A');
INSERT INTO curso_roman VALUES (sq_cusro_roman.NEXTVAL,'Estructuras Discretas',5,4,'A');
INSERT INTO curso_roman VALUES (sq_cusro_roman.NEXTVAL,'Metodos numericos',5,4,'A');
INSERT INTO curso_roman VALUES (sq_cusro_roman.NEXTVAL,'Macroeconomia',4,3,'A');
INSERT INTO curso_roman VALUES (sq_cusro_roman.NEXTVAL,'Investigacion operativa 2',5,4,'A');


INSERT INTO docente_roman VALUES (sq_docente_roman.NEXTVAL,'Levano','Ingeniero','A');

INSERT INTO docente_roman VALUES (sq_docente_roman.NEXTVAL,'Duran Amanda','Ingeniero','A');

INSERT INTO docente_roman VALUES (sq_docente_roman.NEXTVAL,'Leon flor','Ingeniero','A');

INSERT INTO docente_roman VALUES (sq_docente_roman.NEXTVAL,'Navarro pareja','Ingeniero','A');
INSERT INTO docente_roman VALUES (sq_docente_roman.NEXTVAL,'Manuel lizardo','Ingeniero','A');

INSERT into ep_roman VALUES (sq_ep_roman.nextval,'Ingenieria de sistemas','IS');
INSERT into ep_roman VALUES (sq_ep_roman.nextval,'Ingenieria Ambiental','IA');
INSERT into ep_roman VALUES (sq_ep_roman.nextval,'Ingenieria Mecanica','IM');
INSERT into ep_roman VALUES (sq_ep_roman.nextval,'Ingerieria Electrica','IE');
INSERT into ep_roman VALUES (sq_ep_roman.nextval,'Administracion','ADS');

delete from docente_roman where id_docente<=3;
delete from curso_roman where id_curso<=3;
delete from ep_roman where id_ep<=2;

update curso_roman set nombre ='Calculo' where id_curso = 5;
update curso_roman set nombre='Matematicas' where id_curso = 4;

update docente_roman set grado_academico= 'Docente' where id_docente=5; 
update docente_roman set grado_academico= 'Doctor' where id_docente=4; 

update ep_roman set nombre='Ingenieria Industrial', nombre_corto='ID' where id_ep=5;