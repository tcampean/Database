USE GameDevCompany
GO


INSERT Department VALUES(1,'Music')

INSERT Department VALUES(2,'VFX')

INSERT Department VALUES(3,'Storytelling')

INSERT Department VALUES(4,'Art')

INSERT Department VALUES(5,'Codewriters')


INSERT GameDeveloper VALUES(1,'Andrei','Popescu',3000,1)

INSERT GameDeveloper VALUES(2,'Andreea','Popescu',4000,1)

INSERT GameDeveloper VALUES(3,'Dan','Cristian',3420,4)

INSERT GameDeveloper VALUES(4,'Adrian','Leonte',6002,3)

INSERT GameDeveloper VALUES(5,'Mihai','Alexandru',3400,2)

INSERT GameDeveloper VALUES(6,'Ion','Grebla',2000,5)

INSERT GameDeveloper VALUES(7,'Alexandra','Petrisor',4500,5)

INSERT GameDeveloper VALUES(8,'Alex','Man',3200,4)

INSERT GameDeveloper Values(9,'Lucian','Dan',2340,3)

INSERT GameDeveloper VALUES(10,'Maria','Bucur',4323,2)

INSERT GameDeveloper VALUES(11,'Denisa','Suciu',2900,2)

INSERT GameDeveloper VALUES(12,'Andrei','Andrei',6000,4)

/* Invalid
INSERT GameDeveloper VALUES(2,'Maria','Adriana',3000,4)
*/

INSERT DeveloperTeam VALUES(1,'The Gamers')
INSERT DeveloperTeam VALUES(2,'100 Years')
INSERT DeveloperTeam VALUES(3,'Crafters')
INSERT DeveloperTeam VALUES(4,'Fun Wizards')
/*INSERT DeveloperTeam VALUES(3,'Falmea') */

INSERT GameDevTeam VALUES(1,1)
INSERT GameDevTeam VALUES(2,1)
INSERT GameDevTeam VALUES(1,4)
INSERT GameDevTeam VALUES(3,2)
INSERT GameDevTeam VALUES(4,4)
INSERT GameDevTeam VALUES(5,3)
INSERT GameDevTeam VALUES(6,2)
INSERT GameDevTeam VALUES(7,4)
INSERT GameDevTeam VALUES(8,1)
INSERT GameDevTeam VALUES(9,3)
INSERT GameDevTeam VALUES(10,4)
INSERT GameDevTeam VALUES(11,2)
INSERT GameDevTeam VALUES(5,2)
INSERT GameDevTeam VALUES(7,1)
INSERT GameDevTeam VALUES(6,4)
INSERT GameDevTeam VALUES(9,1)
/*INSERT GameDevTeam VALUES(2,1) */


INSERT Game VALUES(1,'Irate Pirate',1)
INSERT Game VALUES(2,'Guardian',4)
INSERT Game Values(3,'Hero101',2)
INSERT Game VALUES(4,'Moblie Adventurers',3)
INSERT Game VALUES(5,'Teleport',1)
INSERT Game VALUES(6,'Astrophobia',3)
INSERT Game VALUES(7,'Saga of Heroes',2)
INSERT Game VALUES(8,NULL ,2)
INSERT Game VALUES(9,NULL,3)
INSERT Game VALUES(10,NULL,2)
INSERT Game VALUES(11,NULL,3)
/*INSERT Game VALUES(3,'Circle of Thorns',2)*/

INSERT TesterGroup VALUES(1,'Gamebreakers')
INSERT TesterGroup VALUES(2,'Bluecloud')
INSERT TesterGroup Values(3,'Inspect Group')

INSERT GameTester VALUES(1,'Larisa','Marginean',5,1)
INSERT GameTester VALUES(2,'Maria','Andreea',1,2)
INSERT GameTester VALUES(3,'Marian','Avram',1,3)
INSERT GameTester VALUES(4,'Andreea','Avram',10,2)
INSERT GameTester VALUES(5,'Mihai','Mihaly',8,1)
INSERT GameTester VALUES(6,'Mihai','Avram',12,3)
INSERT GameTester VALUES(7,'Alex','Andrei',6,1)
INSERT GameTester VALUES(8,'Ovidiu','Pop',9,1)
INSERT GameTester VALUES(9,'Andrei','Mariu',2,2)
INSERT GameTester VALUES(10,'Catalin','Horatiu',1,3)
INSERT GameTester VALUES(11,'Ana','Maria',15,3)

INSERT TestingGame VALUES(1,7)
INSERT TestingGame VALUES(2,3)
INSERT TestingGame VALUES(3,4)
INSERT TestingGame VALUES(3,5)
INSERT TestingGame VALUES(4,1)
INSERT TestingGame VALUES(5,2)
INSERT TestingGame VALUES(6,5)
INSERT TestingGame VALUES(6,6)
INSERT TestingGame VALUES(7,6)
INSERT TestingGame VALUES(8,2)
INSERT TestingGame VALUES(9,7)
INSERT TestingGame VALUES(10,4)
INSERT TestingGame VALUES(10,7)
INSERT TestingGame VALUES(10,2)
/*INSERT TestingGame VALUES(9,7)*/


INSERT Genre VALUES(1,'RPG')
INSERT Genre VALUES(2,'MMORPG')
INSERT Genre VALUES(3,'Action')
INSERT Genre VALUES(4,'Shooter')
INSERT Genre VALUES(5,'MOBA')


INSERT GameGenre VALUES(1,2)
INSERT GameGenre VALUES(1,3)
INSERT GameGenre VALUES(2,4)
INSERT GameGenre VALUES(2,3)
INSERT GameGenre VALUES(3,1)
INSERT GameGenre VALUES(4,5)
INSERT GameGenre VALUES(5,2)
INSERT GameGenre VALUES(5,4)
INSERT GameGenre VALUES(6,1)
INSERT GameGenre VALUES(6,2)
INSERT GameGenre VALUES(7,3)
INSERT GameGenre VALUES(7,5)

