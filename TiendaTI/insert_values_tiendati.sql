insert into cliente (cod_cliente,nombre,apellido,direccion,nr_tel,cod_ciudad)
	values (1,'Juan','Vera','asu',0986123456,3),
	(2,'fulano','aaaaa','asu',0986123456,2),
	(3,'marciano','bbbbb','asu',0986123456,3)

insert into proveedor (cod_prov,nombre,apellido,direccion,nr_tel,cod_prod,cod_ciudad)
	values (1,'Pepe','Gomez','Av. San Francisco',0987123456,1,1),
		   (2,'pedro','ccccc','asdfasdf',0987123456,1,3),
		   (3,'Pepe','Gomez','ZZZZZ',0987123456,2,2)
		 
insert into producto (cod_prod,descripcion,cantidad,precio)
	values (1,'prod 01',3,45000),
		   (2,'prod 02',5,50000),
		   (3,'prod 03',5,30000)
insert into compra(cod_compra,cod_cliente,cod_prod,fecha)
	values (1,1,1,'2023-02-10'),
		   (3,2,1,'2023-02-10'),
		   (2,3,3,'2023-02-10')

insert into ciudad(cod_ciudad,nom_ciudad)
	values(1,'Asuncion'),
		  (2,'CDE'),
		  (3,'P.J.C')	


