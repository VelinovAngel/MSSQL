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


--USE master
--ALTER DATABASE WMS SET OFFLINE WITH ROLLBACK IMMEDIATE;

			--Section 3. Querying 
--5.Mechanic Assignments
/*------------------------------------------------*/
/*
Select all mechanics with their jobs. Include job status and issue date. Order by mechanic Id, issue date, job Id (all ascending).
Required columns:
•	Mechanic Full Name
•	Job Status
•	Job Issue Date
*/


SELECT CONCAT(M.FirstName, ' ', LastName) AS [Full Name], 
	   J.Status AS [Job Status],
	   J.IssueDate AS [Job Issue Date]
				FROM Mechanics AS M
	JOIN Jobs AS J ON J.MechanicId = M.MechanicId
	ORDER By M.MechanicId , J.IssueDate, j.JobId


	--6.	Current Clients
/*------------------------------------------------*/
/*
Select the names of all clients with active jobs (not Finished). Include the status of the job and how many days it’s been since it was submitted. Assume the current date is 24 April 2017. Order results by time length (descending) and by client ID (ascending).
Required columns:
•	Client Full Name
•	Days going – how many days have passed since the issuing
•	Status
*/

SELECT CONCAT(C.FirstName, ' ',C.LastName) AS Client,
		DATEDIFF(DAY, J.IssueDate , '2017-04-24' ) AS [Days going],
		J.Status
	FROM Clients AS C
	JOIN Jobs AS J ON J.ClientId = C.ClientId
	WHERE J.Status != 'Finished'
	ORDER BY [Days going] DESC, C.ClientId ASC



	--7.	Mechanic Performance
/*------------------------------------------------*/
/*
Select all mechanics and the average time they take to finish their assigned jobs. Calculate the average as an integer. Order results by mechanic ID (ascending).
Required columns:
•	Mechanic Full Name
•	Average Days – average number of days the machanic took to finish the job
*/

SELECT CONCAT(M.FirstName,' ',M.LastName) ,AVG(DATEDIFF(DAY, J.IssueDate, FinishDate))  
	FROM Mechanics AS M
	JOIN Jobs AS J ON J.MechanicId = M.MechanicId
	GROUP BY M.MechanicId, M.FirstName,M.LastName
	ORDER BY M.MechanicId ASC


	--8.	Available Mechanics
/*------------------------------------------------*/
/*
Select all mechanics without active jobs (include mechanics which don’t have any job assigned or all of their jobs are finished). Order by ID (ascending).
Required columns:
•	Mechanic Full Name
*/

SELECT CONCAT(M.FirstName, ' ', M.LastName) AS Available
				FROM Mechanics AS M
		LEFT JOIN Jobs AS J ON J.MechanicId = M.MechanicId
		WHERE J.JobId IS NULL OR ( SELECT COUNT(*)
										FROM Jobs
									WHERE Status != 'Finished' AND MechanicId = m.MechanicId
									GROUP BY MechanicId) IS NULL
									GROUP BY CONCAT(M.FirstName, ' ', M.LastName), M.MechanicId
									ORDER BY M.MechanicId
					
			
			
			 
	--9.	Past Expenses	
/*------------------------------------------------*/
/*
Select all finished jobs and the total cost of all parts that were ordered for them. Sort by total cost of parts ordered (descending) and by job ID (ascending).
Required columns:
•	Job ID
•	Total Parts Cost
*/

SELECT Query.JobId,SUM(Query.Price)	AS Total
		FROM(SELECT J.JobId, P.Price, PN.Quantity
					FROM Jobs AS J
					JOIN PartsNeeded As Pn ON Pn.JobId = J.JobId
					JOIN Parts AS P ON P.PartId = PN.PartId
					WHERE J.Status = 'Finished'
					GROUP BY J.JobId, P.Price, PN.Quantity) AS Query
					GROUP BY Query.JobId
					ORDER BY Total DESC

		--Second Solution

SELECT Query.JobId, 
		CASE
			WHEN SUM(Query.Total) > 0 THEN SUM(Query.Total)
			ELSE 0
		END	
		Total
		FROM(SELECT J.JobId, 
		P.Price, 
		OP.Quantity,  
		(SUM(P.Price) * OP.Quantity) AS Total
					FROM Jobs AS J
					LEFT JOIN Orders As O ON O.JobId = J.JobId
					LEFT JOIN OrderParts AS OP ON OP.OrderId = O.OrderId
					LEFT JOIN Parts AS P ON P.PartId = OP.PartId
					WHERE J.Status = 'Finished' OR J.FinishDate IS NOT NULL
					GROUP BY J.JobId, P.Price, OP.Quantity) AS Query
					GROUP BY Query.JobId
					ORDER BY Total DESC, Query.JobId ASC


	--10.	Missing Parts
/*------------------------------------------------*/
/*
List all parts that are needed for active jobs (not Finished) without sufficient quantity in stock and in pending orders (the sum of parts in stock and parts ordered is less than the required quantity). Order them by part ID (ascending).
*/


SELECT p.PartId ,
	   P.Description,
	   SUM(PN.Quantity),
	   P.StockQty,
	   ISNULL(SUM(OP.Quantity), 0) AS [Ordered]
	FROM Parts AS P
	JOIN PartsNeeded AS PN ON PN.PartId = P.PartId
	JOIN Jobs AS J ON J.JobId = PN.JobId
	LEFT JOIN Orders AS O ON O.JobId = J.JobId
	LEFT JOIN OrderParts AS OP ON OP.OrderId = O.OrderId
	WHERE J.Status != 'Finished' 
	GROUP BY P.PartId , P.Description, P.StockQty
	HAVING SUM(PN.Quantity) > P.StockQty + ISNULL(SUM(OP.Quantity), 0)
	ORDER BY P.PartId
