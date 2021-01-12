--create database Hotel
--use Hotel



create table Employees
(
	Id int primary key,
	FirstName varchar(90) not null,
	LastName varchar(90) not null,
	Title varchar(50) not null,
	Notes varchar(max)
)

insert into Employees (Id, FirstName, LastName, Title, Notes) values
(1, 'Gosho', 'Goshev' , 'CEO' , null),
(2, 'Pesho', 'Ivanov' , 'CFO' , 'randon note'),
(3, 'Tosho', 'Stoyanov' , 'CTO' , null)

--(AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)

create table Customers
(
	AccountNumber int primary key,
	FirstName varchar(90) not null,
	LastName varchar(90) not null,
	PhoneNumber char(10)not null,
	EmergencyName varchar(90) not null,
	EmergencyNumber char(10) not null,
	Notes varchar(max)
)

insert into Customers values
(120, 'G', 'P', '1234567890' ,'T', '1234567890', null ),
(121, 'F', 'C', '1234567890' ,'T', '1234567890', null ),
(122, 'T', 'K', '1234567890' ,'T', '1234567890', null )

create table RoomStatus
(
	RoomStatus varchar(20) not null,
	Notes varchar(max)
)

insert into RoomStatus values
('Cleaning', null),
('Free', null),
('Not Free', null)


create table RoomTypes
(
	RoomType varchar(20) not null,
	Notes varchar(max)
)

insert into RoomTypes values
('Apartment', null),
('Suit', null),
('Double' , null)


create table BedTypes
(
	BedType varchar(20) not null,
	Notes varchar(max)
)

insert into BedTypes values
('Single', null),
('Double', null),
('Family', null)

create table Rooms
(
	RoomNumber int primary key,
	RoomType varchar(20) not null,
	BedType varchar(20) not null,
	Rate int,
	RoomStatus varchar(20) not null,
	Notes varchar(max)
)

insert into Rooms values 
(120,'Apartment', 'Single' , 10, 'Free', null),
(121,'Suit', 'Family' , 15, 'Not Free', null),
(122,'Double', 'Double' , 20, 'Free', null)

--(Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)

create table Payments
(
	Id int primary key,
	EmployeeId int not null,
	PaymentDate datetime not null,
	AccountNumber int not null,
	FirstDateOccupied datetime not null,
	LastDateOccupied datetime not null,
	TotalDays int not null,
	AmountCharged decimal(15,2),
	TaxRate int,
	TaxAmount int,
	PaymentTotal decimal(15,2),
	Notes varchar(max)
)

insert into Payments values
(1, 1, GETDATE(), 120, '5/5/2012', '5/8/2012', 3, 540.13,null,null,670,12, null),
(2, 1, GETDATE(), 120, '1/4/2012', '10/4/2012', 3, 2400.13,null,null,610,22, null),
(3, 1, GETDATE(), 120, '5/1/2012', '5/2/2012', 3, 340.13,null,null,690,52, null)

-- (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)

create table Occupancies
(
	Id int primary key,
	EmployeeId int not null,
	DateOccupied datetime not null,
	AccountNumber int not null,
	RoomNumber int not null,
	RateApplied int,
	PhoneCharge decimal(15,2),
	Notes varchar(max)
)

insert into Occupancies values
(1, 120, GETDATE(), 100 , 120, 0, 0, null),
(2, 121, GETDATE(), 10 , 10, 0, 0, null),
(3, 122, GETDATE(), 90 , 90, 0, 0, null)


Select * from Employees


