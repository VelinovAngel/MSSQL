--•	Id – unique number for every person there will be no more than 231-1 people. (Auto incremented)
--•	Name – full name of the person will be no more than 200 Unicode characters. (Not null)
--•	Picture – image with size up to 2 MB. (Allow nulls)
--•	Height –  In meters. Real number precise up to 2 digits after floating point. (Allow nulls)
--•	Weight –  In kilograms. Real number precise up to 2 digits after floating point. (Allow nulls)
--•	Gender – Possible states are m or f. (Not null)
--•	Birthdate – (Not null)
--•	Biography – detailed biography of the person it can contain max allowed Unicode characters. (Allow nulls)

--Create database People

use People

Create table People
(
	Id int primary key,
	[Name] varchar(200) not null,
	Picture varchar(max),
	Height decimal(18,2),
	[Weight] decimal(18,2),
	Gender char(2) not null,
	Biography varchar(max)
)

--drop table People

insert into People values
(1, 'Gosho', 'https://github.com/VelinovAngel', 12.22 , 12.35, 'm', 'Hubav'),
(2, 'Ana', 'https://github.com/VelinovAngel', 2.22 , 2.35, 'f', 'Hubava'),
(3, 'Angel', 'https://github.com/VelinovAngel', 13.22 , 13.35, 'm', 'Hubav'),
(4, 'Ivanka', 'https://github.com/VelinovAngel', 1.22 , 1.35, 'f', 'Hubava'),
(5, 'Stoqnka', 'https://github.com/VelinovAngel', 12.22 , 12.35, 'f', 'Hubava')


--select * from People