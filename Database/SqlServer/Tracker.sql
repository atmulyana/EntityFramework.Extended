USE [master]
GO
/****** Object:  Database [Tracker]  ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'Tracker')
BEGIN
CREATE DATABASE [Tracker]
END
GO
USE [Tracker]
GO

/****** Object:  Table [dbo].[ATable] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ATable](
	[A] [float] NOT NULL,
	[B] [nvarchar](50) NOT NULL,
	[C] [int] IDENTITY(1,1) NOT NULL,
	[D] [date] NOT NULL,
	[E] [bit] NULL,
 CONSTRAINT [PK_ATable] PRIMARY KEY CLUSTERED 
(
	[C] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Audit]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Audit]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Audit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[UserId] [int] NULL,
	[TaskId] [int] NULL,
	[Content] [varchar](max) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Audit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[Audit] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Priority]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Priority]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Priority](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Order] [int] NOT NULL,
	[Description] [nvarchar](200) NULL,
	[CreatedDate] [datetime] NOT NULL DEFAULT (getdate()),
	[ModifiedDate] [datetime] NOT NULL DEFAULT (getdate()),
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Priority] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Priority] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Role]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Role]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](150) NULL,
	[CreatedDate] [datetime] NOT NULL DEFAULT (getdate()),
	[ModifiedDate] [datetime] NOT NULL DEFAULT (getdate()),
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Role] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Status]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Status]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Status](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](150) NULL,
	[Order] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL DEFAULT (getdate()),
	[ModifiedDate] [datetime] NOT NULL DEFAULT (getdate()),
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Status] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Task]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Task]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Task](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StatusId] [int] NOT NULL,
	[PriorityId] [int] NULL,
	[CreatedId] [int] NOT NULL,
	[Summary] [nvarchar](255) NOT NULL,
	[Details] [nvarchar](2000) NULL,
	[StartDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[CompleteDate] [datetime] NULL,
	[AssignedId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL DEFAULT (getdate()),
	[ModifiedDate] [datetime] NOT NULL DEFAULT (getdate()),
	[RowVersion] [timestamp] NOT NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Task] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[TaskExtended]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaskExtended]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TaskExtended](
	[TaskId] [int] NOT NULL,
	[Browser] [nvarchar](200) NULL,
	[OS] [nvarchar](150) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_TaskExtended] PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC
)
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[TaskExtended] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[User]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [nvarchar](250) NOT NULL,
	[FirstName] [nvarchar](200) NULL,
	[LastName] [nvarchar](200) NULL,
	[Avatar] [varbinary](max) NULL,
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__User__CreatedDat__1920BF5C]  DEFAULT (getdate()),
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF__User__ModifiedDa__1A14E395]  DEFAULT (getdate()),
	[RowVersion] [timestamp] NOT NULL,
	[PasswordHash] [char](86) NOT NULL CONSTRAINT [DF__User__PasswordHa__3A81B327]  DEFAULT (''),
	[PasswordSalt] [char](5) NOT NULL CONSTRAINT [DF__User__PasswordSa__3B75D760]  DEFAULT (''),
	[Comment] [text] NULL,
	[IsApproved] [bit] NOT NULL CONSTRAINT [DF__User__IsApproved__3C69FB99]  DEFAULT ((1)),
	[LastLoginDate] [datetime] NULL CONSTRAINT [DF__User__LastLoginD__3D5E1FD2]  DEFAULT (getdate()),
	[LastActivityDate] [datetime] NOT NULL CONSTRAINT [DF__User__LastActivi__3E52440B]  DEFAULT (getdate()),
	[LastPasswordChangeDate] [datetime] NULL,
	[AvatarType] [nvarchar](150) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER AUTHORIZATION ON [dbo].[User] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[UserRole]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRole]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserRole](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[UserRole] TO  SCHEMA OWNER 
GO
INSERT [dbo].[Priority] ([Id], [Name], [Order], [Description], [CreatedDate], [ModifiedDate]) VALUES (1, N'High', 1, N'A High Priority', CAST(N'2011-09-08 13:57:02.743' AS DateTime), CAST(N'2011-09-08 13:57:02.743' AS DateTime))
GO
INSERT [dbo].[Priority] ([Id], [Name], [Order], [Description], [CreatedDate], [ModifiedDate]) VALUES (2, N'Normal', 2, N'A Normal Priority', CAST(N'2011-09-08 13:57:02.743' AS DateTime), CAST(N'2011-09-08 13:57:02.743' AS DateTime))
GO
INSERT [dbo].[Priority] ([Id], [Name], [Order], [Description], [CreatedDate], [ModifiedDate]) VALUES (3, N'Low', 3, N'A Low Priority', CAST(N'2011-09-08 13:57:02.743' AS DateTime), CAST(N'2011-09-08 13:57:02.743' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

GO
INSERT [dbo].[Role] ([Id], [Name], [Description], [CreatedDate], [ModifiedDate]) VALUES (1, N'Admin', NULL, CAST(N'2011-09-08 13:57:02.730' AS DateTime), CAST(N'2011-09-08 13:57:02.730' AS DateTime))
GO
INSERT [dbo].[Role] ([Id], [Name], [Description], [CreatedDate], [ModifiedDate]) VALUES (2, N'Manager', NULL, CAST(N'2011-09-08 13:57:02.730' AS DateTime), CAST(N'2011-09-08 13:57:02.730' AS DateTime))
GO
INSERT [dbo].[Role] ([Id], [Name], [Description], [CreatedDate], [ModifiedDate]) VALUES (3, N'Newb', NULL, CAST(N'2011-09-08 13:57:02.730' AS DateTime), CAST(N'2011-09-08 13:57:02.730' AS DateTime))
GO
INSERT [dbo].[Role] ([Id], [Name], [Description], [CreatedDate], [ModifiedDate]) VALUES (4, N'Nobody', NULL, CAST(N'2011-09-08 13:57:02.730' AS DateTime), CAST(N'2011-09-08 13:57:02.730' AS DateTime))
GO
INSERT [dbo].[Role] ([Id], [Name], [Description], [CreatedDate], [ModifiedDate]) VALUES (5, N'Power User', NULL, CAST(N'2011-09-08 13:57:02.730' AS DateTime), CAST(N'2011-09-08 13:57:02.730' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Status] ON 

GO
INSERT [dbo].[Status] ([Id], [Name], [Description], [Order], [CreatedDate], [ModifiedDate]) VALUES (1, N'Not Started', NULL, 1, CAST(N'2011-09-08 13:57:02.733' AS DateTime), CAST(N'2011-09-08 13:57:02.733' AS DateTime))
GO
INSERT [dbo].[Status] ([Id], [Name], [Description], [Order], [CreatedDate], [ModifiedDate]) VALUES (2, N'In Progress', NULL, 2, CAST(N'2011-09-08 13:57:02.733' AS DateTime), CAST(N'2011-09-08 13:57:02.733' AS DateTime))
GO
INSERT [dbo].[Status] ([Id], [Name], [Description], [Order], [CreatedDate], [ModifiedDate]) VALUES (3, N'Completed', NULL, 3, CAST(N'2011-09-08 13:57:02.733' AS DateTime), CAST(N'2011-09-08 13:57:02.733' AS DateTime))
GO
INSERT [dbo].[Status] ([Id], [Name], [Description], [Order], [CreatedDate], [ModifiedDate]) VALUES (4, N'Waiting on someone else', NULL, 4, CAST(N'2011-09-08 13:57:02.733' AS DateTime), CAST(N'2011-09-08 13:57:02.733' AS DateTime))
GO
INSERT [dbo].[Status] ([Id], [Name], [Description], [Order], [CreatedDate], [ModifiedDate]) VALUES (5, N'Deferred', NULL, 5, CAST(N'2011-09-08 13:57:02.733' AS DateTime), CAST(N'2011-09-08 13:57:02.733' AS DateTime))
GO
INSERT [dbo].[Status] ([Id], [Name], [Description], [Order], [CreatedDate], [ModifiedDate]) VALUES (6, N'Done', NULL, 6, CAST(N'2011-09-08 13:57:02.733' AS DateTime), CAST(N'2011-09-08 13:57:02.733' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Status] OFF
GO
SET IDENTITY_INSERT [dbo].[Task] ON 

GO
INSERT [dbo].[Task] ([Id], [StatusId], [PriorityId], [CreatedId], [Summary], [Details], [StartDate], [DueDate], [CompleteDate], [AssignedId], [CreatedDate], [ModifiedDate], [LastModifiedBy]) VALUES (1, 1, 1, 2, N'Make it to Earth', N'Find and make it to earth while avoiding the cylons.', NULL, NULL, NULL, 1, CAST(N'2009-12-18 11:01:58.713' AS DateTime), CAST(N'2009-12-18 11:01:58.713' AS DateTime), N'laura.roslin@battlestar.com')
GO
SET IDENTITY_INSERT [dbo].[Task] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

GO
INSERT [dbo].[User] ([Id], [EmailAddress], [FirstName], [LastName], [Avatar], [CreatedDate], [ModifiedDate], [PasswordHash], [PasswordSalt], [Comment], [IsApproved], [LastLoginDate], [LastActivityDate], [LastPasswordChangeDate], [AvatarType]) VALUES (1, N'william.adama@battlestar.com', N'William', N'Adama', NULL, CAST(N'2009-05-06 17:46:20.597' AS DateTime), CAST(N'2009-05-06 17:46:20.597' AS DateTime), N'1+v5rvSXnyX7tvwTKfM+aq+s0hDmNXsduGZfq8sQv1ggPnGlQdDdBdbUP0bUmbMbiU40PvRQWKRAy5QUd1xrAA', N'?#nkY', NULL, 1, NULL, CAST(N'2009-05-06 17:46:20.597' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [EmailAddress], [FirstName], [LastName], [Avatar], [CreatedDate], [ModifiedDate], [PasswordHash], [PasswordSalt], [Comment], [IsApproved], [LastLoginDate], [LastActivityDate], [LastPasswordChangeDate], [AvatarType]) VALUES (2, N'laura.roslin@battlestar.com', N'Laura', N'Roslin', NULL, CAST(N'2009-05-06 17:47:00.330' AS DateTime), CAST(N'2009-05-06 17:47:00.330' AS DateTime), N'Sx/jwRHFW/CQpO0E6G8d+jo344AmAKfX+C48a0iAZyMrb4sE8VoDuyZorbhbLZAX9f4UZk67O7eCjk854OrYSg', N'Ph)6;', NULL, 1, NULL, CAST(N'2009-05-06 17:47:00.330' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [EmailAddress], [FirstName], [LastName], [Avatar], [CreatedDate], [ModifiedDate], [PasswordHash], [PasswordSalt], [Comment], [IsApproved], [LastLoginDate], [LastActivityDate], [LastPasswordChangeDate], [AvatarType]) VALUES (3, N'kara.thrace@battlestar.com', N'Kara', N'Thrace', NULL, CAST(N'2009-05-06 17:47:43.417' AS DateTime), CAST(N'2009-05-06 17:47:43.417' AS DateTime), N'5KhtS4ax7G1aGkq97w02ooVZMmJp8bcySEKMSxruXu/Z/wRKoNAxMlkjRVY1yLavrC3GRYQZjy5b6JW8cR5EWg', N'!]@2/', NULL, 1, NULL, CAST(N'2009-05-06 17:47:43.417' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [EmailAddress], [FirstName], [LastName], [Avatar], [CreatedDate], [ModifiedDate], [PasswordHash], [PasswordSalt], [Comment], [IsApproved], [LastLoginDate], [LastActivityDate], [LastPasswordChangeDate], [AvatarType]) VALUES (4, N'lee.adama@battlestar.com', N'Lee', N'Adama', NULL, CAST(N'2009-05-06 17:48:02.367' AS DateTime), CAST(N'2009-05-06 17:48:02.367' AS DateTime), N'IrK8OhI2n4Ev3YA4y5kP7vy+n2CffX2MgcONbAh6/kZpNZYBYoYyrMhqdYztehL0NAIdvcInQ6zOjMplq+zWQA', N'e@_a{', NULL, 1, NULL, CAST(N'2009-05-06 17:48:02.367' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [EmailAddress], [FirstName], [LastName], [Avatar], [CreatedDate], [ModifiedDate], [PasswordHash], [PasswordSalt], [Comment], [IsApproved], [LastLoginDate], [LastActivityDate], [LastPasswordChangeDate], [AvatarType]) VALUES (5, N'gaius.baltar@battlestar.com', N'Gaius', N'Baltar', NULL, CAST(N'2009-05-06 17:48:26.273' AS DateTime), CAST(N'2009-05-06 17:48:26.273' AS DateTime), N'7tfajMaEerDNVgi6Oi6UJ6JxsUXZ0u4zQeUrZQxnaXJQ2f2vd9AzBR4sVOaH7LZtCjQopMzlQ38QqNEnpK0B/g', N'_qpA2', NULL, 1, NULL, CAST(N'2009-05-06 17:48:26.273' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [EmailAddress], [FirstName], [LastName], [Avatar], [CreatedDate], [ModifiedDate], [PasswordHash], [PasswordSalt], [Comment], [IsApproved], [LastLoginDate], [LastActivityDate], [LastPasswordChangeDate], [AvatarType]) VALUES (6, N'saul.tigh@battlestar.com', N'Saul', N'Tigh', NULL, CAST(N'2009-05-06 17:49:26.023' AS DateTime), CAST(N'2009-05-06 17:49:26.023' AS DateTime), N'wzkR89zRXe7hND1jqAP9xgupYJBvEZcjsfUe3TaU45kxRajjjS9u0fOTLK+uglzk67EGochJdeoikWs7hxMNRA', N'h]-zG', NULL, 1, NULL, CAST(N'2009-05-06 17:49:26.023' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
/****** Object:  Index [IX_Task]  ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Task]') AND name = N'IX_Task')
CREATE NONCLUSTERED INDEX [IX_Task] ON [dbo].[Task]
(
	[AssignedId] ASC,
	[StatusId] ASC
)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_User]  ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND name = N'IX_User')
CREATE UNIQUE NONCLUSTERED INDEX [IX_User] ON [dbo].[User]
(
	[EmailAddress] ASC
)
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_Audit_CreatedDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Audit] ADD  CONSTRAINT [DF_Audit_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__TaskExten__Creat__267ABA7A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TaskExtended] ADD  DEFAULT (getdate()) FOR [CreatedDate]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__TaskExten__Modif__276EDEB3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TaskExtended] ADD  DEFAULT (getdate()) FOR [ModifiedDate]
END

GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Audit_Task]') AND parent_object_id = OBJECT_ID(N'[dbo].[Audit]'))
ALTER TABLE [dbo].[Audit]  WITH CHECK ADD  CONSTRAINT [FK_Audit_Task] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Task] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Audit_Task]') AND parent_object_id = OBJECT_ID(N'[dbo].[Audit]'))
ALTER TABLE [dbo].[Audit] CHECK CONSTRAINT [FK_Audit_Task]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Audit_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[Audit]'))
ALTER TABLE [dbo].[Audit]  WITH CHECK ADD  CONSTRAINT [FK_Audit_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Audit_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[Audit]'))
ALTER TABLE [dbo].[Audit] CHECK CONSTRAINT [FK_Audit_User]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Task_Priority]') AND parent_object_id = OBJECT_ID(N'[dbo].[Task]'))
ALTER TABLE [dbo].[Task]  WITH NOCHECK ADD  CONSTRAINT [FK_Task_Priority] FOREIGN KEY([PriorityId])
REFERENCES [dbo].[Priority] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Task_Priority]') AND parent_object_id = OBJECT_ID(N'[dbo].[Task]'))
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Priority]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Task_Status]') AND parent_object_id = OBJECT_ID(N'[dbo].[Task]'))
ALTER TABLE [dbo].[Task]  WITH NOCHECK ADD  CONSTRAINT [FK_Task_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Task_Status]') AND parent_object_id = OBJECT_ID(N'[dbo].[Task]'))
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Status]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Task_User_Assigned]') AND parent_object_id = OBJECT_ID(N'[dbo].[Task]'))
ALTER TABLE [dbo].[Task]  WITH NOCHECK ADD  CONSTRAINT [FK_Task_User_Assigned] FOREIGN KEY([AssignedId])
REFERENCES [dbo].[User] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Task_User_Assigned]') AND parent_object_id = OBJECT_ID(N'[dbo].[Task]'))
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_User_Assigned]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Task_User_Created]') AND parent_object_id = OBJECT_ID(N'[dbo].[Task]'))
ALTER TABLE [dbo].[Task]  WITH NOCHECK ADD  CONSTRAINT [FK_Task_User_Created] FOREIGN KEY([CreatedId])
REFERENCES [dbo].[User] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Task_User_Created]') AND parent_object_id = OBJECT_ID(N'[dbo].[Task]'))
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_User_Created]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TaskExtended_Task]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaskExtended]'))
ALTER TABLE [dbo].[TaskExtended]  WITH CHECK ADD  CONSTRAINT [FK_TaskExtended_Task] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Task] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TaskExtended_Task]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaskExtended]'))
ALTER TABLE [dbo].[TaskExtended] CHECK CONSTRAINT [FK_TaskExtended_Task]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_Role]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole]  WITH NOCHECK ADD  CONSTRAINT [FK_UserRole_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_Role]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Role]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole]  WITH NOCHECK ADD  CONSTRAINT [FK_UserRole_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_User]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Product](
	[ProductId] [varchar](10) NOT NULL,
	[Category] [varchar](10) NOT NULL,
	[Name] [varchar](80) NULL,
	[Descn] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Item](
	[ItemId] [varchar](10) NOT NULL,
	[ProductId] [varchar](10) NOT NULL,
	[ListPrice] [decimal](10, 2) NULL,
	[UnitCost] [decimal](10, 2) NULL,
	[Supplier] [int] NULL,
	[Status] [varchar](2) NULL,
	[Attr1] [varchar](80) NULL,
	[Attr2] [varchar](80) NULL,
	[Attr3] [varchar](80) NULL,
	[Attr4] [varchar](80) NULL,
	[Attr5] [varchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductSummary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProductSummary](
	[ProductId] [varchar](10) NOT NULL,
	[Name] [varchar](80) NULL,
	[AvgPrice] [decimal](10, 2) NOT NULL,
	[Verified] [bit] NOT NULL DEFAULT ((1)),
	[Date] [datetime] NULL,
 CONSTRAINT [PK_ProductSummary] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
--ALTER TABLE [dbo].[ProductSummary] ADD  CONSTRAINT [DF_ProductSummary_Verified]  DEFAULT ((1)) FOR [Verified]
--GO

ALTER TABLE [dbo].[ProductSummary]  WITH NOCHECK ADD  CONSTRAINT [FK_ProductSummary_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[ProductSummary] NOCHECK CONSTRAINT [FK_ProductSummary_Product]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Item 2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Item 2](
	[ItemId] [varchar](10) NOT NULL,
	[ProductId] [varchar](10) NOT NULL,
	[ListPrice] [decimal](10, 2) NULL,
	[UnitCost] [decimal](10, 2) NULL,
	[Supplier] [int] NULL,
	[Status] [varchar](2) NULL,
	[Attr1] [varchar](80) NULL,
	[Attr2] [varchar](80) NULL,
	[Attr3] [varchar](80) NULL,
	[Attr4] [varchar](80) NULL,
	[Attr5] [varchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Item 2]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO

INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'AV-CB-01', N'BIRDS', N'Amazon Parrot', N'<img align="absmiddle" src="Images/Pets/bird1.jpg">Great companion for up to 75 years')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'AV-SB-02', N'BIRDS', N'Finch', N'<img align="absmiddle" src="Images/Pets/bird2.jpg">Great stress reliever')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'FI-FW-01', N'FISH', N'Koi', N'<img align="absmiddle" src="Images/Pets/fish3.jpg">Freshwater fish from Japan')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'FI-FW-02', N'FISH', N'Goldfish', N'<img align="absmiddle" src="Images/Pets/fish4.jpg">Freshwater fish from China')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'FI-SW-01', N'FISH', N'Angelfish', N'<img align="absmiddle" src="Images/Pets/fish1.jpg">Saltwater fish from Australia')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'FI-SW-02', N'FISH', N'Tiger Shark', N'<img align="absmiddle" src="Images/Pets/fish2.jpg">Saltwater fish from Australia')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'FL-DLH-02', N'CATS', N'Persian', N'<img align="absmiddle" src="Images/Pets/cat2.jpg">Friendly house cat, doubles as a princess')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'FL-DSH-01', N'CATS', N'Manx', N'<img align="absmiddle" src="Images/Pets/cat1.jpg">Great for reducing mouse populations')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'K9-BD-01', N'DOGS', N'Bulldog', N'<img align="absmiddle" src="Images/Pets/dog1.jpg">Friendly dog from England')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'K9-CW-01', N'DOGS', N'Chihuahua', N'<img align="absmiddle" src="Images/Pets/dog6.jpg">Great companion dog')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'K9-DL-01', N'DOGS', N'Dalmation', N'<img align="absmiddle" src="Images/Pets/dog3.jpg">Great dog for a fire station')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'K9-PO-02', N'DOGS', N'Poodle', N'<img align="absmiddle" src="Images/Pets/dog2.jpg">Cute dog from France')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'K9-RT-01', N'DOGS', N'Golden Retriever', N'<img align="absmiddle" src="Images/Pets/dog4.jpg">Great family dog')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'K9-RT-02', N'DOGS', N'Labrador Retriever', N'<img align="absmiddle" src="Images/Pets/dog5.jpg">Great hunting dog')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'RP-LI-02', N'REPTILES', N'Iguana', N'<img align="absmiddle" src="Images/Pets/reptile2.jpg">Friendly green friend')
GO
INSERT [dbo].[Product] ([ProductId], [Category], [Name], [Descn]) VALUES (N'RP-SN-01', N'REPTILES', N'Rattlesnake', N'<img align="absmiddle" src="Images/Pets/reptile1.jpg">Doubles as a watch dog')
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-1', N'FI-SW-01', CAST(16.50 AS Decimal(10, 2)), CAST(10.00 AS Decimal(10, 2)), 1, N'P', N'Large', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-10', N'K9-DL-01', CAST(18.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Spotted Adult Female', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-11', N'RP-SN-01', CAST(18.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Venomless', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-12', N'RP-SN-01', CAST(18.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Rattleless', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-13', N'RP-LI-02', CAST(18.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Green Adult', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-14', N'FL-DSH-01', CAST(58.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Tailless', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-15', N'FL-DSH-01', CAST(23.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Tailed', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-16', N'FL-DLH-02', CAST(93.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Adult Female', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-17', N'FL-DLH-02', CAST(93.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Adult Male', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-18', N'AV-CB-01', CAST(193.50 AS Decimal(10, 2)), CAST(92.00 AS Decimal(10, 2)), 1, N'P', N'Adult Male', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-19', N'AV-SB-02', CAST(15.50 AS Decimal(10, 2)), CAST(2.00 AS Decimal(10, 2)), 1, N'P', N'Adult Male', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-2', N'FI-SW-01', CAST(16.50 AS Decimal(10, 2)), CAST(10.00 AS Decimal(10, 2)), 1, N'P', N'Small', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-20', N'FI-FW-02', CAST(5.50 AS Decimal(10, 2)), CAST(2.00 AS Decimal(10, 2)), 1, N'P', N'Adult Male', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-21', N'FI-FW-02', CAST(5.29 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), 1, N'P', N'Adult Female', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-22', N'K9-RT-02', CAST(135.50 AS Decimal(10, 2)), CAST(100.00 AS Decimal(10, 2)), 1, N'P', N'Adult Male', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-23', N'K9-RT-02', CAST(145.49 AS Decimal(10, 2)), CAST(100.00 AS Decimal(10, 2)), 1, N'P', N'Adult Female', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-24', N'K9-RT-02', CAST(255.50 AS Decimal(10, 2)), CAST(92.00 AS Decimal(10, 2)), 1, N'P', N'Adult Male', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-25', N'K9-RT-02', CAST(325.29 AS Decimal(10, 2)), CAST(90.00 AS Decimal(10, 2)), 1, N'P', N'Adult Female', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-26', N'K9-CW-01', CAST(125.50 AS Decimal(10, 2)), CAST(92.00 AS Decimal(10, 2)), 1, N'P', N'Adult Male', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-27', N'K9-CW-01', CAST(155.29 AS Decimal(10, 2)), CAST(90.00 AS Decimal(10, 2)), 1, N'P', N'Adult Female', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-28', N'K9-RT-01', CAST(155.29 AS Decimal(10, 2)), CAST(90.00 AS Decimal(10, 2)), 1, N'P', N'Adult Female', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-3', N'FI-SW-02', CAST(18.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Toothless', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-4', N'FI-FW-01', CAST(18.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Spotted', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-5', N'FI-FW-01', CAST(18.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Spotless', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-6', N'K9-BD-01', CAST(18.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Male Adult', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-7', N'K9-BD-01', CAST(18.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Female Puppy', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-8', N'K9-PO-02', CAST(18.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Male Puppy', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Item] ([ItemId], [ProductId], [ListPrice], [UnitCost], [Supplier], [Status], [Attr1], [Attr2], [Attr3], [Attr4], [Attr5]) VALUES (N'EST-9', N'K9-DL-01', CAST(18.50 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), 1, N'P', N'Spotless Male Puppy', NULL, NULL, NULL, NULL)
GO

USE [master]
GO
ALTER DATABASE [Tracker] SET  READ_WRITE 
GO