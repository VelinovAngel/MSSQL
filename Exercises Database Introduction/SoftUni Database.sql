--Create database SoftUni

--use SoftUni

--•	Towns (Id, Name)
create table Towns
(
	Id int primary key identity,
	[Name] varchar(90),
)

insert into Towns([Name]) values
('Sofia'),('Plovdiv'),('Varna'),('Burgas')

select * from Towns

--•	Addresses (Id, AddressText, TownId)
create table Addresses
(
	Id int primary key identity,
	AddressText varchar(max),
	TownId int foreign key references Towns(Id)
)
--drop table Addresses
--•	Departments (Id, Name)
create table Departments
(
	Id int primary key identity,
	[Name] varchar(90)
)

--•	Departments: Engineering, Sales, Marketing, Software Development, Quality Assurance
insert into Departments([Name]) values
('Engineering'),('Sales'),('Marketing'),('Software Development'),('Quality Assurance')

select * from Departments

--•	Employees (Id, FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId)
create table Employees
(
	Id int primary key identity,
	FirstName varchar(90),
	MiddleName varchar(90),
	LastName varchar(90),
	JobTitle varchar(90),
	DepartmentId int foreign key references Departments(Id),
	HireDate datetime,
	Salary decimal(18,2),
	AddressId int foreign key references Addresses(Id)
)
insert into Employees(FirstName,MiddleName,LastName,JobTitle,DepartmentId,HireDate,Salary)
	values 
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '02/01/2013', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '03/02/2004', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '08/28/2016', 525.25),
('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '12/09/2007', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '08/28/2016', 599.88)

select * from Employees
--Name					Job Title		Department				Hire Date	Salary
--Ivan Ivanov Ivanov	.NET Developer	Software Development	01/02/2013	3500.00
--Petar Petrov Petrov	Senior Engineer	Engineering				02/03/2004	4000.00
--Maria Petrova Ivanova	Intern			Quality Assurance		28/08/2016	525.25
--Georgi Teziev Ivanov	CEO				Sales					09/12/2007	3000.00
--Peter Pan Pan			Intern			Marketing				28/08/2016	599.88


--drop table Employees


