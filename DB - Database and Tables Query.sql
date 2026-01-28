-- Use the master database to create the new database
USE [master]
GO

-- =========================================================
-- CREATE THE DATABASE
-- =========================================================
CREATE DATABASE [E-Shift]
GO

-- =========================================================
-- USE THE NEWLY CREATED DATABASE
-- =========================================================
USE [E-Shift]
GO

-- =========================================================
-- TABLE: admin_registration
-- Stores information for administrative users.
-- =========================================================
CREATE TABLE [dbo].[admin_registration](
	[AdminID] INT IDENTITY(1,1) NOT NULL,
	[Username] VARCHAR(255) NOT NULL,
	[Email] VARCHAR(255) NOT NULL,
	[ContactNo] VARCHAR(20) NULL,
	[Password] VARCHAR(255) NOT NULL,
	[ConfirmPassword] VARCHAR(255) NOT NULL,
	[created_at] DATETIME2(7) NOT NULL,
	[updated_at] DATETIME2(7) NOT NULL,
	PRIMARY KEY CLUSTERED ([AdminID] ASC),
	UNIQUE NONCLUSTERED ([Username] ASC),
	UNIQUE NONCLUSTERED ([Email] ASC)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[admin_registration] ADD DEFAULT (SYSDATETIME()) FOR [created_at]
GO

ALTER TABLE [dbo].[admin_registration] ADD DEFAULT (SYSDATETIME()) FOR [updated_at]
GO

-- =========================================================
-- TABLE: customer_registration
-- Stores information for customer users.
-- =========================================================
CREATE TABLE [dbo].[customer_registration](
	[CustomerID] INT IDENTITY(1,1) NOT NULL,
	[Username] VARCHAR(255) NOT NULL,
	[Email] VARCHAR(255) NOT NULL,
	[ContactNo] VARCHAR(20) NULL,
	[Password] VARCHAR(255) NOT NULL,
	[ConfirmPassword] VARCHAR(255) NOT NULL,
	[created_at] DATETIME2(7) NOT NULL,
	[updated_at] DATETIME2(7) NOT NULL,
	PRIMARY KEY CLUSTERED ([CustomerID] ASC),
	UNIQUE NONCLUSTERED ([Username] ASC),
	UNIQUE NONCLUSTERED ([Email] ASC)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[customer_registration] ADD DEFAULT (SYSDATETIME()) FOR [created_at]
GO

ALTER TABLE [dbo].[customer_registration] ADD DEFAULT (SYSDATETIME()) FOR [updated_at]
GO

-- =========================================================
-- TABLE: products
-- Contains a list of available products.
-- =========================================================
CREATE TABLE [dbo].[products](
	[ProductID] INT IDENTITY(1,1) NOT NULL,
	[ProductName] VARCHAR(255) NOT NULL,
	[Made] VARCHAR(255) NULL,
	[Quantity] INT NOT NULL,
	[created_at] DATETIME2(7) NOT NULL,
	[updated_at] DATETIME2(7) NOT NULL,
	PRIMARY KEY CLUSTERED ([ProductID] ASC),
	UNIQUE NONCLUSTERED ([ProductName] ASC)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[products] ADD DEFAULT (SYSDATETIME()) FOR [created_at]
GO

ALTER TABLE [dbo].[products] ADD DEFAULT (SYSDATETIME()) FOR [updated_at]
GO

-- =========================================================
-- TABLE: jobs
-- Stores details about customer jobs/shipments.
-- =========================================================
CREATE TABLE [dbo].[jobs](
	[JobID] INT IDENTITY(1,1) NOT NULL,
	[CustomerName] VARCHAR(255) NOT NULL,
	[StartLocation] VARCHAR(255) NOT NULL,
	[Destination] VARCHAR(255) NOT NULL,
	[Status] VARCHAR(50) NOT NULL,
	[created_at] DATETIME2(7) NOT NULL,
	[updated_at] DATETIME2(7) NOT NULL,
	PRIMARY KEY CLUSTERED ([JobID] ASC)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[jobs] ADD DEFAULT ('Processing...') FOR [Status]
GO

ALTER TABLE [dbo].[jobs] ADD DEFAULT (SYSDATETIME()) FOR [created_at]
GO

ALTER TABLE [dbo].[jobs] ADD DEFAULT (SYSDATETIME()) FOR [updated_at]
GO

ALTER TABLE [dbo].[jobs] WITH CHECK ADD CONSTRAINT [FK_Jobs_Customer] FOREIGN KEY([CustomerName])
REFERENCES [dbo].[customer_registration] ([Username])
GO

-- =========================================================
-- TABLE: load
-- Details about a specific load for a job.
-- =========================================================
CREATE TABLE [dbo].[load](
	[LoadID] INT IDENTITY(1,1) NOT NULL,
	[JobID] INT NOT NULL,
	[CustomerName] VARCHAR(255) NOT NULL,
	[Lorry] VARCHAR(255) NULL,
	[Driver] VARCHAR(255) NULL,
	[Assistant] VARCHAR(255) NULL,
	[Container] VARCHAR(255) NULL,
	[Products] TEXT NULL,
	[created_at] DATETIME2(7) NOT NULL,
	[updated_at] DATETIME2(7) NOT NULL,
	PRIMARY KEY CLUSTERED ([LoadID] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[load] ADD DEFAULT (SYSDATETIME()) FOR [created_at]
GO

ALTER TABLE [dbo].[load] ADD DEFAULT (SYSDATETIME()) FOR [updated_at]
GO

ALTER TABLE [dbo].[load] WITH CHECK ADD CONSTRAINT [FK_Load_Jobs] FOREIGN KEY([JobID])
REFERENCES [dbo].[jobs] ([JobID])
GO

-- =========================================================
-- TABLE: selected_products
-- Links products to specific jobs with quantities.
-- =========================================================
CREATE TABLE [dbo].[selected_products](
	[JobID] INT NOT NULL,
	[ProductName] VARCHAR(255) NOT NULL,
	[Quantity] INT NOT NULL,
	[created_at] DATETIME2(7) NOT NULL,
	[updated_at] DATETIME2(7) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[selected_products] ADD DEFAULT (SYSDATETIME()) FOR [created_at]
GO

ALTER TABLE [dbo].[selected_products] ADD DEFAULT (SYSDATETIME()) FOR [updated_at]
GO

ALTER TABLE [dbo].[selected_products] WITH CHECK ADD CONSTRAINT [FK_SelectedProducts_Jobs] FOREIGN KEY([JobID])
REFERENCES [dbo].[jobs] ([JobID])
GO

ALTER TABLE [dbo].[selected_products] WITH CHECK ADD CONSTRAINT [FK_SelectedProducts_Products] FOREIGN KEY([ProductName])
REFERENCES [dbo].[products] ([ProductName])
GO
