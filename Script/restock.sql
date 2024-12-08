USE [ebook]
GO

/****** Object:  StoredProcedure [dbo].[restock]    Script Date: 2024/12/8 下午 02:43:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[restock]
	@bid int,
	@q int   -- 增加的數量
as
begin
	update inventory set quantity = quantity + @q where bid = @bid
	update inventory set setdate = getdate() where bid = @bid
	update warehouse set setdate = getdate() where wid = (select wid from inventory where bid = @bid)
end
GO

