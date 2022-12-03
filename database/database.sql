USE master

CREATE DATABASE TCU

GO

USE TCU

CREATE TABLE VehiclesLocations
(
  Latitude FLOAT NOT NULL,
  Longitude FLOAT NOT NULL,
  UpdateTimeStamp DATETIME NOT NULL DEFAULT now(),
  VehicleId BIGINT NOT NULL ,
  FOREIGN KEY (VehicleId) REFERENCES Vehicle(VehicleId),
  PRIMARY KEY (VehicleId)
);
CREATE TABLE DevicesLocations
(
  Latitude FLOAT NOT NULL,
  Longitude FLOAT NOT NULL,
  UpdateTimeStamp DATETIME NOT NULL DEFAULT now() ,
  DeviceId BIGINT NOT NULL ,
  FOREIGN KEY (DeviceId) REFERENCES Devices(DeviceId),
  PRIMARY KEY (DeviceId)
);

CREATE TABLE Users
(
  Name VARCHAR(150) NOT NULL check (Name NOT LIKE '%[^A-Z ]%'),
  Adress VARCHAR(500) NULL,
  RegisterDate DATETIME NOT NULL,
  UserId BIGINT NOT NULL IDENTITY(1,1),
  PRIMARY KEY (UserId),
);

CREATE TABLE Devices
(
  DeviceId SERIAL PRIMARY KEY,
  MAC_Adress CHAR(18) NOT NULL,
  Type INT NOT NULL,
  UserId BIGINT NOT NULL,
  PRIMARY KEY (DeviceId),
  FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

CREATE TABLE LockRequests
(
  UserId BIGINT NOT NULL,
  VehicleId BIGINT NOT NULL,
  Status INT NOT NULL,
  PRIMARY KEY (UserId, VehicleId),
  FOREIGN KEY (UserId) REFERENCES User(UserId),
  FOREIGN KEY (VehicleId) REFERENCES Vehicle(VehicleId)
);

CREATE TABLE Models
(
  ModelId SERIAL PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  ProductionDate DATE NOT NULL,
  Mancufacturor VARCHAR(100) NOT NULL,
  PRIMARY KEY (ModelId)
);


CREATE TABLE Parts
(
  PartId SERIAL PRIMARY KEY,
  Value VARCHAR(100) NOT NULL,
  Price FLOAT NULL CHECK (Price>=0),
  ModelId BIGINT NOT NULL,
  PRIMARY KEY (PartId),
  FOREIGN KEY (ModelId) REFERENCES Models(ModelId)
);



CREATE TABLE Descriptions
(
  DescriptionId SERIAL PRIMARY KEY,
  Value VARCHAR(250) NOT NULL,
  PartId BIGINT NOT NULL,
  PRIMARY KEY (DescriptionId),
  FOREIGN KEY (PartId) REFERENCES Parts(PartId)
);

CREATE TABLE Vehicles
(
  Plate_number VARCHAR(50) NOT NULL,
  VehicleId SERIAL PRIMARY KEY,
  ModelId BIGINT NOT NULL,
  PRIMARY KEY (VehicleId),
  FOREIGN KEY (ModelId) REFERENCES Models(ModelId),
  UNIQUE (Plate_number)
);


CREATE TABLE Alerts
(
  Severity int NOT NULL CHECK (Severity>=0),
  Status int NOT NULL,
  AlertId SERIAL PRIMARY KEY,
  VehicleId BIGINT NOT NULL,
  DescriptionId BIGINT NOT NULL,
  PRIMARY KEY (AlertId),
  FOREIGN KEY (DescriptionId) REFERENCES Descriptions(DescriptionId),
  FOREIGN KEY (VehicleId) REFERENCES Vehicles(VehicleId),
);

CREATE TABLE Users_Vehicles
(
  Access_right INT NOT NULL CHECK (Access_right>=0),
  UserId BIGINT NOT NULL,
  VehicleId BIGINT NOT NULL,
  PRIMARY KEY (UserId, VehicleId),
  FOREIGN KEY (UserId) REFERENCES Vehicles(VehicleId),
  FOREIGN KEY (VehicleId) REFERENCES Users(UserId)
);

