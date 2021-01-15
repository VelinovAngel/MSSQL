

--Create database CarRental

--use CarRental

--•	Categories (Id, CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
Create table Categories
(
	Id int primary key,
	CategoryName varchar(90),
	DailyRate int,
	WeeklyRate int,
	MonthlyRate int,
	WeekendRate int
)

insert into Categories values
(1, 'Gosho', 10, 20, 30, 15),
(2, 'Pesho', 13, 90, 40, 35),
(3, 'Ivan', 14, 10, 80, 85)
--•	Cars (Id, PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)

Create table Cars
(
	Id int primary key,
	PlateNumber char(16) not null,
	Manufacturer varchar(40) not null,
	Model char(20) not null,
	CarYear datetime not null,
	CategoryId int,
	Doors int not null,
	Picture varchar(max) ,
	Condition char(15),
	Available bit not null
)

insert into Cars values 
(112233, 'VW', 'Golf GTI', '10/10/2010', 1, 3, null, 'used', 1),
(9999, 'Audi', 'RS6', '01/01/2021', 2, 3, null, 'new', 0),
(1111, 'Audi', 'A8L', '10/01/2021', 1, 3, null, 'new', 0),

--•	Employees (Id, FirstName, LastName, Title, Notes)

Create table Employees
(
	Id int primary key,
	FirstName varchar(90) not null,
	LastName varchar(90) not null,
	Title varchar(50),
	Notes varchar(max)
)

insert into Employees values
(1, 'Angel', 'Velinov', 'Mr', null),
(2, 'Niki', 'Velinov', 'Mr', null),
(3, 'Valentino', 'Rossi', 'Mr', 'The Doctor VR46')


--•	Customers (Id, DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)
Create table Customers
(
	Id int primary key,
	DriverLicenceNumber char(20) not null,
	FullName varchar(90) not null,
	[Address] varchar(90) not null,
	City varchar(50) not null,
	ZIPCode char(20),
	Notes varchar(max)
)



--•	RentalOrders (Id, EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)

Create table RentalOrders
(
	Id int primary key,
	EmployeeId int foreign key references Employees(Id),
	CustomerId int foreign key references Customers(Id),
	CarId int foreign key references Cars(Id),
	TankLevel int not null,
	KilometrageStart int not null,
	KilometrageEnd int not null,
	TotalKilometrage as KilometrageEnd-KilometrageStart,
	StartDate datetime,
	EndDate datetime,
	TotalDays as datediff(day , StartDate, EndDate),
	RateApplied decimal(5,2),
	TaxRate decimal(10,2) not null,
	OrderStatus char(20),
	Notes varchar(max)
)