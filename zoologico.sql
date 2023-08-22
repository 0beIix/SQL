use master
create database zoologico;
use zoologico;

create table especie(
	idespecie int,
	nomcientifico varchar(100) unique,
	nomvulgar varchar(50) not null,
	familia varchar(50) not null,
	peligro varchar(50),
	constraint pk_idespecie primary key (idespecie)
);
create table pais(
	idpais int,
	nompais varchar(50) not null,
	constraint pk_idpais primary key (idpais),
);
create table ciudad(
	idciudad int,
	nomciudad varchar(50) not null,
	constraint pk_idciudad primary key (idciudad)
);
create table zoo(
	numzoo int,
	nomzoo varchar(50) not null,
	numid int,
	idciudad int,
	idpais int,
	tamaño int not null,
	presupuesto int,
	constraint pk_numzoo primary key (numzoo),
	constraint fk_idciudad foreign  key (idciudad) 
	references ciudad(idciudad) on update cascade,
	constraint fk_idpais foreign key (idpais)
	references pais(idpais) on update cascade,
);

create table animal(
	numid int,
	numzoo int not null,
	idespecie int,
	sexo varchar(10) not null,
	añonacim date,
	idpais int,
	constraint pk_numid primary key (numid),
	constraint fk_idpais_animal foreign key (idpais) 
	references pais(idpais),
	constraint fk_idespecie foreign key (idespecie) 
	references especie(idespecie),
	constraint fk_numzoo foreign key (numzoo) 
	references zoo(numzoo),
);

----------------------------------------------------------------------

INSERT INTO especie (idespecie, nomcientifico, nomvulgar, familia, peligro)
VALUES 
  (1, 'nom cientifico 1', 'tigre', 'Felidae', 'Alto'),
  (2, 'nom cientifico 2', 'leon', 'Felidae', 'Mediano'),
  (3, 'nom cientifico 3', 'elefante', 'Elephantidae', 'bajo'),
  (4, 'nom cientifico 4', 'lobo', 'Canidae ', NULL),
  (5, 'nom cientifico 5', 'oso', 'Ursidae', NULL);
 
INSERT INTO pais (idpais, nompais)
VALUES 
  (1, 'India'),
  (2, 'South Africa'),
  (3, 'Thailand'),
  (4, 'Canada'),
  (5, 'EEUU');

INSERT INTO ciudad (idciudad, nomciudad)
VALUES 
  (1, 'ciudad 1'),
  (2, 'ciudad 2'),
  (3, 'ciudad 3'),
  (4, 'ciudad 4'),
  (5, 'ciudad 5');

INSERT INTO zoo (numzoo, nomzoo, numid, idciudad, idpais, tamaño, presupuesto)
VALUES 
  (1, 'Zoo 1', 123, 1, 1, 1000, 50000),
  (2, 'Zoo 2', 234, 2, 2, 2000, 75000),
  (3, 'Zoo 3', 345, 3, 3, 1500, 60000),
  (4, 'Zoo 4', 456, 4, 4, 1200, 40000),
  (5, 'Zoo 5', 567, 5, 5, 1800, 80000);


INSERT INTO animal (numid, numzoo, idespecie, sexo, añonacim, idpais)
VALUES 
  (123, 1, 1, 'Macho', '2020-01-01', 1),
  (234, 2, 2, 'Hembra', '2019-05-12', 2),
  (345, 3, 3, 'Macho', '2022-03-25', 3),
  (456, 4, 4, 'Hembra', '2021-07-08', 4),
  (567, 5, 5, 'Macho', '2020-11-15', 5),
  (678, 1, 1, 'Macho', '2020-01-01', 1),
  (789, 2, 2, 'Hembra', '2019-05-12', 2),
  (890, 3, 3, 'Macho', '2022-03-25', 3);

------------------------------------------------------------
create view animales_en_varios_zoo as an_zoo
SELECT a.numid, a.numzoo, COUNT(a.numzoo) AS num_zoos
FROM animal a
GROUP BY a.numzoo, a.numid
HAVING COUNT(a.numzoo) > 1;
