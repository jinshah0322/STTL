USE [master]
GO
/****** Object:  Database [librarymanagement]    Script Date: 24-01-2024 10:35:57 ******/
CREATE DATABASE [librarymanagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'librarymanagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\librarymanagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'librarymanagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\librarymanagement_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [librarymanagement] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [librarymanagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [librarymanagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [librarymanagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [librarymanagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [librarymanagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [librarymanagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [librarymanagement] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [librarymanagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [librarymanagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [librarymanagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [librarymanagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [librarymanagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [librarymanagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [librarymanagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [librarymanagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [librarymanagement] SET  ENABLE_BROKER 
GO
ALTER DATABASE [librarymanagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [librarymanagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [librarymanagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [librarymanagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [librarymanagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [librarymanagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [librarymanagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [librarymanagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [librarymanagement] SET  MULTI_USER 
GO
ALTER DATABASE [librarymanagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [librarymanagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [librarymanagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [librarymanagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [librarymanagement] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [librarymanagement] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [librarymanagement] SET QUERY_STORE = OFF
GO
USE [librarymanagement]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAuthorFullName]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetAuthorFullName](@authorId INT)
RETURNS NVARCHAR(200)
AS
BEGIN
DECLARE @FullName NVARCHAR(200)
SELECT @FullName = CONCAT(firstName, ' ', lastName) FROM authors WHERE authorId = @authorId
RETURN @FullName
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetMemberAge]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetMemberAge](@memberId INT)
RETURNS INT
AS
BEGIN
DECLARE @Age INT
SELECT @Age = DATEDIFF(YEAR, birthDate, GETDATE()) FROM members WHERE memberId = @memberId
RETURN @Age
END;
GO
/****** Object:  Table [dbo].[authors]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[authors](
	[authorId] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [nvarchar](100) NOT NULL,
	[lastName] [nvarchar](100) NOT NULL,
	[birthdate] [date] NULL,
	[nationality] [nvarchar](100) NULL,
	[awarded] [bit] NOT NULL,
	[awardDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[authorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[publisher]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[publisher](
	[publisherId] [int] IDENTITY(1,1) NOT NULL,
	[publisherName] [nvarchar](100) NOT NULL,
	[publishDate] [date] NOT NULL,
	[publisherContact] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[publisherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[books]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[books](
	[bookId] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[author] [nvarchar](100) NOT NULL,
	[genre] [nvarchar](100) NULL,
	[publishDate] [date] NOT NULL,
	[copiesAvailable] [int] NOT NULL,
	[shelfLocation] [nvarchar](100) NULL,
	[price] [decimal](10, 2) NOT NULL,
	[authorId] [int] NOT NULL,
	[publisherId] [int] NOT NULL,
	[isEook] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[bookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BookAuthorPublisherView]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BookAuthorPublisherView] AS
SELECT
    B.bookId,
    B.title,
    B.genre,
    B.publishDate AS BookPublishDate,
    B.copiesAvailable,
    B.shelfLocation,
    B.price,
    B.isEook,
    A.authorId,
    A.firstName + ' ' + A.lastName AS AuthorName,
    A.birthdate AS AuthorBirthdate,
    A.nationality AS AuthorNationality,
    A.awarded AS AuthorAwarded,
    A.awardDate AS AuthorAwardDate,
    P.publisherId,
    P.publisherName,
    P.publishDate AS PublisherPublishDate,
    P.publisherContact
FROM
    books B
JOIN
    authors A ON B.authorId = A.authorId
JOIN
    publisher P ON B.publisherId = P.publisherId;
GO
/****** Object:  Table [dbo].[reviews]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reviews](
	[reviewId] [int] IDENTITY(1,1) NOT NULL,
	[memberId] [int] NOT NULL,
	[bookId] [int] NOT NULL,
	[rating] [tinyint] NOT NULL,
	[comment] [nvarchar](100) NULL,
	[reviewDate] [datetime] NOT NULL,
	[reviewSentiment] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[reviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BookReviewView]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BookReviewView] AS
SELECT
    B.bookId,
    B.title,
    B.genre,
    B.publishDate AS BookPublishDate,
    B.copiesAvailable,
    B.shelfLocation,
    B.price,
    B.isEook,
    R.reviewId,
    R.memberId,
    R.rating,
    R.comment,
    R.reviewDate,
    R.reviewSentiment
FROM
    books B
JOIN
    reviews R ON B.bookId = R.bookId
GO
/****** Object:  Table [dbo].[members]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[members](
	[memberId] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [nvarchar](100) NOT NULL,
	[lastName] [nvarchar](100) NOT NULL,
	[birthDate] [date] NULL,
	[contact] [varchar](10) NOT NULL,
	[memberType] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[memberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[authors] ON 

INSERT [dbo].[authors] ([authorId], [firstName], [lastName], [birthdate], [nationality], [awarded], [awardDate]) VALUES (1, N'John', N'Doe', CAST(N'1980-05-15' AS Date), N'American', 1, CAST(N'2005-08-20' AS Date))
INSERT [dbo].[authors] ([authorId], [firstName], [lastName], [birthdate], [nationality], [awarded], [awardDate]) VALUES (2, N'Jane', N'Smith', CAST(N'1975-02-28' AS Date), N'British', 0, NULL)
INSERT [dbo].[authors] ([authorId], [firstName], [lastName], [birthdate], [nationality], [awarded], [awardDate]) VALUES (3, N'Mark', N'Johnson', CAST(N'1990-12-10' AS Date), N'Canadian', 1, CAST(N'2010-03-18' AS Date))
INSERT [dbo].[authors] ([authorId], [firstName], [lastName], [birthdate], [nationality], [awarded], [awardDate]) VALUES (4, N'Alice', N'Williams', CAST(N'1985-07-03' AS Date), N'Australian', 0, NULL)
INSERT [dbo].[authors] ([authorId], [firstName], [lastName], [birthdate], [nationality], [awarded], [awardDate]) VALUES (5, N'Bob', N'Miller', CAST(N'1982-09-25' AS Date), N'German', 1, CAST(N'2007-06-12' AS Date))
SET IDENTITY_INSERT [dbo].[authors] OFF
GO
SET IDENTITY_INSERT [dbo].[books] ON 

INSERT [dbo].[books] ([bookId], [title], [author], [genre], [publishDate], [copiesAvailable], [shelfLocation], [price], [authorId], [publisherId], [isEook]) VALUES (1, N'The Book of Everything', N'John Doe', N'Fiction', CAST(N'2000-05-20' AS Date), 100, N'A1', CAST(9.99 AS Decimal(10, 2)), 1, 1, 0)
INSERT [dbo].[books] ([bookId], [title], [author], [genre], [publishDate], [copiesAvailable], [shelfLocation], [price], [authorId], [publisherId], [isEook]) VALUES (2, N'Coding 101', N'Jane Smith', N'Programming', CAST(N'2015-12-08' AS Date), 50, N'B2', CAST(35.50 AS Decimal(10, 2)), 2, 2, 1)
INSERT [dbo].[books] ([bookId], [title], [author], [genre], [publishDate], [copiesAvailable], [shelfLocation], [price], [authorId], [publisherId], [isEook]) VALUES (3, N'History of Science', N'Mark Johnson', N'Non-Fiction', CAST(N'2012-07-15' AS Date), 75, N'C3', CAST(18.75 AS Decimal(10, 2)), 3, 3, 0)
INSERT [dbo].[books] ([bookId], [title], [author], [genre], [publishDate], [copiesAvailable], [shelfLocation], [price], [authorId], [publisherId], [isEook]) VALUES (4, N'Nature Exploration', N'Alice Williams', N'Nature', CAST(N'2008-09-30' AS Date), 30, N'D4', CAST(12.99 AS Decimal(10, 2)), 4, 1, 0)
INSERT [dbo].[books] ([bookId], [title], [author], [genre], [publishDate], [copiesAvailable], [shelfLocation], [price], [authorId], [publisherId], [isEook]) VALUES (5, N'Poetry Collection', N'Bob Miller', N'Poetry', CAST(N'2019-04-12' AS Date), 20, N'E5', CAST(8.50 AS Decimal(10, 2)), 5, 2, 1)
SET IDENTITY_INSERT [dbo].[books] OFF
GO
SET IDENTITY_INSERT [dbo].[members] ON 

INSERT [dbo].[members] ([memberId], [firstName], [lastName], [birthDate], [contact], [memberType]) VALUES (1, N'Alice', N'Doe', CAST(N'1995-03-10' AS Date), N'9876543210', N'S')
INSERT [dbo].[members] ([memberId], [firstName], [lastName], [birthDate], [contact], [memberType]) VALUES (2, N'Bob', N'Smith', CAST(N'1980-09-18' AS Date), N'1234567890', N'F')
INSERT [dbo].[members] ([memberId], [firstName], [lastName], [birthDate], [contact], [memberType]) VALUES (3, N'Charlie', N'Johnson', CAST(N'1992-11-05' AS Date), N'5678901234', N'S')
INSERT [dbo].[members] ([memberId], [firstName], [lastName], [birthDate], [contact], [memberType]) VALUES (4, N'David', N'White', CAST(N'1988-06-22' AS Date), N'3456789012', N'F')
INSERT [dbo].[members] ([memberId], [firstName], [lastName], [birthDate], [contact], [memberType]) VALUES (5, N'Eva', N'Davis', CAST(N'1997-12-03' AS Date), N'7890123456', N'S')
INSERT [dbo].[members] ([memberId], [firstName], [lastName], [birthDate], [contact], [memberType]) VALUES (6, N'John', N'Doe', CAST(N'1990-01-01' AS Date), N'1234567890', N'A')
SET IDENTITY_INSERT [dbo].[members] OFF
GO
SET IDENTITY_INSERT [dbo].[publisher] ON 

INSERT [dbo].[publisher] ([publisherId], [publisherName], [publishDate], [publisherContact]) VALUES (1, N'ABC Publishers', CAST(N'2000-01-15' AS Date), N'1234567890')
INSERT [dbo].[publisher] ([publisherId], [publisherName], [publishDate], [publisherContact]) VALUES (2, N'XYZ Publications', CAST(N'1995-08-22' AS Date), N'9876543210')
INSERT [dbo].[publisher] ([publisherId], [publisherName], [publishDate], [publisherContact]) VALUES (3, N'BookHouse', CAST(N'2005-03-10' AS Date), N'5678901234')
SET IDENTITY_INSERT [dbo].[publisher] OFF
GO
SET IDENTITY_INSERT [dbo].[reviews] ON 

INSERT [dbo].[reviews] ([reviewId], [memberId], [bookId], [rating], [comment], [reviewDate], [reviewSentiment]) VALUES (2, 2, 2, 5, N'Excellent coding guide.', CAST(N'2022-01-02T10:45:00.000' AS DateTime), 1)
INSERT [dbo].[reviews] ([reviewId], [memberId], [bookId], [rating], [comment], [reviewDate], [reviewSentiment]) VALUES (3, 3, 3, 3, N'Interesting history book.', CAST(N'2022-01-03T12:15:00.000' AS DateTime), 0)
INSERT [dbo].[reviews] ([reviewId], [memberId], [bookId], [rating], [comment], [reviewDate], [reviewSentiment]) VALUES (4, 4, 4, 4, N'Enjoyed the nature exploration.', CAST(N'2022-01-04T14:20:00.000' AS DateTime), 1)
INSERT [dbo].[reviews] ([reviewId], [memberId], [bookId], [rating], [comment], [reviewDate], [reviewSentiment]) VALUES (5, 5, 5, 3, N'Nice collection of poetry.', CAST(N'2022-01-05T16:45:00.000' AS DateTime), 0)
INSERT [dbo].[reviews] ([reviewId], [memberId], [bookId], [rating], [comment], [reviewDate], [reviewSentiment]) VALUES (8, 2, 2, 3, N'good', CAST(N'2024-01-23T15:14:21.940' AS DateTime), 1)
INSERT [dbo].[reviews] ([reviewId], [memberId], [bookId], [rating], [comment], [reviewDate], [reviewSentiment]) VALUES (9, 2, 2, 1, N'bad', CAST(N'2024-01-23T15:14:58.850' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[reviews] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ix_authors_firstName]    Script Date: 24-01-2024 10:35:58 ******/
CREATE NONCLUSTERED INDEX [ix_authors_firstName] ON [dbo].[authors]
(
	[firstName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ix_books_title]    Script Date: 24-01-2024 10:35:58 ******/
CREATE NONCLUSTERED INDEX [ix_books_title] ON [dbo].[books]
(
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[books] ADD  DEFAULT ((0)) FOR [isEook]
GO
ALTER TABLE [dbo].[books]  WITH CHECK ADD FOREIGN KEY([authorId])
REFERENCES [dbo].[authors] ([authorId])
GO
ALTER TABLE [dbo].[books]  WITH CHECK ADD FOREIGN KEY([publisherId])
REFERENCES [dbo].[publisher] ([publisherId])
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD FOREIGN KEY([bookId])
REFERENCES [dbo].[books] ([bookId])
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD FOREIGN KEY([memberId])
REFERENCES [dbo].[members] ([memberId])
GO
/****** Object:  StoredProcedure [dbo].[AddMember]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddMember]
    @firstName NVARCHAR(100),
    @lastName NVARCHAR(100),
    @birthDate DATE,
    @contact VARCHAR(10),
    @memberType CHAR(1)
AS
BEGIN
    INSERT INTO members (firstName, lastName, birthDate, contact, memberType)
    VALUES (@firstName, @lastName, @birthDate, @contact, @memberType);
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteReview]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteReview]
    @reviewId INT
AS
BEGIN
    DELETE FROM reviews
    WHERE reviewId = @reviewId;
END;
GO
/****** Object:  StoredProcedure [dbo].[FullProcedure]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FullProcedure]
    @authorFirstName NVARCHAR(100)
AS
BEGIN
    SELECT a.*, b.*, m.*, r.*
    FROM authors a
    JOIN books b ON a.authorId = b.authorId
    JOIN reviews r ON b.bookId = r.bookId
    JOIN members m ON r.memberId = m.memberId
    WHERE a.firstName = @authorFirstName;
END;
GO
/****** Object:  StoredProcedure [dbo].[SelectAllAuthors]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectAllAuthors]
AS
BEGIN
    SELECT * FROM authors;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateBook]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateBook]
    @bookId INT,
    @price DECIMAL(10,2)
AS
BEGIN
    UPDATE books
    SET price = @price
    WHERE bookId = @bookId;
END;
GO
/****** Object:  Trigger [dbo].[trg_AfterDelete_Books]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_AfterDelete_Books]
ON [dbo].[books]
AFTER DELETE
AS
BEGIN
    PRINT 'Book and associated reviews have been deleted.';
END;
GO
ALTER TABLE [dbo].[books] ENABLE TRIGGER [trg_AfterDelete_Books]
GO
/****** Object:  Trigger [dbo].[trg_AfterUpdate_Books]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_AfterUpdate_Books]
ON [dbo].[books]
AFTER UPDATE
AS
BEGIN
    PRINT 'Books have been updated.';
END;
GO
ALTER TABLE [dbo].[books] ENABLE TRIGGER [trg_AfterUpdate_Books]
GO
/****** Object:  Trigger [dbo].[trg_ForDelete_Books]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_ForDelete_Books]
ON [dbo].[books]
FOR DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM Reviews WHERE BookID IN (SELECT BookID FROM deleted))
    BEGIN
        THROW 50000, 'Cannot delete book with associated reviews.', 16;
        RETURN;
    END

    DELETE FROM Books WHERE BookID IN (SELECT BookID FROM deleted);
END;
GO
ALTER TABLE [dbo].[books] ENABLE TRIGGER [trg_ForDelete_Books]
GO
/****** Object:  Trigger [dbo].[trg_ForUpdate_Books]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_ForUpdate_Books]
ON [dbo].[books]
FOR UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(publishDate)
    BEGIN
        UPDATE Reviews
        SET reviewDate = GETDATE()
        FROM Reviews
        INNER JOIN deleted ON Reviews.BookID = deleted.BookID
        INNER JOIN inserted ON Reviews.BookID = inserted.BookID;
    END
END;
GO
ALTER TABLE [dbo].[books] ENABLE TRIGGER [trg_ForUpdate_Books]
GO
/****** Object:  Trigger [dbo].[Review_AfterInsert]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Review_AfterInsert]
ON [dbo].[reviews]
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON
	UPDATE r SET reviewSentiment=CASE WHEN i.rating>=3 THEN 1 ELSE 0 END
	FROM reviews r 
	INNER JOIN inserted i ON r.reviewID=i.reviewId;
END;
GO
ALTER TABLE [dbo].[reviews] ENABLE TRIGGER [Review_AfterInsert]
GO
/****** Object:  Trigger [dbo].[Review_InsteadOfInsert]    Script Date: 24-01-2024 10:35:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Review_InsteadOfInsert]
ON [dbo].[reviews]
FOR INSERT
AS
BEGIN 
	SET NOCOUNT ON
	INSERT INTO reviews (memberId, bookId, rating, comment, reviewDate, reviewSentiment) 
	SELECT 
		memberId,
		bookId,
		CASE WHEN rating BETWEEN 1 AND 5 THEN rating else 3 END,
		comment,reviewDate,reviewSentiment
	FROM inserted
END;
GO
ALTER TABLE [dbo].[reviews] ENABLE TRIGGER [Review_InsteadOfInsert]
GO
USE [master]
GO
ALTER DATABASE [librarymanagement] SET  READ_WRITE 
GO
