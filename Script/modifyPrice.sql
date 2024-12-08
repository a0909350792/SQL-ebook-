drop procedure if exists modifyPrice 
go
-- 修改書的價格
create procedure modifyPrice
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
	if @oldPrice = @price
	begin
		select '修改的金額不能跟原本價格一樣' as status
		return
	end
	
	-- 修改價格
	update bookinfo set price = @price where bname = @bname
	select '修改成功' as status
end

-- exec modifyPrice '新書C',10
-- select * from bookinfo