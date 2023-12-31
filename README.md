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

Time zone in which most Brazilian customers tend to buy

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

 The states with relatively lower customer counts are: -
* AC with 81 customers
* AP with 68 customers
* RR with 46 customers

<hr>


Top 10 Cities where most of the customers reside


[![Capture15.png](https://i.postimg.cc/Xqxy50yc/Capture15.png)](https://postimg.cc/MfMTkN5v)

<hr>


% difference in sales for each month of 2017 and 2018


[![Capture16.png](https://i.postimg.cc/ncDG5X76/Capture16.png)](https://postimg.cc/w79NRTwV)

<hr>

% difference in total sales from (Jan to Aug) of 2017 and 2018


[![Capture17.png](https://i.postimg.cc/Y24PrqYx/Capture17.png)](https://postimg.cc/yWHjnKfJ)
<hr>


[![Capture33.png](https://i.postimg.cc/MGP1w0k8/Capture33.png)](https://postimg.cc/qtKNX3Mm)

<hr>

 Top 5 Highest freight value State: PB → RR → RO → AC → PI

[![Capture21.png](https://i.postimg.cc/2jMMmJh2/Capture21.png)](https://postimg.cc/F1bDVTPL)

<hr>

Top 5 Lowest freight value State:  SP → PR → MG → RJ → DF

[![Capture22.png](https://i.postimg.cc/yYTmn31c/Capture22.png)](https://postimg.cc/QHHKdtWd)

<hr>

Top 5 states with the highest average delivery time (Slowest Delivery):  RR → AP → AM → AL → PA

[![Capture23.png](https://i.postimg.cc/MpQd5KLS/Capture23.png)](https://postimg.cc/ts93CyyS)

<hr>

Top 5 states with the lowest average delivery time (Fastest Delivery): SP → PR → MG → DF → SC

[![Capture24.png](https://i.postimg.cc/1ttFWvzq/Capture24.png)](https://postimg.cc/3ysWNCm8)

<hr>

Top 5 states where delivery is really FAST compared to estimated delivery time: AC → RO → AP → AM → RR

[![Capture25.png](https://i.postimg.cc/B6YVy7B9/Capture25.png)](https://postimg.cc/xJm5NRZt)

<hr>

Top 5 states where delivery is really SLOW compared to estimated delivery time: AL → MA → SE → ES → BA

[![Capture26.png](https://i.postimg.cc/26Z0cjyv/Capture26.png)](https://postimg.cc/CBwCdgjL)

<hr>

Order Status Breakdown 

[![35.png](https://i.postimg.cc/t4VfK3BZ/35.png)](https://postimg.cc/ZW4V3dt4)

<hr>

Top Performing States by Order Count

[![Capture41.png](https://i.postimg.cc/T3McGx2B/Capture41.png)](https://postimg.cc/tYk6tLxz)

<hr>

Bottom 5 States by Order Count

[![42.png](https://i.postimg.cc/G2dL1H69/42.png)](https://postimg.cc/67bJr5WN)


<hr>


[![Capture39.png](https://i.postimg.cc/vmbRx2Q5/Capture39.png)](https://postimg.cc/mPXp0w1r)


<hr>


[![Capture40.png](https://i.postimg.cc/TPSRSyBt/Capture40.png)](https://postimg.cc/xkvDNdfm)


<hr>


[![Capture36.png](https://i.postimg.cc/j2xGzSn4/Capture36.png)](https://postimg.cc/KkWqbFN1)

* The majority of customers prefer to pay for their orders in one installment, as it has the highest number of orders (52,546).
* The second most popular payment option is two installments (12,413 orders), followed by three installments (10,461 orders).
* There is a gradual decline in the number of orders as the number of payment installments increases. This suggests that customers 
  generally prefer fewer installments for their payments.

<hr>

[![Capture38.png](https://i.postimg.cc/FRQF7H2H/Capture38.png)](https://postimg.cc/KKJhWxG6)

* Customers predominantly use credit cards for payments, followed by UPI and vouchers. This indicates a higher level of trust and 
  the convenience associated with credit card transactions.
* The relatively lower count of orders made with debit cards might suggest that customers are more inclined toward credit cards or 
  digital wallets for online transactions.

<hr>
  

  
### RECOMMENDATION(S): -
* Leverage Seasonal Peaks: Take advantage of the seasonal peaks observed, particularly in November 2017, January 2018, and March 2018. Plan targeted marketing campaigns, offer attractive promotions, and ensure sufficient stock availability during these periods to maximize sales potential.
* Analyze Low-Performing Months: Evaluate the factors contributing to the low order counts in September, October, and December 2016. Identify any potential issues, such as product availability, pricing, or marketing strategies, and make necessary adjustments to improve performance during those months.
* Optimize for Afternoontime Shopping: Considering that the afternoon is the most popular time for purchases, We should ensure that 
our website and mobile app are optimized for smooth and efficient browsing and ordering during afternoon time hours.
* Focus on maintaining fast and efficient delivery services in the top-performing states (SP, RJ, MG, RS, PR) to meet and exceed 
customer expectations.
* Analyze the delivery process in the states with slower delivery times (RR, AP, AM, AL, PA) to identify bottlenecks and areas for 
improvement.
* Monitor and analyze customer feedback and satisfaction related to payment options to identify areas for improvement or additional 
payment features that can enhance the overall customer experience.
