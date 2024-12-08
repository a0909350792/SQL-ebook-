drop procedure if exists GrossIncome
go
create procedure GrossIncome
as
begin
--計算每年收入
select Q as '年',total as '總金額'
from(
    select datepart(YEAR,transactionDate) as Q ,sum(trade.tquantity*bookinfo.price) as total
    from bookinfo join trade on 
	     bookinfo.bid = trade.bid
    group by datepart(YEAR,transactionDate)
)as u
group by Q, total
order by Q

--計算某年的季收入
select Q,sum(total) as '總金額'
from(
    select datepart(quarter,transactionDate) as Q ,sum(trade.tquantity*bookinfo.price) as total
    from bookinfo join trade on 
	     bookinfo.bid = trade.bid
    where datepart(year,transactionDate) = 2024
    group by datepart(quarter,transactionDate)
	union all
	select 1,0
	union all
	select 2,0
	union all
	select 3,0
	union all
	select 4,0
)as u
group by Q 
order by Q

end