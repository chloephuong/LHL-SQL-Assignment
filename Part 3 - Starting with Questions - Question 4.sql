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
		RANK() OVER (PARTITION BY city ORDER BY SUM(orderedquantity) DESC) as rnk
	FROM allsessions as a
	JOIN products as p
	ON a.productsku=p.sku
	WHERE city IS NOT null
	GROUP BY p.sku, a.city, p.name
	ORDER BY SUM(orderedquantity) DESC) as subquery
WHERE rnk = 1
	
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
		RANK() OVER (PARTITION BY country ORDER BY SUM(orderedquantity) DESC) as rnk
	FROM allsessions as a
	JOIN products as p
	ON a.productsku=p.sku
	WHERE country IS NOT null
	GROUP BY p.sku, a.country, p.name
	ORDER BY SUM(orderedquantity) DESC) as subquery
WHERE rnk = 1


--Can we find any pattern worthy of noting in the products sold?