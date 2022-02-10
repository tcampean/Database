USE GameDevCompany
GO

CREATE TABLE TableA
(AID INT PRIMARY KEY,
A2 INT NOT NULL UNIQUE,
A3 INT)


CREATE TABLE TableB
(BID INT PRIMARY KEY,
B2 INT,
B3 INT)

CREATE TABLE TableC
(CID INT PRIMARY KEY,
AID INT FOREIGN KEY REFERENCES TableA(AID),
BID INT FOREIGN KEY REFERENCES TableB(BID),
C2 INT)


CREATE OR ALTER PROC uspInsertIntoTables @table VARCHAR(20), @rows INT
AS
	DECLARE @counter INT
	SET @counter = 1
	WHILE @counter <= @rows
	BEGIN
		IF @table = 'A'
		BEGIN
				INSERT TableA VALUES(@counter,@counter,@counter)
		END

		IF @table = 'B'
		BEGIN
				DECLARE @varb INT
				SET @varb = (SELECT FLOOR(RAND()*1000)+ 1)
				INSERT TableB VALUES(@counter,@varb,@counter)
			
		END

		IF @table = 'C'
		BEGIN
			DECLARE @assignedA INT
			DECLARE @assignedB INT
			SET @assignedA = (SELECT FLOOR(RAND()*(SELECT MAX(AID) FROM TableA))+ 1)
			SET @assignedB = (SELECT FLOOR(RAND()*(SELECT MAX(BID) FROM TableB))+ 1)
			BEGIN TRY
			INSERT TableC VALUES(@counter,@assignedA,@assignedB,@counter)
			END TRY
			BEGIN CATCH
			SET @counter = @counter - 1
			END CATCH
		END
	SET @counter = @counter + 1
	END



exec uspInsertIntoTables 'A',2000
EXEC uspInsertIntoTables 'B',2000
EXEC uspInsertIntoTables 'C',4000

SELECT * FROM TableA
SELECT * FROM TableB
SELECT * FROM TableC

DROP TABLE TableC
DROP TABLE TableA
DROP TABLE TableB

CREATE OR ALTER VIEW vACView AS
SELECT TableA.AID
FROM TableA INNER JOIN TableC ON TableA.AID = TableC.AID
WHERE TableC.CID = 3

sp_helpindex TableA
sp_helpindex TableB
sp_helpindex TableC


-- Clustered Index Scan
SELECT * 
FROM TableA
WHERE A3 > 6
--ESC: 0.009

--Clustered Index Seek
SELECT * 
FROM TableA
WHERE AID > 33
--ESC: 0.009

--Nonclustered Index Scan
SELECT A2 
FROM TableA
--ESC: 0.007

--Nonclustered Index Seek
SELECT AID
FROM TableA 
WHERE A2 > 3
--ESC: 0.007

--Key Lookup
SELECT A3
FROM TableA
WHERE A2 = 5
--ESC: 0.006


SELECT BID
FROM TableB
WHERE B2 = 3
--Clustered Index Scan
--ESC: 0.009

CREATE NONCLUSTERED INDEX idx_tableB on TableB(B2)
DROP INDEX idx_tableB on TableB

--Nonclustered Index Seek
--ESC: 0.003

--Using a nonclustered index on the B2 column reduces the Estimated Subtree Cost from 0.0091857 to 0.0032850
--and the Estimated CPU Cost from 0.002357 to 0.00016


SELECT * FROM vACView
--Existing indexes are helpful
--Use of clustered index seek on CID in TableC to meet the condition CID = 3 and then a clustered
--index seek on AID in TableA to find the matching row. 