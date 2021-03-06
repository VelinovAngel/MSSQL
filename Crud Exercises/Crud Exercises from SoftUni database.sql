use SoftUni


	--02. Find All Information About Departments
/*-------------------------------------------------*/

select * from Departments

	--3.Find all Department Names
/*-------------------------------------------------*/

select [Name] from Departments

	--4.Find Salary of Each Employee
/*-------------------------------------------------*/

select FirstName , LastName , Salary from Employees

	--5.Find Full Name of Each Employee
/*-------------------------------------------------*/

select FirstName, MiddleName, LastName from Employees

	--6. Find Email Address of Each Employee
/*-------------------------------------------------*/

select  FirstName + '.' + LastName + '@softuni.bg' as [Full Email Address] 
		from Employees 

	--7. Find All Different Employee�s Salaries
/*-------------------------------------------------*/

select distinct
		Salary 
	from Employees

	--8. Find all Information About Employees
/*-------------------------------------------------*/

select * from Employees
		where JobTitle = 'Sales Representative'

	--9. Find Names of All Employees by Salary in Range
/*-------------------------------------------------*/

select FirstName , LastName , JobTitle from Employees
		where Salary >= 20000 and Salary <= 30000

	--10. Find Names of All Employees
/*-------------------------------------------------*/

--salary is 25000, 14000, 12500 or 23600. 
select FirstName + ' ' + MiddleName + ' ' + LastName as [Full Name]  
		from Employees
		where Salary = 25000 or	
			  Salary = 14000 or
			  Salary = 12500 or
			  Salary = 23600

	--11. Find All Employees Without Manager
/*-------------------------------------------------*/

select FirstName , LastName from Employees
		where ManagerID is null

	--12. Find All Employees with Salary More Than
/*-------------------------------------------------*/

select FirstName, LastName, Salary 
		from Employees
		where Salary > 50000
		order by Salary desc

	--13. Find 5 Best Paid Employees
/*-------------------------------------------------*/

select top(5) FirstName, LastName from Employees
	order by Salary desc

	--14. Find All Employees Except Marketing
/*-------------------------------------------------*/

select FirstName, LastName from Employees
		where DepartmentID != 4

	--15. Sort Employees Table
/*-------------------------------------------------*/

select * from Employees
	order by Salary desc, FirstName, LastName desc, MiddleName
	
	--16. Create View Employees with Salaries
/*-------------------------------------------------*/

create view V_EmployeesSalaries as
	select FirstName, LastName, Salary 
	from Employees

	--17. Create View Employees with Job Titles
/*-------------------------------------------------*/

create view V_EmployeeNameJobTitle as
	select FirstName + ' ' + ISNULL(MiddleName,'') + ' ' + LastName as [Full Name] , JobTitle
	from Employees

	--18. Distinct Job Titles
/*-------------------------------------------------*/

select distinct JobTitle from Employees

	--19. Find First 10 Started Projects
/*-------------------------------------------------*/

select top(10) * from Projects
		order by StartDate, [Name]

	--20. Last 7 Hired Employees
/*-------------------------------------------------*/

select TOP(7) FirstName, LastName, HireDate 
	from Employees
		order by HireDate desc
		
	--21. Increase Salaries
/*-------------------------------------------------*/
--Engineering, Tool Design, Marketing or Information Services department by 12%. Then select Salaries column from the Employees table. 

update Employees 
	set Salary *= 1.12
	where DepartmentID in (1,2,4,11)

select Salary from Employees


use Geography

	--22. All Mountain Peaks
/*-------------------------------------------------*/

select PeakName
from Peaks
order by PeakName

	--23. Biggest Countries by Population
/*-------------------------------------------------*/

select top(30) CountryName , Population 
		from Countries
		where ContinentCode = 'EU'
		order by Population desc, CountryName

		--24.*Countries and Currency (Euro / Not Euro)
/*-------------------------------------------------*/
select CountryName,CountryCode,
       case
       when CurrencyCode='Eur' then 'Euro'
else 'Not Euro'
         end  as 'Currency'
from Countries
order by CountryName

/*--------------------------*/
use Diablo

select [Name] from Characters
	order by [Name] 

	

