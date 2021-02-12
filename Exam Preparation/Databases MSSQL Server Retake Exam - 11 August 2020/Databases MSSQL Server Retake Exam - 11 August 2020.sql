CREATE DATABASE Bakery

USE Bakery

			--Section 1. DDL 
--1.	Database design
/*------------------------------------------*/

CREATE TABLE Countries(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) UNIQUE
)

CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(25),
	LastName NVARCHAR(25),
	Gender CHAR(1) CHECK(Gender IN('M', 'F')),
	Age INT,
	PhoneNumber CHAR(10) CHECK(LEN(PhoneNumber) = 10),
	CountryId INT REFERENCES Countries(Id)
)


CREATE TABLE Products(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(25) UNIQUE,
	[Description] NVARCHAR(250),
	Recipe NVARCHAR(MAX),
	Price MONEY CHECK(Price >= 0)
)

CREATE TABLE Feedbacks(
	Id INT PRIMARY KEY IDENTITY,
	[Description] NVARCHAR(255),
	Rate DECIMAL(18,2) CHECK(Rate BETWEEN 0 AND 10),
	ProductId INT REFERENCES Products(Id),
	CustomerId INT REFERENCES Customers(Id)
)

CREATE TABLE Distributors(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(25) UNIQUE,
	AddressText NVARCHAR(30),
	Summary NVARCHAR(200),
	CountryId INT REFERENCES Countries(Id)
)

CREATE TABLE Ingredients(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30),
	[Description] NVARCHAR(200),
	OriginCountryId INT REFERENCES Countries(Id),
	DistributorId INT REFERENCES Distributors(Id)
)

CREATE TABLE ProductsIngredients(
	ProductId INT REFERENCES Products(Id),
	IngredientId INT REFERENCES Ingredients(Id),
	PRIMARY KEY(ProductId, IngredientId)
)



--2.	Insert
/*------------------------------------------*/

INSERT INTO Distributors(Name,CountryId,AddressText,Summary) VALUES
('Deloitte & Touche',	 2,		'6 Arch St #9757',	'Customizable neutral traveling'),
('Congress Title',		 13,	'58 Hancock St'	,	'Customer loyalty'),
('Kitchen People',		 1,		'3 E 31st St #77',	'Triple-buffered stable delivery'),
('General Color Co Inc', 21,	'6185 Bohn St #72',	'Focus group'),
('Beck Corporation',	 23,	'21 E 64th Ave'	,	'Quality-focused 4th generation hardware')


INSERT INTO Customers(FirstName, LastName, Age, Gender, PhoneNumber, CountryId) VALUES
('Francoise','Rautenstrauch',15, 'M',	'0195698399',	5 ),
('Kendra',	'Loud',			22	,'F',	'0063631526',	11),
('Lourdes',	'Bauswell',		50	,'M',	'0139037043',	8 ),
('Hannah',	'Edmison',		18	,'F',	'0043343686',	1 ),
('Tom',		'Loeza',		31	,'M',	'0144876096',	23),
('Queenie',	'Kramarczyk',	30	,'F',	'0064215793',	29),
('Hiu',		'Portaro',		25	,'M',	'0068277755',	16),
('Josefa',	'Opitz',		43	,'F',	'0197887645',	17)



--3.	Update
/*------------------------------------------*/
/*
We’ve decided to switch some of our ingredients to a local distributor. Update the table Ingredients and change the DistributorId of "Bay Leaf", "Paprika" and "Poppy" to 35. Change the OriginCountryId to 14 of all ingredients with OriginCountryId equal to 8.
*/

SELECT *	
	FROM Ingredients
	WHERE OriginCountryId = 8


	UPDATE Ingredients
	SET DistributorId = 35
	WHERE (Name = 'Bay Leaf' OR Name = 'Paprika' 
	OR Name = 'Poppy')
	
	UPDATE Ingredients
		SET OriginCountryId = 14
		WHERE OriginCountryId = 8


	--4.	Delete
/*------------------------------------------*/
--Delete all Feedbacks which relate to Customer with Id 14 or to Product with Id 5.

DELETE FROM Feedbacks
	WHERE CustomerId = 14 OR ProductId = 5


--	USE master
--ALTER DATABASE Bakery SET OFFLINE WITH ROLLBACK IMMEDIATE;

		--Section 3. Querying 

	--5.	Products by Price
/*------------------------------------------*/
/*
Select all products ordered by price (descending) then by name (ascending). 
Required columns:
•	Name
•	Price
•	Description
*/

SELECT [Name], Price, Description	
	FROM Products
	ORDER BY Price DESC , [Name] ASC

	--6.	Negative Feedback
/*------------------------------------------*/
/*
Select all feedbacks alongside with the customers which gave them. Filter only feedbacks which have rate below 5.0. Order results by ProductId (descending) then by Rate (ascending).
Required columns:
•	ProductId
•	Rate
•	Description
•	CustomerId
•	Age
•	Gender
*/

SELECT ProductId, Rate, Description, CustomerId, C.Age, C.Gender
	FROM Feedbacks AS F
	JOIN Customers AS C ON C.Id = F.CustomerId
	WHERE Rate < 5
	ORDER BY F.ProductId DESC, F.Rate ASC


	--7.	Customers without Feedback
/*------------------------------------------*/
/*
Select all customers without feedbacks. Order them by customer id (ascending).
Required columns:
•	CustomerName – customer’s first and last name, concatenated with space
•	PhoneNumber
•	Gender
*/

SELECT CONCAT(C.FirstName,' ',C.LastName),
		C.PhoneNumber,
		C.Gender
	FROM Customers AS C
	LEFT JOIN Feedbacks AS F ON F.CustomerId = C.Id
	WHERE F.Id IS NULL
	ORDER BY C.Id ASC

	--8.	Customers by Criteria
/*------------------------------------------*/
/*
Select customers that are either at least 21 old and contain “an” in their first name or their phone number ends with “38” and are not from Greece. Order by first name (ascending), then by age(descending).
Required columns:
•	FirstName
•	Age
•	PhoneNumber
*/

SELECT FirstName, Age, PhoneNumber	
	FROM Customers 
	JOIN Countries AS C ON C.Id = Customers.CountryId
	WHERE Age >= 21 AND FirstName LIKE '%an%' OR PhoneNumber LIKE '%38'
	AND c.Name != 'Greece'
	ORDER BY FirstName ASC , Age DESC




	--9.	Middle Range Distributors
/*------------------------------------------*/
/*
Select all distributors which distribute ingredients used in the making process of all products having average rate between 5 and 8 (inclusive). Order by distributor name, ingredient name and product name all ascending.
Required columns:
•	DistributorName
•	IngredientName
•	ProductName
•	AverageRate
*/

SELECT D.Name , I.Name, P.Name, AVG(F.Rate) AS Rate
		FROM Feedbacks AS F
		JOIN Products AS P ON P.Id = F.ProductId
		JOIN ProductsIngredients AS [PI] ON [PI].ProductId = P.Id
		JOIN Ingredients AS I ON I.Id = [PI].IngredientId
		JOIN Distributors As D ON D.Id = I.DistributorId
		GROUP BY D.Name , I.Name, P.Name
		HAVING AVG(F.Rate) BETWEEN 5 AND 8
		ORDER BY D.Name , I.Name, P.Name
		

	--10.	Country Representative
/*------------------------------------------*/
/*
Select all countries with their most active distributor (the one with the greatest number of ingredients). If there are several distributors with most ingredients delivered, list them all. Order by country name then by distributor name.
*/

SELECT Ordered.[Country Name], Ordered.[Distributor Name]	
		FROM 
			(SELECT 
			C.Name AS [Country Name], 
			D.Name [Distributor Name],
				COUNT(I.Id) AS [Ingradient Id],
				DENSE_RANK() OVER(PARTITION BY C.Name ORDER BY COUNT(I.Id) DESC) AS Rank
		FROM Countries AS C
			JOIN Distributors AS D ON D.CountryId = C.Id
			JOIN Ingredients AS I ON I.DistributorId = D.Id
		GROUP BY C.Name, D.Name) AS Ordered
	WHERE Ordered.Rank = 1
	ORDER BY Ordered.[Country Name], Ordered.[Distributor Name]




