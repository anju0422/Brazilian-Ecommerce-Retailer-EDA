/* Tool used - BigQuery(Sandbox)
   Author - Anju Saini */
   
/* We have total of 8 tables for Analysis */

SELECT * FROM `Target.orders`;
SELECT * FROM `Target.order_items`;
SELECT * FROM `Target.customers`;
SELECT * FROM `Target.geolocation`;
SELECT * FROM `Target.order_reviews`;
SELECT * FROM `Target.payments`;
SELECT * FROM `Target.products`;
SELECT * FROM `Target.sellers`;

/*  Number of rows present in each table */

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

/* Q1. Data type of columns in a tables */

SELECT
table_name,
column_name,
data_type
FROM target-biz-casestudy.Target.INFORMATION_SCHEMA.COLUMNS;

/* Q2. Time period for which the data is given */

SELECT
MIN(EXTRACT(DATE FROM order_purchase_timestamp)) AS first_date_of_dataset,
MAX(EXTRACT(DATE FROM order_purchase_timestamp)) AS first_date_of_dataset,
CONCAT(ROUND(DATE_DIFF(MAX(EXTRACT(DATE FROM order_purchase_timestamp)),
MIN(EXTRACT(DATE FROM order_purchase_timestamp)),day)/365,2)," ","Years") AS DURATION
FROM `Target.orders`;


/* Q3. Count the Cities & States of customers who ordered during the given period */

SELECT 
COUNT(DISTINCT c.customer_city) AS city,
COUNT(DISTINCT c.customer_state) AS state
FROM  `Target.customers`  c 
JOIN `Target.orders` o
ON o.customer_id = c.customer_id
WHERE o.order_purchase_timestamp BETWEEN "2016-09-04 21:15:19 UTC" AND "2018-10-17 17:30:18 UTC";

/* Q4. Total number of different cities and states in which customers are registered. */

SELECT
COUNT(DISTINCT customer_city) as Total_cities,
COUNT(DISTINCT customer_state) as Total_states
FROM `Target.customers`;

/* Q5. Total number of different cities and states in which sellers are registered. */

SELECT
COUNT(DISTINCT seller_city) as Total_cities,
Count(DISTINCT seller_state) as Total_states
FROM `Target.sellers`;

/* Q6. Is there a growing trend in e-commerce in Brazil? How can we describe a complete scenario? */

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

/* Q7. Can we see some seasonality with peaks at specific months? */

SELECT DISTINCT
EXTRACT(MONTH FROM o.order_purchase_timestamp) AS Months,
EXTRACT(YEAR FROM o.order_purchase_timestamp ) AS Years,
COUNT(i.price) OVER(PARTITION BY EXTRACT(YEAR FROM o.order_purchase_timestamp), 
EXTRACT(MONTH FROM o.order_purchase_timestamp)) AS Total_monthly_order
FROM `Target.orders` o  
JOIN `Target.order_items` i  
ON o.order_id = i.order_id
ORDER BY Years, Months;

/* Q8. During what time of the day, do the Brazilian customers mostly place their orders? (Dawn, Morning, Afternoon or Night) */

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

/* Q9. Get the month-on-month orders by region and state. */

SELECT DISTINCT
c.customer_state AS State,
c.customer_city AS City,
EXTRACT(YEAR FROM o.order_purchase_timestamp) AS Years,
EXTRACT(MONTH FROM o.order_purchase_timestamp) AS Months,
COUNT(o.order_id)  OVER(PARTITION BY c.customer_state, c.customer_city, EXTRACT(YEAR FROM o.order_purchase_timestamp),
EXTRACT(MONTH FROM o.order_purchase_timestamp)) AS Total_monthly_orders
FROM `Target.customers` c 
JOIN `Target.orders` o  
ON c.customer_id = o.customer_id
ORDER BY State, City, Years, Months;

/* Q10. Total no of distinct states, cities and zip codes in which customers are present. */

SELECT 
COUNT(DISTINCT customer_state) AS Total_customer_states,
COUNT(DISTINCT customer_city) AS Total_customer_city,
COUNT(DISTINCT customer_zip_code_prefix) AS Total_customer_zipcodes
FROM  `Target.customers`;

/* Q11. Total number of customers present in different states. */

SELECT 
customer_state AS States,
COUNT(customer_id) AS Total_customers
FROM `Target.customers`
GROUP BY customer_state
ORDER BY  Total_customers DESC;

/* Q12. Total number of customers present in different cities. */

SELECT 
customer_city AS City,
COUNT(customer_id) AS Total_customers
FROM `Target.customers`
GROUP BY customer_city
ORDER BY  Total_customers DESC;

/* Q13. Get the % increase in the cost of orders from the year 2017 to 2018 (include months between Jan to Aug only). */

WITH CTE AS(
     SELECT 
           EXTRACT(MONTH FROM o.order_purchase_timestamp) AS Months,
           ROUND(SUM(CASE 
                        WHEN EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017 AND 
                        EXTRACT(MONTH FROM order_purchase_timestamp) BETWEEN 1 AND 8 
                        THEN i.price END ),2) AS Monthly_order_cost_2017,
           ROUND(SUM(CASE 
                       WHEN EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018 AND 
                       EXTRACT(MONTH FROM order_purchase_timestamp) BETWEEN 1 AND 8 
                       THEN i.price END ),2) AS Monthly_order_cost_2018
   FROM `Target.orders` o  
   JOIN `Target.order_items` i  
   ON  o.order_id = i.order_id
   WHERE EXTRACT(Month FROM order_purchase_timestamp) BETWEEN 1 AND 8
   GROUP BY Months

) 
      SELECT
      Months,
      Monthly_order_cost_2017,
      Monthly_order_cost_2018,
      CONCAT(ROUND(((Monthly_order_cost_2018 - Monthly_order_cost_2017)/
      Monthly_order_cost_2017)*100,2)," %") AS Percentage_increase
      FROM CTE
      ORDER BY Months;

/* Q14. Get the total % increase in the cost of orders from the year 2017 to 2018 (include months between Jan to Aug only). */

     SELECT 
           ROUND(SUM(CASE 
                        WHEN EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017 AND 
                        EXTRACT(MONTH FROM order_purchase_timestamp) BETWEEN 1 AND 8 
			THEN i.price END ),2) AS Monthly_order_cost_2017,
           ROUND(SUM(CASE 
                        WHEN EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018 AND 
                        EXTRACT(MONTH FROM order_purchase_timestamp) BETWEEN 1 AND 8 
                        THEN i.price END ),2) AS Monthly_order_cost_2018
   FROM `Target.orders` o  
   JOIN `Target.order_items` i  
   ON o.order_id = i.order_id
   WHERE EXTRACT(Month FROM order_purchase_timestamp) BETWEEN 1 AND 8

) 
  SELECT
  Monthly_order_cost_2017,
  Monthly_order_cost_2018,
  CONCAT(ROUND(((Monthly_order_cost_2018 - Monthly_order_cost_2017)/ Monthly_order_cost_2017)*100,2)," %") AS Percentage_increase
  FROM CTE;

/* Q15. Mean & Sum of price and freight value by a customer state. */

SELECT 
c.customer_state AS State,
ROUND(SUM(i.price),2) AS Price,
ROUND(AVG(i.price),2) Mean_of_price,
ROUND(SUM(i.freight_value),2) AS Freight_value,
ROUND(AVG(i.freight_value),2) AS Mean_of_freight_value
FROM `Target.customers` c
JOIN `Target.orders` o 
ON c.customer_id = o.customer_id 
JOIN `Target.order_items` i  
ON i.order_id = o.order_id
GROUP BY State
ORDER BY Price DESC;

/* Q16. Calculate days between purchasing, delivering, and estimated delivery
   - time_to_delivery  =  order_purchase_timestamp - order_delivered_customer_date
   - diff_estimated_delivery  =  order_estimated_delivery_date - order_delivered_customer_date */

SELECT 
c.customer_state AS State,
c.customer_city AS City,
c.customer_zip_code_prefix AS Zipcodes,
DATE_DIFF(DATE(o.order_estimated_delivery_date), DATE(o.order_purchase_timestamp),DAY) AS Time_to_estimated_delivery,
DATE_DIFF(DATE(o.order_delivered_customer_date), DATE(o.order_purchase_timestamp),DAY) AS Time_to_actual_delivery,
      (
         DATE_DIFF(DATE(o.order_delivered_customer_date),
                                     DATE(o.order_purchase_timestamp),DAY) - 
         DATE_DIFF(DATE(o.order_estimated_delivery_date),
                                     DATE(o.order_purchase_timestamp),DAY)
      )  AS Difference
FROM `Target.customers` c  
JOIN `Target.orders` o  
ON c.customer_id = o.customer_id
WHERE o.order_status = "delivered"
ORDER BY c.customer_state, c.customer_city, c.customer_zip_code_prefix;

/* Q17. Group data by state, take mean of freight_value, time_to_delivery, diff_estimated_delivery */

SELECT 
c.customer_state AS State,
ROUND(AVG(i.freight_value),2) AS Avg_shipping_cost,
      ROUND(AVG(
              DATE_DIFF(DATE(o.order_estimated_delivery_date),
              DATE(o.order_purchase_timestamp),DAY)),2) AS Avg_estimated_delivery_time,
      ROUND(AVG(
             DATE_DIFF(DATE(o.order_delivered_customer_date),
             DATE(o.order_purchase_timestamp),DAY)),2) AS Avg_actual_delivery_time,
      ROUND(AVG((
             DATE_DIFF(DATE(o.order_delivered_customer_date),
             DATE(o.order_purchase_timestamp),DAY)  - 
             DATE_DIFF(DATE(o.order_estimated_delivery_date),
             DATE(o.order_purchase_timestamp),DAY))),2) AS Avg_difference
FROM `Target.customers` c  
JOIN `Target.orders` o  
ON c.customer_id = o.customer_id
JOIN `Target.order_items` i  
ON o.order_id = i.order_id
WHERE o.order_status = "delivered"
GROUP BY c.customer_state
ORDER BY c.customer_state;

/* Q18. Top 5 states with the highest average freight value */

SELECT 
c.customer_state AS State,
ROUND(AVG(i.freight_value),2) AS Avg_shipping_cost
FROM `Target.customers` c 
JOIN `Target.orders` o  
ON c.customer_id = o.customer_id  
JOIN `Target.order_items`   i   
ON o.order_id = i.order_id 
WHERE o.order_status = "delivered"
GROUP BY c.customer_state
ORDER BY Avg_shipping_cost DESC
LIMIT 5;

/* Q19. Top 5 states with lowest average freight value */

c.customer_state AS State,
ROUND(AVG(i.freight_value),2) AS Avg_shipping_cost
FROM `Target.customers` c 
JOIN `Target.orders` o  
ON c.customer_id = o.customer_id  
JOIN `Target.order_items`   i   
ON o.order_id = i.order_id 
WHERE o.order_status = "delivered"
GROUP BY c.customer_state
ORDER BY Avg_shipping_cost ASC
LIMIT 5;

/* Q20. Top 5 state with the highest average time to delivery */

SELECT 
c.customer_state AS State,
ROUND(AVG(DATE_DIFF(DATE(o.order_delivered_customer_date),
DATE(o.order_purchase_timestamp),DAY)),2) AS Avg_actual_delivery_time
FROM `Target.customers` c  
JOIN `Target.orders` o  
ON c.customer_id = o.customer_id 
WHERE o.order_status = "delivered"
GROUP BY c.customer_state
ORDER BY Avg_actual_delivery_time DESC
LIMIT 5;

/* Q21. Top 5 state with lowest average time to delivery i.e., Fastest delivery */

SELECT 
c.customer_state AS State,
ROUND(AVG(DATE_DIFF(DATE(o.order_delivered_customer_date),
DATE(o.order_purchase_timestamp),DAY)),2) AS Avg_actual_delivery_time
FROM `Target.customers` c  
JOIN `Target.orders` o  
ON c.customer_id = o.customer_id 
WHERE (o.order_status) = "delivered"
GROUP BY c.customer_state
ORDER BY Avg_actual_delivery_time ASC
LIMIT 5;

/* Q22. Top 5 states where delivery really FAST compared to estimated delivery time */

SELECT 
      c.customer_state AS State,
      ROUND(AVG(
            DATE_DIFF(DATE(o.order_estimated_delivery_date),
            DATE(o.order_purchase_timestamp),DAY)),2) AS Avg_estimated_delivery_time,
      ROUND(AVG(
            DATE_DIFF(DATE(o.order_delivered_customer_date),
            DATE(o.order_purchase_timestamp),DAY)),2) AS Avg_actual_delivery_time,
      ROUND(AVG((
            DATE_DIFF(DATE(o.order_delivered_customer_date),
            DATE(o.order_purchase_timestamp),DAY)  - 
            DATE_DIFF(DATE(o.order_estimated_delivery_date),
            DATE(o.order_purchase_timestamp),DAY))),2) AS Avg_difference
FROM  `Target.customers` c  
JOIN `Target.orders` o  
ON c.customer_id = o.customer_id
WHERE o.order_status = "delivered"
GROUP BY c.customer_state
ORDER BY Avg_Difference ASC
LIMIT 5;

/* Q23. Top 5 states where delivery really SLOW compared to estimated delivery time */

SELECT 
      c.customer_state AS State,
      ROUND(AVG(
            DATE_DIFF(DATE(o.order_estimated_delivery_date),
            DATE(o.order_purchase_timestamp),DAY)),2) AS Avg_estimated_delivery_time,
      ROUND(AVG(
            DATE_DIFF(DATE(o.order_delivered_customer_date),
            DATE(o.order_purchase_timestamp),DAY)),2) AS Avg_actual_delivery_time,
      ROUND(AVG((
            DATE_DIFF(DATE(o.order_delivered_customer_date),
            DATE(o.order_purchase_timestamp),DAY)  - 
            DATE_DIFF(DATE(o.order_estimated_delivery_date),
            DATE(o.order_purchase_timestamp),DAY))),2) AS Avg_difference
FROM  `Target.customers` c  
JOIN `Target.orders` o  
ON c.customer_id = o.customer_id
WHERE o.order_status = "delivered"
GROUP BY c.customer_state
ORDER BY Avg_Difference DESC
LIMIT 5;

/* Q24. No of orders. shipping cost and delivery time over different states */

WITH CTE AS (
      SELECT 
      c.customer_state AS State,
      COUNT(o.order_id) AS no_of_orders,
      ROUND(AVG(i.freight_value),2) AS Avg_shipping_cost,
      ROUND(AVG(
                  DATE_DIFF(DATE(o.order_estimated_delivery_date),
                  DATE(o.order_purchase_timestamp),DAY)),2) AS Avg_estimated_delivery_time,
      ROUND(AVG(
                  DATE_DIFF(DATE(o.order_delivered_customer_date),
                  DATE(o.order_purchase_timestamp),DAY)),2) AS Avg_actual_delivery_time,
      ROUND(AVG((
                  DATE_DIFF(DATE(o.order_delivered_customer_date),
                  DATE(o.order_purchase_timestamp),DAY)  - 
                  DATE_DIFF(DATE(o.order_estimated_delivery_date),
                  DATE(o.order_purchase_timestamp),DAY))),2) AS Avg_difference
	FROM  `Target.customers` c 
	JOIN `Target.orders` o  
	ON c.customer_id = o.customer_id
	JOIN `Target.order_items` i  
	ON o.order_id = i.order_id
	WHERE o.order_status = "delivered"
	GROUP BY c.customer_state
      
	)
               SELECT 
	       State,
	       no_of_orders,
	       Avg_shipping_cost,
	       Avg_actual_delivery_time
               FROM CTE 
               ORDER BY no_of_orders DESC;

/* Q25. Month over Month count of orders for different payment types. */

SELECT 
EXTRACT(YEAR FROM o.order_purchase_timestamp) AS Years,
EXTRACT(MONTH FROM o.order_purchase_timestamp) AS Months,
p.payment_type AS Payment_type, 
COUNT(p.order_id) AS No_of_orders
FROM `Target.orders`  o  
JOIN `Target.payments`  p   
ON o.order_id = p.order_id
GROUP BY Years, Months, Payment_type
ORDER BY Years, Months, No_of_orders;

/* Q26. EMI and Non-EMI order value split */

WITH CTE AS(
      SELECT 
	  EXTRACT(YEAR FROM o.order_purchase_timestamp) AS Years,
	  ROUND(SUM(CASE 
		       WHEN p.payment_installments <2 THEN p.payment_value END),2) AS Non_EMI_order_value,
	  ROUND(SUM(CASE 
                       WHEN p.payment_installments >=2 THEN p.payment_value END),2) AS EMI_order_value
	FROM `Target.orders` o  
	JOIN `Target.payments` p  
	ON o.order_id = p.order_id
        GROUP BY Years
    ) 
       SELECT 
          Years,
               CONCAT(
                   ROUND(
                       (Non_EMI_order_value/(EMI_order_value + Non_EMI_order_value))*100,2)," %") AS Per100_Non_EMI_order_value,
               CONCAT(
                    ROUND(
                        (EMI_order_value/(EMI_order_value + Non_EMI_order_value))*100,2)," %") AS Per100_EMI_order_value
       FROM CTE 
       ORDER BY Years;

/* Q27. EMI and Non-EMI order count split */ 

WITH CTE AS(
      SELECT 
	  EXTRACT(YEAR FROM o.order_purchase_timestamp) AS Years,
	  ROUND(COUNT(CASE 
                    WHEN p.payment_installments <2 THEN p.payment_value END),2) AS Non_EMI_order_count,
	  ROUND(COUNT(CASE 
                   WHEN p.payment_installments >=2 THEN p.payment_value END),2) AS EMI_order_count
     FROM `Target.orders` o  
     JOIN `Target.payments` p  
     ON o.order_id = p.order_id
     GROUP BY Years
  ) 
       
	SELECT 
          Years,
               CONCAT(
                    ROUND(
                        (Non_EMI_order_count/(EMI_order_count + Non_EMI_order_count))*100,2)," %") AS Per100_Non_EMI_order_count,
               CONCAT(
                     ROUND(
                          (EMI_order_count/(EMI_order_count + Non_EMI_order_count))*100,2)," %") AS Per100_EMI_order_count
       FROM CTE 
       ORDER BY Years;

/* Q28. Distribution of payment installments and count of orders */

SELECT
payment_installments AS Payment_installments,
payment_type AS Payment_type,
COUNT(order_id) AS No_of_orders 
FROM `Target.payments`
WHERE payment_installments >= 2  -- To filter out EMIs orders from all the orders
GROUP BY payment_installments, payment_type
ORDER BY No_of_orders DESC;

/* Thank you! */











     
