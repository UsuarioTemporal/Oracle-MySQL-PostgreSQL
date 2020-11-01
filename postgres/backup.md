Crear un fichero con las sentencias SQL listas para cargar el contenido de
una db en otra db distinta (modo simple)

postgres=# pg_dump source_db_name > db_data.sql

Cargar un fichero con las sentencias SQL listas de una db en otra db
nueva y distinta (modo simple)

postgres=# psql -d new_db_name -f db_data.sql

pg_dump: genera todos los archivos de configuración para hacer una copia de nuestra BD.

es importante resaltar que cuando se hace un backup para ser restaurado en una versión diferente se debe de usar la opción plana dado que el custom varia de versión a versión.


si lo queremos hacer en pgadmin, click dereclo a la bd o tabla, y bucscamos backup

- opcion format -> Custom, Esta opción única de postgres y solo se puede restaurar por pgAdmin. Tar, Es un archivo comprimido que contiene la estructura de la base de datos. Plain, simplemente es un archivo.sql. Directory tiene solo la estructura sin comprimir de la base de datos.
- Compression ratio: es el número de veces que algoritmo de compresión se ejecuta para reducir el tamaño del archivo
- Encoding: hace referencia al tipo de codificación de los carácteres
- Role name Es de quién va a hacer dueño ese dump

Pestaña Dump options, Nos permite configurar la opción si queremos el backup con datos o solo la estructura de la tabla, también se puede definir el propietario.
Pestaña Dump options, la opción Type of objects se puede definir solo los datos (Only data), también podemos solo el esquema (Only schema), por otro lado podemos escoger guardar los binarios sí es que se guardan los binarios (blobs)


# maintenance - matenimiento click derecho tabla o bd

Vacuum: La más importante, con tres opciones, Vacuum, Freeze y Analyze.
Full: la tabla quedará limpia en su totalidad
Freeze: durante el proceso la tabla se congela y no permite modificaciones hasta que no termina la limpieza
Analyze: solo revisa la tabla

Analyze: No hace cambios en la tabla. Solo hace una revisión y la muestra.

Reindex: Aplica para tablas con numerosos registros con indices, como por ejemplo las llaves primarias.

Cluster: Especificamos al motor de base de datos que reorganice la información en el disco.

Postgres maneja una serie de funciones que trabajan en segundo plano mientras que trabajamos directamente en la base de datos, y esto es a lo que le llamamos mantenimiento.
El nombre más común de esto es Vaccum, ya que esto quita todas las filas y columnas e items del disco duro que no están funcionando, ya que postgres al percatarse de esto, las marca como “para borrar después”.
Tiene 2 niveles de limpieza.
Liviano, se ejecuta todo el tiempo en la DB en segundo plano.
Full o completo, que es capaz de bloquear las tablas para hacer la limpieza y luego la desbloquea.
Full es importante porque puede que una tabla tenga problemas de indexación y se demore mucho en hacer las consultas.
Hacer mantenimiento en DB no es lo mismo que hacerlo directamente en las tablas.
Para ejecutar el mantenimiento se da clic derecho sobre la DB o la tabla, y luego a la opción “Maintenance”.
En tablas, aparecen 3 opciones
full: Revisa toda la información de la tabla, si hay información que no es aplicable limpiará/eliminará la fila con la información del índice y demás. Activar o desactivar full puede tumbar totalmente la DB.
freeze: durante el proceso se va a congelar. Ningún usuario va a tener acceso a esta tabla hasta que no termine el proceso de limpieza.
analyze: El más suave, el programa ejecutará una revisión y mostrará qué tan bien o mal está la tabla.
Es importante siempre hacer el mantenimiento en el horario en donde menos es utilizada la DB, ¿por qué? porque si hay menos tráfico los usuarios no van a sentir tanto la ausencia del servicio. Igualmente, en la medida de las posibilidades se puede usar una DB de respaldo para que el servicio no se vea ofuscado durante el mantenimiento, luego, una vez hecho el mantenimiento se puede actualizar la DB con los datos generados en la DB de respaldo.


En la pestaña VACUUM hay tres opciones para hacer mantenimiento, FULL se eliminará todos los indices y filas que ya no son aplicables, FREEZE, incluye que durante ese proceso se congelará la tabla o la bases de datos mientras se hace este proceso. ANALYZE solo analiza la bd.

Postgres desarrolla el mantenimiento de manera activa y sin consentimiento del usuario. El mantenimiento consiste en quitar todas las filas, items y columnas que no están funcionando correctamente y postgres lo hace para optimizar todos los servicios ya por trabajar rápido ocurre

Postgres tiene dos niveles de limpieza son: 1-Liviano que se ejecuta en segundo plano y lo hace constantemente. 2-Full el cual es capaz de bloquear las tablas para hacer la limpieza y luego la desbloquea. En estas actividades no debemos involucrarnos al menos que sea necesario

Una limpieza full es necesario cuando tengamos una tabla grande y tengamos problema de indexación, esto se refiere a que, En el momento de hacer la consulta se demore mucho tiempo.

# Replicas

Son mecánismos que permiten evitar problemas de entrada y salida en los SO.
“Existen 2 tipos de personas, los que ya usan réplicas y los que las van a usar…” - Piensa siempre en modo réplica.
A medida que la DB crece encontraremos limitaciones físicas y de electrónica, si la DB aumenta tanto su tamaño, las limitaciones serán de procesamiento, RAM, almacenamiento.
Hemos visto que las consultas en local son muy rápidas, sin embargo, cuando la aplicación ha sido desplegada pueden ocurrir multiples peticiones de lectura y escritura. Todos los motores de DB pueden hacer una ejecución a la vez, por lo que recibir tantas peticiones de consulta al mismo tiempo puede hacer que regresar una consulta se demore demasiado y eso puede ser catastrófico, pero las réplicas son la solución a este tipo de problemas.
¿Cuál es la estrategia? Tener una base de datos principal donde se realizan todas las modificaciones, y una base de datos secundaria dónde se realiza las lecturas. Separar las tareas es altamente beneficioso en cuanto al rendimiento de la aplicación, así, cuando se modifica una DB automáticamente se lleva el cambio a la DB de lectura. Todo lo que hay que hacer es configurar 2 servidores de postgres, uno como maestro y otro como esclavo. Se debe modificar la aplicación para que todas las modificaciones se hagan sobre el maestro y la lectura sobre la replica, o la DB en caliente. Es imposible realizar cambios en la DB de réplica.
