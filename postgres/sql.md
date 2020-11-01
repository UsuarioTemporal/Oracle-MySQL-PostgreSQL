
```sql
--/////////////////
--16.Inserción y consulta de datos
--////////////////



SELECT * FROM public.estacion;--si data
SELECT * FROM public.pasajero;--reto
SELECT * FROM public.trayecto;--si data
SELECT * FROM public.tren;--si data
SELECT * FROM public.viaje;--reto




--insert "estacion"
INSERT INTO public.estacion (nombre,direccion)
VALUES 
    ('Estación Centro','St 1# 12'),
    ('Estación Norte','St 100# 112')
;

--insert "tren"
INSERT INTO public.tren (capacidad,modelo)
VALUES 
    (100,'Modelo 1'),
    (100,'Modelo 2')
;

--insert "trayecto"
INSERT INTO public.trayecto (tren,estacion,nombre)
VALUES
    (1,1,'Ruta 1');
    (2,2,'Ruta 2');
;

-- RETO
INSERT INTO public.pasajero (nombre,fecha_nacimiento,direccion_residencia)
VALUES
    ('José Ordoñez','1987-1-3','St 100# 12'),
    ('Ángel Quintero','1987-1-12','St 101# 12'),
    ('Rafel Castillo','1977-1-12','St 102# 12'),
;
INSERT INTO public.viaje (id_pasajero,id_trayecto,inicio,fin)
 VALUES
    (1,1,'2019-01-02','2019-01-02'),
    (2,1,'2019-01-03','2019-01-03'),
    (2,2,'2019-01-04','2019-01-04'),
    (3,2,'2019-01-04','2019-01-04')

;
-- Delete sin limit
DELETE FROM public.estacion WHERE estacion.id  =4;
--delete limit
DELETE FROM public.estacion WHERE estacion.id IN
     (
		SELECT id FROM public.estacion 
	  		WHERE estacion.id IN(3,4)
			ORDER BY  estacion.id  
		 	LIMIT 2
	 )
;

-- update sin limit
UPDATE public.estacion
SET id=4, nombre='Estación SUR-OESTE', direccion='St 4# 1'
WHERE estacion.id = 4;

-- update utilizando limit
UPDATE public.estacion
	SET 
		id=4, 
		nombre='Estación SUR-OESTE', 
		direccion='St 4# 1'
	WHERE id IN (
		SELECT estacion.id FROM public.estacion
			WHERE estacion.id in(4)
			ORDER BY estacion.id
			LIMIT 1
	)
;
```

> para agregar datos de forma masiva  https://mockaroo.com/


Funciones especiales

    ON CONFLICT DO
    RETURNING
    LIKE / ILIKE
    IS / IS NOT

```sql
--Sí el registro existe, no hace nada pero sí  el registro  no existe lo crea
INSERT INTO public.estacion(id, nombre, direccion)
VALUES (1, 'Nombre', 'Dire')
ON CONFLICT DO NOTHING;

-- Insercion de un dato que ya existe, te cambia los campos de nombre y direccion
INSERT INTO public.estacion(id, nombre, direccion)
VALUES (1, 'Nombre', 'Dire')
ON CONFLICT (id) DO UPDATE SET nombre = 'Nombre', direccion = 'Dire';


--RETUNING 
-- RETURNING * | RETURNING name_column
--Una vez insertamos el valor este no los devuelve muy útil para no usar un SELECT.
-- Insertara una tupla y mostrara la tupla
INSERT INTO public.estacion(nombre, direccion)
VALUES ('RETU', 'RETDIRE')
RETURNING *;

-- %: Uno o cualquier valor
-- _: Un valor
SELECT nombre FROM public.pasajero
WHERE nombre LIKE 'o%';
-- buscamos sin importar mayusculas o minusculas
SELECT nombre FROM public.pasajero
WHERE nombre ILIKE 'o%';

-- si una estacion o tren tiene un valor nulo
SELECT * FROM public.tren
WHERE modelo IS NULL;
```


Funciones Especiales avanzadas en PosgreSQL
• COALES: compara dos valores y retorna el que es nulo
• NULLIF: Retorna null si son iguales
• GREATEST: Compara un arreglo y retorna el mayor
• LEAST: Compara un arreglo de valores y retorna el menor
• BLOQUES ANONIMOS: Ingresa condicionales dentro de una consulta de BD

```sql
  SELECT * FROM pasajero WHERE id = 5;
  UPDATE pasajero SET nombre = NULL WHERE id = 5
  SELECT COALESCE(nombre, 'Nombre en Null') AS nombrenull , * FROM pasajero WHERE id = 5;
  SELECT NULLIF(0,0);
  SELECT NULLIF(0,1);
  SELECT GREATEST(5,5,8,95,75,4225,8,6,9,212,6);
  SELECT LEAST(5,5,8,95,75,4225,8,6,9,212,6);
  -- Reto
  SELECT COALESCE(nombre, 'Nombre en Null') AS nombrenull , *,
  CASE WHEN fecha_nacimiento > '2015-01-01' THEN
  'Niño' ELSE 'Mayor' END,
  CASE WHEN nombre ILIKE 'D%' THEN
  'Empieza con D' ELSE 'No empieza con D' END, 
  Case WHEN extract(years from age(current_timestamp,fecha_nacimiento::timestamp)) >= 18 THEN
  'Mayor de edad.' ELSE 'Menor de edad.' END
  FROM pasajero;

  ---------------------------------------
  SELECT
    id,
    nombre,
    direccion_residencia,
    fecha_nacimiento,
    CASE
      WHENEXTRACT(YEARFROM(AGE (pa.fecha_nacimiento))) >= 18THEN'Si'
      ELSE'No'
    ENDAS"Adulto"
  FROM pasajero AS pa;

```
