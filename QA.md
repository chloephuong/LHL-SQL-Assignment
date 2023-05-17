What are your risk areas? Identify and describe them. 

Describe your QA process and include the SQL queries used to execute it.

During this task, I realized mistakes can be make anytime so I tried to create alternative queries or run test by pulling out result based on expected value for every single query that I create in this SQL assignment.

QA Process:

QA Process for Part 2 - Data Cleaning

For allsessions table
```
--Check data type for Time column
SELECT data_type
FROM information_schema.columns
WHERE table_name = 'allsessions' AND column_name = 'time'
```
```
--Check data input in productprice column
SELECT productprice
FROM allsessions
```
```
--Check data input in city column
SELECT city
FROM allsessions
WHERE city = 'not available in demo dataset' OR city = '(not set)'
```
```
--Check if the columns are already dropped/deleted
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'allsessions'
```

For analytics table
```
--Check data type for visitstarttime column
SELECT data_type
FROM information_schema.columns
WHERE table_name = 'analytics' AND column_name = 'visitstarttime'
```
```
--Check data input in unitprice column
SELECT unitprice
FROM analytics
```
```
--Check if the columns are already dropped/deleted
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'analytics'
```

QA Process for Part 3 - Starting with Questions

Question 1: 
```
--Which countries have the highest level of transaction revenues on the site?
CREATE VIEW Q1_temp1 AS
	SELECT country, SUM(totaltransactionrevenue) AS total_revenue1
	FROM allsessions
	WHERE country IS NOT NULL
	GROUP BY country
	ORDER BY total_revenue1 DESC;

CREATE VIEW Q1_temp2 AS
	SELECT country, SUM(totaltransactionrevenue) AS total_revenue2
	FROM allsessions
	WHERE totaltransactionrevenue IS NOT NULL
	GROUP BY country
	ORDER BY total_revenue2 DESC;
	
SELECT country, total_revenue1
FROM Q1_temp1 JOIN Q1_temp2 USING (country)
WHERE total_revenue1=total_revenue2
```
```
--Which cities and countries have the highest level of transaction revenues on the site?
CREATE VIEW Q1_temp3 AS
	SELECT city, SUM(totaltransactionrevenue) AS total_revenue3
	FROM allsessions
	WHERE city IS NOT NULL
	GROUP BY city
	ORDER BY total_revenue3 DESC;

CREATE VIEW Q1_temp4 AS
	SELECT city, SUM(totaltransactionrevenue) AS total_revenue4
	FROM allsessions
	WHERE totaltransactionrevenue IS NOT NULL
	GROUP BY city
	ORDER BY total_revenue4 DESC;
	
SELECT city, total_revenue3
FROM Q1_temp3 JOIN Q1_temp4 USING (city)
WHERE total_revenue3=total_revenue4
```

Question 2: What is the average number of products ordered from visitors in each city and country?
```
--Pick a random value of '3786' and test
SELECT city, country, ROUND(AVG(orderedquantity)) AS avg_productordered
FROM allsessions AS a
JOIN products AS p ON a.productsku = p.sku
WHERE country IS NOT NULL OR city IS NOT NULL
GROUP BY city, country
HAVING ROUND(AVG(orderedquantity)) = 3786
ORDER BY avg_productordered DESC;
```

Question 3: Product categories of products ordered from visitors in each city and country?
```
SELECT country, city, category
FROM (
    SELECT a.city, a.country, a.v2productcategory AS category, p.orderedquantity
    FROM allsessions AS a
    JOIN products AS p
    ON a.productsku = p.sku
    WHERE orderedquantity > 0
) AS subquery
WHERE country IS NOT NULL
OR city IS NOT NULL
GROUP BY country, city, category
HAVING category IS NOT null
ORDER BY country, city, category;
```

Question 4: 
```
--What is the top-selling product from each city?
SELECT sku, productname, city, orderedquantity
FROM (
    SELECT p.sku, p.name AS productname, a.city, SUM(p.orderedquantity) AS orderedquantity,
        ROW_NUMBER() OVER (PARTITION BY a.city ORDER BY SUM(p.orderedquantity) DESC) AS rn
    FROM allsessions AS a
    JOIN products AS p
    ON a.productsku = p.sku
    WHERE a.city IS NOT NULL
    GROUP BY p.sku, p.name, a.city
) AS rn
WHERE rn = 1
ORDER BY orderedquantity DESC
```
```
--What is the top-selling product from each country?
SELECT sku, productname, country, orderedquantity
FROM (
    SELECT p.sku, p.name AS productname, a.country, SUM(orderedquantity) AS orderedquantity,
        ROW_NUMBER() OVER (PARTITION BY a.country ORDER BY SUM(orderedquantity) DESC) AS rn
    FROM allsessions AS a
    JOIN products AS p
    ON a.productsku = p.sku
    WHERE a.country IS NOT NULL
    GROUP BY p.sku, p.name, a.country
) AS t
WHERE t.rn = 1
ORDER BY orderedquantity DESC
```

Question 5: 
```
--Total revenue generated from each city
	--Pick a random value of 'New York' and test
SELECT city, SUM(totaltransactionrevenue) AS renvenue_generated
FROM allsessions AS a
WHERE city = 'New York'
GROUP BY a.city
ORDER BY renvenue_generated DESC
```
```
--Total revenue generated from each country
	--Pick a random value of 'United States' and test
SELECT country, SUM(totaltransactionrevenue) AS renvenue_generated
FROM allsessions AS a
WHERE country = 'United States'
GROUP BY a.country
ORDER BY renvenue_generated DESC
```

QA Process for Part 4 - Starting with Data

Question 1: Find duplicate fullvisitorid records in allsessions table
```
--Pick a random value of visitotid as '5684903298881626743' and test
SELECT fullvisitorid, COUNT(*) AS visitor_count
FROM allsessions
WHERE fullvisitorid = '5684903298881626743'
GROUP BY fullvisitorid
HAVING COUNT(*) > 1
```
Question 2: Find the total number of unique visitors
```
SELECT COUNT(*) AS unique_visitors
FROM (
    SELECT DISTINCT fullvisitorid
    FROM allsessions
) AS subquery
```

Question 3: Find the total number of unique visitors by channel
```
SELECT channelgrouping, COUNT(*) AS unique_visitors
FROM (
    SELECT channelgrouping, fullvisitorid
    FROM allsessions
    GROUP BY channelgrouping, fullvisitorid
) AS subquery
GROUP BY channelgrouping
ORDER BY unique_visitors DESC
```

Question 4: Find each unique product viewed by each visitor
```
SELECT DISTINCT fullvisitorid, productsku
FROM (
    SELECT fullvisitorid, productsku, pageviews,
           ROW_NUMBER() OVER (PARTITION BY fullvisitorid, productsku ORDER BY pageviews) AS row_num
    FROM allsessions
) AS subquery
WHERE row_num = 1
ORDER BY fullvisitorid, productsku
```

Question 5: Compute the percentage of visitors to the site that actually makes a purchase
```
WITH total_visitors AS (
  SELECT COUNT(DISTINCT fullvisitorid) AS total_visitors
  FROM analytics
),
visitors_with_purchase AS (
  SELECT COUNT(DISTINCT fullvisitorid) AS visitors_with_purchase
  FROM analytics
  WHERE unitsold > 0
)
SELECT total_visitors.total_visitors,
       visitors_with_purchase.visitors_with_purchase,
       ROUND(100 * visitors_with_purchase.visitors_with_purchase::numeric / total_visitors.total_visitors::numeric) AS purchase_conversion_rate
FROM total_visitors, visitors_with_purchase;
```

