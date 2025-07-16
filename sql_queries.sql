CREATE DATABASE IF NOT EXISTS WALMART_SALES;
USE WALMART_SALES;
SELECT 
    *
FROM
    walmart_sales_data;

-- -------------------------------------                                              ----------------------------------------------
-- -------------------------------------FEATURE ENGINEERING----------------------------------------------
-- -------------------------------------                                              ----------------------------------------------


-- -------------------------------------  ADDING TIME OF DAY  -----------------------------------------------
ALTER TABLE walmart_sales_data ADD COLUMN time_of_day VARCHAR(50);
UPDATE walmart_sales_data 
SET 
    time_of_day = (CASE
        WHEN TIME BETWEEN '00:00:00' AND '06:00:00' THEN 'NIGHT'
        WHEN TIME BETWEEN '06:00:01' AND '12:00:00' THEN 'MORNING'
        WHEN TIME BETWEEN '12:00:01' AND '16:00:00' THEN 'AFTERNOON'
        WHEN TIME BETWEEN '16:00:01' AND '23:59:59' THEN 'EVENING'
    END);

-- ---------------------------------ADDING DAY_NAME------------------------------------------

SELECT 
    *
FROM
    walmart_sales_data;

ALTER TABLE walmart_sales_data ADD COLUMN DAY_NAME VARCHAR(11);
UPDATE walmart_sales_data 
SET 
    DAY_NAME = DAYNAME(DATE);

SELECT 
    *
FROM
    walmart_sales_data;
ALTER TABLE walmart_sales_data ADD COLUMN MONTH_NAME VARCHAR(50);

UPDATE walmart_sales_data 
SET 
    MONTH_NAME = MONTHNAME(DATE);


-- --------------------------------------                                            ------------------------------------------
-- --------------------------------------  GENERIC QUESTIONS   ------------------------------------------
-- --------------------------------------                                            ------------------------------------------

SELECT 
    *
FROM
    walmart_sales_data;

SELECT DISTINCT
    CITY
FROM
    walmart_sales_data;

-- In which city is each branch?
SELECT 
    CITY, BRANCH
FROM
    walmart_sales_data
GROUP BY BRANCH , CITY;

-- --------------------------------------                                              ------------------------------------------
-- --------------------------------------  PRODUCT QUESTIONS   ------------------------------------------
-- --------------------------------------                                              ------------------------------------------

SELECT 
    *
FROM
    walmart_sales_data;
SELECT 
    COUNT(DISTINCT `Product line`) AS unique_product_lines
FROM
    walmart_sales_data;


-- What is the most common payment method?
SELECT 
    *
FROM
    walmart_sales_data;

SELECT DISTINCT
    PAYMENT, COUNT(PAYMENT) AS PAYMENT_METHOD
FROM
    walmart_sales_data
GROUP BY PAYMENT
ORDER BY PAYMENT_METHOD DESC
LIMIT 1;

-- What is the most selling product line?
SELECT 
    `PRODUCT LINE`, COUNT(QUANTITY) AS UNITS_SOLD
FROM
    walmart_sales_data
GROUP BY `PRODUCT LINE`
ORDER BY UNITS_SOLD DESC;

SELECT 
    `PRODUCT LINE`,
    COUNT(*) AS OCCURANCE,
    SUM(quantity) AS TOTAL_UNITS_SOLD
FROM
    walmart_sales_data
GROUP BY `PRODUCT LINE`
ORDER BY TOTAL_UNITS_SOLD DESC;


-- What is the total revenue by month?
SELECT 
    MONTH_NAME, SUM(TOTAL) AS REVENUE
FROM
    walmart_sales_data
GROUP BY MONTH_NAME
ORDER BY REVENUE;


-- What month had the largest COGS?
SELECT 
    *
FROM
    walmart_sales_data;
SELECT 
    MONTH_NAME, SUM(`COGS`) AS TOTAL_COGS
FROM
    walmart_sales_data
GROUP BY MONTH_NAME
ORDER BY TOTAL_COGS DESC;


-- What product line had the largest revenue?
SELECT 
    `Product line`, ROUND(SUM(TOTAL), 4) AS REVENUE
FROM
    walmart_sales_data
GROUP BY `Product line`
ORDER BY REVENUE DESC;


-- What is the city with the largest revenue?
SELECT 
    CITY, BRANCH, ROUND(SUM(TOTAL), 4) AS REVENUE
FROM
    walmart_sales_data
GROUP BY CITY , BRANCH
ORDER BY REVENUE DESC;


-- What product line had the largest VAT per sale?
SELECT 
    `Product line`, ROUND(AVG(`Tax 5%`), 4) AS VAT
FROM
    walmart_sales_data
GROUP BY `Product line`
ORDER BY VAT DESC;


-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT 
    `Product line`,
    AVG(QUANTITY) AS AVG_SALES,
    (CASE
        WHEN
            AVG(QUANTITY) > (SELECT 
                    AVG(QUANTITY)
                FROM
                    walmart_sales_data)
        THEN
            'Good'
        ELSE 'Bad'
    END) AS Performance
FROM
    walmart_sales_data
GROUP BY `Product line`;


-- Which branch sold more products than average product sold?
SELECT 
    BRANCH, SUM(QUANTITY) AS PRODUCTS_SOLD
FROM
    walmart_sales_data
GROUP BY BRANCH
HAVING SUM(QUANTITY) > (SELECT 
        AVG(TOTAL_BRANCH_TOTALS)
    FROM
        (SELECT 
            BRANCH, SUM(QUANTITY) AS TOTAL_BRANCH_TOTALS
        FROM
            walmart_sales_data
        GROUP BY BRANCH) AS BRANCH_TOTAL);


-- What is the most common product line by gender?
SELECT 
    *
FROM
    walmart_sales_data; 

select  `Product line`, Gender, products_purchased
from  (
SELECT  `Product line`,
				Gender,
                COUNT(Quantity)  as  products_purchased,
                rank()  over(partition  by  Gender  ORDER  BY  COUNT(Quantity)  DESC)  as  ranking
				FROM  walmart_sales_data				
				GROUP BY gender, `Product line`
)  AS  Ranked
WHERE  ranking =1;

				

-- What is the average rating of each product line?
SELECT 
    *
FROM
    walmart_sales_data;
SELECT 
    `Product line`, ROUND(AVG(Rating), 2) AS avg_rating
FROM
    walmart_sales_data
GROUP BY `Product line`
ORDER BY avg_rating DESC;


-- ----------------------------------------                                             -----------------------------------------
-- ----------------------------------------    SALES  QUESTIONS    ----------------------------------------
-- ----------------------------------------                                             -----------------------------------------


SELECT 
    time_of_day, DAY_NAME, SUM(Quantity) AS sales_made
FROM
    walmart_sales_data
GROUP BY time_of_day , DAY_NAME
ORDER BY CASE
    WHEN time_of_day = 'Morning' THEN 1
    WHEN time_of_day = 'Afternoon' THEN 2
    WHEN time_of_day = 'Evening' THEN 3
END , CASE
    WHEN day_name = 'Monday' THEN 1
    WHEN day_name = 'Tuesday' THEN 2
    WHEN day_name = 'Wednesday' THEN 3
    WHEN day_name = 'Thursday' THEN 4
    WHEN day_name = 'Friday' THEN 5
    WHEN day_name = 'Saturday' THEN 6
    WHEN day_name = 'Sunday' THEN 7
END;


-- Which of the customer types brings the most revenue?
SELECT 
    `Customer type`, ROUND(SUM(Total), 2) AS total_revenue
FROM
    walmart_sales_data
GROUP BY `Customer type`
ORDER BY total_revenue DESC
LIMIT 1;


-- Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT 
    *
FROM
    walmart_sales_data;
SELECT 
    City, ROUND(AVG(`Tax 5%`), 2) AS VAT
FROM
    walmart_sales_data
GROUP BY City
ORDER BY VAT DESC;


-- Which customer type pays the most in VAT?
SELECT 
    `Customer type`, ROUND(AVG(`Tax 5%`), 2) AS avg_VAT_paid
FROM
    walmart_sales_data
GROUP BY `Customer type`
ORDER BY avg_VAT_paid DESC;


-- ----------------------------------------                                                       -----------------------------------------
-- ----------------------------------------    CUSTOMER  QUESTIONS    ----------------------------------------
-- ----------------------------------------                                                       -----------------------------------------


SELECT 
    *
FROM
    walmart_sales_data;

SELECT 
    COUNT(DISTINCT `Customer type`) AS 'no. of customer types'
FROM
    walmart_sales_data;


-- How many unique payment methods does the data have?
SELECT 
    COUNT(DISTINCT Payment) 'No. of payment methods'
FROM
    walmart_sales_data;


-- What is the most common customer type?
SELECT 
    `Customer type` AS 'common customer type',
    COUNT(`Customer type`) AS count
FROM
    walmart_sales_data
GROUP BY `Customer type`
ORDER BY count DESC
LIMIT 1;
				

-- Which customer type buys the most?

SELECT 
    `Customer type`,
    ROUND(SUM(Quantity), 2) AS 'Items Purchased'
FROM
    walmart_sales_data
GROUP BY `Customer type`
ORDER BY 'Items Purchased' DESC
LIMIT 1;

-- In  Terms  of  Money  Spent
SELECT 
    `Customer type`, ROUND(SUM(Total), 2) AS 'Total buying'
FROM
    walmart_sales_data
GROUP BY `Customer type`
ORDER BY 'Total buying' DESC
LIMIT 1;


-- What is the gender of most of the customers?
SELECT 
    Gender, COUNT(Gender) AS count
FROM
    walmart_sales_data
GROUP BY Gender
ORDER BY count DESC
LIMIT 1;


-- What is the gender distribution per branch?

SELECT 
    Branch,
    SUM(CASE
        WHEN Gender = 'Male' THEN 1
        ELSE 0
    END) AS Male,
    SUM(CASE
        WHEN Gender = 'Female' THEN 1
        ELSE 0
    END) AS Female
FROM
    walmart_sales_data
GROUP BY Branch
ORDER BY CASE
    WHEN Branch = 'A' THEN 1
    WHEN Branch = 'B' THEN 2
    WHEN Branch = 'C' THEN 3
END;


-- Which time of the day do customers give most ratings?
SELECT  time_of_day,
				ROUND( AVG( Rating ),  2)  AS  avg_rating,
                RANK()  OVER( ORDER BY AVG( Rating )  DESC)  AS Ranking
FROM  walmart_sales_data
GROUP BY  time_of_day;


-- Which time of the day do customers give most ratings per branch?
SELECT  *
FROM (
			SELECT  time_of_day,
							Branch,
							ROUND( AVG( Rating ),  2)  AS  avg_rating,
							RANK()  OVER( PARTITION BY BRANCH ORDER BY AVG( Rating )  DESC)  AS Ranking
			FROM  walmart_sales_data
			GROUP BY  time_of_day, Branch
            )  AS ranked
WHERE Ranking = 1
ORDER BY  Branch;


-- Which day of the week has the best avg ratings?
SELECT 
    DAY_NAME, ROUND(AVG(Rating), 2) AS Avg_rating
FROM
    walmart_sales_data
GROUP BY DAY_NAME
ORDER BY Avg_rating DESC
LIMIT 1;


-- Which day of the week has the best average ratings per branch?
SELECT  *
FROM (
		SELECT  DAY_NAME,
						Branch,
						ROUND( AVG( Rating ),  2)  AS Avg_rating,
						RANK()  OVER( PARTITION BY Branch ORDER BY ROUND( AVG( Rating ),  2) DESC) AS ranking
		FROM  walmart_sales_data
		GROUP BY  DAY_NAME, Branch
) AS Ranked
WHERE ranking = 1
ORDER BY Branch;


