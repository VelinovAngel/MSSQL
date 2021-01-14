

--Create database Movies

use Movies

--•	Directors (Id, DirectorName, Notes)
Create table Directors
(
	Id int primary key,
	DirectorName varchar(90) not null,
	Notes varchar(max)
)

insert into Directors values
(1, 'Pesho', null),
(2, 'Gosho', 'Good man'),
(3, 'Tosho', 'Perfect person'),
(4, 'Stoqn', 'Great'),
(5, 'Ivan', 'Bad')

--•	Genres (Id, GenreName, Notes)
Create table Genres
(
	Id int primary key,
	GenreName varchar(90) not null,
	Notes varchar(max)
)

insert into Genres values
(1, 'Pesho', null),
(2, 'Gosho', 'Good man'),
(3, 'Tosho', 'Perfect person'),
(4, 'Stoqn', 'Great'),
(5, 'Ivan', 'Bad')

--•	Categories (Id, CategoryName, Notes)
Create table Categories
(
	Id int primary key,
	CategoryName varchar(90) not null,
	Notes varchar(max)
)

insert into Categories values
(1, 'Pesho', null),
(2, 'Gosho', 'Good man'),
(3, 'Tosho', 'Perfect person'),
(4, 'Stoqn', 'Great'),
(5, 'Ivan', 'Bad')

--•	Movies (Id, Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
Create table Movies
(
	Id int primary key,
	Title varchar(90),
	DirectorId int not null,
	CopyrightYear datetime ,
	[Length] time,
	GenreId int,
	CategoryId int,
	Rating float(2),
	Notes varchar(max)
)

insert into Movies values
(1, 'SuperMan', 1, 05/05/2005, '2:34:12', 120, 50, 5.6, 'The Best'),
(2, 'PrettyWoman', 2, 02/07/2003, '1:54:13', 149, 54, 6.6, 'Good'),
(3, 'Expensible', 3, 02/02/2017, '2:44:12', 160, 20, 6.7, 'Very good'),
(4, 'Chernobyl', 4, 26/05/1986, '1:45:12', 100, 30, 4.6, null),
(5, 'Two half man', 5, 03/05/2002, '1:14:12', 130, 60, 7.8, null)