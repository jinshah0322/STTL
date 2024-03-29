USE [master]
GO
/****** Object:  Database [socialmediaapp]    Script Date: 22-01-2024 16:06:23 ******/
CREATE DATABASE [socialmediaapp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'socialmediaapp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\socialmediaapp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'socialmediaapp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\socialmediaapp_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [socialmediaapp] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [socialmediaapp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [socialmediaapp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [socialmediaapp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [socialmediaapp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [socialmediaapp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [socialmediaapp] SET ARITHABORT OFF 
GO
ALTER DATABASE [socialmediaapp] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [socialmediaapp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [socialmediaapp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [socialmediaapp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [socialmediaapp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [socialmediaapp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [socialmediaapp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [socialmediaapp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [socialmediaapp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [socialmediaapp] SET  ENABLE_BROKER 
GO
ALTER DATABASE [socialmediaapp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [socialmediaapp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [socialmediaapp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [socialmediaapp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [socialmediaapp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [socialmediaapp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [socialmediaapp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [socialmediaapp] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [socialmediaapp] SET  MULTI_USER 
GO
ALTER DATABASE [socialmediaapp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [socialmediaapp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [socialmediaapp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [socialmediaapp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [socialmediaapp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [socialmediaapp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [socialmediaapp] SET QUERY_STORE = OFF
GO
USE [socialmediaapp]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 22-01-2024 16:06:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[PostID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[CommentText] [nvarchar](max) NOT NULL,
	[CommentDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Friendships]    Script Date: 22-01-2024 16:06:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Friendships](
	[FriendshipID] [int] IDENTITY(1,1) NOT NULL,
	[UserID1] [int] NOT NULL,
	[UserID2] [int] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[SinceDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FriendshipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 22-01-2024 16:06:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[SenderID] [int] NOT NULL,
	[ReceiverID] [int] NOT NULL,
	[MessageText] [nvarchar](max) NOT NULL,
	[SentDate] [datetime] NOT NULL,
	[IsRead] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Posts]    Script Date: 22-01-2024 16:06:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Caption] [nvarchar](255) NULL,
	[Image] [varbinary](max) NULL,
	[PostedDate] [datetime] NOT NULL,
	[Likes] [int] NULL,
	[IsPublic] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 22-01-2024 16:06:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Birthdate] [date] NULL,
	[ProfileImage] [varbinary](max) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([CommentID], [PostID], [UserID], [CommentText], [CommentDate]) VALUES (1, 1, 2, N'Looks amazing!', CAST(N'2022-01-10T09:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostID], [UserID], [CommentText], [CommentDate]) VALUES (2, 2, 3, N'Great code!', CAST(N'2022-01-11T11:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostID], [UserID], [CommentText], [CommentDate]) VALUES (3, 3, 4, N'Beautiful places!', CAST(N'2022-01-12T13:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostID], [UserID], [CommentText], [CommentDate]) VALUES (4, 4, 5, N'Nature is the best!', CAST(N'2022-01-13T15:00:00.000' AS DateTime))
INSERT [dbo].[Comments] ([CommentID], [PostID], [UserID], [CommentText], [CommentDate]) VALUES (5, 5, 1, N'Love poetry!', CAST(N'2022-01-14T17:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Comments] OFF
GO
SET IDENTITY_INSERT [dbo].[Friendships] ON 

INSERT [dbo].[Friendships] ([FriendshipID], [UserID1], [UserID2], [Status], [SinceDate]) VALUES (1, 1, 2, N'Friends', CAST(N'2022-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Friendships] ([FriendshipID], [UserID1], [UserID2], [Status], [SinceDate]) VALUES (2, 2, 3, N'Friends', CAST(N'2022-01-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Friendships] ([FriendshipID], [UserID1], [UserID2], [Status], [SinceDate]) VALUES (3, 3, 4, N'Friends', CAST(N'2022-01-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Friendships] ([FriendshipID], [UserID1], [UserID2], [Status], [SinceDate]) VALUES (4, 4, 5, N'Friends', CAST(N'2022-01-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Friendships] ([FriendshipID], [UserID1], [UserID2], [Status], [SinceDate]) VALUES (5, 5, 1, N'Friends', CAST(N'2022-01-05T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Friendships] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [MessageText], [SentDate], [IsRead]) VALUES (1, 1, 2, N'Hi Jane! How are you?', CAST(N'2022-01-01T09:30:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [MessageText], [SentDate], [IsRead]) VALUES (2, 2, 3, N'Hey Mark! Working on any projects?', CAST(N'2022-01-02T11:00:00.000' AS DateTime), 1)
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [MessageText], [SentDate], [IsRead]) VALUES (3, 3, 4, N'Hello Alice! Lets plan a trip.', CAST(N'2022-01-03T13:30:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [MessageText], [SentDate], [IsRead]) VALUES (4, 4, 5, N'Hi Bob! Nature hike this weekend?', CAST(N'2022-01-04T15:45:00.000' AS DateTime), 1)
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [MessageText], [SentDate], [IsRead]) VALUES (5, 5, 1, N'Hey John! Poetry night on Friday!', CAST(N'2022-01-05T18:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[Posts] ON 

INSERT [dbo].[Posts] ([PostID], [UserID], [Caption], [Image], [PostedDate], [Likes], [IsPublic]) VALUES (1, 1, N'Enjoying a sunny day!', NULL, CAST(N'2022-01-10T08:30:00.000' AS DateTime), 15, 1)
INSERT [dbo].[Posts] ([PostID], [UserID], [Caption], [Image], [PostedDate], [Likes], [IsPublic]) VALUES (2, 2, N'Coding all day!', NULL, CAST(N'2022-01-11T10:45:00.000' AS DateTime), 20, 1)
INSERT [dbo].[Posts] ([PostID], [UserID], [Caption], [Image], [PostedDate], [Likes], [IsPublic]) VALUES (3, 3, N'Exploring new places.', NULL, CAST(N'2022-01-12T12:15:00.000' AS DateTime), 25, 1)
INSERT [dbo].[Posts] ([PostID], [UserID], [Caption], [Image], [PostedDate], [Likes], [IsPublic]) VALUES (4, 4, N'Nature hike with friends.', NULL, CAST(N'2022-01-13T14:20:00.000' AS DateTime), 18, 1)
INSERT [dbo].[Posts] ([PostID], [UserID], [Caption], [Image], [PostedDate], [Likes], [IsPublic]) VALUES (5, 5, N'Poetry reading night.', NULL, CAST(N'2022-01-14T16:45:00.000' AS DateTime), 30, 1)
SET IDENTITY_INSERT [dbo].[Posts] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [UserName], [FullName], [Email], [Birthdate], [ProfileImage], [IsActive]) VALUES (1, N'john_doe', N'John Doe', N'john.doe@example.com', CAST(N'1990-05-15' AS Date), NULL, 1)
INSERT [dbo].[Users] ([UserID], [UserName], [FullName], [Email], [Birthdate], [ProfileImage], [IsActive]) VALUES (2, N'jane_smith', N'Jane Smith', N'jane.smith@example.com', CAST(N'1985-02-28' AS Date), NULL, 1)
INSERT [dbo].[Users] ([UserID], [UserName], [FullName], [Email], [Birthdate], [ProfileImage], [IsActive]) VALUES (3, N'mark_johnson', N'Mark Johnson', N'mark.johnson@example.com', CAST(N'1992-12-10' AS Date), NULL, 1)
INSERT [dbo].[Users] ([UserID], [UserName], [FullName], [Email], [Birthdate], [ProfileImage], [IsActive]) VALUES (4, N'alice_williams', N'Alice Williams', N'alice.williams@example.com', CAST(N'1987-07-03' AS Date), NULL, 1)
INSERT [dbo].[Users] ([UserID], [UserName], [FullName], [Email], [Birthdate], [ProfileImage], [IsActive]) VALUES (5, N'bob_miller', N'Bob Miller', N'bob.miller@example.com', CAST(N'1984-09-25' AS Date), NULL, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D1053457FED3BC]    Script Date: 22-01-2024 16:06:24 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Messages] ADD  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT ((0)) FOR [Likes]
GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT ((1)) FOR [IsPublic]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([PostID])
REFERENCES [dbo].[Posts] ([PostID])
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Friendships]  WITH CHECK ADD FOREIGN KEY([UserID1])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Friendships]  WITH CHECK ADD FOREIGN KEY([UserID2])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([ReceiverID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([SenderID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
USE [master]
GO
ALTER DATABASE [socialmediaapp] SET  READ_WRITE 
GO
