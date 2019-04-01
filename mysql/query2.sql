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

alter table Productos add idCat int not null;

alter table Productos add constraint fk_catPro foreign key (idCat) references Categoria(idCategoria)
on delete cascade on update cascade;

show columns from Productos;
show columns from Categoria;
