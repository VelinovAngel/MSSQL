--USE SoftUni

	--1.Employee Address
/*---------------------------------------------------*/
--•	EmployeeId
--•	JobTitle
--•	AddressId
--•	AddressText

SELECT TOP(5) [EmployeeID], [JobTitle], [Addresses].AddressID AS AddressID, [Addresses].AddressText 
	FROM Employees
	LEFT JOIN Addresses ON Employees.AddressID = Addresses.AddressID 
	ORDER BY AddressID ASC

	--2.Addresses with Towns
/*---------------------------------------------------*/
--Write a query that selects:
--•	FirstName
--•	LastName
--•	Town
--•	AddressText
--Sorted by FirstName in ascending order then by LastName. Select first 50 employees.

SELECT TOP(50) [FirstName], [LastName] ,  t.Name AS Town , Addresses.AddressText
		FROM Employees
	 JOIN Addresses ON Employees.AddressID = Addresses.AddressID
	 JOIN Towns AS t ON Addresses.TownID = t.TownID
	ORDER BY [FirstName] ASC , [LastName]


SELECT * FROM Addresses
	
SELECT * FROM Towns


	--3.Sales Employee
/*---------------------------------------------------*/
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	LastName
--•	DepartmentName
--Sorted by EmployeeID in ascending order. Select only employees from "Sales" department.

SELECT [EmployeeID], [FirstName], [LastName], D.Name
	FROM Employees
	LEFT JOIN Departments AS D ON Employees.DepartmentID = D.DepartmentID
	WHERE D.Name = 'Sales'

SELECT * FROM Departments

	--4.Employee Departments
/*---------------------------------------------------*/
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	Salary
--•	DepartmentName
--Filter only employees with salary higher than 15000. Return the first 5 rows sorted by DepartmentID in ascending order.

SELECT TOP(5) [EmployeeID], [FirstName], [Salary], [D].Name
	FROM Employees
	JOIN Departments AS D ON Employees.DepartmentID = D.DepartmentID
	WHERE [Salary] > 15000 
	ORDER BY D.DepartmentID

	--5.Employees Without Project
/*---------------------------------------------------*/
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--Filter only employees without a project. Return the first 3 rows sorted by EmployeeID in ascending order.

SELECT TOP(3) E.EmployeeID , [FirstName]
	FROM Employees AS E
	 LEFT OUTER JOIN EmployeesProjects AS P ON P.EmployeeID = E.EmployeeID
	 WHERE P.ProjectID IS NULL
	ORDER BY E.EmployeeID ASC

SELECT * FROM Projects

	--6.Employees Hired After
/*---------------------------------------------------*/

--Write a query that selects:
--•	FirstName
--•	LastName
--•	HireDate
--•	DeptName
--Filter only employees hired after 1.1.1999 and are from either "Sales" or "Finance" departments, sorted by HireDate (ascending).

SELECT [FirstName], [LastName], [HireDate], [D].Name 
	FROM Employees
	JOIN Departments AS D ON D.DepartmentID = Employees.DepartmentID
	WHERE HireDate > '1999-01-01' AND (d.Name = 'Sales' OR d.Name = 'Finance')
	ORDER BY HireDate ASC

	--7.Employees with Project
/*---------------------------------------------------*/
