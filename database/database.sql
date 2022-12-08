CREATE DATABASE tcu;

\c tcu

CREATE TABLE Models
(
  ModelId SERIAL,
  Name VARCHAR(100) NOT NULL,
  ProductionDate DATE NOT NULL,
  Mancufacturor VARCHAR(100) NOT NULL,
  PRIMARY KEY (ModelId)
);

CREATE TABLE Vehicles
(
  VehicleId SERIAL,
  ModelId BIGINT NOT NULL,
  PRIMARY KEY (VehicleId),
  RXSWIN VARCHAR(150) NOT NULL,
  LastUpdate timestamp NOT NULL,
  FOREIGN KEY (ModelId) REFERENCES Models(ModelId),
);

CREATE TABLE SUMSLogs
(
  VehicleId NOT NULL,
  UpdateTimeStamp timestamp NOT NULL,
  RXSWIN_OLD VARCHAR(150) NOT NULL,
  RXSWIN_NEW VARCHAR(150) NOT NULL,
  PRIMARY KEY(VehicleId, UpdateTimeStamp),
  FOREIGN KEY (VehicleId) REFERENCES Vehicles(VehicleId)
);

CREATE TABLE Users
(
  Name VARCHAR(150) NOT NULL check (Name NOT LIKE '%[^A-Z ]%'),
  Adress VARCHAR(500) NULL,
  RegisterDate timestamp NOT NULL,
  UserId SERIAL NOT NULL,
  PRIMARY KEY (UserId)
);

CREATE TABLE Devices
(
  DeviceId SERIAL,
  MAC_Address CHAR(18) NOT NULL,
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
  FOREIGN KEY (UserId) REFERENCES Users(UserId),
  FOREIGN KEY (VehicleId) REFERENCES Vehicles(VehicleId)
);

CREATE TABLE Parts
(
  PartId SERIAL,
  Value VARCHAR(100) NOT NULL,
  Price FLOAT NULL CHECK (Price>=0),
  ModelId BIGINT NOT NULL,
  PRIMARY KEY (PartId),
  FOREIGN KEY (ModelId) REFERENCES Models(ModelId)
);

CREATE TABLE Descriptions
(
  DescriptionId SERIAL,
  Value VARCHAR(250) NOT NULL,
  PartId BIGINT NOT NULL,
  PRIMARY KEY (DescriptionId),
  FOREIGN KEY (PartId) REFERENCES Parts(PartId)
);

CREATE TABLE Alerts
(
  Severity int NOT NULL CHECK (Severity>=0),
  Status int NOT NULL,
  AlertId SERIAL,
  VehicleId BIGINT NOT NULL,
  DescriptionId BIGINT NOT NULL,
  PRIMARY KEY (AlertId),
  FOREIGN KEY (DescriptionId) REFERENCES Descriptions(DescriptionId),
  FOREIGN KEY (VehicleId) REFERENCES Vehicles(VehicleId)
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