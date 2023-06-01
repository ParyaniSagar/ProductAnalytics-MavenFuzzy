select
	year(od.created_at) as Yr,
	Quarter(od.created_at) as Qtr,
    count(distinct od.order_id) as Orders,
    count(distinct case when utm_source ='gsearch' and utm_campaign = 'nonbrand' then order_id else NULL end) as GsearchNonBrand, 
    count(distinct case when utm_source = 'bsearch' and utm_campaign = 'nonbrand' then order_id else NULL end) as BsearchNonBrand,
    count(distinct case when utm_campaign ='brand' then order_id else NULL end) as Brand,
    count(distinct case when utm_source is null and utm_campaign is NULL and http_referer is Null then order_id else NULL end) as OrganicSearch,
    count(distinct case when utm_source is null and utm_campaign is Null and http_referer in ('https://www.gsearch.com','https://www.bsearch.com')then order_id else NULL end) as DirectTypeIn
from orders od
left join website_sessions ws
	on od.website_session_id = ws.website_session_id
 group by 1,2
;
