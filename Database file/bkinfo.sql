USE [master]
GO
/****** Object:  Database [ebook]    Script Date: 2024/12/8 下午 04:24:53 ******/
CREATE DATABASE [ebook]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ebook', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ebook.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ebook_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ebook_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ebook] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ebook].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ebook] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ebook] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ebook] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ebook] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ebook] SET ARITHABORT OFF 
GO
ALTER DATABASE [ebook] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ebook] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ebook] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ebook] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ebook] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ebook] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ebook] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ebook] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ebook] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ebook] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ebook] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ebook] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ebook] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ebook] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ebook] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ebook] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ebook] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ebook] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ebook] SET  MULTI_USER 
GO
ALTER DATABASE [ebook] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ebook] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ebook] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ebook] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ebook] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ebook] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ebook] SET QUERY_STORE = ON
GO
ALTER DATABASE [ebook] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ebook]
GO
/****** Object:  Table [dbo].[bookinfo]    Script Date: 2024/12/8 下午 04:24:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bookinfo](
	[bid] [int] IDENTITY(1,1) NOT NULL,
	[bname] [nvarchar](50) NOT NULL,
	[price] [money] NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[type] [nvarchar](50) NULL,
 CONSTRAINT [PK_bookinfo] PRIMARY KEY CLUSTERED 
(
	[bid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inventory]    Script Date: 2024/12/8 下午 04:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inventory](
	[bid] [int] NOT NULL,
	[wid] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[setdate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_inventory] PRIMARY KEY CLUSTERED 
(
	[bid] ASC,
	[wid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[trade]    Script Date: 2024/12/8 下午 04:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trade](
	[trade_id] [int] NOT NULL,
	[bid] [int] NOT NULL,
	[cname] [nvarchar](50) NOT NULL,
	[transactionType] [nvarchar](50) NOT NULL,
	[tquantity] [int] NOT NULL,
	[transactionDate] [datetime2](7) NULL,
	[remarks] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userinfo]    Script Date: 2024/12/8 下午 04:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userinfo](
	[cname] [nvarchar](50) NOT NULL,
	[password] [varchar](200) NULL,
	[cellphone] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
	[birthday] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_userinfo] PRIMARY KEY CLUSTERED 
(
	[cname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[warehouse]    Script Date: 2024/12/8 下午 04:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[warehouse](
	[wid] [int] IDENTITY(1,1) NOT NULL,
	[wname] [nvarchar](50) NOT NULL,
	[location] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_werehouse] PRIMARY KEY CLUSTERED 
(
	[wid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[bookinfo] ON 

INSERT [dbo].[bookinfo] ([bid], [bname], [price], [status], [type]) VALUES (1, N'JavaScript', 550.0000, N'有庫存', N'網頁開發')
INSERT [dbo].[bookinfo] ([bid], [bname], [price], [status], [type]) VALUES (3, N'HarryPotter', 418.0000, N'有庫存', N'奇幻小說')
INSERT [dbo].[bookinfo] ([bid], [bname], [price], [status], [type]) VALUES (4, N'100種京都', 380.0000, N'有庫存', N'旅遊')
INSERT [dbo].[bookinfo] ([bid], [bname], [price], [status], [type]) VALUES (6, N'張忠謀自傳全集', 1100.0000, N'有庫存', N'人物傳記')
SET IDENTITY_INSERT [dbo].[bookinfo] OFF
GO
INSERT [dbo].[inventory] ([bid], [wid], [quantity], [setdate]) VALUES (1, 2, 20, CAST(N'2024-12-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[inventory] ([bid], [wid], [quantity], [setdate]) VALUES (3, 3, 5, CAST(N'2024-12-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[inventory] ([bid], [wid], [quantity], [setdate]) VALUES (4, 2, 1, CAST(N'2024-12-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[inventory] ([bid], [wid], [quantity], [setdate]) VALUES (6, 3, 5, CAST(N'2024-12-07T00:00:00.0000000' AS DateTime2))
GO
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [transactionDate], [remarks]) VALUES (1, 1, N'客戶2', N'信用卡', 3, CAST(N'2024-02-08T12:30:00.0000000' AS DateTime2), N'中午12:00後')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [transactionDate], [remarks]) VALUES (2, 3, N'客戶4', N'貨到付款', 5, CAST(N'2024-12-08T15:33:00.0000000' AS DateTime2), N'晚上6點後')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [transactionDate], [remarks]) VALUES (3, 4, N'客戶3', N'信用卡', 4, CAST(N'2024-12-07T22:54:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [transactionDate], [remarks]) VALUES (4, 6, N'客戶5', N'貨到付款', 5, CAST(N'2024-07-08T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [transactionDate], [remarks]) VALUES (5, 1, N'客戶5', N'貨到付款', 1, CAST(N'2014-01-28T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [transactionDate], [remarks]) VALUES (6, 1, N'客戶5', N'貨到付款', 1, CAST(N'2024-08-08T12:12:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [transactionDate], [remarks]) VALUES (7, 1, N'客戶1', N'信用卡', 3, CAST(N'2024-05-04T12:30:00.0000000' AS DateTime2), N'中午12:00後')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [transactionDate], [remarks]) VALUES (8, 6, N'客戶4', N'貨到付款', 2, CAST(N'2024-10-08T18:33:00.0000000' AS DateTime2), NULL)
GO
INSERT [dbo].[userinfo] ([cname], [password], [cellphone], [address], [birthday]) VALUES (N'客戶1', N'tsmc2330', N'0923302330', N'tsmc2330@tsmc.com', CAST(N'1994-09-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[userinfo] ([cname], [password], [cellphone], [address], [birthday]) VALUES (N'客戶2', N'rich888person', N'0977766520', N'abc888@gmail.com', CAST(N'2011-08-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[userinfo] ([cname], [password], [cellphone], [address], [birthday]) VALUES (N'客戶3', N'885588rich', N'0988555888', N'rich888@gmail.com', CAST(N'1988-12-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[userinfo] ([cname], [password], [cellphone], [address], [birthday]) VALUES (N'客戶4', N'starbks888', N'0950500500', N'drink50@gmail.com', CAST(N'2006-12-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[userinfo] ([cname], [password], [cellphone], [address], [birthday]) VALUES (N'客戶5', N'88rich88', N'0912334567', N'rich5588gmail.com', CAST(N'2002-03-07T00:00:00.0000000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[warehouse] ON 

INSERT [dbo].[warehouse] ([wid], [wname], [location]) VALUES (2, N'倉庫A', N'東側')
INSERT [dbo].[warehouse] ([wid], [wname], [location]) VALUES (3, N'倉庫B', N'西側')
SET IDENTITY_INSERT [dbo].[warehouse] OFF
GO
/****** Object:  Index [IX_trade]    Script Date: 2024/12/8 下午 04:24:54 ******/
CREATE NONCLUSTERED INDEX [IX_trade] ON [dbo].[trade]
(
	[trade_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inventory]  WITH CHECK ADD  CONSTRAINT [FK_inventory_bookinfo] FOREIGN KEY([bid])
REFERENCES [dbo].[bookinfo] ([bid])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[inventory] CHECK CONSTRAINT [FK_inventory_bookinfo]
GO
ALTER TABLE [dbo].[inventory]  WITH CHECK ADD  CONSTRAINT [FK_inventory_werehouse] FOREIGN KEY([wid])
REFERENCES [dbo].[warehouse] ([wid])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[inventory] CHECK CONSTRAINT [FK_inventory_werehouse]
GO
ALTER TABLE [dbo].[trade]  WITH CHECK ADD  CONSTRAINT [FK_trade_bookinfo] FOREIGN KEY([bid])
REFERENCES [dbo].[bookinfo] ([bid])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[trade] CHECK CONSTRAINT [FK_trade_bookinfo]
GO
ALTER TABLE [dbo].[trade]  WITH CHECK ADD  CONSTRAINT [FK_trade_userinfo] FOREIGN KEY([cname])
REFERENCES [dbo].[userinfo] ([cname])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[trade] CHECK CONSTRAINT [FK_trade_userinfo]
GO
ALTER TABLE [dbo].[userinfo]  WITH CHECK ADD  CONSTRAINT [FK_userinfo_userinfo] FOREIGN KEY([cname])
REFERENCES [dbo].[userinfo] ([cname])
GO
ALTER TABLE [dbo].[userinfo] CHECK CONSTRAINT [FK_userinfo_userinfo]
GO
/****** Object:  StoredProcedure [dbo].[ApplyBirthdayDiscount]    Script Date: 2024/12/8 下午 04:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ApplyBirthdayDiscount]
    @cname NVARCHAR(50)          
AS
BEGIN
    DECLARE @price MONEY
    DECLARE @discounted_price MONEY
    DECLARE @book_name NVARCHAR(50)
    DECLARE @tquantity INT
    DECLARE @birthday_discount INT  -- 生日優惠標記
    DECLARE @password NVARCHAR(50)
    DECLARE @hashed_password VARBINARY(64)
    DECLARE @query_time DATETIME2(7)

    -- 獲取查詢時間
    SET @query_time = GETDATE()

    -- 查詢用戶的生日月份，並確認是否為當月
    IF EXISTS (SELECT 1 FROM userinfo WHERE cname = @cname AND MONTH(birthday) = MONTH(GETDATE()))
    BEGIN
        -- 設定生日優惠標記為 1
        SET @birthday_discount = 1
    END
    ELSE
    BEGIN
        -- 設定生日優惠標記為 0
        SET @birthday_discount = 0
    END

    -- 查詢用戶的密碼，若密碼為 NULL 或空值則使用 cellphone 作為預設密碼
    SELECT @password = 
           CASE 
               WHEN password IS NULL OR password = '' THEN cellphone  -- 當密碼為 NULL 或空，使用 cellphone 作為預設密碼
               ELSE password 
           END
    FROM userinfo
    WHERE cname = @cname

    -- 確保密碼變數不為 NULL，若為 NULL 或空，強制設為 cellphone
    IF @password IS NULL OR @password = ''
    BEGIN
        SET @password = (SELECT cellphone FROM userinfo WHERE cname = @cname)
    END

    -- 將密碼進行 hash 處理
    SET @hashed_password = HASHBYTES('SHA2_512', CONVERT(VARBINARY(50), @password))

  

	

    -- 查詢該客戶所有的購買資料，顯示每筆交易明細及總和
    SELECT t.cname, 
           t.transactionDate, 
           b.bname AS book_name, 
           b.price AS unit_price,
           t.tquantity AS quantity, 
           b.price * t.tquantity AS total_price, 
           -- 如果是當月生日，給予折扣
           CASE 
               WHEN MONTH(u.birthday) = MONTH(GETDATE()) THEN b.price * t.tquantity * 0.8 
               ELSE b.price * t.tquantity 
           END AS discounted_price,
           @query_time AS query_time,  -- 查詢時間
           @birthday_discount AS birthday_discount  -- 生日優惠標記
    FROM trade t
    JOIN bookinfo b ON t.bid = b.bid
    JOIN userinfo u ON t.cname = u.cname
    WHERE t.cname = @cname
    ORDER BY t.transactionDate DESC  -- 顯示所有交易並按日期排序

    -- 計算該客戶的總購買數量、總金額和總折扣金額
    SELECT t.cname, 
           SUM(t.tquantity) AS total_quantity, 
           SUM(b.price * t.tquantity) AS total_amount,
           SUM(CASE 
               WHEN MONTH(u.birthday) = MONTH(GETDATE()) THEN b.price * t.tquantity * 0.8 
               ELSE b.price * t.tquantity 
           END) AS total_discounted_amount,  
           @query_time AS query_time, 
           @birthday_discount AS birthday_discount 
    FROM trade t
    JOIN bookinfo b ON t.bid = b.bid
    JOIN userinfo u ON t.cname = u.cname
    WHERE t.cname = @cname
    GROUP BY t.cname
    ORDER BY t.cname  
	
	 SELECT cname, birthday, 
           CONVERT(VARCHAR(128), HASHBYTES('SHA2_512', CONVERT(VARBINARY(50), password)), 2) AS hashed_password
    FROM userinfo
    WHERE cname = @cname
END
GO
USE [master]
GO
ALTER DATABASE [ebook] SET  READ_WRITE 
GO
