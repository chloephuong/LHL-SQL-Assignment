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
```
--What is the average number of products ordered from visitors in each city and country?
SELECT  city, country,
		ROUND(AVG(orderedquantity)) as avg_productordered
FROM allsessions as a
JOIN products as p
ON a.productsku=p.sku
WHERE country IS NOT null OR city IS NOT null
GROUP BY city, country
ORDER BY ROUND(AVG(orderedquantity)) DESC
```

Answer:
The result showed 401 rows with top 1 is Council Bluffs from the United States with the average product ordered amount of 7589.


**Question 3: Is there any pattern in the types (product categories) of products ordered from visitors in each city and country?**


SQL Queries:
```
--Product categories of products ordered from visitors in each city and country?
SELECT country, city, category
FROM (
	SELECT a.city, a.country, a.v2productcategory as category, p.orderedquantity
	FROM allsessions AS a
	JOIN products AS p
	ON a.productsku=p.sku
	WHERE orderedquantity > 0 ) AS subquery
WHERE country IS NOT null 
OR city IS NOT null
GROUP BY country, city, category
```

Answer:



**Question 4: What is the top-selling product from each city/country? Can we find any pattern worthy of noting in the products sold?**


SQL Queries:
```
--What is the top-selling product from each city? 
SELECT  sku,
		productname,
		city,
		orderedquantity
FROM (
	SELECT
		p.sku,
		p.name as productname,
		a.city,
		SUM(orderedquantity) as orderedquantity,
		ROW_NUMBER() OVER (PARTITION BY city ORDER BY SUM(orderedquantity) DESC) as rn
	FROM allsessions as a
	JOIN products as p
	ON a.productsku=p.sku
	WHERE city IS NOT null
	GROUP BY p.sku, a.city, p.name
	ORDER BY SUM(orderedquantity) DESC) as subquery
WHERE rn = 1
```
```
--What is the top-selling product from each country? 
SELECT  sku,
		productname,
		country,
		orderedquantity
FROM (
	SELECT
		p.sku,
		p.name as productname,
		a.country,
		SUM(orderedquantity) as orderedquantity,
		ROW_NUMBER() OVER (PARTITION BY country ORDER BY SUM(orderedquantity) DESC) as rn
	FROM allsessions as a
	JOIN products as p
	ON a.productsku=p.sku
	WHERE country IS NOT null
	GROUP BY p.sku, a.country, p.name
	ORDER BY SUM(orderedquantity) DESC) as subquery
WHERE rn = 1
```

Answer:

For cities, result showed 250 rows with top 1 is Kick Ball - city Mountain View with ordered quantity of 75850

For countries, result showed 134 rows with top 1 is Kick Ball - United Stated with ordered quantity of 409590

The pattern...


**Question 5: Can we summarize the impact of revenue generated from each city/country?**

SQL Queries:
```
--Total revenue generated from each city

SELECT A.CITY,
	SUM(TOTALTRANSACTIONREVENUE) AS REVENUE_GENERATED
FROM ALLSESSIONS AS A
WHERE CITY IS NOT NULL
	AND TOTALTRANSACTIONREVENUE IS NOT NULL
GROUP BY A.CITY
ORDER BY SUM(TOTALTRANSACTIONREVENUE) DESC 
```
```
--Total revenue generated from each country

SELECT A.COUNTRY,
	SUM(TOTALTRANSACTIONREVENUE) AS REVENUE_GENERATED
FROM ALLSESSIONS AS A
WHERE COUNTRY IS NOT NULL
	AND TOTALTRANSACTIONREVENUE IS NOT NULL
GROUP BY A.COUNTRY
ORDER BY SUM(TOTALTRANSACTIONREVENUE) DESC 
```

Answer:







