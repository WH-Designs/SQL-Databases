--Assignment 7
--Wyatt Haak

USE College;

--Part 1

--1
IF OBJECT_ID('spInsertDepartment') IS NOT NULL
	DROP PROC spInsertDepartment
GO

CREATE PROC spInsertDepartment
	@DepartmentName VARCHAR(255)
AS
	INSERT INTO Departments (DepartmentName)
	VALUES(@DepartmentName);
GO

EXEC spInsertDepartment 'Criminal Justice';
GO

SELECT * FROM Departments

--2
IF OBJECT_ID('fnStudentUnits') IS NOT NULL
	DROP FUNCTION fnStudentUnits
GO

CREATE FUNCTION fnStudentUnits (@StudentID INT)
	RETURNS INT
BEGIN

DECLARE @TotalStudentUnits INT;

SELECT @TotalStudentUnits = SUM(C.CourseUnits)
FROM StudentCourses AS SC
INNER JOIN Courses AS C 
	ON SC.CourseID = C.CourseID
WHERE SC.StudentID = @StudentID;

RETURN @TotalStudentUnits

END;
GO

SELECT SC.StudentID, 
C.CourseNumber, 
C.CourseUnits, 
dbo.fnStudentUnits(SC.StudentID) AS StudentUnits 
FROM StudentCourses AS SC
INNER JOIN Courses AS C 
	ON SC.CourseID = C.CourseID

--3
IF OBJECT_ID('fnTuition') IS NOT NULL
	DROP FUNCTION fnTuition
GO

CREATE FUNCTION fnTuition (@StudentID INT)
	RETURNS MONEY
BEGIN

	DECLARE @TotalStudentTuition MONEY;
	DECLARE @TotalStudentUnits INT;

	SELECT @TotalStudentTuition = IIF(dbo.fnStudentUnits(@StudentID) > 9,
									  T.FullTimeCost +(dbo.fnStudentUnits(@StudentID)) * T.PerUnitCost,
									  T.PartTimeCost + (dbo.fnStudentUnits(@StudentID) * T.PerUnitCost))
	FROM Students AS S CROSS JOIN Tuition T
	WHERE S.StudentID = @StudentID

	RETURN @TotalStudentTuition

END;
GO

SELECT S.StudentID, 
	   dbo.fnStudentUnits(S.StudentID) AS TotalUnits,
	   dbo.fnTuition(S.StudentID) AS Tuition
FROM Students AS S

WHERE dbo.fnStudentUnits(S.StudentID) > 0;

--4
IF OBJECT_ID('spInsertInstructor') IS NOT NULL
	DROP PROC spInsertInstructor
GO

CREATE PROC spInsertInstructor
	@LastName VARCHAR(64),
	@FirstName VARCHAR(64),
	@Status   CHAR(1),
	@DepartmentChairman BIT,
	@AnnualSalary MONEY,
	@DepartmentID INT
AS
	IF @AnnualSalary < 0
		THROW 50001, 'Annual Salary must be >= 0', 1;

	INSERT INTO Instructors
	(LastName, FirstName, [Status], DepartmentChairman, HireDate, AnnualSalary, DepartmentID)
	VALUES
	(@LastName, @FirstName, @Status, @DepartmentChairman, GETDATE(), @AnnualSalary, @DepartmentID)
GO

--EXEC dbo.spInsertInstructor 'Cordova', 'Luke', 'F', 0, -40000, 1;
EXEC dbo.spInsertInstructor 'Morgan', 'Becka', 'P', 0, 50000, 1;

SELECT * FROM Instructors

--5
IF OBJECT_ID('spUpdateInstructor') IS NOT NULL
	DROP PROC spUpdateInstructor
GO

CREATE PROC spUpdateInstructor
	@InstructorID INT,
	@AnnualSalary MONEY
AS
	IF @AnnualSalary < 0
		THROW 50001, 'AnnualSalary must be a positive number', 1;
	UPDATE Instructors
	SET AnnualSalary = @AnnualSalary
	WHERE InstructorID = @InstructorID

GO

EXEC dbo.spUpdateInstructor 6, 20000

SELECT * FROM Instructors

--6
IF OBJECT_ID('Instructor_UPDATE') IS NOT NULL
	DROP TRIGGER Instructor_UPDATE
GO

CREATE TRIGGER Instructor_UPDATE
	ON Instructors AFTER UPDATE
AS 

IF (SELECT AnnualSalary FROM inserted) >= 120000
	THROW 50001, 'The annual salary must be < 120K', 1;
IF (SELECT AnnualSalary FROM inserted) < 0
	THROW 50001, 'The annual salary must be > 0', 1;

UPDATE Instructors
SET AnnualSalary = (SELECT AnnualSalary FROM inserted) * 12
WHERE InstructorID = (SELECT InstructorID FROM inserted);

GO

UPDATE Instructors
SET AnnualSalary = 5000
WHERE InstructorID = 2;

SELECT * FROM Instructors

--7
IF OBJECT_ID('Instructor_INSERT') IS NOT NULL
	DROP TRIGGER Instructor_INSERT
GO

CREATE TRIGGER Instructor_INSERT
	ON Instructors AFTER INSERT
AS 

IF (SELECT HireDate FROM inserted) IS NOT NULL
	THROW 50001, 'The hire date in that column is not null', 1;

UPDATE Instructors
SET HireDate = GETDATE()
WHERE HireDate IS NULL 

INSERT INTO Instructors
	(LastName, FirstName, [Status], DepartmentChairman, HireDate, AnnualSalary, DepartmentID)
VALUES
	('Waffles', 'Waffles2.0', 'P', 0, NULL, 20000, 2)

INSERT INTO Instructors
	(LastName, FirstName, [Status], DepartmentChairman, HireDate, AnnualSalary, DepartmentID)
VALUES
	('Wyatt', 'HAAK', 'P', 0, '2017-09-21', 20000, 2)

SELECT * FROM Instructors

--8
IF OBJECT_ID('InstructorsAudit') IS NOT NULL
	DROP TABLE InstructorsAudit
GO

CREATE TABLE InstructorsAudit (
	AuditID		INT		PRIMARY KEY IDENTITY,
	InstructorID int NOT NULL,
	LastName varchar(25) NOT NULL,
	FirstName varchar(25) NULL,
	[Status] char(1) NOT NULL,
	DepartmentChairman bit NOT NULL,
	HireDate date NULL,
	AnnualSalary money NOT NULL,
	DepartmentID int NOT NULL,
	DateUpdated		DATETIME	DEFAULT NULL
);
GO

IF OBJECT_ID('Instructor_UPDATE') IS NOT NULL
	DROP TRIGGER Instructor_UPDATE
GO

CREATE TRIGGER Instructor_UPDATE
	ON Instructors AFTER UPDATE
AS

INSERT INTO InstructorsAudit
		(InstructorID, LastName, FirstName, [Status], DepartmentChairman, HireDate, AnnualSalary, DepartmentID, DateUpdated)
VALUES(
		(SELECT InstructorID FROM deleted),
		(SELECT LastName FROM deleted),
		(SELECT FirstName FROM deleted),
		(SELECT [Status] FROM deleted),
		(SELECT DepartmentChairman FROM deleted),
		(SELECT HireDate FROM deleted),
		(SELECT AnnualSalary FROM deleted),
		(SELECT DepartmentID FROM deleted),
		GETDATE());

GO

UPDATE Instructors
SET HireDate = GETDATE()
WHERE InstructorID = 4

SELECT * FROM InstructorsAudit

--Part 2

--1
BEGIN TRAN;

DELETE FROM StudentCourses
WHERE StudentID = 10;

DELETE FROM Students
WHERE StudentID = 10;

IF @@ROWCOUNT > 1
BEGIN
	ROLLBACK TRAN
	PRINT 'Did not delete Student'
END
ELSE
BEGIN
	COMMIT TRAN;
END

SELECT * FROM Students

--2
BEGIN TRY
	BEGIN TRANSACTION
		INSERT Students
		VALUES('Smith', 'John', GETDATE(), NULL);

		DECLARE @StudentID INT;
		DECLARE @CourseID INT;

		SET @CourseID = 12;

		SET @StudentID = @@IDENTITY;

		INSERT StudentCourses
		VALUES(@StudentID, @CourseID);
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	THROW 50001, 'ERROR', 1;
	ROLLBACK TRANSACTION
END CATCH;

SELECT * FROM StudentCourses