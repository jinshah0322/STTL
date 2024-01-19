CREATE DATABASE INVENTORYMODULE;

USE INVENTORYMODULE;

create table products(
	productId int primary key identity(1,1),
	productName nvarchar(25) not null,
	price decimal(10,2) not null,
	quantity int,
	createdDate date,
	description varchar(50)
)

create table categories(
	categoryId int primary key identity(1,1),
	categoryName nvarchar(25) not null,
	description varchar(100),
	createdDate datetime,
	isActive bit not null,
)

create table suppliers(
	supplierId int primary key identity(1,1),
	supplierName nvarchar(25) not null,
	contact varchar(10) not null,
	supplierEmail nvarchar(50),
	registrationDate datetime,
	isActive bit not null
)

create table users(
	userId int primary key identity(1,1),
	firstName nvarchar(50) not null,
	lastName nvarchar(50) not null,
	registrationDate date not null,
	contact varchar(10) not null,
	isAdmin bit default 0
)

create table orders(
	orderId int primary key identity(1,1),
	orderDate datetime ,
	userId int not null,
	productId int not null,
	quantity int not null,
	totalAmount decimal(10,2) not null,
	note varchar(100),
	isDelivered bit default 0 not null,
	foreign key(userId) references users(userId),
	foreign key(productId) references products(productId)
)