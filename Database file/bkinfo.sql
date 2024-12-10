USE [master]
GO
/****** Object:  Database [ebook]    Script Date: 2024/12/10 下午 08:02:34 ******/
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
/****** Object:  Table [dbo].[bookinfo]    Script Date: 2024/12/10 下午 08:02:34 ******/
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
/****** Object:  Table [dbo].[inventory]    Script Date: 2024/12/10 下午 08:02:34 ******/
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
/****** Object:  Table [dbo].[trade]    Script Date: 2024/12/10 下午 08:02:34 ******/
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
	[total] [int] NULL,
	[transactionDate] [datetime2](7) NULL,
	[remarks] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userinfo]    Script Date: 2024/12/10 下午 08:02:34 ******/
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
 CONSTRAINT [PK_userinfo_1] PRIMARY KEY CLUSTERED 
(
	[cname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[warehouse]    Script Date: 2024/12/10 下午 08:02:34 ******/
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
INSERT [dbo].[bookinfo] ([bid], [bname], [price], [status], [type]) VALUES (7, N'新書A', 560.0000, N'有庫存', N'技術類')
SET IDENTITY_INSERT [dbo].[bookinfo] OFF
GO
INSERT [dbo].[inventory] ([bid], [wid], [quantity], [setdate]) VALUES (1, 2, 0, CAST(N'2024-12-09T22:32:13.7666667' AS DateTime2))
INSERT [dbo].[inventory] ([bid], [wid], [quantity], [setdate]) VALUES (3, 3, 13, CAST(N'2024-12-10T19:57:02.8700000' AS DateTime2))
INSERT [dbo].[inventory] ([bid], [wid], [quantity], [setdate]) VALUES (4, 2, 20, CAST(N'2024-12-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[inventory] ([bid], [wid], [quantity], [setdate]) VALUES (6, 3, 18, CAST(N'2024-12-08T22:19:57.0700000' AS DateTime2))
INSERT [dbo].[inventory] ([bid], [wid], [quantity], [setdate]) VALUES (7, 2, 10, CAST(N'2024-12-09T20:56:49.3333333' AS DateTime2))
GO
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (1, 1, N'客戶2', N'信用卡', 3, NULL, CAST(N'2024-02-08T12:30:00.0000000' AS DateTime2), N'中午12:00後')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (2, 3, N'客戶4', N'貨到付款', 5, NULL, CAST(N'2024-12-08T15:33:00.0000000' AS DateTime2), N'晚上6點後')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (3, 4, N'客戶3', N'信用卡', 4, NULL, CAST(N'2024-12-07T22:54:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (4, 6, N'客戶5', N'貨到付款', 5, NULL, CAST(N'2024-07-08T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (5, 1, N'客戶5', N'貨到付款', 1, NULL, CAST(N'2014-01-28T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (6, 1, N'客戶5', N'貨到付款', 1, NULL, CAST(N'2024-08-08T12:12:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (7, 1, N'客戶1', N'信用卡', 3, NULL, CAST(N'2024-05-04T12:30:00.0000000' AS DateTime2), N'中午12:00後')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (8, 6, N'客戶4', N'貨到付款', 2, NULL, CAST(N'2024-10-08T18:33:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (1, 3, N'客戶5', N'信用卡', 5, NULL, CAST(N'2024-12-08T00:00:00.0000000' AS DateTime2), N'晚上9點')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (9, 1, N'客戶2', N'信用卡', 1, NULL, CAST(N'2024-12-09T21:03:10.9300000' AS DateTime2), N'')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (10, 1, N'客戶3', N'信用卡', 1, 440, CAST(N'2024-12-09T22:29:09.3200000' AS DateTime2), N'')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (11, 1, N'客戶3', N'信用卡', 3, 1320, CAST(N'2024-12-09T22:31:13.9200000' AS DateTime2), N'')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (12, 1, N'客戶1', N'信用卡', 1, 550, CAST(N'2024-12-09T22:32:13.7666667' AS DateTime2), N'')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (13, 3, N'客戶1', N'信用卡', 1, 418, CAST(N'2024-12-09T22:33:43.0066667' AS DateTime2), N'')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (14, 3, N'客戶1', N'信用卡', 1, 418, CAST(N'2024-12-09T22:35:20.7000000' AS DateTime2), N'')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (15, 3, N'客戶1', N'信用卡', 1, 418, CAST(N'2024-12-09T22:40:56.5700000' AS DateTime2), N'')
INSERT [dbo].[trade] ([trade_id], [bid], [cname], [transactionType], [tquantity], [total], [transactionDate], [remarks]) VALUES (16, 3, N'客戶2', N'信用卡', 1, 418, CAST(N'2024-12-10T19:57:02.8700000' AS DateTime2), N'')
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
/****** Object:  Index [IX_trade]    Script Date: 2024/12/10 下午 08:02:34 ******/
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
/****** Object:  StoredProcedure [dbo].[AddNewBook]    Script Date: 2024/12/10 下午 08:02:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 新增書籍與庫存
CREATE procedure [dbo].[AddNewBook]
	@bname nvarchar(50),
	@price money,
	@quantity int,
	@type nvarchar(50),
	@wname nvarchar(50)
as
begin
	-- 判斷書名是否重複(建立在不能重複書名的狀況下，可斟酌要不要加這個判斷)
	declare @n int
	select @n = count(*) from bookinfo where bname = @bname
	if @n>0 
	begin
		select '此書已存在，無法新增一樣的書名' as status
		return
	end
	-- 判斷金額、數量不能為負的
	if @price <= 0 or @quantity <= 0
	begin
		select '金額或庫存數量不能為0或負的' as status
		return
	end
	-- 判斷倉庫是否存在
	declare @wid int
	select @wid = wid from warehouse where wname = @wname
	if @wid is null
	begin
		select '此倉庫不存在' as status
		return
	end
	-- 新增新書資訊
	insert into bookinfo(bname,price,status,type) values (@bname,@price,'有庫存',@type)
	declare @bid int
	select @bid = bid from bookinfo where bname = @bname
	-- 新增新書的庫存
	insert into inventory(bid,wid,quantity,setdate) values (@bid,@wid,@quantity,getdate())
	select '成功新增' as status
end
GO
/****** Object:  StoredProcedure [dbo].[ApplyBirthdayDiscount]    Script Date: 2024/12/10 下午 08:02:34 ******/
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
    --SELECT t.cname, 
         --  t.transactionDate, 
          -- b.bname AS book_name, 
         --  b.price AS unit_price,
          -- t.tquantity AS quantity, 
         -- b.price * t.tquantity AS total_price, 
           -- 如果是當月生日，給予折扣
          -- CASE 
             --  WHEN MONTH(u.birthday) = MONTH(GETDATE()) THEN b.price * t.tquantity * 0.8 
            --   ELSE b.price * t.tquantity 
         --  END AS discounted_price,
          -- @query_time AS query_time,  -- 查詢時間
          -- @birthday_discount AS birthday_discount  -- 生日優惠標記
   -- FROM trade t
   -- JOIN bookinfo b ON t.bid = b.bid
   -- JOIN userinfo u ON t.cname = u.cname
  --  WHERE t.cname = @cname
  --  ORDER BY t.transactionDate DESC  -- 顯示所有交易並按日期排序

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
	
	 --SELECT cname, birthday, 
       --    CONVERT(VARCHAR(128), HASHBYTES('SHA2_512', CONVERT(VARBINARY(50), password)), 2) AS hashed_password
    --FROM userinfo
    --WHERE cname = @cname
END
GO
/****** Object:  StoredProcedure [dbo].[BrowseBook]    Script Date: 2024/12/10 下午 08:02:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[BrowseBook]
--動作
as begin
	select bname as '書名',type as '類型',price as '價格',status as '狀態',wname as '所在倉庫',setdate as '最新一筆入庫資料' from bookinfo
	left join inventory
		on bookinfo.bid=inventory.bid
	left join warehouse
		on inventory.wid=warehouse.wid
end
GO
/****** Object:  StoredProcedure [dbo].[GrossIncome]    Script Date: 2024/12/10 下午 08:02:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GrossIncome]
AS
BEGIN
    -- 計算年度收入
    SELECT 
        '年度' AS report_type,  -- 用於標識這是年度報表
        Q AS '期間',
        SUM(CASE 
                WHEN MONTH(u.birthday) = MONTH(GETDATE()) THEN total * 0.8  -- 如果是當月生日，給 8 折
                ELSE total 
            END) AS '總金額'
    FROM (
        SELECT 
            DATEPART(YEAR, transactionDate) AS Q, 
            SUM(trade.tquantity * bookinfo.price) AS total,
            u.birthday
        FROM bookinfo
        JOIN trade ON bookinfo.bid = trade.bid
        JOIN userinfo u ON trade.cname = u.cname
        GROUP BY DATEPART(YEAR, transactionDate), u.birthday
    ) AS u
    GROUP BY Q

    UNION ALL  -- 使用 UNION ALL 合併年度報表與季度報表

    -- 計算季度收入
    SELECT 
        '季度' AS report_type,  -- 用於標識這是季度報表
        Q AS '期間',
        SUM(CASE 
                WHEN MONTH(u.birthday) = MONTH(GETDATE()) THEN total * 0.8  -- 如果是當月生日，給 8 折
                ELSE total 
            END) AS '總金額'
    FROM (
        SELECT 
            DATEPART(QUARTER, transactionDate) AS Q, 
            SUM(trade.tquantity * bookinfo.price) AS total,
            u.birthday
        FROM bookinfo
        JOIN trade ON bookinfo.bid = trade.bid
        JOIN userinfo u ON trade.cname = u.cname
        WHERE DATEPART(YEAR, transactionDate) = 2024
        GROUP BY DATEPART(QUARTER, transactionDate), u.birthday
        UNION ALL
        SELECT 1, 0, NULL
        UNION ALL
        SELECT 2, 0, NULL
        UNION ALL
        SELECT 3, 0, NULL
        UNION ALL
        SELECT 4, 0, NULL
    ) AS u
    GROUP BY Q
    ORDER BY report_type,期間  -- 按照報表類型和期間排序
END
GO
/****** Object:  StoredProcedure [dbo].[Inventorychanges]    Script Date: 2024/12/10 下午 08:02:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Inventorychanges]
    @cname NVARCHAR(50),              -- 客戶名稱
    @transactionType NVARCHAR(50),     -- 交易類型
    @remarks NVARCHAR(50),             -- 備註
    @bid INT,                          -- 書籍ID（單筆資料）
    @tquantity INT                     -- 交易數量（單筆資料）
AS
BEGIN
    DECLARE @wid INT;                -- 倉庫ID
    DECLARE @quantity INT;           -- 當前庫存量
    DECLARE @price MONEY;            -- 書籍單價
    DECLARE @total MONEY;            -- 計算後的總金額
    DECLARE @transactionDate DATETIME2(7) = GETDATE(); -- 交易日期
    DECLARE @birthday_discount INT = 0;  -- 生日優惠標記，0 表示沒有，1 表示有

    -- 根據 bid 查找書籍是否存在
    IF NOT EXISTS (SELECT 1 FROM bookinfo WHERE bid = @bid)
    BEGIN
        -- 書籍不存在，返回錯誤訊息
        SELECT '書本不存在，bid=' + CAST(@bid AS NVARCHAR(50)) AS status;
        RETURN;
    END

    -- 根據書籍ID查詢倉庫ID、庫存量以及書籍價格
    SELECT TOP 1 @wid = wid, @quantity = quantity, @price = price
    FROM inventory
    JOIN bookinfo ON bookinfo.bid = inventory.bid
    WHERE inventory.bid = @bid;

    -- 判斷交易數量是否大於零
    IF @tquantity <= 0
    BEGIN
        SELECT '下單數量不可為零，bid=' + CAST(@bid AS NVARCHAR(50)) AS status;
        RETURN;
    END

    -- 查詢用戶的生日，判斷是否為當月生日
    IF EXISTS (SELECT 1 FROM userinfo WHERE cname = @cname AND MONTH(birthday) = MONTH(GETDATE()))
    BEGIN
        SET @birthday_discount = 1;  -- 如果是當月生日，設置為有生日優惠
    END

    -- 計算總金額，若有生日優惠則8折
    SET @total = @price * @tquantity;
    IF @birthday_discount = 1
    BEGIN
        SET @total = @total * 0.8;  -- 生日優惠，給 8 折
    END

    -- 如果庫存足夠，則減少庫存量
    IF @quantity >= @tquantity
    BEGIN
        -- 更新庫存，減少庫存量
        UPDATE inventory
        SET quantity = @quantity - @tquantity, setdate = GETDATE()
        WHERE bid = @bid AND wid = @wid;

        -- 手動生成 trade_id
        DECLARE @trade_id INT;
        SELECT @trade_id = ISNULL(MAX(trade_id), 0) + 1 FROM trade;

        -- 插入交易記錄，包括計算後的總金額
        INSERT INTO trade (trade_id, bid, cname, transactionType, tquantity, transactionDate, remarks, total)
        VALUES (@trade_id, @bid, @cname, @transactionType, @tquantity, @transactionDate, @remarks, @total);

        -- 顯示交易狀態，包括價格、交易數量、總金額和庫存
        SELECT 
            '交易完成，bid=' + CAST(@bid AS NVARCHAR(50)) + 
            ', tquantity=' + CAST(@tquantity AS NVARCHAR(50)) +
            ', 單價=' + CAST(@price AS NVARCHAR(50)) +
            ', 總金額=' + CAST(@total AS NVARCHAR(50)) +
            ', 庫存數量為 ' + CAST(quantity AS NVARCHAR(50)) AS status
        FROM inventory
        WHERE bid = @bid AND wid = @wid;

    END
    ELSE
    BEGIN
        -- 庫存不足，無法完成交易
        SELECT '庫存不足，bid=' + CAST(@bid AS NVARCHAR(50)) AS status;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[modifyPrice]    Script Date: 2024/12/10 下午 08:02:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 修改書的價格
create procedure [dbo].[modifyPrice]
	@bname nvarchar(50),
	@price money
as
begin
	declare @n int
	declare @oldPrice money
	select @n = count(*) from bookinfo where bname = @bname

	if @n < 1 
	begin
		select '查無此書，無法修改價格' as status
		return
	end

	-- 判斷要修改的金額不能跟原本一樣
	select @oldPrice = price from bookinfo where bname = @bname
	if @oldPrice = @price or @price < 0
	begin
		select '修改的金額不能跟原本價格一樣或是為負的' as status
		return
	end
	
	-- 修改價格
	update bookinfo set price = @price where bname = @bname
	select '修改成功' as status
end

-- exec modifyPrice '新書C',10
-- select * from bookinfo
GO
/****** Object:  StoredProcedure [dbo].[restock]    Script Date: 2024/12/10 下午 08:02:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[restock]
	@bid int,
	@q int   --增加的數量
as
begin
	update inventory set quantity = quantity + @q where bid = @bid
	update inventory set setdate = getdate() where bid = @bid
	
end
GO
USE [master]
GO
ALTER DATABASE [ebook] SET  READ_WRITE 
GO
