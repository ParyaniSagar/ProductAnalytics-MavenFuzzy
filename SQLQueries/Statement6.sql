-- drop table ProductSessions;
create temporary table ProductSessions
select 
    created_at,
    website_session_id,
    website_pageview_id
from website_pageviews
where pageview_url = '/products';

create temporary table NextProductSessions
select 
	ps.created_at,
    ps.website_session_id,
    wp.pageview_url as next_page
from ProductSessions ps
left join website_pageviews wp
	on wp.website_session_id = ps.website_session_id 
	and wp.website_pageview_id > ps.website_pageview_id
    and wp.pageview_url in ('/the-original-mr-fuzzy','/the-forever-love-bear','/the-birthday-sugar-panda','/the-hudson-river-mini-bear')
;

select 
	year(nps.created_at) as Yr,
    month(nps.created_at) as Mnth,
    count(distinct nps.website_session_id) as sessions,
    count(distinct CASE WHEN next_page = '/the-original-mr-fuzzy' THEN nps.website_session_id ELSE NULL END) as ToMrFuzzy,
	count(distinct CASE WHEN next_page = '/the-forever-love-bear' THEN nps.website_session_id ELSE NULL END)as ToLoveBear,
	count(distinct CASE WHEN next_page = '/the-birthday-sugar-panda' THEN nps.website_session_id ELSE NULL END) as ToSugarPanda,
	count(distinct CASE WHEN next_page = '/the-hudson-river-mini-bear' THEN nps.website_session_id ELSE NULL END) as ToMiniBear,
    count(distinct od.order_id) as orders,
    count(distinct od.order_id)/count(distinct nps.website_session_id) as ConvRate
from NextProductSessions nps
left join orders od
	on od.website_session_id =  nps.website_session_id
group by 1,2    
order by 1,2
;   