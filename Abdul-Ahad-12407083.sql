create database paper6;

-- first create database paper6 and import each file using table data import wizard!

SELECT * FROM paper6.sales;

SELECT * FROM paper6.customer;

SELECT * FROM paper6.product;


-- 1.	Retrieve the top 5 customers who generated the highest profit for the company.

SELECT 
    customer_name, 
    SUM(profit) AS total_profit
FROM 
    sales
GROUP BY 
    customer_name
ORDER BY 
    total_profit DESC
LIMIT 5;


-- 2. Identify the top 10 most profitable product categories? 

SELECT 
    product_category, 
    SUM(profit) AS total_profit
FROM 
    sales_data
GROUP BY 
    product_category
ORDER BY 
    total_profit DESC
LIMIT 10;


-- 3.	Calculate the average sales per customer for each region.

SELECT 
    region, 
    AVG(total_sales) AS average_sales_per_customer
FROM (
    SELECT 
        region, 
        customer_id, 
        SUM(sales) AS total_sales
    FROM 
        sales_data
    GROUP BY 
        region, customer_id
) AS customer_sales
GROUP BY 
    region;


-- 4. List the top 5 cities with the highest average profit per order.

SELECT 
    city, 
    AVG(profit) AS average_profit_per_order
FROM 
    sales_data
GROUP BY 
    city
ORDER BY 
    average_profit_per_order DESC
LIMIT 5;


-- 5.	Display the total sales and profit for each product subcategory and region, 
--  excluding orders where sales were less than $1000.


SELECT 
    region, 
    product_subcategory, 
    SUM(sales) AS total_sales, 
    SUM(profit) AS total_profit
FROM 
    sales_data
WHERE 
    sales >= 1000
GROUP BY 
    region, 
    product_subcategory
ORDER BY 
    region, 
    product_subcategory;


-- 6.	Calculate the average profit per order and the percentage of orders that were returned for each category, 
--  excluding orders where sales were less than $100.

SELECT 
    category, 
    AVG(profit) AS average_profit_per_order, 
    (SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS percentage_orders_returned
FROM 
    sales_data
WHERE 
    sales >= 100
GROUP BY 
    category
ORDER BY 
    category;
    
-- 7.	Retrieve the total sales and profit for each subcategory and brand combination, 
-- considering only orders that were not returned and were made by customers in the East region.

SELECT 
    product_subcategory, 
    brand, 
    SUM(sales) AS total_sales, 
    SUM(profit) AS total_profit
FROM 
    sales_data
WHERE 
    returned = 'No' 
    AND region = 'East'
GROUP BY 
    product_subcategory, 
    brand
ORDER BY 
    total_sales DESC;


-- 8.	Retrieve the total sales and profit for each brand in each product subcategory.

SELECT 
    product_subcategory, 
    brand, 
    SUM(sales) AS total_sales, 
    SUM(profit) AS total_profit
FROM 
    sales_data
GROUP BY 
    product_subcategory, 
    brand
ORDER BY 
    product_subcategory, 
    brand;


-- 9.	List the top 10 states by total sales, excluding orders that were returned.

SELECT 
    state, 
    SUM(sales) AS total_sales
FROM 
    sales_data
WHERE 
    returned = 'No'
GROUP BY 
    state
ORDER BY 
    total_sales DESC
LIMIT 10;

-- 10.	Retrieve the top 10 customers with the most returns, 
-- along with the total value of their returns.

SELECT 
    customer_id, 
    COUNT(*) AS total_returns, 
    SUM(sales) AS total_value_of_returns
FROM 
    sales_data
WHERE 
    returned = 'Yes'
GROUP BY 
    customer_id
ORDER BY 
    total_returns DESC
LIMIT 10;
