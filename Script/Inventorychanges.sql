DROP PROCEDURE IF EXISTS Inventorychanges;
GO

CREATE PROCEDURE Inventorychanges
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

    -- 判斷是否為當月生日
    IF EXISTS (SELECT 1 FROM userinfo WHERE cname = @cname AND MONTH(birthday) = MONTH(GETDATE()))
    BEGIN
        SET @birthday_discount = 1;  -- 如果是當月生日，設置為有生日優惠
    END

    -- 計算總金額，生日優惠8折
    SET @total = @price * @tquantity;
    IF @birthday_discount = 1
    BEGIN
        SET @total = @total * 0.8;  -- 生日優惠，給 8 折
    END

   
    IF @quantity >= @tquantity
    BEGIN
        -- 更新庫存減少庫存量
        UPDATE inventory
        SET quantity = @quantity - @tquantity, setdate = GETDATE()
        WHERE bid = @bid AND wid = @wid;

        -- 手動生成 trade_id
        DECLARE @trade_id INT;
        SELECT @trade_id = ISNULL(MAX(trade_id), 0) + 1 FROM trade;

        -- 計算後的總金額
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


EXEC Inventorychanges 
    @bid = 3,                       -- 書籍ID
    @cname = '客戶1',                -- 客戶名稱
    @transactionType = '信用卡',     -- 交易類型
    @tquantity = 1,                  -- 交易數量
    @remarks = '';                   -- 備註（可選）



