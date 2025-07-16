**WALMART SALES SQL PROJECT**



This project focuses on analysing transactional sales data from a Walmart dataset using **SQL.** The objective was to answer real-world business questions by writing clean, efficient, and structured queries in **MySQL**



---



**DATASET OVERVIEW**



**- Source**: [Walmart Sales Dataset (Kaggle)](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

**- Format**: CSV

**- Scope**: 1,000 transactions across 3 branches and multiple product lines



---



**PROJECT OBJECTIVES**



- Analyse sales trends by time of day and day of the week

- Identify top-performing product lines

- Measure customer behaviour across branches and genders

- Evaluate VAT contributions per product line

- Explore customer rating patterns over time



---



**FEATURE ENGINEERING**



Before starting with the analysis, I performed basic feature engineering to derive new time-based columns from the existing data. These additional features allowed for deeper insight into sales patterns, ratings, and customer behaviour.



New Columns Created:



- `time_of_day` 
Categorises each transaction based on the purchase time into:
1. Morning
2. Afternoon
3. Evening
4. Night

**Insight Enabled**: Identifies which part of the day has the most sales or highest ratings.



- `day_name`
Extracts the day of the week from the `Date` column (e.g., Mon, Tue, Wed...).  

**Insight Enabled**: Helps determine which day each branch is busiest.



- `month\_name`  
Extracts the month from the `Date` column (e.g., Jan, Feb, Mar...).  

**Insight Enabled**: Helps analyze sales and revenue trends by month.

These engineered columns were crucial for answering time-based business questions more efficiently and allowed grouping and ranking by logical periods.



---



**BUSINESS QUESTIONS ADDRESSED**



- **GENERIC QUESTIONS**

 	1. How many unique cities does the data have?

 	2. In which city is each branch?





- **PRODUCT-LEVEL QUESTIONS**

 	1. How many unique product lines does the data have?

 	2. What is the most common payment method?

 	3. What is the most selling product line?

 	4. What is the total revenue by month?

 	5. What month had the largest COGS?

 	6. What product line had the largest revenue?

 	7. What is the city with the largest revenue?

 	8. What product line had the largest VAT?

 	9. Fetch each product line and add a column to each product line showing "Good", "Bad". Good if it's greater than average sales

 	10. Which branch sold more products than the average product sold?

 	11. What is the most common product line by gender?

 	12. What is the average rating of each product line?


- **SALES**

 	1. Number of sales made in each time of the day per weekday

 	2. Which of the customer types brings the most revenue?

 	3. Which city has the largest tax percent/ VAT (Value Added Tax)?

 	4. Which customer type pays the most in VAT?



- **CUSTOMER**

 	1. How many unique customer types does the data have?

 	2. How many unique payment methods does the data have?

 	3. What is the most common customer type?

 	4. Which customer type buys the most?

 	5. What is the gender of most of the customers?

 	6. What is the gender distribution per branch?

 	7. Which time of the day do customers give most ratings?

 	8. Which time of the day do customers give most ratings per branch?

 	9. Which day of the week has the best avg ratings?

 	10. Which day of the week has the best average ratings per branch?

---



**TOOLS & TECHNOLOGIES**



- MySQL – Core SQL querying and analysis

- MySQL Workbench – SQL editor and schema visualisation

- Python – Used for importing the dataset into MySQL (optional)



---



**LEARNINGS & SKILLS PRACTICED**



- Writing efficient and readable SQL queries

- Using `GROUP BY`, `HAVING`, `ORDER BY`, and aggregate functions

- Applying conditional logic using `CASE` statements

- Ranking and filtering with `RANK()` and `PARTITION BY`

- Structuring pivot-style outputs with `CASE` inside `SELECT`

- Translating business KPIs into executable SQL logic



---



**CONNECT**



I'm actively working on building real-world data projects.

Let's connect if you're also learning Data Engineering, working on data related projects, or interested in sharing feedback!



**LINKEDIN PROFILE:** [**www.linkedin.com/in/adityabhosale12003**](www.linkedin.com/in/adityabhosale12003/)

