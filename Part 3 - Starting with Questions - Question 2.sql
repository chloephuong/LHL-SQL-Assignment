SELECT productsku, city,
		ROUND(AVG(orderedquantity)) as avg_productordered
FROM allsessions as a
JOIN products as p
ON a.productsku=p.sku
WHERE city is not null
GROUP BY city, productsku, orderedquantity
