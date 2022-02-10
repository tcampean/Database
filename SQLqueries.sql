USE GameDevCompany
GO


UPDATE GameDeveloper
SET Salary = 4000
WHERE Salary BETWEEN 2000 AND 3000 OR Salary >5500 AND DevLName IS NOT NULL AND DepartmentID IN(3,5) OR DevFName LIKE 'M%';

UPDATE Game
SET GName = 'Unnamed'
WHERE GName IS NULL OR GName LIKE '%1%' AND GID BETWEEN 3 AND 5 OR GID >=2 AND TID IN(1,4)

UPDATE GameTester
SET TGID = 2
WHERE TGID IS NULL OR GTExperience <= 1 OR GTFName LIKE 'M%' OR GTExperience BETWEEN 3 AND 6 OR GTLName IN ('Avram','Mariu')

DELETE TestingGame
WHERE GTID IN(Select GTID 
			FROM GameTester 
			WHERE GTLName LIKE 'A%' AND GTExperience = 1 OR TGID IS NULL OR GTExperience BETWEEN 8 AND 10 AND TGID IN(2,3))

DELETE GameTester
WHERE GTLName LIKE 'A%' AND GTExperience = 1 OR TGID IS NULL OR GTExperience BETWEEN 8 AND 10 AND TGID IN(2,3)

Delete GameDevTeam
WHERE DevID IN (Select DevID 
				FROM GameDeveloper 
				WHERE DepartmentID IS NULL OR (DevFName LIKE 'L%' OR DepartmentID =4) AND Salary BETWEEN 2000 and 3500 OR DevLName IN ('Popescu','Pop')) 


DELETE GameDeveloper
WHERE DepartmentID IS NULL OR (DevFName LIKE 'L%' OR DepartmentID =4) AND Salary BETWEEN 2000 and 3500 OR DevLName IN ('Popescu','Pop') 


Select DepartmentID
from Department
WHERE DepartmentID = 4 or DepartmentName = 'Music'
UNION
Select DepartmentID
from GameDeveloper
WHERE DevFName LIKE 'A%' AND DepartmentID IS NOT NULL



Select GName
from Game
WHERE TID = 1 OR TID = 2
UNION ALL
Select GName
from Game
WHERE TID = 2 OR TID = 4




Select GName
from Game INNER JOIN GameGenre on Game.GID = GameGenre.GID
			INNER JOIN Genre on GameGenre.GenreID = Genre.GenreID
WHERE GenreName in ('MMORPG','RPG')
INTERSECT
Select GName
from Game INNER JOIN GameGenre on Game.GID = GameGenre.GID
			INNER JOIN Genre on GameGenre.GenreID = Genre.GenreID
WHERE GenreName in ('Action')

Select DevFName,DevLName
from GameDeveloper GD INNER JOIN GameDevTeam GT on GD.DevID = GT.DevID
INNER JOIN DeveloperTeam DT on GT.TID = DT.TID
WHERE DT.TID IN(1,2)
INTERSECT
Select DevFName,DevLName
from GameDeveloper GD INNER JOIN GameDevTeam GT on GD.DevID = GT.DevID
INNER JOIN DeveloperTeam DT on GT.TID = DT.TID
WHERE DT.TID IN(2,3)


Select *
FROM GameDeveloper
WHERE Salary >= 4000
EXCEPT
Select *
from GameDeveloper
WHERE DepartmentID NOT IN(1,2)

Select Game.GName,Genre.GenreName
from Game INNER JOIN GameGenre on Game.GID = GameGenre.GID
			INNER JOIN Genre on GameGenre.GenreID = Genre.GenreID
EXCEPT
Select Game.GName,Genre.GenreName
from Game INNER JOIN GameGenre on Game.GID = GameGenre.GID
			INNER JOIN Genre on GameGenre.GenreID = Genre.GenreID
WHERE GenreName NOT IN ('Action','MMORPG')
ORDER BY Game.GName


Select *
FROM GameDeveloper
WHERE DepartmentID in(Select DepartmentID FROM Department WHERE DepartmentID BETWEEN 3 AND 5)


Select GameDeveloper.DevID, DevFName, DevLName, Salary, DepartmentID, DeveloperTeam.TName
from GameDeveloper LEFT JOIN GameDevTeam on GameDeveloper.DevID = GameDevTeam.DevID
					LEFT JOIN  DeveloperTeam on DeveloperTeam.TID = GameDevTeam.TID	
WHERE TName IS NULL
ORDER BY DevFName

Select GameTester.GTID, GTFName, GTLName, GName
from GameTester INNER JOIN TestingGame on GameTester.GTID = TestingGame.GTID
				INNER JOIN Game on TestingGame.GID = Game.GID 
				INNER JOIN GameGenre on GameGenre.GID = Game.GID
				INNER JOIN Genre on Genre.GenreID = GameGenre.GenreID
WHERE GenreName = 'Action' AND GName != 'Unnamed'
ORDER BY GTLName

Select TOP 5 Department.DepartmentID,DevFName,DevLName,Salary
from Department RIGHT JOIN GameDeveloper on Department.DepartmentID = GameDeveloper.DepartmentID
ORDER BY Salary DESC

Select TOP 3 GTID, GTFName,GTLName,GTExperience
from GameTester
order by GTExperience DESC

Select DevID,DevFName,DevLName,Salary * 12
from GameDeveloper

Select GTID,GTFName,GTLName,GTExperience * 4
from GameTester

Select DevID,DevFName,DevLName,Salary - (Select AVG(Salary) from GameDeveloper)
from GameDeveloper

Select *
FROM Game FULL JOIN GameGenre on Game.GID = GameGenre.GID FULL JOIN Genre
ON Genre.GenreID = GameGenre.GenreID
WHERE Genre.GenreID IS NULL or Game.GID IS NULL




Select *
FROM GameTester
WHERE GTID IN(Select TG.GTID 
			from TestingGame TG 
			WHERE TG.GID IN(Select GID 
							FROM Game 
							WHERE GID IN(Select Game.GID
										from Game INNER JOIN GameGenre on Game.GID = GameGenre.GID
										INNER JOIN Genre on GameGenre.GenreID = Genre.GenreID
										WHERE GenreName = 'Action'))) 

Select DepartmentName
From Department
WHERE EXISTS(Select DevFName 
			from GameDeveloper 
			WHERE GameDeveloper.DepartmentID = Department.DepartmentID AND DevFName LIKE 'A%');

Select GroupName
From TesterGroup
WHERE EXISTS(Select GTID 
			from GameTester 
			WHERE GameTester.TGID = TesterGroup.TGID AND GTExperience >10);

Select GName
FROM (Select GName 
		from Game INNER JOIN GameGenre on Game.GID = GameGenre.GID
					INNER JOIN Genre on GameGenre.GenreID = Genre.GenreID
		WHERE Genre.GenreName = 'MMORPG'
		) AS MMORPGGames
WHERE GName NOT IN('Unnamed')

Select GName
FROM (Select GName 
	from Game INNER JOIN GameGenre on Game.GID = GameGenre.GID
		INNER JOIN Genre on GameGenre.GenreID = Genre.GenreID
	WHERE Genre.GenreName = 'MMORPG' 
		AND Game.GID IN (Select Game.GID 
						FROM Game INNER JOIN GameGenre on Game.GID = GameGenre.GID 
						WHERE GameGenre.GenreID = 3)
	) AS MMORPGGames


Select COUNT(DevID) as Number_of_Devs,DepartmentID
from GameDeveloper
GROUP BY DepartmentID

Select SUM(Salary) as Salary,DepartmentID
from GameDeveloper
group by DepartmentID

Select GTFName
FROM GameTester
WHERE GTID IN(	Select GTID
				from TestingGame
				GROUP BY GTID
				HAVING COUNT(GTID) >=2
			)

Select DevFName,Salary
from GameDeveloper
GROUP BY Salary,DevFName
HAVING Salary >= (Select AVG(Salary)
					From GameDeveloper
					)

Select TName
from DeveloperTeam INNER JOIN GameDevTeam on DeveloperTeam.TID = GameDevTeam.TID
GROUP BY TName
HAVING COUNT(GameDevTeam.TID) = (Select Max(DevCount)
								FROM (Select COUNT(DevID) DevCount,TID
									FROM GameDevTeam
									group by TID) as Situation)

Select DevFName,DevLName,DepartmentID
from GameDeveloper
WHERE DevID = ANY(Select DevID
					from GameDevTeam
					GROUP BY DevID
					HAVING COUNT(DevID) = 1)

Select DevFName,DevLName,DepartmentID
from GameDeveloper
WHERE DevID IN(Select DevID
					from GameDevTeam
					GROUP BY DevID
					HAVING COUNT(DevID) = 1)


Select DevFName
from GameDeveloper
WHERE Salary >ANY(Select AVG(Salary)
					FROM GameDeveloper
					)



Select GroupName
from TesterGroup
WHERE TGID = ANY(Select TGID
				FROM GameTester
				GROUP BY TGID
				HAVING SUM(GTExperience)>10)

Select GroupName
from TesterGroup
WHERE TGID IN(Select TGID
				FROM GameTester
				GROUP BY TGID
				HAVING SUM(GTExperience)>10)




Select DevFName,DevLName
from GameDeveloper
WHERE Salary >= ALL(Select Salary
					from GameDeveloper
					where DepartmentID = 5
					)

Select DevFName,DevLName
from GameDeveloper
WHERE Salary >= (Select MAX(Salary)
					from GameDeveloper
					where DepartmentID = 5
					)

Select GTFName, GTLName
from GameTester
where GTExperience < ALL(Select GTExperience
						from GameTester
						WHERE TGID = 1)

Select GTFName, GTLName
from GameTester
where GTExperience < (Select MIN(GTExperience)
						from GameTester
						WHERE TGID = 1)




Select DISTINCT GameTester.GTID, GTFName, GTLName, GName
from GameTester INNER JOIN TestingGame on GameTester.GTID = TestingGame.GTID
				INNER JOIN Game on TestingGame.GID = Game.GID 
				INNER JOIN GameGenre on GameGenre.GID = Game.GID
				INNER JOIN Genre on Genre.GenreID = GameGenre.GenreID
WHERE GenreName IN( 'Action','Shooter') 
ORDER BY GTLName

Select DISTINCT GameDeveloper.DevID,DevFName,DevLName,DepartmentID
from GameDeveloper INNER JOIN GameDevTeam on GameDeveloper.DevID = GameDevTeam.DevID
				INNER JOIN DeveloperTeam on GameDevTeam.TID = DeveloperTeam.TID
				INNER JOIN Game ON DeveloperTeam.TID = Game.TID
				INNER JOIN GameGenre on GameGenre.GID = Game.GID
				INNER JOIN Genre on Genre.GenreID = GameGenre.GenreID
WHERE GenreName IN ('MMORPG','RPG')
ORDER BY GameDeveloper.DevID

Select Distinct GroupName
FROM TesterGroup INNER JOIN GameTester ON TesterGroup.TGID = GameTester.TGID
				INNER JOIN TestingGame ON GameTester.GTID =TestingGame.GTID
				INNER JOIN Game ON TestingGame.GID = Game.GID
WHERE Game.GName = 'Unnamed'






