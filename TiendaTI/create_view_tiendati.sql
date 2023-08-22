create view factura as
select c.cod_compra,p.descripcion,cl.nombre,cl.apellido,c.fecha from compra c
inner join cliente cl on c.cod_cliente=cl.cod_cliente
inner join producto p on c.cod_prod=p.cod_prod

select * from factura
union
select * from compra

create view Compras AS
select c.Cod_Compra,c.fecha,c.cod_prod,cl.Cod_Cliente,cl.nombre,cl.apellido,p.descripcion from Compra c
inner join Cliente cl on c.Cod_Cliente=cl.Cod_Cliente
inner join Producto p on c.cod_prod=p.cod_prod
