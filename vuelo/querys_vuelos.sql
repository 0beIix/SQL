use db_vuelo
go
-- asientos disponibles en vuelo
select NumeroVuelo,AsientosDisponibles from Vuelos

-- asientos reservados
select p.Nombre,p.Apellido,p.FechaNacimiento from Pasajeros p
inner join Reservas r on p.ID=r.ID

-- metodo de pago
select pas.Nombre+' '+pas.Apellido from Pasajeros pas 
inner join Pagos pag on pas.ID=pag.ID where pag.MetodoPago = 'Credito'

-- pasajero mas viejo
select * from Pasajeros pk_vuelos_id
WHERE p.FechaNacimiento = (SELECT MIN(FechaNacimiento)
						  FROM Pasajeros);
                          
-- datos de vuelo de pasajero 1
select v.NumeroVuelo,v.origen,v.destino from Vuelos v
inner join Reservas r on v.ID=r.ID where r.ID=1