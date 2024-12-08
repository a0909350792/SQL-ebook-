drop procedure if exists AddNewBook 
go

-- 新增書籍與庫存
create procedure AddNewBook
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

--EXEC AddNewBook 
--    @bname = '新書A', 
--    @price = 560.00, 
--    @quantity = 10, 
--    @type = '技術類', 
--    @wname = '倉庫A';


-- select * from bookinfo
-- select * from inventory