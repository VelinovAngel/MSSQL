CREATE TABLE Users
(
	Id BIGINT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) NOT NULL, 
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARCHAR(MAX),
	LastLoginTime DATETIME,
	IsDeleted BIT
)



INSERT INTO Users 
(Username, [Password], ProfilePicture, LastLoginTime, IsDeleted) 
VALUES 
('velinov', 'stron', 'https://www.pinterest.it/pin/502784745871843906/', '4/4/2021', 0),
('goshov', 'asfas', 'https://www.pinterest.it/pin/502784745871843906/', '12/4/2021', 0),
('gosdashov', 'atgtn', 'https://www.pinterest.it/pin/502784745871843906/', '2/03/2022', 0),
('gosd', 'atgASDtn', 'https://www.pinterest.it/pin/502784745871843906/', '10/04/2022', 0),
('gsov', 'atgtn', 'https://www.pinterest.it/pin/502784745871843906/', '02/03/2022', 0)

SELECT * FROM Users