--use TableRelations
--CREATE DATABASE TableRelations
--drop database TableRelations

	--Problem 1.	One-To-One Relationship
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