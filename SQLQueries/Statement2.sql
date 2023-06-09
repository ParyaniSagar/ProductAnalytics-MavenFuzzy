USE mavenfuzzyfactory;

SELECT 
	CONCAT(CONCAT(year(ws.created_at),'_Q'),Quarter(ws.created_at)) Yr_Qt,
    COUNT(DISTINCT ws.website_session_id) as sessions,
    COUNT(DISTINCT od.order_id) as orders,
    COUNT(DISTINCT od.order_id)/count(DISTINCT ws.website_session_id) as S2OConvRate,
    SUM(od.price_usd)/COUNT(DISTINCT od.order_id) as RevenuePerOrder,
    SUM(od.price_usd)/COUNT(DISTINCT ws.website_session_id) as RevenuePerSession
FROM website_sessions ws
LEFT JOIN orders od
	ON od.website_session_id = ws.website_session_id
GROUP BY 1
ORDER by 1
;
