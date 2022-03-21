USE master;
GO

IF DB_ID('Faculty') IS NOT NULL
DROP DATABASE Faculty;
GO

CREATE DATABASE Faculty;
GO

USE Faculty;

CREATE TABLE ProfRank (
	ProfRankId Int NOT NULL IDENTITY(1,1),
	ProfRankName NVarChar(30),
	Minimum Decimal(8, 2),
	Maximum Decimal(8, 2)

	CONSTRAINT ProfRankId_PK PRIMARY KEY(ProfRankId)
);

CREATE TABLE Dept (
	DeptId Int NOT NULL IDENTITY(1,1),
	DeptName NVarChar(30) NOT NULL

	CONSTRAINT DeptId_PK PRIMARY KEY(DeptId)
);

CREATE TABLE Major (
	MajorId Int NOT NULL IDENTITY(1,1),
	MajorName NVarChar(64) NOT NULL

	CONSTRAINT MajorId_PK PRIMARY KEY(MajorId)
);

CREATE TABLE Faculty (
	FacultyId Int NOT NULL IDENTITY(1,1),
	FirstName NVarChar(64) NOT NULL,
	LastName NVarChar(64) NOT NULL,
	Phone NVarChar(12), 
	Salary Decimal(8,2),
	Stipend Decimal(8,2),
	Hiredate Date,
	SupervisorId Int,
	DeptId Int NOT NULL,

	CONSTRAINT FacultyId_PK PRIMARY KEY(FacultyId),
	CONSTRAINT SupervisorId_FK FOREIGN KEY (FacultyId)
		REFERENCES Faculty(FacultyId),
	CONSTRAINT DeptId_FK FOREIGN KEY (DeptId)
		REFERENCES Dept(DeptId)
);

CREATE TABLE Student (
	StudentId Int NOT NULL IDENTITY(1,1),
	FirstName NVarChar(64) NOT NULL,
	LastName NVarChar(64) NOT NULL,
	Phone NVarChar(12),
	AdvisorId Int NOT NULL,

	CONSTRAINT StudentId_PK PRIMARY KEY(StudentId),
	CONSTRAINT AdvisorId_FK FOREIGN KEY (AdvisorId)
		REFERENCES Faculty(FacultyId)
);

CREATE TABLE StudentMajor (
	StudentMajorId Int NOT NULL IDENTITY(1,1),
	MajorId Int NOT NULL,
	StudentId Int NOT NULL,

	CONSTRAINT StudentMajorId_PK PRIMARY KEY(StudentMajorId),
	CONSTRAINT StudentId_FK FOREIGN KEY (StudentId)
		REFERENCES Student(StudentId),
	CONSTRAINT MajorId_FK FOREIGN KEY (MajorId)
		REFERENCES Major(MajorId)
);


INSERT INTO Major VALUES('Software Engineering Technology');
INSERT INTO Major VALUES('Computer Engineering Technology');
INSERT INTO Major VALUES('Applied Psychology');
INSERT INTO Major VALUES('Communication Studies');

INSERT INTO Dept VALUES('Computer Science')
INSERT INTO Dept VALUES('Humanities and Social Science');
INSERT INTO Dept VALUES('Communication');
INSERT INTO Dept VALUES('Mathematics');

INSERT INTO Faculty VALUES ('Lucas', 'Cordova', '885-1230', 25000.00, 3000.00, '15-sep-2016', Null, 1);
INSERT INTO Faculty VALUES ('Becka', 'Morgan', '885-1598', 33000.00, 3000.00, '15-sep-1986', Null, 1);
INSERT INTO Faculty VALUES ('Breeann', 'Flesch', '885-1596', 35000.00, 1500.00, '15-sep-1984', 1, 1);
INSERT INTO Faculty VALUES ('Scot', 'Morse', '885-1453', 37000.00, 1500.00,'5-Jan-1990', 1, 1);
INSERT INTO Faculty VALUES ('Don', 'Kraus', '885-1577',  23000.00, NULL,'15-sep-1999', 2, 1);
INSERT INTO Faculty VALUES ('Allison', 'Omid', '885-1543', 26000.00, NULL,'7-jan-2001', 3, 1);
INSERT INTO Faculty VALUES ('Phong', 'Nguyen', '885-1599', 25000.00, NULL,'15-sep-1999', 3, 1);
INSERT INTO Faculty VALUES ('Sherry', 'Yang', '885-1594', 27000.00, NULL,'15-sep-1997', 2, 1);
INSERT INTO Faculty VALUES ('Lynda', 'Baker', '885-1672', 38000.00, 3000.00, '15-sep-1989', Null, 2);
INSERT INTO Faculty VALUES ('Maria Lynn', 'Kessler', '885-1674', 26000.00, NULL, '15-sep-2003', 8, 2);
INSERT INTO Faculty VALUES ('John', 'Puckett', '885-1678', 39000.00, 3000.00, '15-sep-1989', Null, 3);
INSERT INTO Faculty VALUES ('Robin', 'Schwartz', '885-1398', 9000.00, NULL, '15-sep-1999', 10, 3);
INSERT INTO Faculty VALUES ('Jim', 'Long', '885-1580', 19500.00, NULL, '15-sep-2000', 2, 1);
INSERT INTO Faculty VALUES ('Tim', 'Stewart', '851-5160', 19000.00, NULL, '15-sep-2000', 2, 1);
INSERT INTO Faculty VALUES ('Leo', 'Dubray', '885-1492', 17000.00, NULL, '15-sep-2001', 8, 2);
INSERT INTO Faculty VALUES ('Michele', 'Malott', '885-1395', 6000.00, NULL, '15-sep-2005', 8, 2);

INSERT INTO ProfRank VALUES ('Instructor', 00000.00, 10000.00);
INSERT INTO ProfRank VALUES ('Assistant Professor', 10000.00, 20000.00);
INSERT INTO ProfRank VALUES ('Associate Professor', 20000.00, 30000.00);
INSERT INTO ProfRank VALUES ('Professor', 30000.00, 40000.00);

INSERT INTO Student VALUES ('Paul', 'Scott', '882-1002', 1);
INSERT INTO Student VALUES ('Chris', 'Ambiel', '883-1312', 13);
INSERT INTO Student VALUES ('Jake', 'Brownson', '882-3424', 5);
INSERT INTO Student VALUES ('Farhad', 'Shakiba', '884-1231', 5);
INSERT INTO Student VALUES ('Allan', 'Snippen', '882-2342', 5);
INSERT INTO Student VALUES ('Michael', 'Hart', '882-5464', 12);
INSERT INTO Student VALUES ('Jonathan', 'Thibeau', '883-2342', 12);
INSERT INTO Student VALUES ('Alberto', 'Martinez', '882-8796', 2);
INSERT INTO Student VALUES ('Jeanie', 'King', '891-1234', 3);
INSERT INTO Student VALUES ('Jason', 'Richards', '882-3456', 3);
INSERT INTO Student VALUES ('Justin', 'Royse', '885-1111', 3);
INSERT INTO Student VALUES ('Xinger', 'Yu', '883-2322', 2);
INSERT INTO Student VALUES ('Storm', 'Dain', '885-3212', 13);
INSERT INTO Student VALUES ('TJ', 'Atterberry', '883-1231', 12);
INSERT INTO Student VALUES ('Roscoe', 'Casita', '883-1213', 4);
INSERT INTO Student VALUES ('Shad', 'Cole', '882-3232', 4);
INSERT INTO Student VALUES ('Luke', 'Goodale', '885-1002', 4);
INSERT INTO Student VALUES ('Kyle', 'Spencer', '885-1012', 4);
INSERT INTO Student VALUES ('Ed', 'Hudson', '882-1878', 7);
INSERT INTO Student VALUES ('Scott', 'Ore', '883-9303', 7);
INSERT INTO Student VALUES ('Ryan', 'McCarty', '884-1922', 6);
INSERT INTO Student VALUES ('Devan', 'Stormont', '883-1999', 4);
INSERT INTO Student VALUES ('Jeffrey', 'Bernt', '882-9999', 8);
INSERT INTO Student VALUES ('Chris', 'Gheen', '883-3434', 8);
INSERT INTO Student VALUES ('Cody', 'Zuschlag', '885-9654', 9);
INSERT INTO Student VALUES ('Kevin', 'Wong', '883-1233', 9);
INSERT INTO Student VALUES ('Andrew', 'Wilson', '885-2322', 10);
INSERT INTO Student VALUES ('Jesse', 'Stafford', '882-2328', 10);
INSERT INTO Student VALUES ('Kevin', 'Roberts', '882-1765', 14);
INSERT INTO Student VALUES ('Tim', 'Clark', '882-8888', 2);

INSERT INTO StudentMajor (Studentid, Majorid) VALUES (1, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (2, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (3, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (3, 2);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (4, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (4, 2);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (5, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (5, 2);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (6, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (7, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (8, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (9, 2);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (10, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (10, 2);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (11, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (11, 2);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (12, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (13, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (14, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (15, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (16, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (17, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (18, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (19, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (20, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (21, 2);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (22, 1);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (23, 3);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (24, 3);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (25, 3);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (26, 3);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (27, 4);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (28, 4);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (29, 4);
INSERT INTO StudentMajor (Studentid, Majorid) VALUES (30, 1);

SELECT F.FirstName, F.LastName, F.Salary
FROM Faculty AS F
WHERE F.Salary > 20000
ORDER BY F.Salary DESC;

SELECT F.FirstName, F.LastName, F.Salary
FROM Faculty AS F
WHERE F.Salary < 10000 OR F.Salary > 30000
ORDER BY F.Salary DESC;

SELECT F.FirstName + ' ' + F.LastName AS [Name], F.Phone, F.Hiredate
FROM Faculty AS F
WHERE F.Hiredate BETWEEN '1999-09-01' AND '2003-09-01'
ORDER BY F.Hiredate;

SELECT * FROM Faculty AS F
WHERE F.DeptId IN (1,2,4);

SELECT F.FacultyId, F.LastName, F.Salary AS [Current Salary], FLOOR((F.Salary * 0.15) + F.Salary) AS [Projected Salary]
From Faculty AS F;

SELECT F.LastName + ' earns $' + CONVERT(varchar, cast(F.Salary as money),1) + 
' but wants $' + CONVERT(varchar, cast((F.Salary * 5.0) as money),1)
FROM Faculty AS F;

SELECT * FROM StudentMajor

--SELECT FirstName, LastName FROM Faculty
--ORDER BY LastName;
--SELECT FirstName + ' ' + LastName FROM Faculty;
--SELECT FirstName + ' ' + LastName AS [Faculty Full Name] FROM Faculty
--ORDER BY [Faculty Full Name];
--SELECT F.FirstName, F.LastName FROM Faculty as F
--ORDER BY F.LastName;
