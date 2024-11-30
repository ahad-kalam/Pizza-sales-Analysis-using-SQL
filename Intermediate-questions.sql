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
    
    
-- Intermediate Questions :-


-- 1. join the necessary table to find the total quantity of each pizza order??

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC;



-- 2. join the necessary table to find the total quantity of each pizza category order??

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;



-- 3. determine the distribution of order by hour of the day??

SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS total_order
FROM
    orders
GROUP BY hour
ORDER BY total_order DESC;



-- 4. join relevent tables to find the category wise distribution of pizzas??

SELECT 
    category, COUNT(name) AS count
FROM
    pizza_types
GROUP BY category
ORDER BY count DESC;



-- 5. group the orders by date and calculate the average number of pizzas order by per day??

SELECT 
    ROUND(AVG(quantity), 0) as avg_order_perDay
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS total_order;
    

-- 6. determine the top 3 most ordered pizzas types based on revenue??

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;


-- 7. 
