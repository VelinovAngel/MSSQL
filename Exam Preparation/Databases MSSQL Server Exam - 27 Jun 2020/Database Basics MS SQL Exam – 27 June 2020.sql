CREATE DATABASE WMS

--USE WMS


				--Section 1. DDL
--1.Database design
/*------------------------------------------------*/

CREATE TABLE Clients(
	ClientId INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	Phone NVARCHAR(12)
)

CREATE TABLE Mechanics(
	MechanicId INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	Address NVARCHAR(255)
)

CREATE TABLE Models(
	ModelId INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) UNIQUE
)

CREATE TABLE Jobs(
	JobId INT PRIMARY KEY IDENTITY,
	ModelId INT NOT NULL REFERENCES Models(ModelId),
	[Status] NVARCHAR(11) CHECK([Status] IN ('Pending', 'In Progress', 'Finished')) DEFAULT 'Pending' NOT NUll,
	ClientId INT NOT NULL REFERENCES Clients(ClientId),
	MechanicId INT REFERENCES Mechanics(MechanicId),
	IssueDate DATE,
	FinishDate DATE
)

CREATE TABLE Orders(
	OrderId INT PRIMARY KEY IDENTITY,
	JobId INT NOT NULL REFERENCES Jobs(JobId),
	IssueDate DATE,
	Delivered BIT DEFAULT 0
)

CREATE TABLE Vendors(
	VendorId INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL UNIQUE
)

CREATE TABLE Parts(
	PartId INT PRIMARY KEY IDENTITY,
	SerialNumber NVARCHAR(50) UNIQUE,
	[Description] NVARCHAR(255),
	Price DECIMAL (6,2) NOT NULL CHECK(Price > 0),
	VendorId INT NOT NULL REFERENCES Vendors(VendorId),
	StockQty INT CHECK(StockQty >= 0) DEFAULT 0
)

CREATE TABLE OrderParts(
	OrderId INT NOT NULL REFERENCES Orders(OrderId),
	PartId INT NOT NULL REFERENCES Parts(PartId),
	Quantity INT CHECK(Quantity > 0) DEFAULT 1,
	PRIMARY KEY(OrderId, PartId)
)

CREATE TABLE PartsNeeded(
	JobId INT NOT NULL REFERENCES Jobs(JobId),
	PartId INT NOT NULL REFERENCES Parts(PartId),
	Quantity INT NOT NULL CHECK(Quantity > 0) DEFAULT 1,
	PRIMARY KEY(JobId,PartId)
)


				--Section 2. DML
--2.Insert
/*------------------------------------------------*/

INSERT INTO Clients(FirstName, LastName , Phone) VALUES
('Teri',   'Ennaco', '570-889-5187'),
( 'Merlyn', 'Lawler', '201-588-7810'),
( 'Georgen','Montezuma', '925-615-5185'),
( 'Jettie', 'Mconnell', '908-802-3564'),
( 'Lemuel', 'Latzke', '631-748-6479'),
( 'Melodie','Knipp', '805-690-1682'),
 ('Candida','Corbley', '908-275-8357')


INSERT INTO Parts(SerialNumber, [Description], Price, VendorId)
	VALUES
	('WP8182119', 'Door Boot Seal', 117.86, 2),
	('W10780048', 'Suspension Rod', 42.81, 1),
	('W10841140', 'Silicone Adhesive ', 6.77, 4),
	('WPY055980', 'High Temperature Adhesive', 13.94, 3)


--3.Update
/*------------------------------------------------*/
--Assign all Pending jobs to the mechanic Ryan Harnos 
--(look up his ID manually, there is no need to use table joins) and change their status to 'In Progress'.

SELECT COUNT(*) FROM Jobs 
	WHERE MechanicId = 3

SELECT * FROM Jobs

UPDATE Jobs
	SET Status = 'In Progress', MechanicId = 3
	WHERE Status = 'Pending'
	

--4.Delete
/*------------------------------------------------*/
--Cancel Order with ID 19 – delete the order from the database and all associated entries from the mapping table.

DELETE FROM OrderParts
	WHERE OrderId = 19

	DELETE FROM Orders
	WHERE OrderId = 19


			--Section 3. Querying 
--5.Mechanic Assignments
/*------------------------------------------------*/
