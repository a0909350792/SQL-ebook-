drop procedure if exists restock
go
create procedure restock
	@bid int,
	@q int   --增加的數量
as
begin
	update inventory set quantity = quantity + @q where bid = @bid
	update inventory set setdate = getdate() where bid = @bid
	update warehouse set setdate = getdate() where wid = (select wid from inventory where bid = @bid)
end