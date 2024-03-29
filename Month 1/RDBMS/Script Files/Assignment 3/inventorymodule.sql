USE [master]
GO
/****** Object:  Database [INVENTORYMODULE]    Script Date: 24-01-2024 10:35:19 ******/
CREATE DATABASE [INVENTORYMODULE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'INVENTORYMODULE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\INVENTORYMODULE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'INVENTORYMODULE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\INVENTORYMODULE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [INVENTORYMODULE] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [INVENTORYMODULE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [INVENTORYMODULE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET ARITHABORT OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [INVENTORYMODULE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [INVENTORYMODULE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [INVENTORYMODULE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET  ENABLE_BROKER 
GO
ALTER DATABASE [INVENTORYMODULE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [INVENTORYMODULE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [INVENTORYMODULE] SET  MULTI_USER 
GO
ALTER DATABASE [INVENTORYMODULE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [INVENTORYMODULE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [INVENTORYMODULE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [INVENTORYMODULE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [INVENTORYMODULE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [INVENTORYMODULE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [INVENTORYMODULE] SET QUERY_STORE = OFF
GO
USE [INVENTORYMODULE]
GO
/****** Object:  UserDefinedFunction [dbo].[GetProductPrice]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetProductPrice](@productId INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
DECLARE @Price DECIMAL(10,2)
SELECT @Price = price FROM products WHERE productId = @productId
RETURN @Price
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetUserFullName]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetUserFullName] (@userId INT)
RETURNS NVARCHAR(100)
AS
BEGIN
DECLARE @FullName NVARCHAR(100)
SELECT @FullName = CONCAT(firstName, ' ', lastName) FROM users WHERE userId = @userId
RETURN @FullName
END;
GO
/****** Object:  Table [dbo].[categories]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[categoryId] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [nvarchar](25) NOT NULL,
	[description] [varchar](100) NULL,
	[createdDate] [datetime] NULL,
	[isActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[productId] [int] IDENTITY(1,1) NOT NULL,
	[categoryId] [int] NOT NULL,
	[productName] [nvarchar](25) NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[quantity] [int] NULL,
	[createdDate] [date] NULL,
	[description] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductCategoryView]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductCategoryView] AS
SELECT
    P.productId,
    P.productName,
    P.price,
    P.quantity,
    P.createdDate AS ProductCreatedDate,
    P.description AS ProductDescription,
    C.categoryId,
    C.categoryName,
    C.description AS CategoryDescription,
    C.createdDate AS CategoryCreatedDate,
    C.isActive AS CategoryIsActive
FROM
    products P
JOIN
    categories C ON P.categoryId = C.categoryId;
GO
/****** Object:  Table [dbo].[users]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[userId] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [nvarchar](50) NOT NULL,
	[lastName] [nvarchar](50) NOT NULL,
	[registrationDate] [date] NOT NULL,
	[contact] [varchar](10) NOT NULL,
	[isAdmin] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[orderId] [int] IDENTITY(1,1) NOT NULL,
	[orderDate] [datetime] NULL,
	[userId] [int] NOT NULL,
	[productId] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[totalAmount] [decimal](10, 2) NOT NULL,
	[note] [varchar](100) NULL,
	[isDelivered] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[UserOrderProductView]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UserOrderProductView] AS
SELECT
    O.orderId,
    O.orderDate,
    U.userId,
    U.firstName + ' ' + U.lastName AS UserName,
    U.registrationDate AS UserRegistrationDate,
    U.contact AS UserContact,
    U.isAdmin AS IsAdmin,
    P.productId,
    P.productName,
    P.price,
    P.quantity AS ProductQuantity,
    P.createdDate AS ProductCreatedDate,
    P.description AS ProductDescription,
    O.quantity AS OrderQuantity,
    O.totalAmount,
    O.note,
    O.isDelivered
FROM
    orders O
JOIN
    users U ON O.userId = U.userId
JOIN
    products P ON O.productId = P.productId;
GO
/****** Object:  Table [dbo].[suppliers]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[suppliers](
	[supplierId] [int] IDENTITY(1,1) NOT NULL,
	[supplierName] [nvarchar](25) NOT NULL,
	[contact] [varchar](10) NOT NULL,
	[supplierEmail] [nvarchar](50) NULL,
	[registrationDate] [datetime] NULL,
	[isActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[supplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[categories] ON 

INSERT [dbo].[categories] ([categoryId], [categoryName], [description], [createdDate], [isActive]) VALUES (1, N'Category1', N'Description for Category1', CAST(N'2022-01-01T08:00:00.000' AS DateTime), 1)
INSERT [dbo].[categories] ([categoryId], [categoryName], [description], [createdDate], [isActive]) VALUES (2, N'Category2', N'Description for Category2', CAST(N'2022-02-05T10:30:00.000' AS DateTime), 1)
INSERT [dbo].[categories] ([categoryId], [categoryName], [description], [createdDate], [isActive]) VALUES (3, N'Category3', N'Description for Category3', CAST(N'2022-03-20T12:45:00.000' AS DateTime), 1)
INSERT [dbo].[categories] ([categoryId], [categoryName], [description], [createdDate], [isActive]) VALUES (4, N'Category4', N'Description for Category4', CAST(N'2022-04-15T14:15:00.000' AS DateTime), 1)
INSERT [dbo].[categories] ([categoryId], [categoryName], [description], [createdDate], [isActive]) VALUES (5, N'Category5', N'Description for Category5', CAST(N'2022-05-25T16:30:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[categories] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([orderId], [orderDate], [userId], [productId], [quantity], [totalAmount], [note], [isDelivered]) VALUES (3, CAST(N'2022-01-15T09:30:00.000' AS DateTime), 1, 7, 10, CAST(199.90 AS Decimal(10, 2)), N'Order for Product1', 0)
INSERT [dbo].[orders] ([orderId], [orderDate], [userId], [productId], [quantity], [totalAmount], [note], [isDelivered]) VALUES (4, CAST(N'2022-02-20T11:45:00.000' AS DateTime), 2, 6, 5, CAST(149.95 AS Decimal(10, 2)), N'Order for Product2', 1)
INSERT [dbo].[orders] ([orderId], [orderDate], [userId], [productId], [quantity], [totalAmount], [note], [isDelivered]) VALUES (5, CAST(N'2022-03-10T13:00:00.000' AS DateTime), 3, 3, 15, CAST(224.85 AS Decimal(10, 2)), N'Order for Product3', 0)
INSERT [dbo].[orders] ([orderId], [orderDate], [userId], [productId], [quantity], [totalAmount], [note], [isDelivered]) VALUES (6, CAST(N'2022-04-05T14:30:00.000' AS DateTime), 4, 4, 8, CAST(319.92 AS Decimal(10, 2)), N'Order for Product4', 0)
INSERT [dbo].[orders] ([orderId], [orderDate], [userId], [productId], [quantity], [totalAmount], [note], [isDelivered]) VALUES (7, CAST(N'2022-05-12T16:45:00.000' AS DateTime), 5, 5, 12, CAST(299.88 AS Decimal(10, 2)), N'Order for Product5', 1)
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([productId], [categoryId], [productName], [price], [quantity], [createdDate], [description]) VALUES (3, 1, N'Product1', CAST(19.99 AS Decimal(10, 2)), 50, CAST(N'2022-01-15' AS Date), N'Description for Product1')
INSERT [dbo].[products] ([productId], [categoryId], [productName], [price], [quantity], [createdDate], [description]) VALUES (4, 1, N'Product2', CAST(29.99 AS Decimal(10, 2)), 30, CAST(N'2022-02-20' AS Date), N'Description for Product2')
INSERT [dbo].[products] ([productId], [categoryId], [productName], [price], [quantity], [createdDate], [description]) VALUES (5, 2, N'Product3', CAST(14.99 AS Decimal(10, 2)), 80, CAST(N'2022-03-10' AS Date), N'Description for Product3')
INSERT [dbo].[products] ([productId], [categoryId], [productName], [price], [quantity], [createdDate], [description]) VALUES (6, 4, N'Product4', CAST(39.99 AS Decimal(10, 2)), 20, CAST(N'2022-04-05' AS Date), N'Description for Product4')
INSERT [dbo].[products] ([productId], [categoryId], [productName], [price], [quantity], [createdDate], [description]) VALUES (7, 2, N'Product5', CAST(24.99 AS Decimal(10, 2)), 60, CAST(N'2022-05-12' AS Date), N'Description for Product5')
INSERT [dbo].[products] ([productId], [categoryId], [productName], [price], [quantity], [createdDate], [description]) VALUES (11, 2, N'New Product', CAST(19.99 AS Decimal(10, 2)), 100, CAST(N'2024-01-25' AS Date), N'Description of the new product')
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[suppliers] ON 

INSERT [dbo].[suppliers] ([supplierId], [supplierName], [contact], [supplierEmail], [registrationDate], [isActive]) VALUES (1, N'Supplier1', N'1234567890', N'supplier1@example.com', CAST(N'2022-01-01T09:00:00.000' AS DateTime), 0)
INSERT [dbo].[suppliers] ([supplierId], [supplierName], [contact], [supplierEmail], [registrationDate], [isActive]) VALUES (2, N'Supplier2', N'9876543210', N'supplier2@example.com', CAST(N'2022-02-10T11:30:00.000' AS DateTime), 1)
INSERT [dbo].[suppliers] ([supplierId], [supplierName], [contact], [supplierEmail], [registrationDate], [isActive]) VALUES (3, N'Supplier3', N'5678901234', N'supplier3@example.com', CAST(N'2022-03-25T13:45:00.000' AS DateTime), 1)
INSERT [dbo].[suppliers] ([supplierId], [supplierName], [contact], [supplierEmail], [registrationDate], [isActive]) VALUES (4, N'Supplier4', N'3456789012', N'supplier4@example.com', CAST(N'2022-04-15T15:15:00.000' AS DateTime), 1)
INSERT [dbo].[suppliers] ([supplierId], [supplierName], [contact], [supplierEmail], [registrationDate], [isActive]) VALUES (5, N'Supplier5', N'7890123456', N'supplier5@example.com', CAST(N'2022-05-05T17:30:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[suppliers] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([userId], [firstName], [lastName], [registrationDate], [contact], [isAdmin]) VALUES (1, N'John', N'Doe', CAST(N'2022-01-01' AS Date), N'1234567890', 1)
INSERT [dbo].[users] ([userId], [firstName], [lastName], [registrationDate], [contact], [isAdmin]) VALUES (2, N'Jane', N'Smith', CAST(N'2022-02-05' AS Date), N'9876543210', 0)
INSERT [dbo].[users] ([userId], [firstName], [lastName], [registrationDate], [contact], [isAdmin]) VALUES (3, N'Mark', N'Johnson', CAST(N'2022-03-20' AS Date), N'5678901234', 0)
INSERT [dbo].[users] ([userId], [firstName], [lastName], [registrationDate], [contact], [isAdmin]) VALUES (4, N'Alice', N'Williams', CAST(N'2022-04-15' AS Date), N'3456789012', 0)
INSERT [dbo].[users] ([userId], [firstName], [lastName], [registrationDate], [contact], [isAdmin]) VALUES (5, N'Bob', N'Miller', CAST(N'2022-05-25' AS Date), N'7890123456', 1)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ix_products_productName]    Script Date: 24-01-2024 10:35:19 ******/
CREATE NONCLUSTERED INDEX [ix_products_productName] ON [dbo].[products]
(
	[productName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ix_supplier_supplierName]    Script Date: 24-01-2024 10:35:19 ******/
CREATE NONCLUSTERED INDEX [ix_supplier_supplierName] ON [dbo].[suppliers]
(
	[supplierName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT ((0)) FOR [isDelivered]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [isAdmin]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[products] ([productId])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([userId])
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[categories] ([categoryId])
GO
/****** Object:  StoredProcedure [dbo].[AddProduct]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddProduct]
	@categoryId INT,
    @productName NVARCHAR(25),
    @price DECIMAL(10,2),
    @quantity INT,
    @createdDate DATE,
    @description VARCHAR(50)
AS
BEGIN
    INSERT INTO products (productName,categoryId, price, quantity, createdDate, description)
    VALUES (@productName,@categoryId, @price, @quantity, @createdDate, @description);
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUser]
    @orderId INT
AS
BEGIN
    DELETE FROM orders
    WHERE orderId = @orderId;
END;
GO
/****** Object:  StoredProcedure [dbo].[FullOrderProcedure]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FullOrderProcedure]
    @orderId INT
AS
BEGIN
    SELECT
        o.orderId,
        o.orderDate,
        u.userId,
        u.firstName + ' ' + u.lastName AS userName,
        p.productId,
        p.productName,
        o.quantity,
        o.totalAmount,
        o.note,
        o.isDelivered
    FROM
        orders o
    JOIN
        users u ON o.userId = u.userId
    JOIN
        products p ON o.productId = p.productId
    WHERE
        o.orderId = @orderId;
END;
GO
/****** Object:  StoredProcedure [dbo].[SelectAllCategories]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectAllCategories]
AS
BEGIN
    SELECT * FROM categories;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateSupplier]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSupplier]
    @supplierId INT,
    @isActive BIT
AS
BEGIN
    UPDATE suppliers
    SET isActive = @isActive
    WHERE supplierId = @supplierId;
END;
GO
/****** Object:  Trigger [dbo].[Orders_AfterUpdate]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Orders_AfterUpdate]
ON [dbo].[orders]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    PRINT 'Orders have been updated.';
END;
GO
ALTER TABLE [dbo].[orders] ENABLE TRIGGER [Orders_AfterUpdate]
GO
/****** Object:  Trigger [dbo].[Orders_InsteadOfUpdate]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Orders_InsteadOfUpdate]
ON [dbo].[orders]
INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE o
    SET 
        orderDate = i.orderDate,
        userId = i.userId,
        productId = i.productId,
        quantity = i.quantity,
        totalAmount = o.totalAmount, 
        note = i.note,
        isDelivered = i.isDelivered
    FROM orders o
    INNER JOIN inserted i ON o.orderId = i.orderId;
END;
GO
ALTER TABLE [dbo].[orders] ENABLE TRIGGER [Orders_InsteadOfUpdate]
GO
/****** Object:  Trigger [dbo].[trg_AfterUpdate_Products]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_AfterUpdate_Products]
ON [dbo].[products]
AFTER UPDATE
AS
BEGIN
    PRINT 'Products have been updated.';
END;
GO
ALTER TABLE [dbo].[products] ENABLE TRIGGER [trg_AfterUpdate_Products]
GO
/****** Object:  Trigger [dbo].[trg_ForUpdate_Products]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_ForUpdate_Products]
ON [dbo].[products]
FOR UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(Price)
    BEGIN
        UPDATE Orders
        SET OrderDate = GETDATE()
        FROM Orders
        INNER JOIN deleted ON Orders.ProductID = deleted.ProductID
        INNER JOIN inserted ON Orders.ProductID = inserted.ProductID;
    END
END;
GO
ALTER TABLE [dbo].[products] ENABLE TRIGGER [trg_ForUpdate_Products]
GO
/****** Object:  Trigger [dbo].[trg_ForDelete_Users]    Script Date: 24-01-2024 10:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_ForDelete_Users]
ON [dbo].[users]
FOR DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM Orders WHERE UserID IN (SELECT UserID FROM deleted))
    BEGIN
        THROW 50000, 'Cannot delete user with related orders.', 16;
        RETURN;
    END

    DELETE FROM Users WHERE UserID IN (SELECT UserID FROM deleted);
END;
GO
ALTER TABLE [dbo].[users] ENABLE TRIGGER [trg_ForDelete_Users]
GO
USE [master]
GO
ALTER DATABASE [INVENTORYMODULE] SET  READ_WRITE 
GO
