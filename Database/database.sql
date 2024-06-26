USE [SchoolDB]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 5/17/2024 3:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DepartmentId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 5/17/2024 3:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 5/17/2024 3:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 5/17/2024 3:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Gender] [nvarchar](10) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[ClassId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Classes] ON 

INSERT [dbo].[Classes] ([Id], [Name], [DepartmentId]) VALUES (1, N'K15CNTTA', 1)
INSERT [dbo].[Classes] ([Id], [Name], [DepartmentId]) VALUES (2, N'K16KT', 2)
INSERT [dbo].[Classes] ([Id], [Name], [DepartmentId]) VALUES (3, N'K17NNTA', 3)
SET IDENTITY_INSERT [dbo].[Classes] OFF
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([Id], [Name], [Description]) VALUES (1, N'Lập trình hướng đối tượng', N'Tìm hiểu về các khái niệm và kỹ thuật lập trình hướng đối tượng')
INSERT [dbo].[Courses] ([Id], [Name], [Description]) VALUES (2, N'Cấu trúc dữ liệu và giải thuật', N'Nghiên cứu về các cấu trúc dữ liệu cơ bản và các giải thuật xử lý chúng')
INSERT [dbo].[Courses] ([Id], [Name], [Description]) VALUES (3, N'Kinh tế vi mô', N'Phân tích hành vi của các cá nhân và doanh nghiệp trong nền kinh tế')
INSERT [dbo].[Courses] ([Id], [Name], [Description]) VALUES (4, N'Toán cao cấp', N'Học về các khái niệm toán học nâng cao')
INSERT [dbo].[Courses] ([Id], [Name], [Description]) VALUES (5, N'Toán cao cấp 1', N'Học về các khái niệm toán học nâng cao')
INSERT [dbo].[Courses] ([Id], [Name], [Description]) VALUES (6, N'Toán cao cấp 2', N'Học về các khái niệm toán học nâng cao')
INSERT [dbo].[Courses] ([Id], [Name], [Description]) VALUES (9, N'Toán cao cấp 3', N'Học về các khái niệm toán học nâng cao')
INSERT [dbo].[Courses] ([Id], [Name], [Description]) VALUES (14, N'Toán cao cấp 4', N'Học về các khái niệm toán học nâng cao')
INSERT [dbo].[Courses] ([Id], [Name], [Description]) VALUES (15, N'Toán cao cấp 5', N'Học về các khái niệm toán học nâng cao')
SET IDENTITY_INSERT [dbo].[Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([Id], [Name], [Description]) VALUES (1, N'Khoa Công ngh? thông tin', N'Chuyên ngành về lập trình, mạng máy tính, ...')
INSERT [dbo].[Departments] ([Id], [Name], [Description]) VALUES (2, N'Khoa Kinh t?', N'Chuyên ngành về tài chính, kế toán, ...')
INSERT [dbo].[Departments] ([Id], [Name], [Description]) VALUES (3, N'Khoa Ngo?i ng?', N'Chuyên ngành về tiếng Anh, tiếng Nhật, ...')
SET IDENTITY_INSERT [dbo].[Departments] OFF
GO
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [Gender], [Email], [PhoneNumber], [ClassId]) VALUES (1, N'Nguyễn', N'Văn A', CAST(N'2000-01-01' AS Date), N'Nam', N'nguyenvana@example.com', N'0912345678', 1)
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [Gender], [Email], [PhoneNumber], [ClassId]) VALUES (2, N'Trần', N'Thị B', CAST(N'1999-05-15' AS Date), N'Nữ', N'tranthib@example.com', N'0987654321', 2)
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [Gender], [Email], [PhoneNumber], [ClassId]) VALUES (3, N'Lê', N'Văn C', CAST(N'2001-12-20' AS Date), N'Nam', N'levanc@example.com', N'0123456789', 1)
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [Gender], [Email], [PhoneNumber], [ClassId]) VALUES (4, N'Phạm', N'Thị D', CAST(N'1998-08-10' AS Date), N'Nữ', N'phamthid@example.com', N'0345678901', 3)
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Courses__737584F65EFA8BCD]    Script Date: 5/17/2024 3:55:21 PM ******/
ALTER TABLE [dbo].[Courses] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Departme__737584F6174BC455]    Script Date: 5/17/2024 3:55:21 PM ******/
ALTER TABLE [dbo].[Departments] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Students__A9D105348CAB6714]    Script Date: 5/17/2024 3:55:21 PM ******/
ALTER TABLE [dbo].[Students] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([Id])
GO
