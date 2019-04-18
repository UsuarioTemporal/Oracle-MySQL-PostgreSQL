-- para ver el usuario actual
select user from dual;
show user;
select table_name from user_tables;
select table_name from all_tables owner = 'juan';

select * from tab;

SELECT * FROM libros WHERE precio = (SELECT MAX(precio) FROM libros);

delete from tabla where = (subconsulta);


-- para mostrar el nombre de las editoriales donde el autor ha publicado sus libros
SELECT nombre FROM editorales WHERE codigo IN (SELECT codigo_editorial FROM libros WHERE autor = 'Richard Brach');

-- otra forma

SELECT DISTINCT e.nombre FROM editoriales e
    JOIN libros  l ON l.codigo_editorial= e.codigo
    WHERE l.autor = 'Richard Bach';


/* 4- Obtenga todos los datos de los alumnos con la nota más alta, empleando subconsulta */
SELECT * FROM alumnos WHERE nota= (SELECT MAX(nota) FROM alumnos);

/* 6- Muestre los alumnos que tienen una nota menor al promedio */
select * from alumnos where nota < (SELECT AVG(nota) FROM alumnos);
/* 7- Cambie la nota del alumno que tiene la menor nota por 4. */
UPDATE alumnos SET nota=  4 WHERE nota< (SELECT min(nota) FROM alumnos);
/* 8- Elimine los alumnos cuya nota es menor al promedio. */
delete from alumnos WHERE nota = (SELECT AVG(nota) FROM alumnos );


 -- Mostramos los títulos de los libros de "Borges" de editoriales que
 -- han publicado también libros de "Richard Bach":

-- en esya consulta solo mostrara los codigo_editorial que se encuentran en la subconsulta
select * from libros where autor like '%Borges%' and codigo_editorial =any (select e.codigo from editoriales e join libros l on codigo_editorial = e.codigo where l.autor like '%Bach%');

--pero si ponemos en lugar de any -- all todos los codigo_editorial deben encontrarse en la subconsulta de lo contrario no se mostrara ninguna tabla


/* Mostramos los títulos y precios de los libros "Borges" cuyo precio supera a ALGUN precio de los libros de "Richard Bach": */

select * from libros where autor like '%Borges%'
and precio>any (select precio from libros where autor like 'Richard Bach');


CREATE TABLE alumnos(
    codigo_alumno VARCHAR(10) NOT NULL,
    dni VARCHAR(8) NOT NULL,
    id_alumno NUMBER UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    PRIMARY KEY(codigo_alumno,dni)
);

CREATE SEQUENCE sq_id_alumno
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

INSERT INTO alumnos VALUES ('2016200202','12345678',sq_id_alumno.NEXTVAL,'Carlos Jose','Jimenez');
INSERT INTO alumnos VALUES ('2015200202','98765432',sq_id_alumno.NEXTVAL,'Thom Maurick','Aguilar');
INSERT INTO alumnos VALUES ('2014200201','36985214',sq_id_alumno.NEXTVAL,'Jorge Juan','Perez');
INSERT INTO alumnos VALUES ('2013200203','14785236',sq_id_alumno.NEXTVAL,'Katie Jasmin','Olaya');
INSERT INTO alumnos VALUES ('2011200204','72847964',sq_id_alumno.NEXTVAL,'Fabrizio Raul','Gomez');
INSERT INTO alumnos VALUES ('2017200205','10256987',sq_id_alumno.NEXTVAL,'Angel Newton','Lopez');
INSERT INTO alumnos VALUES ('2019200506','36974120',sq_id_alumno.NEXTVAL,'Cristian Gutierres','Caceres');
INSERT INTO alumnos VALUES ('2018200302','87456321',sq_id_alumno.NEXTVAL,'Pepe Juan','Roman');
INSERT INTO alumnos VALUES ('2010200205','87654321',sq_id_alumno.NEXTVAL,'Fatima Jessica','Gutierrez');
INSERT INTO alumnos VALUES ('2016200201','84625793',sq_id_alumno.NEXTVAL,'Anastasio Sheldon','Olaya');

UPDATE alumnos set nombre = 'Alberto Raul' WHERE id_alumno=1;
UPDATE alumnos set nombre = 'Pedro Rodrigo' WHERE id_alumno=2;
UPDATE alumnos set nombre = 'Carla Thalia' WHERE id_alumno=3;
delete from alumnos where id_alumno=10;
delete from alumnos where id_alumno=9;
delete from alumnos where id_alumno=8;