--USE SoftUni

	--1.Employee Address
/*---------------------------------------------------*/
--�	EmployeeId
--�	JobTitle
--�	AddressId
--�	AddressText

SELECT TOP(5) [EmployeeID], [JobTitle], [Addresses].AddressID AS AddressID, [Addresses].AddressText 
	FROM Employees
	LEFT JOIN Addresses ON Employees.AddressID = Addresses.AddressID 
	ORDER BY AddressID ASC

	--2.Addresses with Towns
/*---------------------------------------------------*/
--Write a query that selects:
--�	FirstName
--�	LastName
--�	Town
--�	AddressText
--Sorted by FirstName in ascending order then by LastName. Select first 50 employees.

SELECT TOP(50) [FirstName], [LastName] ,  t.Name AS Town , Addresses.AddressText
		FROM Employees
	 JOIN Addresses ON Employees.AddressID = Addresses.AddressID
	 JOIN Towns AS t ON Addresses.TownID = t.TownID
	ORDER BY [FirstName] ASC , [LastName]


SELECT * FROM Addresses
	
SELECT * FROM Towns