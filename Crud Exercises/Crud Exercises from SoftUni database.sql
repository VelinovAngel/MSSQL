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

	--7. Find All Different Employee’s Salaries
/*-------------------------------------------------*/

select distinct
		Salary 
	from Employees

	--8. Find all Information About Employees
/*-------------------------------------------------*/

