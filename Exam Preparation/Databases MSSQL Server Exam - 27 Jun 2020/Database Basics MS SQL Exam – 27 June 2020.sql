--CREATE DATABASE WMS

--USE WMS


				--Section 1. DDL
--1.Database design
/*------------------------------------------------*/

CREATE TABLE Clients(
	ClientId INT NOT NULL PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	Phone NVARCHAR(12)
)

CREATE TABLE Mechanics(
	MechanicId INT NOT NULL PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	Address NVARCHAR(255)
)

CREATE TABLE Models(
	ModelId INT NOT NULL PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) UNIQUE
)

CREATE TABLE Jobs(
	JobId INT NOT NULL PRIMARY KEY IDENTITY,
	ModelId INT NOT NULL REFERENCES Models(ModelId),
	[Status] NVARCHAR(11) CHECK([Status] IN ('Pending', 'Finished')) DEFAULT 'Pending' NOT NUll,
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
	[Name] NVARCHAR(50) UNIQUE
)

CREATE TABLE Parts(
	PartId INT NOT NULL PRIMARY KEY IDENTITY,
	SerialNumber NVARCHAR(50) UNIQUE,
	[Description] NVARCHAR(255),
	Price DECIMAL (6,2) CHECK(Price > 0),
	VendorId INT NOT NULL REFERENCES Vendors(VendorId),
	StockQty INT CHECK(StockQty < 0) DEFAULT 0
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
	Quantity INT CHECK(Quantity > 0) DEFAULT 1,
	PRIMARY KEY(JobId,PartId)
)


				--Section 2. DML
--2.Insert
/*------------------------------------------------*/