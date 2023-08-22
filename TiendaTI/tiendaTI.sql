use master;
go
create database db_ITstore;
use db_ITstore;
create table producto(
	cod_prod int unique,
	descripcion varchar(255) not null,
	precio int not null,
	cantidad int not null,		
	constraint pk_cod_prod primary key (cod_prod)
);
create table ciudad(
	cod_ciudad int unique,
	nom_ciudad varchar(50),
	constraint pk_cod_ciudad primary key (cod_ciudad)
);

create table cliente(
	cod_cliente int unique,
	nombre varchar(30) not null,
	apellido varchar(30) not null,
	direccion varchar(50),
	cod_ciudad int,
	nr_tel int,
	constraint pk_cod_cliente primary key (cod_cliente),
	constraint fk_cod_ciudad_cliente foreign key (cod_ciudad)
	references ciudad(cod_ciudad)
);
create table proveedor(
	cod_prov int unique,
	nombre varchar(30) not null,
	apellido varchar(30) not null,
	direccion varchar(50) not null,
	cod_ciudad int,
	nr_tel int,
	cod_prod int,
	constraint pk_cod_prov primary key (cod_prov),
	constraint fk_cod_prod foreign key (cod_prod) 
	references producto(cod_prod),
	constraint fk_cod_ciudad_proveedor foreign key (cod_ciudad)
	references ciudad(cod_ciudad)
);
create table compra(
	cod_compra int unique,
	cod_prod int not null,
	cod_cliente int not null, 
	fecha date not null,
	constraint pk_cod_compra1 primary key (cod_compra),
	constraint fk_cod_prod1 foreign key (cod_prod) references producto(cod_prod),
	constraint fk_cod_cliente foreign key (cod_cliente) references cliente(cod_cliente)
);

----------------------------------------------------------------------------------

insert into ciudad(cod_ciudad,nom_ciudad)
	values(1,'Asuncion'),
		  (2,'CDE'),
		  (3,'Loma Plata')

insert into cliente (cod_cliente,nombre,apellido,direccion,nr_tel,cod_ciudad)
	values (1,'Gabriel','Neufeld','chaco',0986123456,3),
	(2,'fulano','aaaaa','asu',0986123456,2),
	(3,'marciano','bbbbb','asu',0986123456,3)

insert into proveedor (cod_prov,nombre,apellido,direccion,nr_tel,cod_prod,cod_ciudad)
	values (1,'Elias','Canhete','Av. San Francisco',0987123456,1,1),
		   (2,'pedro','ccccc','asdfasdf',0987123456,1,3),
		   (3,'Elias','Canhete','ZZZZZ',0987123456,2,2)
		 
insert into producto (cod_prod,descripcion,cantidad,precio)
	values (1,'prod 01',3,45000),
		   (2,'prod 02',5,50000),
		   (3,'prod 03',5,30000)
insert into compra(cod_compra,cod_cliente,cod_prod,fecha)
	values (1,1,1,'2023-02-10'),
		   (3,2,1,'2023-02-10'),
		   (2,3,3,'2023-02-10')


--------------------------------------------------------------------------------

create view Compras 
select c.Cod_Compra,c.fecha,c.cod_prod,cl.Cod_Cliente,cl.nombre,cl.apellido,p.descripcion from Compra c
inner join Cliente cl on c.Cod_Cliente=cl.Cod_Cliente
inner join Producto p on c.cod_prod=p.cod_prod