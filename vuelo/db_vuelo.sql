use master
create database db_vuelo
go
use db_vuelo
go

CREATE TABLE Pasajeros (
  ID INT NOT NULL,
  Nombre VARCHAR(50),
  Apellido VARCHAR(50),
  FechaNacimiento DATE,
  Genero VARCHAR(10),
  Nacionalidad VARCHAR(50),
  CONSTRAINT pk_pasajeros_id PRIMARY KEY (ID)
);
CREATE TABLE Vuelos (
  ID INT NOT NULL,
  NumeroVuelo VARCHAR(10),
  origen VARCHAR(50),
  destino VARCHAR(50),
  FechaSalida DATE,
  HoraSalida TIME,
  FechaLlegada DATE,
  HoraLlegada TIME,
  AsientosDisponibles INT,
  Precio DECIMAL(8, 2) DEFAULT 0.0,
  CONSTRAINT pk_vuelos_id PRIMARY KEY (ID)
)
CREATE TABLE Reservas (
  ID INT PRIMARY KEY,
  NumeroReserva VARCHAR(10),
  PasajeroID INT,
  VueloID INT,
  Asiento VARCHAR(10),
  FOREIGN KEY (PasajeroID) REFERENCES Pasajeros(ID),
  FOREIGN KEY (VueloID) REFERENCES Vuelos(ID)
);
CREATE TABLE Pagos (
  ID INT PRIMARY KEY,
  ReservaID INT,
  Monto DECIMAL(8, 2),
  MetodoPago VARCHAR(20),
  FOREIGN KEY (ReservaID) REFERENCES Reservas(ID)
);
INSERT INTO Pasajeros (ID, Nombre, Apellido, FechaNacimiento, Genero, Nacionalidad)
VALUES
  (1, 'Juan', 'Pérez', '1990-05-15', 'Masculino', 'Argentina'),
  (2, 'María', 'López', '1985-10-22', 'Femenino', 'España'),
  (3, 'Carlos', 'Gómez', '1995-02-28', 'Masculino', 'México');

INSERT INTO Vuelos (ID, NumeroVuelo, Origen, Destino, FechaSalida, HoraSalida, FechaLlegada, HoraLlegada, AsientosDisponibles, Precio)
VALUES
  (1, 'ABC123', 'Buenos Aires', 'Madrid', '2023-06-01', '08:30:00', '2023-06-01', '19:45:00', 150, 500.00),
  (2, 'DEF456', 'Lima', 'Santiago', '2023-06-02', '10:00:00', '2023-06-02', '14:30:00', 100, 350.00),
  (3, 'GHI789', 'Tokio', 'Nueva York', '2023-06-03', '14:45:00', '2023-06-04', '08:20:00', 200, 800.00);

INSERT INTO Reservas (ID, NumeroReserva, PasajeroID, VueloID, Asiento)
VALUES
  (1, 'R12345', 1, 1, 'A1'),
  (2, 'R54321', 2, 3, 'B3'),
  (3, 'R98765', 3, 2, 'C2');