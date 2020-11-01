# Particiones

- separación física de los datos : guardar varias partes de una misma tabla en disferentes espacios
  esto es optimo cuando la tabla tiene millones de millones de filas
- estructura lógica : funciona haciendo el mismo select

Se puede poner rangos a las particiones, estos sangos pueden ser espacio o fechas lo cual equita que la tabla se pueda bloquear ya que esta siendo consultada permanenetemente y  modificada al mismo tiempo

los insert serán comun y corriente  igual que los selects

```sql
  CREATE TABLE public.bitacora_viajes(
    id serial,
    id_viaje integer,
    fecha date # este será la condicion x la cual se particionara
   ) PARTITION BY RANGE (fecha) WITH (OIDS = FALSE);
   ALTER TABLE public.bitacora_viajes OWNER to postgres;

    -- Vamos a crear la particion
    CREATE TABLE bitacora_viaje201001 PARTITION OF public.bitacora_viajes
    FOR VALUES FROM ('2010-01-01') TO  ('2020-04-24');

    -- Insertamos un dato --> ERROR antes de crear la particion, necesitamos tener al menos una particion
    INSERT INTO public.bitacora_viajes(id_viaje, fecha)
    VALUES(1, '2010-01-01');

    -- Mostramos los valores de la tabla bitacora_viaje
    SELECT * FROM bitacora_viajes;

    -- eliminamos la tabla bitacora_viaje y se eliminara la particion igualmente
    DROP TABLE bitacora_viajes;```
```

Otra de las ventajas de las tablas particionadas es que puedes utilizar la sentencia TRUNCATE, la cual elimina toda la información de una tabla, pero a nivel partición. Es decir, si tienes una tabla con 12 particiones (1 para cada mes del año) y deseas eliminar toda la información del mes de Enero; con la sentencia `ALTER TABLE tabla TRUNCATE PARTITION enero`; podrías eliminar dicha información sin afectar el resto.

Todo esto se puede hacer con pgAdmin

```sql
-- Agregamos llave foranea de id_estacion a la tabla trayecto
ALTER TABLE public.trayecto
    ADD CONSTRAINT trayecto_estacion_fkey FOREIGN KEY (id_estacion)
    REFERENCES public.estacion (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

-- Agregamos llave foranea de id_tren a la tabla trayecto
ALTER TABLE public.trayecto
    ADD CONSTRAINT trayecto_tren_fkey FOREIGN KEY (id_tren)
    REFERENCES public.tren (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

-- Agregamos llave foranea de id_trayecto a la tabla viaje
ALTER TABLE public.viaje
    ADD CONSTRAINT viaje_trayecto_fkey FOREIGN KEY (id_trayecto)
    REFERENCES public.trayecto (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

-- Agregamos llave foranea de id_pasajero a la tabla viaje
ALTER TABLE public.viaje
    ADD CONSTRAINT viaje_pasajero_fkey FOREIGN KEY (id_pasajero)
    REFERENCES public.pasajero (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

-- Para borrar una llave foranea por si tienes algun error
ALTER TABLE public.viaje DROP CONSTRAINT viaje_trayecto_fkey;
```
