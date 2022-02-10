USE GameDevCompany
GO

CREATE TABLE DepartmentCOPY
(DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(20))

CREATE TABLE GameDeveloperCOPY
(DevID INT PRIMARY KEY,
DevFName VARCHAR(20),
DevLName VARCHAR(20),
Salary INT,
DepartmentID INT FOREIGN KEY REFERENCES DepartmentCOPY(DepartmentID),
)

CREATE TABLE DeveloperTeamCOPY
(TID INT PRIMARY KEY,
TName VARCHAR(20)
)

CREATE TABLE GameDevTeamCOPY
(DevID INT REFERENCES GameDeveloperCOPY(DevID),
TID INT REFERENCES DeveloperTeamCOPY(TID)
PRIMARY KEY(DevID,TID)

CREATE TABLE GameCOPY
(GID INT PRIMARY KEY,
GName VARCHAR(20)
)

CREATE TABLE GenreCOPY
(GenreID INT PRIMARY KEY,
GenreName VARCHAR(20)
)

CREATE TABLE GameGenreCOPY
(GID INT REFERENCES GameCOPY(GID),
GenreID INT REFERENCES GenreCOPY(GenreID)
)


Select *
from TestTables

DELETE FROM Views

SELECT *
FROM Views


INSERT Views VALUES('TesterExperience')

INSERT Tests VALUES('Test1')
INSERT Tests VALUES('Test2')

INSERT TestTables VALUES(1,3,1000,1)
INSERT TestTables VALUES(1,2,1000,2)
INSERT TestTables VALUES(1,4,1000,3)


INSERT TestTables VALUES(2,6,5000,1)
INSERT TestTables VALUES(2,5,5000,2)
INSERT TestTables VALUES(2,7,5000,3)

UPDATE TestTables
SET NoOfRows = 1000
WHERE NoOfRows = 20


Select * from TestTables

CREATE VIEW vDevsHigherThanAvg
AS
	Select DevFName
	from GameDeveloperCOPY
	WHERE Salary >ANY(Select AVG(Salary)
					FROM GameDeveloperCOPY
					)

CREATE VIEW vDevsWithOneTeam AS
Select DevFName,DevLName,DepartmentID
from GameDeveloperCOPY
WHERE DevID = ANY(Select DevID
					from GameDevTeamCOPY
					GROUP BY DevID
					HAVING COUNT(DevID) = 1)


CREATE VIEW vDevsWithNoTeam AS
Select GameDeveloperCOPY.DevID, DevFName, DevLName, Salary, DepartmentID, DeveloperTeamCOPY.TName
from GameDeveloperCOPY LEFT JOIN GameDevTeamCOPY on GameDeveloperCOPY.DevID = GameDevTeamCOPY.DevID
					LEFT JOIN  DeveloperTeamCOPY on DeveloperTeamCOPY.TID = GameDevTeamCOPY.TID	
WHERE TName IS NULL

CREATE VIEW vGamesWithDigitOne AS
SELECT GName
FROM GameCOPY
WHERE GName LIKE '%1%'

CREATE VIEW vGamesWithGenres AS
SELECT GName
FROM GameCOPY INNER JOIN GameGenreCOPY on GameCOPY.GID = GameGenreCOPY.GID
WHERE GameGenreCOPY.GenreID BETWEEN 200 AND 3000

CREATE VIEW vGamesWithOneGenre AS
Select GName
from GameCOPY
WHERE GID = ANY(Select GID
					from GameGenreCOPY
					GROUP BY GID
					HAVING COUNT(GID) = 1)




DROP VIEW vDevsHigherThanAvg
DROP VIEW vDevsWithOneTeam
DROP VIEW vDevsWithNoTeam

INSERT Views VALUES('vDevsHigherThanAvg')
INSERT Views VALUES('vDevsWithOneTeam')
INSERT Views VALUES('vDevsWithNoTeam')
INSERT Views VALUES('vGamesWithDigitOne')
INSERT Views VALUES('vGamesWithGenres')
INSERT Views VALUES('vGamesWithOneGenre')

UPDATE Views
SET Name = 'vGamesWithOneGenre'
WHERE Name = 'vGameWithOneGenre'

INSERT TestViews VALUES(1,12)
INSERT TestViews VALUES(1,13)
INSERT TestViews VALUES(1,14)
INSERT TestViews VALUES(2,15)
INSERT TestViews VALUES(2,16)
INSERT TestViews VALUES(2,17)

DELETE FROM Views

Select *
from Views

Select *
from Tables

CREATE OR ALTER PROC uspInsertValues @table VARCHAR(20), @rows INT
AS
	DECLARE @counter INT
	SET @counter = 1
	WHILE @counter <= @rows
	BEGIN
		IF @table = 'GameDeveloperCOPY'
		BEGIN
				DECLARE @dev_id INT
				DECLARE @dev_dep INT
				DECLARE @dev_salary INT
				SET @dev_id = @counter
				SET @dev_dep = (SELECT FLOOR(RAND()*5) + 1)
				SET @dev_salary = (SELECT FLOOR(RAND()*(6001 - 3000)) + 3000)
				INSERT GameDeveloperCOPY VALUES (@dev_id,'Marian','Mihai',@dev_salary,@dev_dep)
		END

		IF @table = 'DeveloperTeamCOPY'
		BEGIN
				DECLARE @teamName VARCHAR(20)
				SET @teamName = 'Team'
				SET @teamName = @teamName + CAST(@counter as varchar(10))
				INSERT DeveloperTeamCOPY VALUES (@counter,@teamName)
			
		END

		IF @table = 'GameDevTeamCopy'
		BEGIN
			DECLARE @assignedTeam INT
			DECLARE @devss INT
			SET @assignedTeam = (SELECT FLOOR(RAND()*(SELECT MAX(TID) FROM DeveloperTeamCOPY))+ 1)
			SET @devss = (SELECT FLOOR(RAND()*(SELECT MAX(DevID) FROM GameDeveloperCOPY))+ 1)
			BEGIN TRY
			INSERT GameDevTeamCOPY VALUES(@devss,@assignedTeam)
			END TRY
			BEGIN CATCH
			SET @counter = @counter - 1
			END CATCH
		END

		IF @table = 'GameCopy'
		BEGIN
				DECLARE @gameName VARCHAR(20)
				SET @gameName = 'Game'
				SET @gameName = @gameName + CAST(@counter as varchar(10))
				INSERT GameCOPY VALUES (@counter,@gameName)
		END

		IF @table = 'GenreCOPY'
		BEGIN
				DECLARE @GenreName VARCHAR(20)
				SET @GenreName = 'Game'
				SET @GenreName = @GenreName + CAST(@counter as varchar(10))
				INSERT GenreCOPY VALUES (@counter,@GenreName)
		END

		IF @table = 'GameGenreCopy'
		BEGIN
				DECLARE @assignedGenre INT
				DECLARE @gamee INT
				SET @assignedGenre = (SELECT FLOOR(RAND()*(SELECT MAX(GenreID) FROM GenreCOPY))+ 1)
				SET @gamee = (SELECT FLOOR(RAND()*(SELECT MAX(GID) FROM GameCOPY))+ 1)
				BEGIN TRY
				INSERT GameGenreCOPY VALUES(@gamee,@assignedGenre)
				END TRY
				BEGIN CATCH
				SET @counter = @counter - 1
				END CATCH
		END

	SET @counter = @counter + 1
	END


CREATE OR ALTER PROC runTest @testID int
AS
	DECLARE @currentPos INT
	DECLARE @endingPos INT
	SET @currentPos = 1
	SET @endingPos = (SELECT MAX(Position) FROM TestTables WHERE TestID = @testID)
	
	WHILE @currentPos <= @endingPos
	BEGIN
		DECLARE @tableName VARCHAR(20)
		SET @tableName = (SELECT Name FROM Tables WHERE TableID = (SELECT TableID FROM TestTables WHERE Position = @currentPos AND TestID = @testID))
		DECLARE @deleteTable VARCHAR(30)
		SET @deleteTable = 'DELETE FROM ' + @tableName
		EXEC (@deleteTable)
		SET @currentPos = @currentPos + 1
	END

	SET @currentPos = @endingPos

	DECLARE @startTest DATETIME
	DECLARE @endTest DATETIME
	DECLARE @startTable DATETIME
	DECLARE @endTable DATETIME
	DECLARE @startView DATETIME
	DECLARE @endView DATETIME
	DECLARE @testRunID INT
	DECLARE @tableID INT

	SET @startTest = GETDATE()
	DECLARE @testDesc VARCHAR(10)
	SET @testDesc = (SELECT Name FROM Tests WHERE @testID = TestID)
	INSERT TestRuns VALUES(@testDesc,@startTest,@endTest)
	SET @testRunID = (SELECT MAX(TestRunID) FROM TestRuns)
	WHILE @currentPos >= 1
	BEGIN
		SET @tableName = (SELECT Name FROM Tables WHERE TableID = (SELECT TableID FROM TestTables WHERE Position = @currentPos AND TestID = @testID))
		DECLARE @nrRows INT
		SET @nrRows = (SELECT NoOfRows FROM TestTables WHERE Position = @currentPos AND TestID = @testID)
		SET @startTable = GETDATE()
		EXEC uspInsertValues @tableName,@nrRows
		SET @endTable = GETDATE()
		SET @tableID = (SELECT TableID FROM Tables WHERE Name = @tableName)
		INSERT TestRunTables VALUES(@testRunID,@tableID,@startTable,@endTable)
		SET @currentPos = @currentPos - 1
	END
	
	DECLARE @select VARCHAR(50)
	DECLARE @viewName VARCHAR(20)
	DECLARE @viewID INT
	DECLARE viewNameCursor CURSOR FOR
	SELECT ViewID,Name
	FROM Views
	WHERE ViewID IN (SELECT ViewID FROM TestViews WHERE TestID = @testID)

	OPEN viewNameCursor
	FETCH viewNameCursor INTO @viewID,@viewName
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @select = 'SELECT * FROM ' + @viewName
		SET @startView = GETDATE()
		EXEC(@select)
		SET @endView = GETDATE()
		INSERT TestRunViews VALUES(@testRunID,@viewID,@startView,@endView)
		FETCH viewNameCursor INTO @viewID,@viewName
	END

	CLOSE viewNameCursor
	DEALLOCATE viewNameCursor

	SET @endTest = GETDATE()


	UPDATE TestRuns
	SET EndAT = @endTest
	WHERE TestRunID = @testRunID


EXEC runTest 1
EXEC runTest 2
EXEC runTest 3

select *
from GameDeveloperCOPY

Select *
from DeveloperTeamCOPY
USE GameDevCompany
GO
select *
from GameDevTeamCOPY

DELETE FROM GameDeveloperCOPY
DELETE FROM DeveloperTeamCOPY

SELECT * FROM TestViews

INSERT TestViews VALUES (1,12)
INSERT TestViews VALUES (1,13)
INSERT TestViews VALUES (1,14)


SELECT * FROM TestRuns
SELECT * FROM TestRunTables
SELECT * FROM TestRunViews

SELECT * FROM Tables
SELECT * FROM Tests
SELECT * FROM TestViews

SELECT * FROM TestTables

INSERT Tests VALUES('Test3')


INSERT TestTables VALUES(3,3,7000,1)
INSERT TestTables VALUES(3,2,5000,2)
INSERT TestTables VALUES(3,4,5000,3)

	