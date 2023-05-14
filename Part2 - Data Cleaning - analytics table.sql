--Convert Unix timestamps to timestamps
UPDATE analytics 
SET visitstarttime = to_timestamp(visitstarttime::bigint);

--Change data type for column visitstarttime from text to timestamps
ALTER TABLE analytics
ALTER COLUMN visitstarttime TYPE timestamp 
USING to_timestamp(visitstarttime, 'YYYY-MM-DD HH24:MI:SS');