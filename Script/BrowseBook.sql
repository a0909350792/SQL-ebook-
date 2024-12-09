--宣告
drop procedure if exists BrowseBook
go

create procedure BrowseBook
--動作
as begin
	select bname as '書名',type as '類型',price as '價格',status as '狀態',wname as '所在倉庫',setdate as '最新一筆入庫資料' from bookinfo
	left join inventory
		on bookinfo.bid=inventory.bid
	left join warehouse
		on inventory.wid=warehouse.wid
end