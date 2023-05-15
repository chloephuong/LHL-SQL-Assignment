--What is the average number of products ordered from visitors in each city and country?
SELECT  city, country,
		ROUND(AVG(orderedquantity)) as avg_productordered
FROM allsessions as a
JOIN products as p
ON a.productsku=p.sku
WHERE country IS NOT null AND city IS NOT null
GROUP BY city, country
ORDER BY ROUND(AVG(orderedquantity)) DESC