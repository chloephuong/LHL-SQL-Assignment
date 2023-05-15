--Find duplicate fullvisitorid records in allsessions table
SELECT fullvisitorid, COUNT(*)
FROM allsessions
GROUP BY fullvisitorid
HAVING COUNT(*) > 1;

--Find the total number of unique visitors
SELECT COUNT(DISTINCT fullvisitorid) AS unique_visitors
FROM allsessions

--Find the total number of unique visitors by referring sites
SELECT channelgrouping,
		COUNT(DISTINCT fullvisitorid) AS unique_visitors	
FROM allsessions
GROUP BY channelgrouping
ORDER BY channelgrouping