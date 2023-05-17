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
HAVING category IS NOT null
