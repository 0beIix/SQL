use master
go
create database db_taller
go
create table cliente
(
 ci int not null,
 nombre varchar (50) not null,
 apellido varchar(50),
 direccion varchar (150),
 telefono varchar(50),
 constraint pk_cliente_ci primary key (ci)
 )
go
 
 create table marca 
 (
 cod_marca char not null,
 descripcion varchar(50)not null,
 constraint pk_marca_cod primary key (cod_marca)
 )
 go
 create table color 
 (
 cod_color int not null,
 descripcion varchar(50)not null,
 constraint pk_color_cod primary key (cod_color)
 )
 go
 create table vehiculo
 (
 matricula char not null,
 cod_marca char not null,
 cod_color int not null,
 constraint pk_vehiculo_matricula primary key (matricula),
 constraint fk_marca_vehiculo foreign key (matricula)
 references marca(cod_marca) on delete no action on update no action, 
 constraint fk_color_vehiculo foreign key(cod_color)
 references color(cod_color) on delete no action on update no action 
 )
 go
 create table ingreso
 (
 cod_ingreso int not null identity(1,1),
 matricula char not null,
 fecha_ingreso date not null,
 hora_ingreso time not null,
 constraint pk_ingreso_cod primary key (cod_ingreso),
 constraint fk_ingreso_cod foreign key (matricula)
 references vehiculo(matricula) on delete no action on update no action
)
go
 create table mecanico
(
 ci int not null,
 nombre varchar (50) not null,
 apellido varchar(50),
 direccion varchar (150),
 telefono varchar(50),
 constraint pk_mecanico_ci primary key (ci)
 )
 go
 create table repuesto
 (
 cod_repuesto int not null,
 descripcion varchar(100) not null,
 precio money not null default 0,
 cantidad int not null default 0,
 constraint pk_repuesto_cod primary key (cod_repuesto)
 )
 go
 create table reparacion
 (
 nro_reparacion int not null,
 fecha date not null default getdate(),
 hora time not null,
 ci_cliente int  not null,
 ci_mecanico int not null,
 matricula char not null,
constraint pk_reparacion_nro primary key (nro_reparacion),
constraint fk_reparacion_cliente foreign key (ci_cliente)
references cliente(ci) on delete no action on update no action,
constraint fk_reparacion_vehiculo foreign key (matricula)
references vehiculo(matricula) on delete no action on update no action,
constraint fk_reparacion_mecanico foreign key (ci_mecanico)
references mecanico(ci) on delete no action on update no action
)
go
 create table factura
 (
 nro_factura int not null,
 fecha date not null default getdate(),
 hora time not null,
 ci_cliente int  not null,
 ci_mecanico int not null,
 matricula char not null,
nro_reparacion int not null,
constraint pk_factura_nro primary key (nro_factura),
constraint fk_factura_cliente foreign key (ci_cliente)
references cliente(ci) on delete no action on update no action,
constraint fk_factura_vehiculo foreign key (matricula)
references vehiculo(matricula) on delete no action on update no action,
constraint fk_factura_mecanico foreign key (ci_mecanico)
references mecanico(ci) on delete no action on update no action,
constraint fk_factura_reparacion foreign key (nro_reparacion)
references reparacion(nro_reparacion) on delete no action on update no action
)
go
create table reparacion_mecanico
(
nro_reparacion int not null,
ci_mecanico int not null,
constraint pk_reparacion_mecanico_id primary key (nro_reparacion, ci_mecanico),
constraint fk_reparacion_mecanico_reparacion foreign key (nro_reparacion)
references reparacion(nro_reparacion) on delete cascade on update cascade,
constraint fk_reparacion_mecanico_mecanico foreign key (ci_mecanico),
)
go
create table repuesto_factura
(
nro_factura int not null,
cod_repuesto int not null,
cantidad int not null default 1,
precio money not null default 0,
iva int not null default 10,
constraint pk_repuesto_factura_id primary key (nro_factura, cod_repuesto),
constraint fk_repuesto_factura_factura foreign key (nro_factura)
references factura(nro_factura) on delete cascade on update cascade,
constraint fk_repuesto_factura_repuesto foreign key (cod_repuesto)
references repuesto(cod_repuesto) on delete cascade on update cascade
)
go