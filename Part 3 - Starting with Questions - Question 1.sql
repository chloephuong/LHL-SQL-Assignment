--Which countries have the highest level of transaction revenues on the site?
SELECT country, 
		SUM(totaltransactionrevenue) as totaltransactionrevenue
FROM allsessions
WHERE totaltransactionrevenue IS NOT NULL
AND country IS NOT null
GROUP BY country
ORDER BY totaltransactionrevenue DESC

--Which cities have the highest level of transaction revenues on the site?
SELECT city,
		SUM(totaltransactionrevenue) as totaltransactionrevenue
FROM allsessions
WHERE totaltransactionrevenue IS NOT null
AND city IS NOT null
GROUP BY city
ORDER BY totaltransactionrevenue DESC
