DROP PROCEDURE IF EXISTS Inventorychanges;
GO

CREATE PROCEDURE Inventorychanges
    @bid INT,                        
    @cname NVARCHAR(50),             
    @transactionType NVARCHAR(50),   
    @tquantity INT,                  
    @remarks NVARCHAR(50)            
AS
BEGIN
    DECLARE @wid INT;           -- 倉庫ID
    DECLARE @quantity INT;      -- 當前庫存量
    DECLARE @trade_id INT;      -- 交易ID
    DECLARE @transactionDate DATETIME2(7) = GETDATE();
    -- 根據 bid 查找書籍是否存在
    IF NOT EXISTS (SELECT 1 FROM bookinfo WHERE bid = @bid)
    BEGIN
        -- 書籍不存在，返回錯誤訊息
        SELECT '書本不存在' AS status;
        RETURN;
    END

    -- 根據書籍ID查詢倉庫ID和庫存量
    SELECT TOP 1 @wid = wid, @quantity = quantity 
    FROM inventory 
    WHERE bid = @bid;

    -- 判斷交易數量是否大於零
    IF @tquantity <= 0
    BEGIN
        SELECT '下單數量不可為零' AS status;
        RETURN;
    END

    -- 如果庫存足夠，則減少庫存量
    IF @quantity >= @tquantity
    BEGIN
        -- 更新庫存，減少庫存量
        UPDATE inventory
        SET quantity = @quantity - @tquantity, setdate = GETDATE()
        WHERE bid = @bid AND wid = @wid;

        -- 手動生成 trade_id
        SELECT @trade_id = ISNULL(MAX(trade_id), 0) + 1 FROM trade;

        -- 插入交易記錄
        INSERT INTO trade (trade_id, bid, cname, transactionType, tquantity, transactionDate, remarks)
        VALUES (@trade_id, @bid, @cname, @transactionType, @tquantity, @transactionDate, @remarks);

        -- 顯示庫存更新成功
        SELECT '交易完成，庫存數量已減少' AS status;
    END
    ELSE
    BEGIN
        -- 庫存不足，無法完成交易
        SELECT '庫存不足，無法完成交易' AS status;
    END
END    