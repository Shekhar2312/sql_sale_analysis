                                           -- SQL RETAIL SALES ANALYSIS_2025--
CREATE DATABASE RETAIL_SALES_2025
use retail_sale2025
-- create table
drop table if exists sales2025;
CREATE TABLE sales2025 (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
-- DATA CLEANING --
SELECT 
    *
FROM
    sales2025
LIMIT 10;
SELECT 
    COUNT(*)
FROM
    sales2025;
SELECT 
    *
FROM
    sales2025
WHERE
    transaction_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR GENDER IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantity IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;
     -- 
	DELETE FROM sales2025 
WHERE
    transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR GENDER IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;
     
    -- DATA EXPLORATION --
    
SELECT 
    COUNT(*) AS total_sale
FROM
    sales2025;
    
     -- HOW MANY UNIQUE_CUSTOMERS WE HAVE? --
SELECT 
    COUNT(DISTINCT customer_id) AS total_sale
FROM
    sales2025;
      
      
SELECT DISTINCT
    CATEGORY
FROM
    sales2025;
       
       
     -- DATA ANALYSIS & BUSINESS PROPLEM--
     
SELECT 
    *
FROM
    sales2025
WHERE
    sale_date = '2022-11-05';
    
   --  Write a SQL query to retrieve all transaction where the category is 'Clothing' and the quan ty sold is more than 4 in the month of Nov-2022 --
SELECT 
    category, SUM(quantity)
FROM
    sales2025
WHERE
    category = 'Clothing'
GROUP BY 1;
SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM
    sales2025
GROUP BY 1;
        -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT 
    *
FROM
    sales2025
WHERE
    category = 'Beauty';
SELECT 
    AVG(age) AS avg_age
FROM
    sales2025
WHERE
    category = 'Beauty';
SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM
    sales2025
WHERE
    category = 'Beauty';
        
        -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000--
SELECT 
    *
FROM
    sales2025
WHERE
    total_sale > 1000;
        
        -- Q.6 Write a SQL query to find the total number of transactions (transac on_id) made by each gender in each category. 
SELECT 
    category, gender, COUNT(*) AS toatl_trans
FROM
    sales2025
GROUP BY category , gender
ORDER BY 2;
              
        
        -- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year --
SELECT 
    YEAR(sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_total_sale
FROM
    sales2025
GROUP BY 1 , 2
ORDER BY 1 , 3 DESC;
        
        select 
        year(sale_date) as year,
        extract(month from sale_date) as month,
        avg(total_sale) as avg_total_sale,
        rank() over (partition by year(sale_date) order by avg(total_sale) desc)
        from sales2025
	    group by 1,2;
        
        -- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales  
SELECT 
    customer_id, SUM(total_sale) AS total_sales
FROM
    sales2025
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
        -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
			
		SELECT 
    category, COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM
    sales2025
GROUP BY category;
             
             -- Q.10 Write a SQL query to create each shi and number of orders (Example Morning <=12, afternoon between 12 & 17, Evening >17) 
SELECT 
    *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
        ELSE 'evening'
    END AS shift
FROM
    sales2025;
              with hourly_sale
              as
              (
                select *,
               case
               when extract(hour from sale_time) < 12 then 'morning'
                when extract(hour from sale_time) between 12 and 17 then 'afternoon'
                else 'evening'
                end as shift
                from sales2025
                )
                select
                shift,
                count(*) as total_order
                from hourly_sale
                group by shift;
                
                
                                                            -- END OF THE PROJECT--