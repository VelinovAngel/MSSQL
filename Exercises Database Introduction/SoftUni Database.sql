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

--drop table Employees


