--USE SoftUni

	--1.Employee Address
/*---------------------------------------------------*/
--•	EmployeeId
--•	JobTitle
--•	AddressId
--•	AddressText

SELECT [EmployeeID], [JobTitle], [Addresses].AddressID AS AddressID, [Addresses].AddressText 
	FROM Employees
	LEFT JOIN Addresses ON Employees.AddressID = Addresses.AddressID 
	ORDER BY AddressID


