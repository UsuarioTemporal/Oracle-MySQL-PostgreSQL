Agarra una consulta que se realice muchas veces y colocarla bajo un solo nombre.
Centraliza muchos esfuerzos en una sola función.
- Vista volátil: Siempre que se haga la consulta en la vista, la BD hace la ejecución de la consulta en la BD, por lo que siempre se va a tener información reciente.
- Vista materializada: Hace la consulta una sola vez, y la información queda almacenada en memoria, la siguiente vez que se consulte, trae el dato almacenado, eso es bueno y malo a la vez, bueno porque la velocidad con la que se entrega la información es rápida, malo porque la información no es actualizada. Es ideal utilizar este tipo de vista en procesos que utilice días anteriores, porque el día de ayer, ya pasó y no hay razón para actualizarlo.
Para crear una vista volátil en postgres, damos click derecho a views, create, view, le damos un nombre, y en la pestaña code escribimos o pegamos el código de la consulta que queremos guardar, la guardamos y para usar la vista usamos:

    SELECT * FROM <nombre_vista>; y listo.

Para crear una vista materializada, primero creamos la consulta, y definimos si los datos nos interesan o no, luego, vamos a la opción materialized views, click derecho, create, materialized view. Se abre la ventana, le damos un nombre, termina con _mview, y en la pestaña Definition escribimos la consulta que necesitamos guardar. Guardamos.
Al probarla en este momento nos lanza un error, ¿por qué? porque no tiene datos almacenados. Para almacenar datos usamos:

    REFRESH MATERIALIZED VIEW <nombre vista>;

Y ahora si podemos consultarla:

    SELECT * FROM <nombre_vista_mview>;

En el caso de las vistas materializadas, es conveniente agregar una columna para indicar la fecha del último “refresh” de la información.


```sql
  -- Creamos la vista
CREATE OR REPLACE VIEW public.rango_view
AS
    SELECT *,
        CASE
        WHEN fecha_nacimiento > '2015-01-01' THEN
            'Mayor'
        ELSE
            'Menor'
        END AS tipo
    FROM pasajero ORDER BY tipo;
ALTER TABLE public.rango_view OWNER TO postgres;

-- mostramos la vista
SELECT * FROM public.rango_view;

-- Vistas Materializada, no se cambia a menos que queramos que se cambie
SELECT * FROM viaje WHERE inicio > '22:00:00';

CREATE MATERIALIZED VIEW public.despues_noche_mview
AS
    SELECT * FROM viaje WHERE inicio > '22:00:00';
WITH NO DATA;
ALTER TABLE public.despues_noche_mview OWNER TO postgres;

-- observamos la vista
SELECT * FROM despues_noche_mview;

-- Damos refresh
REFRESH MATERIALIZED VIEW despues_noche_mview;

-- Borramos una tupla de viaje cuando el id = 2, para observar que no se borro
DELETE FROM viaje WHERE id = 2;
```


```sql
CREATE OR REPLACE VIEW public.rango_view
 AS
 SELECT COALESCE(pasajero.nombre, 'Nombre en Null'::character varying) AS nombrenull,
    pasajero.id,
    pasajero.nombre,
    pasajero.direccion_residencia,
    pasajero.fecha_nacimiento,
        CASE
            WHEN pasajero.fecha_nacimiento > '2015-01-01'::date THEN 'Niño'::text
            ELSE 'Mayor'::text
        END AS tipo,
        CASE
            WHEN pasajero.nombre::text ~~* 'D%'::text THEN 'Empieza con D'::text
            ELSE 'No empieza con D'::text
        END AS letra,
        CASE
            WHEN date_part('years'::text, age(CURRENT_TIMESTAMP, pasajero.fecha_nacimiento::timestamp without time zone::timestamp with time zone)) >= 18::double precision THEN 'Mayor de edad.'::text
            ELSE 'Menor de edad.'::text
        END AS edad
   FROM pasajero;

ALTER TABLE public.rango_view
    OWNER TO postgres;

CREATE MATERIALIZED VIEW public.despues2014
AS
SELECT * FROM pasajero WHERE fecha_nacimiento > '2015-01-01'
WITH NO DATA;

ALTER TABLE public.despues2014
    OWNER TO postgres;

SELECT * FROM rango_view;
SELECT * FROM  public.despues2014;
REFRESH MATERIALIZED VIEW despues2014;
SELECT * FROM  public.despues2014;
DELETE FROM pasajero WHERE id = 89;
SELECT * FROM  public.despues2014;
REFRESH MATERIALIZED VIEW despues2014;
SELECT * FROM  public.despues2014;
```
