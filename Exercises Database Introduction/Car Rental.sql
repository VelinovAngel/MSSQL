

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
	Available char(15)
)

--•	Employees (Id, FirstName, LastName, Title, Notes)

Create table Employees
(
	Id int primary key,
	FirstName varchar(90),
	LastName varchar(90),
	Title varchar(50),
	Notes varchar(max)
)

insert into Employees values
(1, 'Gosho', 'Goshev', 'Ivanka', null),
(2, 'Ivan', 'Goshev', 'AGr', null),
(3, 'Stoyan', 'Goshev', 'Adk', null)


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
	EmployeeId int,
	CustomerId int,
	CarId int,
	TankLevel int,
	KilometrageStart int,
	KilometrageEnd int,
	TotalKilometrage int,
	StartDate time,
	EndDate time,
	TotalDays time,
	RateApplied float(2),
	TaxRate float(2),
	OrderStatus char(10),
	Notes varchar(max)
)