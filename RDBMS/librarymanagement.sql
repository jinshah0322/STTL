create database librarymanagement

use librarymanagement

create table authors(
	authorId int primary key identity(1,1),
	firstName nvarchar(100) not null,
	lastName nvarchar(100) not null,
	birthdate date,
	nationality nvarchar(100),
	awarded bit not null,
	awardDate date,
)

create table publisher(
	publisherId int primary key identity(1,1),
	publisherName nvarchar(100) not null,
	publishDate date not null,
	publisherContact varchar(10),
)

create table books(
	bookId int primary key identity(1,1),
	title nvarchar(100) not null,
	author nvarchar(100) not null,
	genre nvarchar(100),
	publishDate date not null,
	copiesAvailable int not null,
	shelfLocation nvarchar(100),
	price decimal(10,2) not null,
	authorId int not null,
	publisherId int not null,
	isEook bit default 0,
	foreign key (authorId) references authors(authorId),
	foreign key (publisherId) references publisher(publisherId),
)

create table members(
	memberId int primary key identity(1,1),
	firstName nvarchar(100) not null,
	lastName nvarchar(100) not null,
	birthDate date,
	contact varchar(10) not null,
	memberType char(1) not null,
)

create table reviews(
	reviewId int primary key identity(1,1),
	memberId int not null,
	bookId int not null,
	rating tinyint not null,
	comment nvarchar(100),
	reviewDate datetime not null,
	reviewSentiment bit,
	foreign key (memberId) references members(memberID),
	foreign key (bookId) references books(bookId)
)



insert into authors(firstName,lastName,birthdate,nationality,awarded,awardDate)
values  ('John', 'Doe', '1980-05-15', 'American', 1, '2005-08-20'),
		('Jane', 'Smith', '1975-02-28', 'British', 0, NULL),
		('Mark', 'Johnson', '1990-12-10', 'Canadian', 1, '2010-03-18'),
		('Alice', 'Williams', '1985-07-03', 'Australian', 0, NULL),
		('Bob', 'Miller', '1982-09-25', 'German', 1, '2007-06-12')

select * from authors


insert into publisher(publisherName,publishDate,publisherContact)
values	('ABC Publishers', '2000-01-15', '1234567890'),
		('XYZ Publications', '1995-08-22', '9876543210'),
		('BookHouse', '2005-03-10', '5678901234')

select * from publisher


insert into books(title, author, genre, publishDate, copiesAvailable, shelfLocation, price, authorId, publisherId, isEook)
values	('The Book of Everything', 'John Doe', 'Fiction', '2000-05-20', 100, 'A1', 25.99, 1, 1, 0),
		('Coding 101', 'Jane Smith', 'Programming', '2015-12-08', 50, 'B2', 35.50, 2, 2, 1),
		('History of Science', 'Mark Johnson', 'Non-Fiction', '2012-07-15', 75, 'C3', 18.75, 3, 3, 0),
		('Nature Exploration', 'Alice Williams', 'Nature', '2008-09-30', 30, 'D4', 12.99, 4, 1, 0),
		('Poetry Collection', 'Bob Miller', 'Poetry', '2019-04-12', 20, 'E5', 8.50, 5, 2, 1)

select * from books


insert into members (firstName, lastName, birthDate, contact, memberType)
values	('Alice', 'Doe', '1995-03-10', '9876543210', 'S'),
		('Bob', 'Smith', '1980-09-18', '1234567890', 'F'),
		('Charlie', 'Johnson', '1992-11-05', '5678901234', 'S'),
		('David', 'White', '1988-06-22', '3456789012', 'F'),
		('Eva', 'Davis', '1997-12-03', '7890123456', 'S')

select * from members


insert into reviews(memberId, bookId, rating, comment, reviewDate, reviewSentiment)
values	(1, 1, 4, 'Great book!', '2022-01-01 08:30:00', 1),
		(2, 2, 5, 'Excellent coding guide.', '2022-01-02 10:45:00', 1),
		(3, 3, 3, 'Interesting history book.', '2022-01-03 12:15:00', 0),
		(4, 4, 4, 'Enjoyed the nature exploration.', '2022-01-04 14:20:00', 1),
		(5, 5, 3, 'Nice collection of poetry.', '2022-01-05 16:45:00', 0)

select * from reviews