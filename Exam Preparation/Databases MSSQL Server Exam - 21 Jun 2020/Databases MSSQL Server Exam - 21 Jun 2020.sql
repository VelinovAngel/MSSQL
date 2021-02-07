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


