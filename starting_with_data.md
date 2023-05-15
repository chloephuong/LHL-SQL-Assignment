Question 1: Find duplicate fullvisitorid records in allsessions table

SQL Queries:
SELECT fullvisitorid, COUNT(*)
FROM allsessions
GROUP BY fullvisitorid
HAVING COUNT(*) > 1

Answer: 
There are 794 fullvisitorid that are duplicated at least 2 times


Question 2: Find the total number of unique visitors

SQL Queries:
SELECT COUNT(DISTINCT fullvisitorid) AS unique_visitors
FROM allsessions

Answer:
There are total of 14223 unique visitors


Question 3: Find the total number of unique visitors by channel

SQL Queries:
SELECT channelgrouping,
		COUNT(DISTINCT fullvisitorid) AS unique_visitors	
FROM allsessions
GROUP BY channelgrouping
ORDER BY channelgrouping

Answer:
The query pulled out data output showed that there are 7 rows of total 6 channels and 1 other (unidentified sources) with the distinct count of visitors reffering to each source.


Question 4: Find each unique product viewed by each visitor

SQL Queries:
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

Answer:
The result showed there are total of 15115 unique products viewed by each visitor


Question 5: 

Compute the percentage of visitors to the site that actually makes a purchase

SQL Queries:

SELECT COUNT(DISTINCT fullvisitorid) AS total_visitors,
       
       COUNT(DISTINCT CASE WHEN unitsold > 0 THEN fullvisitorid END) AS visitors_with_purchase,
       
       100 * COUNT(DISTINCT CASE WHEN unitsold > 0 THEN fullvisitorid END) / COUNT(DISTINCT fullvisitorid) AS purchase_conversion_rate

FROM analytics

Answer: 

The conversion rate is 13%
