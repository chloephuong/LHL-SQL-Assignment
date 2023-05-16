--QA Process for Part 2 - Data Cleaning

--For allsessions table
--Check data type for Time column
SELECT data_type
FROM information_schema.columns
WHERE table_name = 'allsessions' AND column_name = 'time'

--Check data input in productprice column
SELECT productprice
FROM allsessions

--Check data input in city column
SELECT city
FROM allsessions
WHERE city = 'not available in demo dataset' OR city = '(not set)'

--Check if the columns are already dropped/deleted
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'allsessions'

--For analytics table
--Check data type for visitstarttime column
SELECT data_type
FROM information_schema.columns
WHERE table_name = 'analytics' AND column_name = 'visitstarttime'

--Check data input in unitprice column
SELECT unitprice
FROM analytics

--Check if the columns are already dropped/deleted
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'analytics'


--QA Process for Part 3 - Starting with Questions

--Question 1: 
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

--Question 2: What is the average number of products ordered from visitors in each city and country?
SELECT city, country, ROUND(AVG(orderedquantity)) AS avg_productordered
FROM allsessions AS a
JOIN products AS p ON a.productsku = p.sku
WHERE country IS NOT NULL OR city IS NOT NULL
GROUP BY city, country
HAVING ROUND(AVG(orderedquantity)) = 3786
ORDER BY avg_productordered DESC;

--

