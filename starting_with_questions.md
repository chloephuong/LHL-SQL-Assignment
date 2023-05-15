Answer the following questions and provide the SQL queries used to find the answer.

    
**Question 1: Which cities and countries have the highest level of transaction revenues on the site?**


SQL Queries:
```
--Which countries have the highest level of transaction revenues on the site?
SELECT country, 
		SUM(totaltransactionrevenue) as totaltransactionrevenue
FROM allsessions
WHERE totaltransactionrevenue IS NOT NULL
AND country IS NOT null
GROUP BY country
ORDER BY totaltransactionrevenue DESC
```
```
--Which cities have the highest level of transaction revenues on the site?
SELECT city,
		SUM(totaltransactionrevenue) as totaltransactionrevenue
FROM allsessions
WHERE totaltransactionrevenue IS NOT null
AND city IS NOT null
GROUP BY city
ORDER BY totaltransactionrevenue DESC
```

Answer:

The Top-5 Countries that have the highest level of transaction revenues on the site are
   
   - United States
   
   - Israel
   
   - Australia
   
   - Canada
    
   - Switzerland

For Cities, the result showed up for 19 cities with San Francisco ranked top 1


**Question 2: What is the average number of products ordered from visitors in each city and country?**


SQL Queries:



Answer:





**Question 3: Is there any pattern in the types (product categories) of products ordered from visitors in each city and country?**


SQL Queries:



Answer:





**Question 4: What is the top-selling product from each city/country? Can we find any pattern worthy of noting in the products sold?**


SQL Queries:



Answer:





**Question 5: Can we summarize the impact of revenue generated from each city/country?**

SQL Queries:



Answer:







