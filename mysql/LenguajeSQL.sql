/* create database tiendita character set utf8 collate utf8_spanish_ci; */
use tiendita ; 
SHOW TABLE tiendita ;
create table Productos(
	idProducto int primary key auto_increment ,
    nombreProducto varchar(50) not null ,
    precio decimal(10,2) not null,
    fecha date default '0000-00-00'
);

create table Categoria (
	idCategoria int primary key auto_increment,
    nombre varchar(50) not null
);

alter table Producto add idCat int not null;

alter table Producto add constraint fk_catPro foreign key (idCat) references Categoria(idCategoria)
on delete cascade on update cascade;

-- TIPOS DE RESTRICCIONES 
/* Integridad refencial 
	Cuando se define una columna como clave foránea , 
	las filas de la tabla pueden contener n esa columna o bien el
	valor nulo(ningun valor), o bien un valor que existe en la otra tabla ,
	un error sería asignar a un habitante una poblacion que no esta en la
	tabla de operaciones . Eso es lo que se denomina INTEGRIDAD REFERENCIAL
	y consites en que LOS DATOS QUE REFERENCIAN OTROS (CLAVES FORÁNEAS) DEBEN 
	SER CONCRETOS . La INTEGRIDAD REFERENCIAL hace que el sistema gestor de base 
	de datos se asegure de que no hayan las claves foráneas valores que no
	estén en la tabla principal

	La integridad refencial se activa cuando creamos una clave foránea y 
	a partir de ese momento se comprueba cada vez que se modifquen datos 
	que puedan alterarla

	¿Cuando se pueden producir errores en los datos ? 
	- Cuando insertamos una nueva fila en la tabla secundaria y el valor de la clave foránea no exita en la tabla principal
	- Cuando modificamos el valor de la clave principal de un registro que tiene hijos
*/
/*
	RESTRICT .- Es el comportamiento por defecto , que impide realizar modifcaiones que atentan 
				contra la integridad referencial

	CASCADE .- Borra los registros de la tabla dependiente cuando se borra el registro 
				de la tabla principal (en una sentencia DELETE) , o actualiza el valor
				de la clave secundaria . los borra sin dejar rastros
	
	SET NULL .- Establece a NULL el valor de la clave secundaria cuando se elimina el registro 
				o cuando se modifica el vlor del campo refenciado
	
	NO ACTION .-Inhabilita el efecto de la restricion , permitiendo que se efectue el cambio
				en la base de datos

*/


/*quitando las restricciones de la tabla*/

alter table Producto drop foreign key fk_catPro; 

/*Eliminado esa columna*/

alter table Producto drop column idCategoria ;