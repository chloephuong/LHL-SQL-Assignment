--Convert Unix timestamps to timestamps
UPDATE analytics 
SET visitstarttime = to_timestamp(visitstarttime::bigint);

--Change data type for column visitstarttime from text to timestamps
ALTER TABLE analytics
ALTER COLUMN visitstarttime TYPE timestamp 
USING to_timestamp(visitstarttime, 'YYYY-MM-DD HH24:MI:SS');

--Update unit price (unit cost) as it suggested should be divided by 1,000,000
UPDATE analytics 
SET unitprice = unitprice/1000000

--Drop/Delete userid column because it offers no value
ALTER TABLE analytics
DROP COLUMN userid