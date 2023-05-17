--Question 1: Find duplicate fullvisitorid records in allsessions table
SELECT fullvisitorid, COUNT(*)
FROM allsessions
GROUP BY fullvisitorid
HAVING COUNT(*) > 1

--Question 2: Find the total number of unique visitors
SELECT COUNT(DISTINCT fullvisitorid) AS unique_visitors
FROM allsessions

--Question 3: Find the total number of unique visitors by channel
SELECT channelgrouping,
		COUNT(DISTINCT fullvisitorid) AS unique_visitors	
FROM allsessions
GROUP BY channelgrouping
ORDER BY unique_visitors DESC

--Question 4: Find each unique product viewed by each visitor
SELECT DISTINCT ON (fullvisitorid, productsku) fullvisitorid, 
	   productsku
FROM (
  SELECT fullvisitorid, 
		 productsku, 
		 MIN(pageviews) AS first_view_time
  FROM allsessions
  GROUP BY fullvisitorid, productsku
) subquery
ORDER BY fullvisitorid, productsku, first_view_time

--Question 5: Compute the percentage of visitors to the site that actually makes a purchase
SELECT COUNT(DISTINCT fullvisitorid) AS total_visitors,
       COUNT(DISTINCT CASE WHEN unitsold > 0 THEN fullvisitorid END) AS visitors_with_purchase,
       100 * COUNT(DISTINCT CASE WHEN unitsold > 0 THEN fullvisitorid END) / COUNT(DISTINCT fullvisitorid) AS purchase_conversion_rate
FROM analytics
