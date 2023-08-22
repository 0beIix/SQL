-- Creacion de la base de datos
use master
go 
create database db_canino
go
use db_canino
go
-- Creacion de la tabla
create table raza(
	cod_raza int,
	nombre_raza varchar (100) not null,
	cod_pais int not null,
	constraint pk_raza_cod primary key (cod_raza)
)
--El codigo recae en el codigo del perro ya que una raza puede tener varios perros
create table perro (
	cod_perro int,
	nombre_perro varchar (100) not null,
	fecha_nac date not null default getdate(),
	cod_raza int not null,
	constraint pk_perro_cod primary key (cod_perro)
)

create table pais(
	cod_pais int,
	nombre_pais varchar (100) not null,
	gentilicio varchar (100) not null,
	constraint pk_pais_cod primary key (cod_pais)
)

create table concurso(
	cod_concurso int,
	nombre_concurso varchar (100),
	fecha_concurso date not null default getdate(),
	constraint pk_concurso_cod primary key (cod_concurso)
)

create table juez(
	matricula int,
	nombre varchar(100) not null,
	apellido varchar (100) not null,
	cod_pais int,
	constraint pk_juez_matricula primary key (matricula)
)

create table participo(
	cod_perro int,
	cod_concurso int,
	constraint pk_participo_perro_concurso primary key (cod_perro,cod_concurso)
)

create table evaluo(
	matricula int not null,
	cod_perro int not null,
	cod_concurso int not null,
	nota int not null default 0,
	constraint pk_evaluo_matricula_perro_concurso primary key (matricula,cod_perro,cod_concurso)
)

create table experto(
	matricula int not null,
	cod_raza int not null,
	constraint pk_experto_matricula_raza primary key (matricula,cod_raza)
)
go
alter table perro add constraint fk_perro_raza foreign key (cod_raza)
	references raza (cod_raza)
go
alter table raza add constraint fk_raza_pais foreign key (cod_pais)
	references pais (cod_pais)
go
alter table juez add constraint fk_juez_pais foreign key (cod_pais)
	references pais (cod_pais)
go
alter table participo add constraint fk_participo_perro foreign key (cod_perro)
	references perro (cod_perro) on delete cascade on update cascade
go
alter table participo add constraint fk_participo_concurso foreign key (cod_concurso)
	references concurso (cod_concurso) on delete cascade on update cascade
go
alter table evaluo add constraint fk_evaluo_matricula foreign key (matricula)
	references juez (matricula)on delete cascade on update cascade 
go
alter table evaluo add constraint fk_evaluo_perro foreign key (cod_perro) 
	references perro (cod_perro) on delete cascade on update cascade
go 
alter table evaluo add constraint fk_evaluo_cnocurso foreign key (cod_concurso)
	references concurso (cod_concurso) on delete cascade on update cascade
go
alter table evaluo add constraint ch_evaluo_note check (nota between 0 and 10)
go
alter table experto add constraint fk_experto_matricula foreign key (matricula)
	references juez (matricula) on delete cascade on update cascade
go
alter table experto add constraint fk_experto_raza foreign key (cod_raza) 
	references raza (cod_raza) on delete cascade on update cascade
go

insert into dbo.pais(cod_pais,nombre_pais,gentilicio)
	values	(1,'Alemania','Alemania'),
			(2,'Argentina','Argentina'),
			(3,'China','China')
go
insert into raza (cod_raza,nombre_raza,cod_pais)
	values (1,'Pastor Aleman',1),
		   (2,'Chow Chow',3),
		   (3,'Dogo Argentino',2)
go
insert into perro (cod_perro,nombre_perro,fecha_nac,cod_raza)
	values (1,'Firulais',12022008,1)
GO
insert into concurso (cod_concurso,nombre_concurso,fecha_concurso)
	values (1,'Concurso anual de perros','12022010'),
			(2,'Concurso trimestral de perros','14042010')

insert into participo (cod_concurso,cod_perro)
	values (1,1),(1,2),(1,3),(2,1),(2,4)
go
alter table evaluo add constraint fk_evaluo_participo foreign key (cod_perro,cod_concurso)
	references participo (cod_perro,cod_concurso)
go 
insert into evaluo(matricula,cod_perro,cod_concurso,nota)
values (1,2,1,10), (2,2,1,9)
go
insert into evaluo(matricula,cod_perro,cod_concurso,nota)
values (2,2,2,7), (2,2,1,5)
go

--nombra juezes noobs

select j.nombre+' '+j.apellido as nombre,e.*
	from juez j
	inner join experto e on j.matricula = e.matricula

select e.matricula 
from evaluo e
inner join perro p on e.cod_perro = p.cod_perro
inner join raza r on p.cod_raza = r.cod_raza
where p.cod_raza in (select e.cod_raza
						from juez j 
						inner join experto e on j.matricula = e.matricula)

