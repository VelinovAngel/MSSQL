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

