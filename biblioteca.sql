create table usuario(
	ci int,
	nombre varchar (50),
	apellido varchar (50),
	direccion varchar (70),
	constraint pk_ci primary key (ci)
);

create table edicion(
	isbn int,
	anho date,
	constraint pk_isbn primary key (isbn)
);

create table nacionalidad (
	id int,
	pais varchar (50) unique,
	constraint pk_id primary key (id)
);

create table autor(
	id int,
	nombre varchar (50) unique,
	fecha_nac date,
	nac int ,
	constraint pk_id_autor primary key (id),
	constraint fk_id_nac foreign key (id)
	references nacionalidad(id)
);

create table libro(
	id int,
	titulo varchar (60) unique,
	idioma varchar (40),
	paginas int,
	id_autor int,
	id_edicion int,
	constraint pk_id_libro primary key (id),
	constraint fk_id_autor foreign key (id_autor)
	references autor(id),
	constraint fk_id_edicion foreign key (id_edicion)
	references edicion(isbn)
);
create table prestamo (
	id int,
	ci_usuario int,
	id_libro int,
	fecha_prestamo date,
	fecha_devolucion date,
	constraint pk_id_prestamo primary key (id),
	constraint fk_ci_usuario_prestamo foreign key (ci_usuario)
	references usuario(ci),
	constraint fk_id_libro_prestamo foreign key (id_libro)
	references libro(id),
);
