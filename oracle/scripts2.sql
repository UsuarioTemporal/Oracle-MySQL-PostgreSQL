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