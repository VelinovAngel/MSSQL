CREATE DATABASE TripService
--DROP DATABASE TripService
--1. Database design
/*-----------------------------------------*/

CREATE TABLE Cities(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(20) NOT NULL,
	CountryCode CHAR(2) NOT NULL,
)

CREATE TABLE Hotels(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL,
	CityId INT FOREIGN KEY REFERENCES Cities(Id) NOT NULL,
	EmployeeCount INT NOT NULL,
	BaseRate DECIMAL(18,2)
)

CREATE TABLE Rooms(
	Id INT PRIMARY KEY IDENTITY,
	Price DECIMAL(18,2) NOT NULL,
	[Type] NVARCHAR(20) NOT NULL,
	Beds INT NOT NULL,
	HotelId INT FOREIGN KEY REFERENCES Hotels(Id) NOT NULL
)

CREATE TABLE Trips(
	Id INT PRIMARY KEY IDENTITY,
	RoomId INT FOREIGN KEY REFERENCES Rooms(Id) NOT NULL,
	BookDate DATE  NOT NULL,
	ArrivalDate DATE NOT NULL,
	ReturnDate DATE NOT NULL,
	CancelDate DATE,
	CONSTRAINT CK_BookData CHECK (BookDate < ArrivalDate),
	CONSTRAINT CK_ArrivalData CHECK (ArrivalDate < ReturnDate) 
)

CREATE TABLE Accounts(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(20),
	LastName NVARCHAR(50) NOT NULL,
	CityId INT FOREIGN KEY REFERENCES Cities(Id) NOT NULL,
	BirthDate DATE NOT NULL,
	Email NVARCHAR(100) UNIQUE NOT NULL
)

CREATE TABLE AccountsTrips(
	AccountId INT FOREIGN KEY REFERENCES Accounts(Id) NOT NULL,
	TripId INT FOREIGN KEY REFERENCES Trips(Id) NOT NULL,
	Luggage INT CHECK (Luggage >= 0),
	PRIMARY KEY (AccountId , TripId)
)



--2. Insert
/*-----------------------------------------*/

--John		Smith		Smith		34	1975-07-21	j_smith@gmail.com
--Gosho		NULL		Petrov		11	1978-05-16	g_petrov@gmail.com
--Ivan		Petrovich	Pavlov		59	1849-09-26	i_pavlov@softuni.bg
--Friedrich	Wilhelm		Nietzsche	2	1844-10-15	f_nietzsche@softuni.bg

INSERT INTO Accounts(FirstName,MiddleName,LastName,CityId,BirthDate,Email) VALUES 
('John', 'Smith', 'Smith', 34, '1975-07-21', 'j_smith@gmail.com'),
('Gosho', NULL, 'Petrov', 11, '1978-05-16', 'g_petrov@gmail.com'),
('Ivan', 'Petrovich', 'Pavlov', 59, '1849-09-26', 'i_pavlov@softuni.bg'),
('Friedrich', 'Wilhelm', 'Nietzsche', 2, '1844-10-15', 'f_nietzsche@softuni.bg')


--RoomId	BookDate	ArrivalDate	ReturnDate	CancelDate
--101		2015-04-12	2015-04-14	2015-04-20	2015-02-02
--102		2015-07-07	2015-07-15	2015-07-22	2015-04-29
--103		2013-07-17	2013-07-23	2013-07-24	NULL
--104		2012-03-17	2012-03-31	2012-04-01	2012-01-10
--109		2017-08-07	2017-08-28	2017-08-29	NULL

INSERT INTO Trips(RoomId,BookDate,ArrivalDate,ReturnDate,CancelDate) VALUES
(101, '2015-04-12', '2015-04-14', '2015-04-20', '2015-02-02'),
(102, '2015-07-07', '2015-07-15', '2015-07-22', '2015-04-29'),
(103, '2013-07-17', '2013-07-23', '2013-07-24', NULL),
(104, '2012-03-17', '2012-03-31', '2012-04-01', '2012-01-10'),
(109, '2017-08-07', '2017-08-28', '2017-08-29', NULL)


--3. Update
/*-----------------------------------------*/
--Make all rooms’ prices 14% more expensive where the hotel ID is either 5, 7 or 9.

UPDATE Rooms
	SET Price *= 1.14
	WHERE HotelId IN (5,7,9)


--4. Delete
/*-----------------------------------------*/
--Delete all of Account ID 47’s account’s trips from the mapping table.

DELETE FROM AccountsTrips
	WHERE AccountId = 47



--USE master
--ALTER DATABASE TripService SET OFFLINE WITH ROLLBACK IMMEDIATE;

USE TripService

--5. EEE-Mails
/*-----------------------------------------*/
--Select accounts whose emails start with the letter “e”. Select their first and last name, their birthdate in the format "MM-dd-yyyy", their city name, and their Email.

SELECT FirstName, LastName, FORMAT(BirthDate,'MM-dd-yyyy'), C.Name  ,Email 
	FROM Accounts AS A
	JOIN Cities AS C ON C.Id = A.CityId
	WHERE Email LIKE 'e%'
	ORDER BY C.Name ASC

	--6. City Statistics
/*-----------------------------------------*/
--Select all cities with the count of hotels in them. Order them by the hotel count (descending), then by city name. Do not include cities, which have no hotels in them.

SELECT C.Name ,COUNT(H.Id) AS CountHotel
	FROM Cities AS C
	JOIN Hotels AS H ON H.CityId = C.Id 
	GROUP BY C.Id, C.Name
	ORDER BY CountHotel DESC , C.Name

	--Second Solution:

SELECT  C.Name AS City, (SELECT COUNT(*) FROM Hotels AS H WHERE H.CityId = C.Id) As Hotels
	FROM Cities AS C
	ORDER BY Hotels DESC, City

	--7. Longest and Shortest Trips
/*-----------------------------------------*/
--Find the longest and shortest trip for each account, in days. Filter the results to accounts with no middle name and trips, which are not cancelled (CancelDate is null).
--Order the results by Longest Trip days (descending), then by Shortest Trip (ascending).

SELECT Acc.Id, CONCAT(Acc.FirstName , ' ', Acc.LastName ), 
		MAX(DATEDIFF(DAY ,T.ArrivalDate, T.ReturnDate )) AS Longest, 
	    MIN(DATEDIFF(DAY ,T.ArrivalDate, T.ReturnDate)) AS Shortest
	FROM Trips AS T
	JOIN AccountsTrips AS A ON A.TripId = T.Id
	JOIN Accounts AS Acc ON Acc.Id = A.AccountId
	WHERE Acc.MiddleName IS NULL AND T.CancelDate IS NULL 
	GROUP BY Acc.Id, Acc.FirstName, Acc.LastName
	ORDER BY Longest DESC , Shortest ASC


	--8. Metropolis
/*-----------------------------------------*/
--Find the top 10 cities, which have the most registered accounts in them. Order them by the count of accounts (descending).

SELECT TOP(10) C.Id ,C.Name ,C.CountryCode  ,COUNT(A.CityId) AS CityCount
	FROM Cities AS C
	JOIN Accounts AS A ON A.CityId = C.Id
	GROUP BY A.CityId, C.Name, C.Id, C.CountryCode
	ORDER BY CityCount DESC


	--9. Romantic Getaways
/*-----------------------------------------*/
--Find all accounts, which have had one or more trips to a hotel in their hometown.
--Order them by the trips count (descending), then by Account ID.

SELECT  A.Id, A.Email, C.Name, COUNT(*) AS Trips
	FROM Accounts AS A
	JOIN AccountsTrips AS ATR ON ATR.AccountId = A.Id
	JOIN Trips AS T ON T.Id = ATR.TripId
	JOIN Rooms AS R ON R.Id = T.RoomId
	JOIN Hotels AS H ON H.Id = R.HotelId
	JOIN Cities AS C ON C.Id = H.CityId
	WHERE A.CityId = H.CityId
	GROUP BY A.Email, A.Id, C.Name 
	ORDER BY Trips DESC , A.Id


	--10. GDPR Violation
/*-----------------------------------------*/
--Retrieve the following information about each trip:
	--•	Trip ID
	--•	Account Full Name
	--•	From – Account hometown
	--•	To – Hotel city
	--•	Duration – the duration between the arrival date and return date in days. If a trip is cancelled, the value is “Canceled”
--Order the results by full name, then by Trip ID.


SELECT  T.Id, 
		CONCAT(A.FirstName, ' '+ MiddleName , ' ', A.LastName) AS FullName ,
		CA.Name AS [FROM],
		CH.Name AS [TO],
		CASE	
			WHEN T.CancelDate IS NOT NULL THEN 'Canceled'
			ELSE CONCAT(DATEDIFF(DAY, T.ArrivalDate, T.ReturnDate), ' days')
		END		
		FROM Accounts AS A
			JOIN AccountsTrips AS ATR ON ATR.AccountId = A.Id
			JOIN Trips AS T ON T.Id = ATR.TripId
			JOIN Rooms AS R ON R.Id = T.RoomId
			JOIN Hotels AS H ON H.Id = R.HotelId
			JOIN Cities AS CH ON CH.Id = H.CityId
			JOIN Cities AS CA ON CA.Id = A.CityId
			ORDER BY FullName ASC ,T.Id ASC


	--11. Available Room
/*-----------------------------------------*/
GO

CREATE FUNCTION udf_GetAvailableRoom(@HotelId INT, @Date DATE, @People INT)
RETURNS VARCHAR(MAX)
BEGIN

DECLARE @RoomID INT = 
					(SELECT TOP(1) R.Id
							 FROM Trips AS T
							 JOIN Rooms AS R ON t.RoomId = R.Id
							 JOIN Hotels AS H ON R.HotelId = H.Id
								 WHERE H.Id = @HotelId
								 AND @DATE NOT BETWEEN T.ArrivalDate AND T.ReturnDate
								 AND T.CancelDate IS NULL
								 AND R.Beds >= @People
								 AND YEAR(@Date) = YEAR(T.ArrivalDate)
								 ORDER BY r.Price DESC) 

IF @RoomId IS NULL
        RETURN 'No rooms available'


DECLARE @RoomPrice DECIMAL(18,2) = 
	(SELECT Price
			FROM Rooms
			WHERE Id =  @RoomID)


    DECLARE @RoomType VARCHAR(50) = (SELECT Type
                                         FROM Rooms
                                         WHERE Id = @RoomId)

    DECLARE @BedsCount INT = (SELECT Beds
                                  FROM Rooms
                                  WHERE Id = @RoomId)

    DECLARE @HotelBaseRate DECIMAL(15, 2) = (SELECT BaseRate
                                                 FROM Hotels
                                                 WHERE Id = @HotelId)

    DECLARE @TotalPrice DECIMAL(15, 2) = (@HotelBaseRate + @RoomPrice) * @People

    RETURN CONCAT('Room ', @RoomId, ': ', @RoomType, ' (', @BedsCount, ' beds', ') - $', @TotalPrice)

END

GO

SELECT dbo.udf_GetAvailableRoom(112, '2011-12-17', 2)
SELECT dbo.udf_GetAvailableRoom(94, '2015-07-26', 3)



	--12. Switch Room
/*-----------------------------------------*/
GO

CREATE PROC usp_SwitchRoom(@TripId INT, @TargetRoomId INT)
AS
	DECLARE @HotelID INT =	(
							   SELECT H.Id 
									FROM Hotels AS H
									JOIN Rooms AS R ON R.HotelId = H.Id
									JOIN Trips AS T On T.RoomId = R.Id
									WHERE T.Id = @TripId
							)

	DECLARE @RoomIdInHotel INT =  (
										SELECT h.Id
											FROM Hotels AS H
											JOIN Rooms AS R ON R.HotelId = H.Id
											WHERE @TargetRoomId = R.Id
								  )

	IF(@HotelID != @RoomIdInHotel)
		THROW 50001, 'Target room is in another hotel!', 1

	DECLARE @PeopleCount INT = (
									SELECT COUNT(*)
										FROM AccountsTrips
										WHERE TripId = @TripId
							    )

	DECLARE @RoomCount INT = (
									SELECT Beds
										FROM Rooms
										WHERE Id = @TargetRoomId
							  )

	IF(@PeopleCount > @RoomCount)
		THROW 50001, 'Not enough beds in target room!', 1


	UPDATE Trips	
		SET RoomId = @TargetRoomId
		WHERE Id = @TripId


GO

EXEC usp_SwitchRoom 10, 11
SELECT RoomId FROM Trips WHERE Id = 10

EXEC usp_SwitchRoom 10, 7

EXEC usp_SwitchRoom 10, 8
