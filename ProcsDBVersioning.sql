USE GameDevCompany
GO

CREATE PROCEDURE uspAddSalaryToTesters
AS
	ALTER TABLE GameTester
	ADD Salary INT

EXEC uspAddSalaryToTesters

CREATE PROC uspRemoveSalaryOfTesters
AS
	ALTER TABLE GameTester
	DROP COLUMN Salary

EXEC uspRemoveSalaryOfTesters

CREATE OR ALTER PROC uspAddGameDevScore
AS
	CREATE TABLE GameDevScore
	(ScoreID INT NOT NULL,
	DevID INT NOT NULL,
	Score INT)

CREATE PROC uspRemoveGameDevScore
AS
	DROP TABLE GameDevScore


EXEC uspRemoveGameDevScore

CREATE OR ALTER PROC uspAddPKGameDevScore
AS
	ALTER TABLE GameDevScore
	ADD CONSTRAINT PK_ScoreID PRIMARY KEY (ScoreID)

EXEC uspAddPKGameDevScore

DROP TABLE GameDevScore

CREATE OR ALTER PROC uspRemovePKGameDevScore
AS
	ALTER TABLE GameDevScore
	DROP CONSTRAINT PK_ScoreID

EXEC uspRemovePKGameDevScore


CREATE OR ALTER PROC uspDefaultTesterSalary
AS
	ALTER TABLE GameTester
	ADD CONSTRAINT df_GTSalary
	DEFAULT 3000 FOR Salary

EXEC uspDefaultTesterSalary

CREATE OR ALTER PROC uspRemoveDefaultTesterSalary
AS
	ALTER TABLE GameTester
	DROP CONSTRAINT df_GTSalary

EXEC uspRemoveDefaultTesterSalary


CREATE OR ALTER PROC uspAddCKGameDevScore
AS
	ALTER TABLE GameDevScore
	ADD CONSTRAINT CK_GameDevScore PRIMARY KEY(ScoreID,DevID)

EXEC uspAddCKGameDevScore

CREATE OR ALTER PROC uspRemoveCKGameDevScore
AS
	ALTER TABLE GameDevScore
	DROP CONSTRAINT CK_GameDevScore

EXEC uspRemoveCKGameDevScore

CREATE OR ALTER PROC uspAddFKGameDevScore
AS
	ALTER TABLE GameDevScore
	ADD CONSTRAINT FK_GameDevScore
	FOREIGN KEY (DevID) REFERENCES GameDeveloper(DevID)

CREATE OR ALTER PROC uspRemoveFKGameDevScore
AS
	ALTER TABLE GameDevScore
	DROP CONSTRAINT FK_GameDevScore

CREATE OR ALTER PROC uspSetDevScoreFloat
AS
	ALTER TABLE GameDevScore
	ALTER COLUMN Score FLOAT

EXEC uspSetDevScoreFloat

CREATE OR ALTER PROC uspSetDevScoreInt
AS
	ALTER TABLE GameDevScore
	ALTER COLUMN Score INT

EXEC uspSetDevScoreInt
	

CREATE TABLE CurrentVersion
(currentVersion INT
)


INSERT CurrentVersion VALUES(1)

CREATE TABLE DataBaseVersions
(
VersionID INT PRIMARY KEY,
uspName VARCHAR(100),
ruspName VARCHAR(100),

)

INSERT DataBaseVersions VALUES(1,'uspAddSalaryToTesters','uspRemoveSalaryOfTesters')
INSERT DataBaseVersions VALUES(2,'uspAddGameDevScore','uspRemoveGameDevScore')
INSERT DataBaseVersions VALUES(3,'uspAddPKGameDevScore','uspRemovePKGameDevScore')
INSERT DataBaseVersions VALUES(4,'uspAddFKGameDevScore', 'uspRemoveFKGameDevScore')
INSERT DataBaseVersions VALUES(5,'uspDefaultTesterSalary','uspRemoveDefaultTesterSalary')
INSERT DataBaseVersions VALUES(6,'uspRemovePKGameDevScore','uspAddPKGameDevScore')
INSERT DataBaseVersions VALUES(7,'uspAddCKGameDevScore','uspRemoveCKGameDevScore')
INSERT DataBaseVersions VALUES(8,'uspSetDevScoreFloat','uspSetDevScoreInt')


CREATE OR ALTER PROC uspDBVersion @version INT
AS
	
	IF @version < 0 OR @version > (Select MAX(VersionID) FROM DataBaseVersions)
	BEGIN 
		RAISERROR ('There is no such version.',10,1)
		RETURN
	END
	DECLARE @currentDBVersion INT
	SET @currentDBVersion = (Select TOP(1) currentVersion FROM CurrentVersion)

	DECLARE @ExeProcedure VARCHAR(100)
	IF(@currentDBVersion < @version)
		WHILE(@currentDBVersion < @version)
		BEGIN
			SET @currentDBVersion = @currentDBVersion +1
			SET @ExeProcedure = (Select uspName FROM DataBaseVersions WHERE @currentDBVersion = VersionID)
			exec(@ExeProcedure)
		END
	ELSE IF(@currentDBVersion > @version)
			WHILE(@currentDBVersion > @version)
			BEGIN
				SET @ExeProcedure = (Select ruspName FROM DataBaseVersions WHERE @currentDBVersion = VersionID)
				SET @currentDBVersion = @currentDBVersion -1
				exec(@ExeProcedure)
			END

	UPDATE CurrentVersion
	SET currentVersion = @version


EXEC uspDBVersion 5

select *
from GameTester

TRUNCATE TABLE DataBaseVersions

select *
from DataBaseVersions

Select *
from CurrentVersion

UPDATE CurrentVersion
SET currentVersion = 8

select *
from GameDevScore

				
INSERT GameTester VALUES(13,'Mariana','Maier',3,3,DEFAULT)

