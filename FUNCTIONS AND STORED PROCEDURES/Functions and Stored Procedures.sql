
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








--7.Define Function
/*----------------------------------------*/

