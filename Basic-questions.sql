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
    
    
-- Basic Questions :-

-- 1. retrieve the total number of order?

SELECT 
    COUNT(order_details_id) AS total_order
FROM
    order_details;


-- 2. Calculate the total revenue generated from pizza sales?

SELECT 
    ROUND(SUM(pizzas.price * order_details.quantity),
            2) AS Total_revenue
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id;
    
    
-- 3. Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 3;


-- 4. identify the most common pizza size ordered?

SELECT 
    pizzas.size, SUM(order_details.quantity) AS total_order
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY total_order DESC;


-- 5. list the top 5 most ordered pizza types along with their quantities?

SELECT 
    pizza_types.name AS name,
    SUM(order_details.quantity) AS total_quantities
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY total_quantities DESC
LIMIT 5;