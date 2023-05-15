--What is the average number of products ordered from visitors in each city?
SELECT  city,
		ROUND(AVG(orderedquantity)) as avg_productordered
FROM allsessions as a
JOIN products as p
ON a.productsku=p.sku
WHERE city is not null
GROUP BY city
ORDER BY ROUND(AVG(orderedquantity)) DESC

--What is the average number of products ordered from visitors in each country?
SELECT  country,
		ROUND(AVG(orderedquantity)) as avg_productordered
FROM allsessions as a
JOIN products as p
ON a.productsku=p.sku
WHERE country is not null
GROUP BY country
ORDER BY ROUND(AVG(orderedquantity)) DESC