use mavenfuzzyfactory;

select
	CONCAT(CONCAT(year(ws.created_at),'_Q'),Quarter(ws.created_at)) Yr_Qt,
    count(distinct ws.website_session_id) as sessions,
    count(distinct od.order_id) as orders
from website_sessions ws
left join orders od
	on ws.website_session_id = od.website_session_id
 where ws.created_at < '2014-12-31'
group by 1
ORDER BY 1
;



