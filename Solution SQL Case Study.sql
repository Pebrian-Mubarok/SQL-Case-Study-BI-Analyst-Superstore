--Case Study 1
select
    count (1) as late_ship
from
    superstore_order
where
    ship_mode = 'Same Day'
    and order_date != ship_date

--Case Study 2
select
    case when discount < 0.2 then 'LOW'
    when discount <0.4 then 'MEDIUM'
    else 'HIGH'
    end as level_discount,
    avg (profit) as avg_profit
from
    superstore_order
group by
    level_discount

--Case Study 3
select
    p.category as category,
    p.sub_category as sub_category,
    avg (o.discount) as avg_discount,
    avg (o.profit) as avg_profit
from
    superstore_product p
    left join
    superstore_order o
    on p.product_id = o.product_id
group by
    1,2
order by
    1,2

--Case Study 4
select
    c.segment,
    sum (o.sales) as sum_sales,
    avg (o.profit) as avg_profit
from
    superstore_customer c
    left join 
    superstore_order o
    on c.customer_id = o.customer_id
where
    extract (year from o.order_date) = 2016
    and c.state in ('California', 'Texas', 'Georgia')
group by
    1
order by
    1

--Case Study 5
with
a as
    (select
        customer_id,
        avg (discount)
     from
        superstore_order
     group by
        1
     having
        avg (discount) > 0.4
    )
select 
    c. region,
    count (1)
from
    a
    join 
    superstore_customer c
    on a.customer_id = c.customer_id
group by
    1