select 
	YEAR(created_at) as Yr,
    MONTH(created_at) as Mnth,
    SUM(CASE WHEN product_id = 1 THEN price_usd ELSE NULL END) as MrFuzzyRev,
    SUM(CASE WHEN product_id = 1 THEN price_usd - cogs_usd ELSE NULL END) as MrFuzzyMarg,
    SUM(CASE WHEN product_id = 2 THEN price_usd ELSE NULL END) as LoveBearRev,
    SUM(CASE WHEN product_id = 2 THEN price_usd - cogs_usd ELSE NULL END)as LoveBearMarg,
    SUM(CASE WHEN product_id = 3 THEN price_usd ELSE NULL END) as BirthdayBearRev,
    SUM(CASE WHEN product_id = 3 THEN price_usd - cogs_usd ELSE NULL END) as BirthdayBearMarg,
    SUM(CASE WHEN product_id = 4 THEN price_usd ELSE NULL END) as MiniBearRev,
	SUM(CASE WHEN product_id = 4 THEN price_usd - cogs_usd ELSE NULL END) as MiniBearMarg,
    SUM(price_usd) as TotalRevenue,
    SUM(price_usd-cogs_usd) as TotalMargin
from order_items
group by 1,2
order by 1,2
;

-- Insights on seasonality, observed in revenue during months of November and December for MrFuzzy (Holiday)
-- Insights on seasonality, observed in revenue during months of February LoveBear and MiniBear (Valentines)