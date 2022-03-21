USE master;
GO

IF DB_ID('ServicesData') IS NOT NULL
DROP DATABASE ServicesData;
GO

CREATE DATABASE ServicesData;
GO

USE ServicesData;

CREATE TABLE Category (
	CategoryId Int NOT NULL IDENTITY(1,1),
	CategoryName NVarChar(5) NOT NULL,

	CONSTRAINT CategoryId_PK PRIMARY KEY(CategoryId)
);

CREATE TABLE Term (
	TermId Int NOT NULL IDENTITY(1,1),
	TermName NVarChar(7) NOT NULL,

	CONSTRAINT TermId_PK PRIMARY KEY(TermId)
);

CREATE TABLE Devices (
	DeviceId Int NOT NULL IDENTITY(1,1),
	DeviceName NVarChar(8) NOT NULL,

	CONSTRAINT DeviceId_PK PRIMARY KEY(DeviceId)
);

CREATE TABLE SubTerminated (
	SubTerminatedId Int NOT NULL IDENTITY(1,1),
	SubTerminatedValue NVarChar(3) NOT NULL,

	CONSTRAINT SubTerminatedId_PK PRIMARY KEY(SubTerminatedId)
);

CREATE TABLE Subscription (
	SubscriptionId Int NOT NULL IDENTITY(1,1),
	OriginalSubStart Date NOT NULL,
	CurrentSubPeriodStart Date,
	CurrentSubPeriodEnd Date,
	SubTerminatedId Int NOT NULL,

	CONSTRAINT SubscriptionId_PK PRIMARY KEY(SubscriptionId),
	CONSTRAINT SubTerminatedId_FK FOREIGN KEY(SubTerminatedId)
		REFERENCES SubTerminated(SubTerminatedId)
);

CREATE TABLE [Services] (
	ServicesId Int NOT NULL IDENTITY(1,1),
	ServiceName NVarChar(14) NOT NULL,
	NumberOfSubs Int NOT NULL,
	[URL] VarChar(18) NOT NULL,
	ServiceFee Decimal(4,2) NOT NULL,
	TermId Int NOT NULL,
	CategoryId Int NOT NULL,
	SubscriptionId Int NOT NULL,

	CONSTRAINT ServicesId_PK PRIMARY KEY(ServicesId),
	CONSTRAINT TermId_FK FOREIGN KEY(TermId)
		REFERENCES Term(TermId),
	CONSTRAINT CategoryId_FK FOREIGN KEY(CategoryId)
		REFERENCES Category(CategoryId),
	CONSTRAINT SubscriptionId_FK FOREIGN KEY(SubscriptionId)
		REFERENCES Subscription(SubscriptionId)
);

CREATE TABLE DevicesSupported (
	DevicesSupportedId Int NOT NULL IDENTITY(1,1),
	DeviceId Int NOT NULL,
	ServicesId Int NOT NULL,

	CONSTRAINT DevicesSupportedId_PK PRIMARY KEY(DevicesSupportedId),
	CONSTRAINT DeviceId_FK FOREIGN KEY(DeviceId)
		REFERENCES Devices(DeviceId),
	CONSTRAINT ServicesId_FK FOREIGN KEY(ServicesId)
		REFERENCES [Services](ServicesId)
);

INSERT INTO Category VALUES('Music');
INSERT INTO Category VALUES('Video');

INSERT INTO [Services] VALUES('Spotify', 2, 'Spotify.com', 5.00, 1, 1, 4);
INSERT INTO [Services] VALUES('IHeartRadio', 2, 'IHeartRadio.com', 50.00, 1, 1, 5);
INSERT INTO [Services] VALUES('Netflix', 1, 'Netflix.com', 9.99, 2, 2, 6);

INSERT INTO Term VALUES('Year');
INSERT INTO Term VALUES('Monthly');

INSERT INTO Devices VALUES('Mobile');
INSERT INTO Devices VALUES('Computer');
INSERT INTO Devices VALUES('Car');
INSERT INTO Devices VALUES('TV');

INSERT INTO Subscription VALUES('12-Dec-2012', '12-Dec-2020', '12-Dec-2021', 2);
INSERT INTO Subscription VALUES('29-Jan-2014', NULL, NULL, 1);
INSERT INTO Subscription VALUES('10-Mar-2016', '10-Mar-2021', '10-Mar-2022', 2);

INSERT INTO SubTerminated VALUES('Yes');
INSERT INTO SubTerminated VALUES('No');

INSERT INTO DevicesSupported VALUES(1, 9);
INSERT INTO DevicesSupported VALUES(2, 10);
INSERT INTO DevicesSupported VALUES(3, 11);

SELECT * FROM Category

SELECT * FROM [Services]

SELECT * FROM Term

SELECT * FROM Devices

SELECT * FROM Subscription

SELECT * FROM SubTerminated

SELECT * FROM DevicesSupported