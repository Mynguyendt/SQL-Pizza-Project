-- table (all columns)
( 
-- order_details:   order_details_id, order_id, pizza_id, quantity

-- pizzas:          pizza_id, pizza_type_id, size, price

-- orders:          order_id, date, time

-- pizza_types:     pizza_type_id, name, category, ingredients 
)


-- 1/ Calculate the total revenue generated from pizza sales.
(
select 
 cast(sum(p.price*od.quantity) as decimal(10,2))  as total_revenue
from pizza.pizzas as p
join pizza.order_details as od on p.pizza_id = od.pizza_id
)

-- 2/ Identify the highest-priced pizza.
(
select  pizza.pizza_types.name as 'Pizza Name'
, cast(pizza.pizzas.price as decimal(10,2)) as 'Price'
from pizza.pizzas 
join pizza.pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by price desc
limit 1
)

-- 3/ The most common pizza size ordered
(
select pizza.pizzas.size, 
count(distinct pizza.order_details.order_id) as number_order
,sum(pizza.order_details.quantity) as total_order
from pizza.order_details
join pizza.pizzas on pizza.pizzas.pizza_id = pizza.order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza.pizzas.size
order by count(distinct order_id) desc
)

-- 4/ The distribution of orders by hour of the day
(
select hour(pizza.orders.time) as hour_day
, count(distinct pizza.orders.order_id) as number_pizza
from pizza.orders
group by hour(pizza.orders.time)
)

-- 5/ The average number of pizzas ordered per day
(
with table1 as(
select pizza.orders.date 
, sum(pizza.order_details.quantity) as total_pizza
from pizza.order_details
join pizza.orders on pizza.order_details.order_id = pizza.orders.order_id
group by pizza.orders.date
)
select
avg(total_pizza) as avg_pizza
from table1
)

-- 6/ The percentage contribution of each pizza type to total revenues
(
select 
category
,cast(sum(pizza.pizzas.price*pizza.order_details.quantity) /(
select sum(order_details.quantity*pizzas.price) as total
from order_details 
join pizzas on pizzas.pizza_id = order_details.pizza_id) as decimal(10,3)) *100
 as percentage_revenue
from pizza.pizzas
join pizza.order_details on  pizza.order_details.pizza_id = pizza.pizzas.pizza_id
join pizza.pizza_types on  pizza.pizza_types.pizza_type_id = pizza.pizzas.pizza_type_id
group by category
)

-- 7/ The cumulative revenue generated over time
(
with table1 as (
select
date 
, cast(sum(quantity*price) as decimal(10,2)) as Revenue
from order_details 
join orders on order_details.order_id = orders.order_id
join pizzas on pizzas.pizza_id = order_details.pizza_id
group by date)
select
Date
, Revenue
, sum(Revenue) over (order by date) as 'Cumulative Sum'
from table1 
group by date, Revenue
)

-- 8/ The variation of revenue per day
(
with table1 as (
select
date 
, cast(sum(quantity*price) as decimal(10,2)) as Revenue
from order_details 
join orders on order_details.order_id = orders.order_id
join pizzas on pizzas.pizza_id = order_details.pizza_id
group by date
)
, table2 AS (
    SELECT
        date,
        Revenue,
        LAG(Revenue) OVER (ORDER BY date) AS PrevRevenue
    FROM table1
)
SELECT
    date,
    Revenue,
    PrevRevenue,
    CASE
        WHEN PrevRevenue IS NULL THEN 0
        ELSE (Revenue - PrevRevenue) / PrevRevenue * 100
    END AS PercentChange
    FROM table2
    )
    
-- 9/ The price range customer often choose
( 
select pizza.pizzas.price
,sum(pizza.order_details.quantity) as total_order_price
from pizza.order_details
join pizza.pizzas on pizza.pizzas.pizza_id = pizza.order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza.pizzas.price
order by count(distinct order_id) desc
)