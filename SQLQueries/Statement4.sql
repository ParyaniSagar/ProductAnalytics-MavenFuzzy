-- drop table myt;
create temporary table myt
select
    ws.created_at,
    ws.website_session_id,
    order_id,
    case when utm_source ='gsearch' and utm_campaign = 'nonbrand' then ws.website_session_id else NULL end as GsearchNonBrandSession,
    case when utm_source ='gsearch' and utm_campaign = 'nonbrand' then order_id else NULL end as GsearchNonBrandOrder, 
    case when utm_source = 'bsearch' and utm_campaign = 'nonbrand' then ws.website_session_id else NULL end as BsearchNonBrandSession,
    case when utm_source = 'bsearch' and utm_campaign = 'nonbrand' then order_id else NULL end as BsearchNonBrandOrder,
    case when utm_campaign ='brand' then ws.website_session_id else NULL end as BrandSession,
    case when utm_campaign ='brand' then order_id else NULL end as BrandOrder,
    case when utm_source is null and utm_campaign is NULL and http_referer is Null then ws.website_session_id else NULL end as OrganicSearchSession,
    case when utm_source is null and utm_campaign is NULL and http_referer is Null then order_id else NULL end as OrganicSearchOrder,
    case when utm_source is null and utm_campaign is Null and http_referer in ('https://www.gsearch.com','https://www.bsearch.com')then ws.website_session_id else NULL end as DirectTypeInSession,
    case when utm_source is null and utm_campaign is Null and http_referer in ('https://www.gsearch.com','https://www.bsearch.com')then order_id else NULL end as DirectTypeInOrder
from website_sessions ws
left join orders od
	on od.website_session_id = ws.website_session_id
;


select 
	CONCAT(CONCAT(year(created_at),'_Q'),Quarter(created_at)) Yr_Qt,
    count(distinct website_session_id) as sessions,
    count(distinct order_id) as orders,
    count(distinct GsearchNonBrandOrder)/count(distinct GsearchNonBrandSession) as GSearchNonBrandConvRt,
    count(distinct BsearchNonBrandOrder)/count(distinct BsearchNonBrandSession) as BSearchNonBrandConvRt,
    count(distinct BrandOrder)/count(distinct BrandSession) as BrandConvRt,
	count(distinct OrganicSearchOrder)/count(distinct OrganicSearchSession) as OrganicSearchConvRt,
	count(distinct DirectTypeInOrder)/count(distinct DirectTypeInSession) as DirectTypeInConvRt
from myt
group by 1
;


