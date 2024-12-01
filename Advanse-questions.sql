-- first i created a database name pizzahut for this project.
create database pizzahut;

-- I used this database to create tables and solve questions.
use pizzahut;


-- I import all three files data from import wazerd

SELECT 
    *
FROM
    order_details;

SELECT 
    *
FROM
    pizzas;

SELECT 
    *
FROM
    orders;

SELECT 
    *
FROM
    pizza_types;
    
    

-- Advance Questions :-

-- 1. Calculate the percentage contribution of each pizza 
-- type of total revenue??


SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;



-- 2. Analyse the cumulative revenue generated over time ??

select order_date, revenue,
sum(revenue) over(order by order_date) as cum_revenue
from
(select orders.order_date, 
round(sum(order_details.quantity * pizzas.price),2) as revenue
from order_details join pizzas on
order_details.pizza_id = pizzas.pizza_id
join orders on 
orders.order_id = order_details.order_id
group by orders.order_date) as sales;



-- 3. Determine the top 3 most ordered pizza type on based on revenue 
--  for each pizza category??

select category, name , revenue,rank_
from
(select category, name , revenue, 
rank() over(partition by category order by revenue desc) as rank_
from
(select pizza_types.category, pizza_types.name,
round(sum(order_details.quantity * pizzas.price),2) as revenue
from pizza_types join pizzas on 
pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on 
order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name
order by revenue desc) as sales) as nisar
where rank_ = 1;
