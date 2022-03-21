USE master;
GO

IF DB_ID('RideShare') IS NOT NULL
DROP DATABASE RideShare;
GO

CREATE DATABASE RideShare;
GO

IF DB_ID('UserTypes') IS NOT NULL
	DROP TABLE UserTypes;
GO

CREATE TABLE UserTypes (
	UserTypeId	INT NOT NULL IDENTITY(1,1),
	UserType	NVARCHAR(6) NOT NULL

	CONSTRAINT UserTypeId_PK PRIMARY KEY(UserTypeId)
);

IF DB_ID('Zip') IS NOT NULL
	DROP TABLE Zip;
GO

CREATE TABLE Zip (
	ZipId	INT NOT NULL IDENTITY(1,1),
	Code	INT NOT NULL

	CONSTRAINT ZipId_PK PRIMARY KEY(ZipId)
);

IF DB_ID('Locale') IS NOT NULL
	DROP TABLE Locale;
GO

CREATE TABLE Locale (
	LocaleId	INT NOT NULL IDENTITY(1,1),
	City	NVARCHAR(17) NOT NULL,
	[State] NVARCHAR(32) NOT NULL

	CONSTRAINT LocaleId_PK PRIMARY KEY(LocaleId)
);

IF DB_ID('MakeModel') IS NOT NULL
	DROP TABLE MakeModel;
GO

CREATE TABLE MakeModel (
	MakeModelId	INT NOT NULL IDENTITY(1,1),
	Make	NVARCHAR(32),
	Model	NVARCHAR(32)

	CONSTRAINT MakeModelId_PK PRIMARY KEY(MakeModelId)
);

IF DB_ID('Vehicle') IS NOT NULL
	DROP TABLE Vehicle;
GO

CREATE TABLE Vehicle (
	VehicleId	INT	NOT NULL IDENTITY(1,1),
	MakeModelId	INT	NOT NULL,
	VehicleLicensePlate	INT NOT NULL

	CONSTRAINT VehicleId_PK PRIMARY KEY(VehicleId),
	CONSTRAINT MakeModelId_FK FOREIGN KEY(MakeModelId)
		REFERENCES MakeModel(MakeModelId)
);

IF DB_ID('Address') IS NOT NULL
	DROP TABLE [Address];
GO

CREATE TABLE [Address] (
	AddressId	INT NOT NULL IDENTITY(1,1),
	Line1	VARCHAR(32) NOT NULL,
	Line2	VARCHAR(32) NULL,
	ZipId	INT	NOT NULL,
	LocaleId	INT NOT NULL

	CONSTRAINT AddressId_PK PRIMARY KEY(AddressId),
	CONSTRAINT ZipId_FK FOREIGN KEY(ZipId)
		REFERENCES Zip(ZipId),
	CONSTRAINT LocaleId_FK	FOREIGN KEY(LocaleId)
		REFERENCES Locale(LocaleId)
);

IF DB_ID('User') IS NOT NULL
	DROP TABLE [User];
GO

CREATE TABLE [User] (
	UserId	INT	NOT NULL IDENTITY(1,1),
	UserTypeId	INT NOT NULL,
	UserName	NVARCHAR(64) NOT NULL,
	[Password]  NVARCHAR(255) NOT NULL,
	AddressId	INT NULL,
	UserPhone	NVARCHAR(12) NOT NULL,
	UserEmail	NVARCHAR(255) NOT NULL,
	UserBalance	MONEY DEFAULT 0

	CONSTRAINT UserId_PK PRIMARY KEY(UserId),
	CONSTRAINT UserTypeId_FK FOREIGN KEY(UserTypeId)
		REFERENCES UserTypes(UserTypeId),
	CONSTRAINT AddressId_FK	FOREIGN KEY(AddressId)
		REFERENCES [Address](AddressId)
);

IF DB_ID('Ride') IS NOT NULL
	DROP TABLE Ride;
GO

CREATE TABLE Ride (
	RideId	INT	 NOT NULL IDENTITY(1,1),
	VehicleId INT NOT NULL,
	UserId	INT NOT NULL,
	User2Id INT NOT NULL,
	RideStatus BIT NOT NULL,
	PaymentStatus BIT NOT NULL,
	ETA		TIME NOT NULL,
	PickupTime	TIME NOT NULL,
	Destination	VARCHAR(255) NOT NULL,
	PickupLocation	VARCHAR(255) NOT NULL

	CONSTRAINT RideId_PK PRIMARY KEY(RideId),
	CONSTRAINT VehicleId_FK FOREIGN KEY(VehicleId)
		REFERENCES Vehicle(VehicleId),
	CONSTRAINT UserId_FK FOREIGN KEY(UserId)
		REFERENCES [User](UserId),
	CONSTRAINT User2Id_FK FOREIGN KEY(User2Id)
		REFERENCES [User](UserId)
);


INSERT INTO [User]
VALUES ('1', 'Wyatt', '123', NULL, '503-936-2768', 'whaak19@gmail.com', 0)

INSERT INTO [User]
VALUES ('2', 'Logan', '234', NULL, '503-126-5738', 'whaak20@gmail.com', 0)