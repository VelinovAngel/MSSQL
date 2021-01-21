--use TableRelations
--CREATE DATABASE TableRelations
--drop database TableRelations

	--Problem 1.One-To-One Relationship
/*------------------------------------------------*/

--Persons													Passports
--PersonID	FirstName	Salary		PassportID		PassportID	PassportNumber
--1  		Roberto    	43300.00	102				101			N34FG21B
--2			Tom			56100.00	103				102			K65LO4R7
--3			Yana		60200.00	101				103			ZE657QP2

CREATE TABLE Passports
(
	PassportID INT PRIMARY KEY NOT NULL,
	PassportNumber NCHAR(20) UNIQUE,
)


INSERT INTO Passports VALUES
(102,'N34FG21B'),
(103, 'K65LO4R7'),
(101, 'ZE657QP2')


CREATE TABLE Persons
(
	PersonID INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(60) NOT NULL,
	Salary DECIMAL(16,2) NOT NULL,
	PassportID INT REFERENCES Passports(PassportID)

)

INSERT INTO Persons(FirstName,Salary,PassportID) VALUES
('Roberto', 43300.00, 102),
('Tom', 56100.00, 103),
('Yana', 60200.00, 101)


SELECT * 
	FROM Persons
	JOIN Passports ON Passports.PassportID = Persons.PassportID

SELECT * FROM Passports




		--Problem 2.One-To-Many Relationship
/*------------------------------------------------*/


CREATE TABLE Manufacturers
(
	ManufacturerID INT PRIMARY KEY IDENTITY,
	Name NCHAR(30),
	EstablishedOn DATETIME
)

		--Manufacturers
--ManufacturerID	Name	EstablishedOn
--		1  			BMW		07/03/1916
--		2			Tesla	01/01/2003
--		3			Lada	01/05/1966


INSERT INTO Manufacturers(Name, EstablishedOn) VALUES
('BMW', '1916-03-07'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01')

SELECT * FROM Manufacturers


CREATE TABLE Models
(
	ModelID INT PRIMARY KEY IDENTITY(100,1),
	Name NCHAR(30),
	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

--DROP TABLE Models

         --Models	
--ModelID	Name	ManufacturerID	
--	101		X1			1	
--	102		i6			1	
--	103		Model S		2	
--	104		Model X		2	
--	105		Model 3		2	
--	106		Nova		3	

INSERT INTO Models(Name,ManufacturerID) VALUES 
('X1',1),
('i6',1),
('Model S',2),
('Model X',2),
('Model 3',2),
('Nova',3)

SELECT * FROM Models

SELECT m.ManufacturerID,m.Name,m.EstablishedOn FROM Manufacturers AS m
	JOIN Models AS mdl
	ON mdl.Manufacture	rID = m.ManufacturerID


		--Problem 3.	Many-To-Many Relationship
/*------------------------------------------------*/

CREATE TABLE Students
(
	StudentID INT PRIMARY KEY IDENTITY,
	Name NCHAR(30),
)

DROP TABLE Students

INSERT INTO Students(Name) VALUES 
('Mila'),
('Toni'),
('Ron')

SELECT * FROM Students

CREATE TABLE Exams
(
	ExamID INT PRIMARY KEY IDENTITY(100,1),
	Name NCHAR(50)
)

INSERT INTO Exams(Name) VALUES 
('SpringMVC'),
('Neo4j'),
('Oracle 11g')


CREATE TABLE StudentsExams
(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	ExamID INT FOREIGN KEY REFERENCES Exams(ExamID),
	PRIMARY KEY(StudentID,ExamID)
)


		--Problem 4. Self-Referencing 
/*------------------------------------------------*/

CREATE TABLE Teachers
(
	TeacherID INT IDENTITY(101,1) PRIMARY KEY,
	Name NCHAR(40) NOT NULL,
	ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

--DROP TABLE Teachers

INSERT INTO Teachers(Name, ManagerID) VALUES
('John', NULL),
('Maya', 106),
('Silvia', 106),
('Ted',	105),
('Mark', 101),
('Greta', 101)

--Truncate table Teachers
SELECT * FROM Teachers

	--Problem 5.	Online Store Database
/*------------------------------------------------*/
CREATE TABLE Cities
(
	CityID INT PRIMARY KEY,
	[Name] VARCHAR(50)
)

CREATE TABLE Customers
(
	CustomerID INT PRIMARY KEY,
	[Name] VARCHAR(50),
	Birthday DATE,
	CityID INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE Orders
(
	OrderID INT PRIMARY KEY,
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
)

CREATE TABLE ItemTypes
(
	ItemTypeID INT PRIMARY KEY,
	[Name] VARCHAR(50)
)

CREATE TABLE Items
(
	ItemID INT PRIMARY KEY,
	[Name] VARCHAR(50),
	ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE OrderItems
(
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
	ItemID INT FOREIGN KEY REFERENCES Items(ItemID),
	PRIMARY KEY(OrderID, ItemID)
)


	--Problem 1.	University Database
/*------------------------------------------------*/
--CREATE DATABASE UniversityDatabase
--USE UniversityDatabase

CREATE TABLE Majors
(
	MajorID INT PRIMARY KEY,
	[Name] VARCHAR(50)
)

CREATE TABLE Students
(
	StudentID INT PRIMARY KEY,
	StudentNumber INT NOT NULL,
	StudentName NCHAR(30) NOT NULL,
	MajorID INT FOREIGN KEY REFERENCES Majors(MajorID)
)

