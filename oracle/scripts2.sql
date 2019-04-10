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
