create view info AS
select r.ID,pas.Nombre,pas.Apellido,v.NumeroVuelo,v.origen,v.destino,pag.Monto
from Reservas r
inner join Pasajeros pas on r.ID=pas.ID
inner join Vuelos v on r.ID=v.ID
inner join Pagos pag on r.ID=pag.ID
select SUM(pag.monto) from Pagos pag;

select * from info;