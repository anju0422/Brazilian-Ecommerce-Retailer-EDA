## BUSINESS CASE STUDY: E-COMMERCE SALES ANALYSIS IN BRAZIL


### INTRODUCTION
Target is one of the world’s most recognized brands and one of America’s leading retailers. This business case has information of 100k orders from 2016 to 2018 made at Target in Brazil. Its features allows viewing an order from multiple dimensions: from order status, delivery time, order price, payment details, freight performance and customer location. We have to generate business insights and provide recommendations (backed by data) using this dataset.

<hr>


### CASE STUDY QUESTIONS
* Time period for which the data is given
* Count the Cities & States of customers who ordered during the given period
* Total number of different cities and states in which customers are registered
* Total number of different cities and states in which sellers are registered
* Is there a growing trend in e-commerce in Brazil? How can we describe a complete scenario?
* Can we see some seasonality with peaks at specific months?
* During what time of the day, do the Brazilian customers mostly place their orders? (Dawn, Morning, Afternoon or Night)
* Get the month-on-month orders by region and state
* How are customers distributed in Brazil?
* Get the % increase in the cost of orders from the year 2017 to 2018 (include months between Jan to Aug only)
* Mean & Sum of price and freight value by a customer state
* Calculate days between purchasing, delivering, and estimated delivery
   - time_to_delivery  =  order_purchase_timestamp - order_delivered_customer_date
   - diff_estimated_delivery  =  order_estimated_delivery_date - order_delivered_customer_date
* Group data by state, take a mean of freight_value, time_to_delivery, and, diff_estimated_delivery
* Sort the data to get the following:
    - Top 5 states with highest/lowest average freight value - sort in desc/asc limit 5
    - Top 5 states with highest/lowest average time to delivery
    - Top 5 states where delivery is speedy/ not so fast compared to the estimated date
    - No of orders. shipping cost and delivery time over different states
* Payment type analysis
    - Month over Month count of orders for different payment types.
    - EMI and Non-EMI order value split
    - EMI and Non-EMI order count split
* Distribution of payment installments and count of orders

  <hr>


  ### INSIGHTS: -
   

 


[![Capture10.png](https://i.postimg.cc/BQrVXW32/Capture10.png)](https://postimg.cc/QHqbyyHM)


* There is a noticeable and consistent growing trend on e-commerce in Brazil from the year 2016 to 2018.
* Seasonality can be observed within the data, with distinct peaks occurring in November 2017, followed by January 2018 and March 2018. These months experienced a significant surge in the number of orders placed, indicating a seasonal trend within the e-commerce market.

  <hr>

  [![Capture11.png](https://i.postimg.cc/hv77TMXG/Capture11.png)](https://postimg.cc/Lg2XMtBd)

* The data shows that the highest number of orders (38,361) were placed during the afternoon, indicating that a significant portion of 
    Brazilian customers prefers to make their purchases during this time.
* The data indicates the least number of orders (4740) placed during the dawn period, suggesting that it is the least preferred time 
    for online purchases among Brazilian customers.

  <hr>

Total no of distinct states, cities, and zip codes in which customers are present
  
[![Capture13.png](https://i.postimg.cc/TP2FjVSV/Capture13.png)](https://postimg.cc/3k6tYv3N)

<hr>

  [![Capture32.png](https://i.postimg.cc/sDYkshmF/Capture32.png)](https://postimg.cc/crJ9c6PT)

  The states with the highest customer counts are: -
* SP with 41,746 customers
* RJ with 12,852 customers
* MG with 11,635 customers

  States with relatively lower customer counts include: -
* AC with 81 customers
* AP with 68 customers
* RR with 46 customers

  <hr>
Top 10 Cities where most of the customers reside

[![Capture15.png](https://i.postimg.cc/Xqxy50yc/Capture15.png)](https://postimg.cc/MfMTkN5v)

<hr>
% difference in each month of 2017 and 2018

[![Capture16.png](https://i.postimg.cc/ncDG5X76/Capture16.png)](https://postimg.cc/w79NRTwV)

<hr>

% difference in total sales from (Jan to Aug) for 2017 and 2018
[![Capture17.png](https://i.postimg.cc/Y24PrqYx/Capture17.png)](https://postimg.cc/yWHjnKfJ)
<hr>
    
    
  
### RECOMMENDATION(S): -
* Leverage Seasonal Peaks: Take advantage of the seasonal peaks observed, particularly in November 2017, January 2018, and March 2018. Plan targeted marketing campaigns, offer attractive promotions, and ensure sufficient stock availability during these periods to maximize sales potential.
* Analyze Low-Performing Months: Evaluate the factors contributing to the low order counts in September, October, and December 2016. Identify any potential issues, such as product availability, pricing, or marketing strategies, and make necessary adjustments to improve performance during those months.
