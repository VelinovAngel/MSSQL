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
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	ProjectName
--Filter only employees with a project which has started after 13.08.2002 and it is still ongoing (no end date). Return the first 5 rows sorted by EmployeeID in ascending order.


SELECT TOP(5) E.EmployeeID, [FirstName], [P].Name AS [ProjectName]
	FROM Employees AS E
	JOIN EmployeesProjects AS EP ON EP.EmployeeID = E.EmployeeID
	JOIN Projects AS P ON EP.ProjectID = P.ProjectID
	WHERE P.StartDate >= '2002-08-13' AND P.EndDate IS NULL
	ORDER BY E.EmployeeID

SELECT * FROM Employees
SELECT * FROM Projects


	--8.Employee 24
/*---------------------------------------------------*/
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	ProjectName
--Filter all the projects of employee with Id 24. If the project has started during or after 2005 the returned value should be NULL.

SELECT 
		E.EmployeeID, 
		FirstName,
		CASE
		WHEN YEAR(P.StartDate) >= 2005 THEN NULL
		ELSE P.Name
		END AS [ProjectName]
	FROM Employees AS E
	JOIN EmployeesProjects AS EM  ON EM.EmployeeID = E.EmployeeID
	JOIN Projects AS P ON P.ProjectID = EM.ProjectID
	WHERE E.EmployeeID = 24


	--9.Employee Manager
/*---------------------------------------------------*/

--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	ManagerID
--•	ManagerName
--Filter all employees with a manager who has ID equals to 3 or 7. Return all the rows, sorted by EmployeeID in ascending order.

SELECT E.EmployeeID, E.FirstName,E.ManagerID, Em.FirstName
	FROM Employees AS Em
	JOIN Employees AS E ON E.ManagerID = Em.EmployeeID
	WHERE E.ManagerID = 3 OR E.ManagerID = 7
	ORDER BY E.EmployeeID ASC


	--10. Employee Summary
/*---------------------------------------------------*/

--Write a query that selects:
--•	EmployeeID
--•	EmployeeName
--•	ManagerName
--•	DepartmentName
--Show first 50 employees with their managers and the departments they are in (show the departments of the employees). Order by EmployeeID.

SELECT TOP(50) EM.EmployeeID, EM.FirstName + ' ' + EM.LastName, E.FirstName + ' ' + E.LastName,
D.Name
	FROM Employees AS Em
	JOIN Employees AS E ON E.EmployeeID = Em.ManagerID
	JOIN Departments AS D ON D.DepartmentID = Em.DepartmentID
	ORDER BY EM.EmployeeID ASC
	

	--11. Min Average Salary
/*---------------------------------------------------*/

SELECT MIN(Average)
	FROM (
			SELECT AVG(Salary) AS Average
			FROM Employees 
			GROUP BY Employees.DepartmentID
			) AS A

	--Second type

SELECT TOP(1)  AVG(E.Salary) AS AverageSalary
	FROM Employees AS E
	JOIN Departments AS D ON D.DepartmentID = E.DepartmentID
	GROUP BY d.DepartmentID
	ORDER BY AverageSalary

	--12. Highest Peaks in Bulgaria
/*---------------------------------------------------*/

--Write a query that selects:
--•	CountryCode
--•	MountainRange
--•	PeakName
--•	Elevation
--Filter all peaks in Bulgaria with elevation over 2835. Return all the rows sorted by elevation in descending order.

SELECT c.CountryCode, Mon.MountainRange, P.PeakName, P.Elevation
	FROM Countries AS C
	JOIN MountainsCountries AS M ON M.CountryCode = C.CountryCode
	JOIN Mountains AS Mon ON Mon.Id = M.MountainId
	JOIN Peaks AS P ON P.MountainId = Mon.Id
	WHERE C.CountryName LIKE 'Bulgaria' AND P.Elevation > 2835
	ORDER BY P.Elevation DESC
	
		--13. Count Mountain Ranges
/*---------------------------------------------------*/

--Write a query that selects:
--•	CountryCode
--•	MountainRanges
--Filter the count of the mountain ranges in the United States, Russia and Bulgaria.

SELECT	C.CountryCode, COUNT(m.MountainRange)
	FROM Countries AS C
	JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
	JOIN Mountains AS m ON m.Id = mc.MountainId
	WHERE C.CountryCode IN ('US', 'BG', 'RU')
	GROUP BY c.CountryCode

	--14. Countries with Rivers
/*---------------------------------------------------*/
--Write a query that selects:
--•	CountryName
--•	RiverName
--Find the first 5 countries with or without rivers in Africa. Sort them by CountryName in ascending order.

SELECT TOP(5) C.CountryName , R.RiverName
	FROM Countries AS C
	LEFT JOIN CountriesRivers AS CR On CR.CountryCode = C.CountryCode
	LEFT JOIN Rivers AS R ON R.Id = CR.RiverId
	LEFT JOIN Continents AS Cont ON Cont.ContinentCode = C.ContinentCode
	WHERE Cont.ContinentName LIKE 'Africa'
	ORDER BY C.CountryName ASC

	--15. *Continents and Currencies
/*---------------------------------------------------*/
--Write a query that selects:
--•	ContinentCode
--•	CurrencyCode
--•	CurrencyUsage
--Find all continents and their most used currency. Filter any currency that is used in only one country. Sort your results by ContinentCode.

SELECT ContinentCode, CurrencyCode, Total
	FROM
	(
	SELECT ContinentCode ,CurrencyCode, COUNT(CurrencyCode) as Total,
		DENSE_RANK() OVER(PARTITION BY ContinentCode ORDER BY COUNT(CurrencyCode) DESC) AS Ranked
	FROM Countries
	GROUP BY ContinentCode ,CurrencyCode
	) AS TotalResult
	WHERE Ranked = 1 AND Total > 1
ORDER BY ContinentCode

	--16.Countries Without Any Mountains
/*---------------------------------------------------*/
--Find all the count of all countries, which don’t have a mountain.

SELECT COUNT(C.CountryName)
	FROM Countries AS C
	LEFT JOIN MountainsCountries AS MS ON MS.CountryCode = C.CountryCode	
	WHERE MS.MountainId IS NULL




	--17. Highest Peak and Longest River by Country
/*---------------------------------------------------*/

--For each country, find the elevation of the highest peak and the length of the longest river, sorted by the highest peak elevation (from highest to lowest), then by the longest river length (from longest to smallest), then by country name (alphabetically). Display NULL when no data is available in some of the columns. Limit only the first 5 rows.


SELECT Peak.CountryName, Peak.Elevation, River.Length
	FROM 
	(
	SELECT C.CountryName, P.Elevation
	FROM Countries AS C
	LEFT JOIN MountainsCountries AS MC ON MC.CountryCode = C.CountryCode
	LEFT JOIN Mountains AS M ON M.Id = MC.MountainId
	LEFT JOIN Peaks AS P ON P.MountainId = M.Id
	) AS Peak 	,
	(SELECT R.Length 
		FROM Countries AS CO
		LEFT JOIN CountriesRivers AS CR ON CR.CountryCode = CO.CountryCode
		LEFT JOIN Rivers AS R ON R.Id = CR.RiverId
	) AS RIVER
	ORDER BY Peak.Elevation DESC, River.[Length] DESC ,Peak.CountryName

	




