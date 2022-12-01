USE master

CREATE DATABASE TCU

GO

USE TCU

CREATE TABLE Locations
(
  Latitude INT NOT NULL,
  Longitude INT NOT NULL,
  UpdateTimeStamp DATE NOT NULL,
  TrackingCode BIGINT NOT NULL,
  PRIMARY KEY (TrackingCode)
);

CREATE TABLE Users
(
  Name VARCHAR(150) NOT NULL,
  Adress VARCHAR(500) NULL,
  RegisterDate DATETIME NOT NULL,
  UserId BIGINT NOT NULL IDENTITY(1,1),
  PRIMARY KEY (UserId),
);

CREATE TABLE Devices
(
  DeviceId BIGINT NOT NULL IDENTITY(1,1),
  MAC_Adress CHAR(12) NOT NULL,
  Type INT NOT NULL,
  UserId BIGINT NOT NULL,
  PRIMARY KEY (DeviceId),
  FOREIGN KEY (DeviceId) REFERENCES Locations(TrackingCode),
  FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

CREATE TABLE LockRequests
(
  RequestId BIGINT NOT NULL,
  Status INT NOT NULL,
  PRIMARY KEY (RequestId)
);

CREATE TABLE Models
(
  ModelId BIGINT NOT NULL,
  Name VARCHAR(100) NOT NULL,
  ProductionDate DATETIME NOT NULL,
  Mancufacturor VARCHAR(100) NOT NULL,
  PRIMARY KEY (ModelId)
);


CREATE TABLE Parts
(
  PartId BIGINT NOT NULL,
  Value VARCHAR(100) NOT NULL,
  Price INT NULL,
  ModelId BIGINT NOT NULL,
  PRIMARY KEY (PartId),
  FOREIGN KEY (ModelId) REFERENCES Models(ModelId)
);

CREATE TABLE User_LockRequests
(
  TimeStamp DATETIME NOT NULL,
  UserId BIGINT NOT NULL,
  RequestId BIGINT NOT NULL,
  PRIMARY KEY (UserId, RequestId),
  FOREIGN KEY (UserId) REFERENCES Users(UserId),
  FOREIGN KEY (RequestId) REFERENCES LockRequests(RequestId)
);

CREATE TABLE Descriptions
(
  DescriptionId BIGINT NOT NULL,
  Value VARCHAR(250) NOT NULL,
  PartId BIGINT NOT NULL,
  PRIMARY KEY (DescriptionId),
  FOREIGN KEY (PartId) REFERENCES Parts(PartId)
);

CREATE TABLE Vehicles
(
  Plate_number VARCHAR(50) NOT NULL,
  VehicleId BIGINT NOT NULL,
  ModelId BIGINT NOT NULL,
  PRIMARY KEY (VehicleId),
  FOREIGN KEY (VehicleId) REFERENCES Locations(TrackingCode),
  FOREIGN KEY (ModelId) REFERENCES Models(ModelId),
  UNIQUE (Plate_number)
);


CREATE TABLE Alerts
(
  Severity int NOT NULL,
  Status int NOT NULL,
  AlertId BIGINT NOT NULL,
  VehicleId BIGINT NOT NULL,
  DescriptionId BIGINT NOT NULL,
  PRIMARY KEY (AlertId),
  FOREIGN KEY (DescriptionId) REFERENCES Descriptions(DescriptionId),
  FOREIGN KEY (VehicleId) REFERENCES Vehicles(VehicleId),
);

CREATE TABLE Users_Vehicles
(
  Access_right INT NOT NULL,
  UserId BIGINT NOT NULL,
  VehicleId BIGINT NOT NULL,
  PRIMARY KEY (UserId, VehicleId),
  FOREIGN KEY (UserId) REFERENCES Vehicles(VehicleId),
  FOREIGN KEY (VehicleId) REFERENCES Users(UserId)
);

CREATE TABLE Vehicles_LockRequest
(
  timestamp DATETIME NOT NULL,
  VehicleId BIGINT NOT NULL,
  RequestId BIGINT NOT NULL,
  PRIMARY KEY (VehicleId, RequestId),
  FOREIGN KEY (VehicleId) REFERENCES Vehicles(VehicleId),
  FOREIGN KEY (RequestId) REFERENCES LockRequests(RequestId)
);