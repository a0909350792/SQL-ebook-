DROP PROCEDURE IF EXISTS ApplyBirthdayDiscount
GO

CREATE PROCEDURE ApplyBirthdayDiscount
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

    -- 更新用戶的密碼欄位為哈希密碼
    UPDATE userinfo
    SET password = CONVERT(VARCHAR(128), @hashed_password, 2) 
    WHERE cname = @cname

	ALTER TABLE userinfo
	DROP COLUMN cellphone;

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
           @query_time AS query_time,  -- 合併查詢時間
           @birthday_discount AS birthday_discount  -- 顯示生日優惠標記
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
END
