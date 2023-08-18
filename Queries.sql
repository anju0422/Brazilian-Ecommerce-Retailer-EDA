/* Tool used - BigQuery(Sandbox)
   Author - Anju Saini */
   
/* We have total 8 tables for Analysis */

SELECT * FROM `Target.orders`;
SELECT * FROM `Target.order_items`;
SELECT * FROM `Target.customers`;
SELECT * FROM `Target.geolocation`;
SELECT * FROM `Target.order_reviews`;
SELECT * FROM `Target.payments`;
SELECT * FROM `Target.products`;
SELECT * FROM `Target.sellers`;

/* Number of rows present in each table */

SELECT "orders" AS table_name,COUNT(*) AS row_count FROM  `Target.orders`
UNION ALL
SELECT "order_items" AS table_name,COUNT(*) AS row_count FROM  `Target.order_items`
UNION ALL
SELECT "customers" AS table_name,COUNT(*) AS row_count FROM  `Target.customers`
UNION ALL
SELECT "products" AS table_name,COUNT(*) AS row_count FROM  `Target.products`
UNION ALL
SELECT "geolocation" AS table_name,COUNT(*) AS row_count FROM  `Target.geolocation`
UNION ALL 
SELECT "order_reviews" AS table_name,COUNT(*) AS row_count FROM `Target.order_reviews`
UNION ALL 
SELECT "payments" AS table_name,COUNT(*) AS row_count FROM  `Target.payments`
UNION ALL 
SELECT "sellers" AS table_name,COUNT(*) AS row_count FROM  `Target.sellers`;

/*  Data type of columns in a tables */

SELECT
table_name,
column_name,
data_type
FROM target-biz-casestudy.Target.INFORMATION_SCHEMA.COLUMNS;
     
/* Time period for which the data is given */

SELECT
MIN(EXTRACT(DATE FROM order_purchase_timestamp)) AS first_date_of_dataset,
MAX(EXTRACT(DATE FROM order_purchase_timestamp)) AS first_date_of_dataset,
CONCAT(ROUND(DATE_DIFF(MAX(EXTRACT(DATE FROM order_purchase_timestamp)),
MIN(EXTRACT(DATE FROM order_purchase_timestamp)),day)/365,2)," ","Years") AS DURATION
FROM `Target.orders`;
     
/* Count the Cities & States of customers who ordered during the given period */

SELECT 
COUNT(DISTINCT c.customer_city) AS city,
COUNT(DISTINCT c.customer_state) AS state
FROM  `Target.customers`  c 
JOIN `Target.orders` o
ON o.customer_id = c.customer_id
WHERE o.order_purchase_timestamp BETWEEN "2016-09-04 21:15:19 UTC" AND "2018-10-17 17:30:18 UTC";
       
/* Total number of different cities and states in which customers are registered. */

SELECT
COUNT(DISTINCT customer_city) as Total_cities,
COUNT(DISTINCT customer_state) as Total_states
FROM `Target.customers`;
      
/* Total number of different cities and states in which sellers are registered. */

SELECT
COUNT(DISTINCT seller_city) as Total_cities,
Count(DISTINCT seller_state) as Total_states
FROM `Target.sellers`;
     
/* Is there a growing trend in e-commerce in Brazil? How can we describe a complete scenario? */

WITH CTE AS (
    SELECT 
	EXTRACT(MONTH FROM o.order_purchase_timestamp) AS Months,
	EXTRACT(YEAR FROM o.order_purchase_timestamp ) AS Years,
	ROUND(SUM(i.price) OVER(PARTITION BY EXTRACT(YEAR FROM o.order_purchase_timestamp), 
    EXTRACT(MONTH FROM o.order_purchase_timestamp))) AS Total_monthly_order_value,
    ROUND(AVG(i.price) OVER(PARTITION BY EXTRACT(YEAR FROM o.order_purchase_timestamp), 
	EXTRACT(MONTH FROM o.order_purchase_timestamp))) AS Average_monthly_order_value,
	COUNT(i.price) OVER(PARTITION BY EXTRACT(YEAR FROM o.order_purchase_timestamp), 
	EXTRACT(MONTH FROM o.order_purchase_timestamp)) AS Total_monthly_order
	FROM `Target.orders` o  
	JOIN `Target.order_items` i  
	ON  o.order_id = i.order_id
)
          SELECT 
		  DISTINCT * 
          FROM CTE
          ORDER BY Years, Months;
          
/* Can we see some seasonality with peaks at specific months? */

SELECT DISTINCT
EXTRACT(MONTH FROM o.order_purchase_timestamp) AS Months,
EXTRACT(YEAR FROM o.order_purchase_timestamp ) AS Years,
COUNT(i.price) OVER(PARTITION BY EXTRACT(YEAR FROM o.order_purchase_timestamp), 
EXTRACT(MONTH FROM o.order_purchase_timestamp)) AS Total_monthly_order
FROM `Target.orders` o  
JOIN `Target.order_items` i  
ON o.order_id = i.order_id
ORDER BY Years, Months;

/* During what time of the day, do the Brazilian customers mostly place their orders? (Dawn, Morning, Afternoon or Night) */

WITH CTE AS(
     SELECT
	 order_id,
     CASE
         WHEN EXTRACT(HOUR FROM order_purchase_timestamp ) >= 0 AND 
         EXTRACT(HOUR FROM order_purchase_timestamp) < 6 THEN 
         'Dawn  (0:00 AM to 5:59:59 AM)'
         WHEN EXTRACT(HOUR FROM order_purchase_timestamp) >= 6 AND 
         EXTRACT(HOUR FROM order_purchase_timestamp) < 12 THEN 
         'Morning  (6:00 AM to 11;59:59 AM)'
         WHEN EXTRACT(HOUR FROM order_purchase_timestamp) >= 12 AND 
         EXTRACT(HOUR FROM order_purchase_timestamp) < 18 THEN  
        'Afternoon  (12:00 PM to 5:59:59 PM)'
         WHEN EXTRACT(HOUR FROM order_purchase_timestamp) >= 18 OR 
         EXTRACT(HOUR FROM order_purchase_timestamp) < 23 THEN 
         'Night  (6:00 PM to 11:59:59 PM)'
    END AS time_of_day
    FROM `Target.orders`
) 
  SELECT
  time_of_day,
  COUNT(order_id) AS total_orders
  FROM CTE 
  GROUP BY time_of_day
  ORDER BY total_orders DESC;
