USE mavenfuzzyfactory;

SELECT 
	YEAR(ws.created_at) Yr,
    QUARTER(ws.created_at) as Qtr,
    COUNT(DISTINCT ws.website_session_id) as sessions,
    COUNT(DISTINCT od.order_id) as orders,
    COUNT(DISTINCT od.order_id)/count(DISTINCT ws.website_session_id) as S2OConvRate,
    SUM(od.price_usd)/COUNT(DISTINCT od.order_id) as RevenuePerOrder,
    SUM(od.price_usd)/COUNT(DISTINCT ws.website_session_id) as RevenuePerSession
FROM website_sessions ws
LEFT JOIN orders od
	ON od.website_session_id = ws.website_session_id
GROUP BY 1,2
ORDER by 1,2
;
