--USE SoftUni

	--Problem 1.Find Names of All Employees by First Name
/*----------------------------------------------------------*/

SELECT FirstName, LastName FROM Employees
	WHERE FirstName LIKE 'SA%'

	--Problem 2.Find Names of All employees by Last Name 
/*----------------------------------------------------------*/

SELECT [FirstName], [LastName] FROM Employees
	WHERE [LastName] LIKE '%ei%'


	--Problem 3.Find First Names of All Employees 
/*----------------------------------------------------------*/

--Write a SQL query to find the first names of all employees in the departments 
--with ID 3 or 10 and whose hire year is between 1995 and 2005 inclusive.

SELECT [FirstName] FROM Employees
	WHERE DepartmentID in (3,10)
		AND YEAR(HireDate) BETWEEN 1995 AND 2005
	
	
	--Problem 4.Find All Employees Except Engineers
/*----------------------------------------------------------*/

SELECT [FirstName], [LastName] FROM Employees
	WHERE JobTitle NOT LIKE '%engineer%'


	--Problem 5.Find Towns with Name Length
/*----------------------------------------------------------*/

--Write a SQL query to find town names that are 5 or 6 symbols long and order them alphabetically by town name.

SELECT [Name] FROM Towns
	WHERE LEN([Name]) in (5,6)
	ORDER BY [Name] ASC


	--Problem 6.Find Towns Starting With
/*----------------------------------------------------------*/

--Write a SQL query to find all towns that start with letters M, K, B or E. Order them alphabetically by town name. 

SELECT [TownID], [Name] FROM Towns
	WHERE [Name] LIKE '[MBKE]%'
	ORDER BY [Name] ASC

	--Problem 7.Find Towns Not Starting With
/*----------------------------------------------------------*/

SELECT [TownID], [Name] From Towns
	WHERE [Name] NOT LIKE '[RBD]%'
	ORDER BY [Name] ASC

	--Problem 8.Create View Employees Hired After 2000 Year
/*----------------------------------------------------------*/

CREATE VIEW V_EmployeesHiredAfter2000 AS
	SELECT [FirstName], [LastName] FROM Employees
		WHERE YEAR(HireDate) > 2000

		--Problem 9.Length of Last Name
/*----------------------------------------------------------*/

--Write a SQL query to find the names of all employees whose last name is exactly 5 characters long.

SELECT [FirstName], LastName FROM Employees
	WHERE LEN(LastName) in (5)

	--Problem 10.Rank Employees by Salary
/*----------------------------------------------------------*/


SELECT [EmployeeID], [FirstName], [LastName], [Salary],
     DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
	 FROM Employees
	 WHERE Salary BETWEEN 10000 AND 50000
	 ORDER BY Salary DESC

	 --Problem 11.Find All Employees with Rank 2 *
/*----------------------------------------------------------*/

--Use the query from the previous problem and upgrade it, so that it finds only the employees whose Rank is 2 and again, order them by Salary (descending).

SELECT * 
	FROM(SELECT [EmployeeID], [FirstName], [LastName], [Salary],
			 DENSE_RANK() OVER (PARTITION BY Salary 
						  ORDER BY EmployeeID) AS [Rank]
		FROM Employees
			 WHERE Salary BETWEEN 10000 AND 50000) AS [Rank]
			 WHERE [Rank] = 2
			 ORDER BY Salary DESC

	 --Problem 12.	Countries Holding ‘A’ 3 or More Times
/*----------------------------------------------------------*/

--USE Geography

SELECT [CountryName], [IsoCode] FROM Countries
	WHERE CountryName LIKE '%a%a%a%'
		ORDER BY IsoCode

	 --Problem 13.	 Mix of Peak and River Names
/*----------------------------------------------------------*/

SELECT [PeakName], [RiverName], 
		LOWER((Left(PeakName, LEN(PeakName) - 1)) + [RiverName]) AS Mix 
FROM Rivers, Peaks
	WHERE RIGHT(PeakName, 1) = Left(RiverName, 1)
	ORDER BY Mix

	--Problem 14.Games from 2011 and 2012 year
/*----------------------------------------------------------*/

--USE Diablo

SELECT TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd' ) AS [DATA] FROM Games
	WHERE YEAR([Start]) BETWEEN 2011 AND 2012 
	ORDER BY [DATA], [Name]

	--Problem 15.User Email Providers
/*----------------------------------------------------------*/

SELECT [Username], SUBSTRING ( [Email], CHARINDEX( '@', [Email] ) + 1,
		   LEN([Email])) AS [Email Provider] 
		   FROM Users
		   ORDER BY [Email Provider], [Username]

 
	--Problem 16.Get Users with IPAdress Like Pattern
/*----------------------------------------------------------*/	

--Find all users along with their IP addresses sorted by username alphabetically. Display only rows that IP address matches the pattern: "___.1%.%.___".

--Legend: * - one symbol, ^ - one or more symbols

SELECT [Username], [IpAddress] AS [IP Address] FROM Users
	WHERE [IpAddress] LIKE '___.1%.%.___'
	ORDER BY [Username]