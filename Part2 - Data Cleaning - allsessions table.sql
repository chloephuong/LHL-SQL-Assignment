--Convert Unix timestamps to timestamps
UPDATE allsessions
SET time = to_timestamp(time::bigint);

--Change data type for column time from text to timestamps
ALTER TABLE allsessions
ALTER COLUMN time TYPE timestamp 
USING to_timestamp(starttime, 'YYYY-MM-DD HH24:MI:SS');

--Update productprice (divided by 1,000,000)
UPDATE allsessions 
SET productprice = productprice/1000000
