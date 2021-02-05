CREATE DATABASE ColonialJourney


	--01. DDL
/*--------------------------------------*/

CREATE TABLE Planets
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30) NOT NULL,
)

CREATE TABLE Spaceports
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	PlanetId INT FOREIGN KEY REFERENCES Planets(Id) NOT NULL
)

CREATE TABLE Spaceships
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	Manufacturer VARCHAR(30) NOT NULL,
	LightSpeedRate INT DEFAULT 0 NOT NULL 
)

CREATE TABLE Colonists
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	Ucn VARCHAR(10) UNIQUE NOT NULL,
	BirthDate DATETIME NOT NULL
)


CREATE TABLE Journeys
(
	Id INT PRIMARY KEY IDENTITY,
	JourneyStart DATETIME NOT NULL,
	JourneyEnd DATETIME NOT NULL,
	Purpose CHAR(11) CHECK (Purpose IN('Medical', 'Technical', 'Educational', 'Military')),
	DestinationSpaceportId INT FOREIGN KEY REFERENCES Spaceports(Id) NOT NULL,
	SpaceshipId INT FOREIGN KEY REFERENCES Spaceships(Id) NOT NULL
)

CREATE TABLE TravelCards
(
	Id INT PRIMARY KEY IDENTITY,
	CardNumber CHAR(10) CHECK(LEN(CardNumber) = 10) UNIQUE NOT NULL,
	JobDuringJourney CHAR(8) CHECK ((LEN(JobDuringJourney)= 8) AND (JobDuringJourney IN('Pilot', 'Engineer', 'Trooper', 'Cleaner', 'Cook'))),
	ColonistId INT FOREIGN KEY REFERENCES Colonists(Id) NOT NULL,
	JourneyId INT FOREIGN KEY REFERENCES Journeys(Id) NOT NULL
)


	--02. Insert
/*--------------------------------------*/

SELECT * FROM Planets

INSERT INTO Planets VALUES 
('Mars'),
('Earth'),
('Jupiter'),
('Saturn')

INSERT INTO Spaceships VALUES
('Golf', 'VW', 3),
('WakaWaka', 'Wakanda', 4),
('Falcon9', 'SpaceX', 1),
('Bed', 'Vidolov', 6)


	--3.Update
/*--------------------------------------*/

UPDATE Spaceships
	SET LightSpeedRate += 1
	WHERE Id BETWEEN 8 AND 12

	--4.Delete
/*--------------------------------------*/

SELECT * FROM Journeys

 
DELETE FROM TravelCards
	WHERE JourneyId IN(1,2,3)

DELETE FROM Journeys
	WHERE Id IN(1,2,3)

--SecondSolution
DELETE TOP(3) FROM Journeys


		--Section 3. Querying 
--5.Select all military journeys
/*--------------------------------------*/

SELECT	Id, FORMAT (JourneyStart, 'dd/MM/yyyy') as JS, FORMAT (JourneyEnd, 'dd/MM/yyyy') as JE
	FROM Journeys
	WHERE Purpose LIKE 'Military'
	ORDER BY JS

	SELECT * FROM Journeys
	ORDER BY JourneyStart

--6.Select all pilots
/*--------------------------------------*/

SELECT C.Id, C.FirstName + ' ' + C.LastName
	FROM Colonists AS C
	JOIN TravelCards AS T ON T.ColonistId = C.Id
	WHERE T.JobDuringJourney LIKE 'Pilot'
	ORDER BY C.Id ASC


--7.Count colonists
/*--------------------------------------*/

SELECT COUNT(J.Purpose)
	FROM Colonists AS C
	JOIN TravelCards AS T ON T.ColonistId = C.Id
	JOIN Journeys AS J ON J.Id = T.JourneyId
	WHERE J.Purpose LIKE 'Technical'
	GROUP BY J.Purpose
	
--8.Select spaceships with pilots younger than 30 years
/*--------------------------------------*/
--Extract from the database those spaceships, which have pilots, younger than 30 years old. In other words, 30 years from 01/01/2019. Sort the results alphabetically by spaceship name.

SELECT S.Name , S.Manufacturer
	FROM Colonists AS C
	JOIN TravelCards AS T ON T.ColonistId = C.Id
	JOIN Journeys AS J ON J.Id = T.JourneyId
	JOIN Spaceships AS S ON S.Id = J.SpaceshipId
	WHERE DATEDIFF(YEAR, C.BirthDate, '01/01/2019') < 30 AND T.JobDuringJourney = 'Pilot'
	ORDER BY S.Name


--9.Select all planets and their journey count
/*--------------------------------------*/
--Extract from the database all planets’ names and their journeys count. Order the results by journeys count, descending and by planet name ascending.

SELECT P.Name , COUNT(P.Name) AS [COUNT]
	FROM Journeys AS J
	JOIN Spaceports AS S ON S.Id = J.DestinationSpaceportId
	JOIN Planets AS P ON P.Id = S.PlanetId
	GROUP BY P.Name
	ORDER BY [COUNT] DESC, P.Name 


--10.Select Second Oldest Important Colonist
/*--------------------------------------*/
--Find all colonists and their job during journey with rank 2. Keep in mind that all the selected colonists with rank 2 must be the oldest ones. You can use ranking over their job during their journey.

SELECT K.JobDuringJourney, CONCAT(CO.FirstName,' ',CO.LastName), K.JobRank
	FROM
	(SELECT T.JobDuringJourney, T.ColonistId,
		DENSE_RANK() OVER(PARTITION BY T.JobDuringJourney ORDER BY C.BirthDate ) AS JobRank
	FROM Colonists AS C
	JOIN TravelCards AS T ON T.ColonistId = C.Id
	) AS K
	JOIN Colonists AS CO ON CO.Id = K.ColonistId
	WHERE K.JobRank = 2
	ORDER BY K.JobDuringJourney


--11.Get Colonists Count
/*--------------------------------------*/
GO
CREATE FUNCTION dbo.udf_GetColonistsCount(@PlanetName VARCHAR (30)) 
RETURNS INT
AS
BEGIN
RETURN(
SELECT COUNT(C.Id)
	FROM Journeys AS J
	JOIN TravelCards AS TC ON TC.JourneyId = J.Id
	JOIN Colonists AS C ON C.Id = TC.ColonistId
	JOIN Spaceports AS S ON S.Id = J.DestinationSpaceportId
	JOIN Planets AS P ON P.Id = S.PlanetId
	WHERE P.Name = @PlanetName)
END
GO

SELECT dbo.udf_GetColonistsCount('Otroyphus')

GO

CREATE PROC

