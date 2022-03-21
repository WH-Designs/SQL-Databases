
USE PetDatabase;
GO

CREATE TABLE PetOwner (
	OwnerID			Int			NOT NULL IDENTITY(1, 1),
	OwnerLastName	NVarChar(100)	NOT NULL,
	OwnerFirstName	NVarChar(100)	NOT NULL,
	OwnerPhone		Varchar(12)		NULL,
	OwnerEmail		Varchar(100)	NULL,

	CONSTRAINT		OWNER_PK		PRIMARY KEY(OwnerID)
);

CREATE TABLE PetType (
	PetTypeID		Int		NOT NULL IDENTITY(1, 1),
	PetTypeName		NVarChar(100) NOT NULL
	CONSTRAINT		PetTypePK	PRIMARY KEY(PetTypeID)
);

CREATE TABLE PetBreed (
	PetBreedID		Int		NOT NULL IDENTITY(1, 1),
	PetBreedName	VarChar(100)	NOT NULL,
	CONSTRAINT		PetBreedPK	PRIMARY KEY(PetBreedID)

);

CREATE TABLE Pet (
		PetID		Int		NOT NULL IDENTITY(1, 1),
		PetName		NVarChar(100) NOT NULL,
		PetDOB		DateTime	NULL,
		OwnerID		int		NOT NULL,
		PetTypeID	int		NOT NULL,
		PetBreedID	int		NULL,
		CONSTRAINT	PetPK	PRIMARY KEY(PetID),
		CONSTRAINT	OwnerIDFK	FOREIGN KEY(OwnerID)
			REFERENCES PetOwner(OwnerID),
		CONSTRAINT	PetTypeFK	FOREIGN KEY(PetTypeID)
			REFERENCES PetType(PetTypeID),
		CONSTRAINT PetBreedFK	FOREIGN KEY(PetBreedID)
			REFERENCES PetBreed(PetBreedID)
);

INSERT INTO PetOwner
	(OwnerLastName, OwnerFirstName, OwnerPhone, OwnerEmail)
VALUES
	('Downs', 'Marsha', '555-537-8765', 'Marsha.Downs@mail.com'),
	('James', 'Richard', '555-537-7654', 'James.Richard@mail.com');

SELECT * FROM PetOwner;

INSERT INTO PetType
	(PetTypeName)
VALUES
	('Dog'),
	('Cat');

INSERT INTO PetBreed
	(PetBreedName)
VALUES
	('Standard Poodle'),
	('Cashmere'),
	('Collie Mix'),
	('Border Collie'),
	('Unknown');

INSERT INTO Pet
	(PetName, PetDOB, PetTypeID, OwnerID, PetBreedID)
VALUES
	('King', '2017-02-27', 1, 1, 1),
	('Teddy', '2017-02-01', 2, 2, 2);

SELECT * FROM Pet;

