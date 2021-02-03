
--1.Employees with Salary Above 35000
/*----------------------------------------*/
--Create stored procedure usp_GetEmployeesSalaryAbove35000 that returns all employees’ first and last names for whose salary is above 35000. 

CREATE PROC usp_GetEmployeesSalaryAbove35000
AS
SELECT FirstName, LastName	
	FROM Employees	
	WHERE Salary > 35000

EXEC usp_GetEmployeesSalaryAbove35000


--2.Employees with Salary Above Number
/*----------------------------------------*/
--Create stored procedure usp_GetEmployeesSalaryAboveNumber that accept a number (of type DECIMAL(18,4)) as parameter and returns all employees’ first and last names whose salary is above or equal to the given number. 

CREATE PROC usp_GetEmployeesSalaryAboveNumber(@inputValue DECIMAL(18,4))
AS
SELECT FirstName, LastName	
	FROM Employees	
	WHERE Salary >= @inputValue

EXEC usp_GetEmployeesSalaryAboveNumber 48100



--3.Town Names Starting With
/*----------------------------------------*/
--Write a stored procedure usp_GetTownsStartingWith that accept string as parameter and returns all town names starting with that string. 

CREATE PROC usp_GetTownsStartingWith(@nameValue NVARCHAR(50))
AS
SELECT [Name]
	FROM Towns
	WHERE [Name] LIKE @nameValue + '%'


EXEC usp_GetTownsStartingWith 'b'


--4.Employees from Town
/*----------------------------------------*/

--Write a stored procedure usp_GetEmployeesFromTown that accepts town name as parameter and return the employees’ first and last name that live in the given town. 

CREATE PROC usp_GetEmployeesFromTown(@cityName NVARCHAR(50))
AS
SELECT FirstName, LastName
	FROM Employees AS E
	JOIN Addresses AS A ON A.AddressID = E.AddressID
	JOIN Towns AS T ON T.TownID = A.TownID
	WHERE T.Name = @cityName 

EXEC usp_GetEmployeesFromTown 'Sofia' 


--5.Salary Level Function
/*----------------------------------------*/
--Write a function ufn_GetSalaryLevel(@salary DECIMAL(18,4)) that receives salary of an employee and returns the level of the salary.
--•	If salary is < 30000 return "Low"
--•	If salary is between 30000 and 50000 (inclusive) return "Average"
--•	If salary is > 50000 return "High"

CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @result VARCHAR(50)

	IF (@salary < 30000)
		SET @result = 'Low'
	ELSE IF(@salary >= 3000 AND @salary <= 50000)
		SET @result = 'Average'
	ELSE 
		SET @result = 'High'

RETURN @result;
END

SELECT dbo.ufn_GetSalaryLevel(Salary) FROM Employees

--SELECT CASE
--			WHEN Salary < 30000 THEN 'Low'
--			WHEN Salary BETWEEN 30000 AND 50000 THEN 'Average'
--			ELSE 'High'
--			END
--		FROM Employees



--6.Employees by Salary Level
/*----------------------------------------*/
--Write a stored procedure usp_EmployeesBySalaryLevel that receive as parameter level of salary (low, average or high) and print the names of all employees that have given level of salary. You should use the function - "dbo.ufn_GetSalaryLevel(@Salary) ", which was part of the previous task, inside your "CREATE PROCEDURE …" query.

CREATE PROC usp_EmployeesBySalaryLevel(@levelSalary VARCHAR(20))
AS
SELECT 
		FirstName,
		LastName
	FROM Employees
		WHERE dbo.ufn_GetSalaryLevel(Salary) = @levelSalary 


EXEC usp_EmployeesBySalaryLevel 'High'

--7.Define Function
/*----------------------------------------*/
--Define a function ufn_IsWordComprised(@setOfLetters, @word) that returns true or false depending on that if the word is a comprised of the given set of letters. 
GO

CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @town VARCHAR(MAX))
RETURNs BIT
BEGIN
DECLARE @count int = 1;

WHILE(@count <= LEN(@town))
BEGIN
		DECLARE @currLetter CHAR(1) = SUBSTRING(@town, @count, 1)
		IF (CHARINDEX(@currLetter, @setOfLetters) = 0)
		RETURN 0
	SET @count += 1
END
RETURN 1
END


SELECT dbo.ufn_IsWordComprised('pppp', 'Guy')

GO

--8.* Delete Employees and Departments
/*----------------------------------------*/
--Write a procedure with the name usp_DeleteEmployeesFromDepartment (@departmentId INT) which deletes all Employees from a given department. Delete these departments from the Departments table too. Finally SELECT the number of employees from the given department. If the delete statements are correct the select query should return 0.
--After completing that exercise restore your database to revert all changes.
--Hint:
--You may set ManagerID column in Departments table to nullable (using query "ALTER TABLE …").

CREATE PROC usp_DeleteEmployeesFromDepartment(@departmentId INT) 
AS
ALTER TABLE Departments
ALTER COLUMN ManagerID INT NULL

DELETE FROM EmployeesProjects	
WHERE EmployeeID IN(SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

UPDATE Employees
	SET ManagerID = NULL
	WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

UPDATE Employees	
	SET ManagerID = NULL
	WHERE ManagerID IN (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

UPDATE Departments
	SET ManagerID = NULL
	WHERE DepartmentID = @departmentId

DELETE FROM Employees
	WHERE DepartmentID = @departmentId

DELETE FROm Departments
	WHERE DepartmentID = @departmentId

SELECT COUNT(*) FROM Employees WHERE DepartmentID = @departmentId


				--2.Queries for Bank Database

--9.Find Full Name
/*----------------------------------------*/
--You are given a database schema with tables AccountHolders(Id (PK), FirstName, LastName, SSN) and Accounts(Id (PK), AccountHolderId (FK), Balance).  Write a stored procedure usp_GetHoldersFullName that selects the full names of all people. 


CREATE PROC usp_GetHoldersFullName
AS
SELECT FirstName + ' ' + LastName	
	FROM AccountHolders


--10.People with Balance Higher Than
/*----------------------------------------*/
--Your task is to create a stored procedure usp_GetHoldersWithBalanceHigherThan that accepts a number as a parameter and returns all people who have more money in total of all their accounts than the supplied number. Order them by first name, then by last name

CREATE PROC usp_GetHoldersWithBalanceHigherThan(@Total DECIMAL(15,2))
AS
SELECT FirstName, LastName 	
	FROM AccountHolders AS AH 
	JOIN Accounts AS A ON AH.Id = A.AccountHolderId
	GROUP BY FirstName, LastName
	HAVING SUM(Balance) > @Total
	ORDER BY FirstName, LastName


--11.Future Value Function
/*----------------------------------------*/
--Your task is to create a function ufn_CalculateFutureValue that accepts as parameters – sum (decimal), yearly interest rate (float) and number of years(int). It should calculate and return the future value of the initial sum rounded to the fourth digit after the decimal delimiter. Using the following formula:

CREATE FUNCTION ufn_CalculateFutureValue(@sum DECIMAL(15,2), @yearly FLOAT, @years int)
RETURNS DECIMAL(15,4)
BEGIN
	DECLARE @Result DECIMAL(15,4) = (@sum*(POWER((1 + @yearly), @years)))
	RETURN @Result
END

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)


--12.Calculating Interest
/*----------------------------------------*/
--Your task is to create a stored procedure usp_CalculateFutureValueForAccount that uses the function from the previous problem to give an interest to a person's account for 5 years, along with information about his/her account id, first name, last name and current balance as it is shown in the example below. It should take the AccountId and the interest rate as parameters. Again you are provided with “dbo.ufn_CalculateFutureValue” function which was part of the previous task.

CREATE PROC usp_CalculateFutureValueForAccount(@accountID INT, @interest FLOAT)
AS
SELECT A.Id , AH.FirstName, AH.LastName, A.Balance, dbo.ufn_CalculateFutureValue(a.Balance , @interest , 5)	
	FROM AccountHolders AS AH
	JOIN Accounts AS A ON AH.Id = A.AccountHolderId
	WHERE A.Id = @accountID


--13.*Scalar Function: Cash in User Games Odd Rows
/*----------------------------------------*/
--Create a function ufn_CashInUsersGames that sums the cash of odd rows. Rows must be ordered by cash in descending order. The function should take a game name as a parameter and return the result as table. Submit only your function in.
--Execute the function over the following game names, ordered exactly like: "Love in a mist".


CREATE FUNCTION ufn_CashInUsersGames(@gameName VARCHAR(100))
RETURNS TABLE 
AS
		RETURN(SELECT SUM(total.TotalCash) AS CASH
				FROM(SELECT Cash AS TotalCash,
						ROW_NUMBER() OVER(ORDER BY CASH DESC) AS RN
						FROM Games AS G
							JOIN UsersGames AS UG ON UG.GameId = G.Id
						WHERE Name = @gameName
				) AS total
				WHERE total.RN % 2 = 1)	



