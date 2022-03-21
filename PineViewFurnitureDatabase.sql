USE master;
GO

IF DB_ID('PineViewDatabase') IS NOT NULL
DROP DATABASE PineViewDatabase;
GO

CREATE DATABASE PineViewDatabase;
GO

USE PineViewDatabase

CREATE TABLE Customer (
	CustomerId Int NOT NULL IDENTITY(1,1),
	CustomerNum Int NOT NULL,
	CustomerName NVarChar(64) NOT NULL,
	CustomerAddress VarChar(30) NOT NULL,
	CustomerCity NVarChar(30) NOT NULL,
	CustomerState NVarChar(2) NOT NULL,
	CustomerZip Int NOT NULL,

	CONSTRAINT CustomerId_PK PRIMARY KEY(CustomerId)
);

CREATE TABLE FurnitureOrder (
	OrderId Int NOT NULL IDENTITY(1,1),
	OrderNum Int NOT NULL,
	OrderDate Date NOT NULL,
	OrderPromisedDate Date NOT NULL,
	CustomerId Int NOT NULL,

	CONSTRAINT OrderId_PK PRIMARY KEY(OrderId),
	CONSTRAINT CustomerId_FK FOREIGN KEY(CustomerId)
		REFERENCES Customer(CustomerId)
);

CREATE TABLE Product (
	ProductId Int NOT NULL IDENTITY(1,1),
	ProductNum VarChar(4) NOT NULL,
	ProductDescription NVarChar(30) NOT NULL,
	ProductPrice Decimal(8,2)

	CONSTRAINT ProductId_PK PRIMARY KEY(ProductId)
);

CREATE TABLE OrderLineItems (
	OrderLineId Int NOT NULL IDENTITY(1,1),
	Inventory Int NOT NULL,
	OrderId Int NOT NULL,
	ProductId Int NOT NULL,

	CONSTRAINT OrderLineId_PK PRIMARY KEY(OrderLineId),
	CONSTRAINT OrderId_FK FOREIGN KEY(OrderId)
		REFERENCES FurnitureOrder(OrderId),
	CONSTRAINT ProductId_FK FOREIGN KEY(ProductId)
		REFERENCES Product(ProductId),
);

INSERT INTO Customer VALUES(1273, 'Contemporary Designs', '123 Oak St.', 'Austin', 'TX', 28384);

INSERT INTO FurnitureOrder VALUES(61384, '11/4/2014', '11/21/2017', 1);

INSERT INTO OrderLineItems VALUES(4, 1, 1);
INSERT INTO OrderLineItems VALUES(2, 1, 2);
INSERT INTO OrderLineItems VALUES(1, 1, 3);

INSERT INTO Product VALUES('M128', 'Bookcase', 200.00);
INSERT INTO Product VALUES('B381', 'Cabinet', 150.00);
INSERT INTO Product VALUES('R210', 'Table', 500.00);

SELECT * FROM Customer

SELECT * FROM FurnitureOrder

SELECT * FROM OrderLineItems

SELECT * FROM Product