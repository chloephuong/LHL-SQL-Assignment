What issues will you address by cleaning the data?
1. Data type of column time (allsessions) and column visitstarttime (analytics). At first when creating the tables and their columns, i had to set the data type as string so they allow to import the raw data. Next step, because the raw data at those above columns were recognized as unix timestamps so I convert the Unix timestamps to timestamps using to_timestamp. Otherwise, error show up as the data are out of range becasue Postgresql timestamps only starts since 00:00:00 AM on 01/01/2000 but the fact that our raw data has values older than that. Next, I change the data type for those columns from string to timestamps.

2. Some of the columns such as productprice and unitprice, their values needed to be divided by 1,000,000 as the values are too unrealistic for product or unit price.

3. I also changed the value of some not available value input into 'null'

4. I deleted/droped columns because they offer no value at all

- userid column in analytics table
- productrefundamount column, itemquantity column, itemrevenue column is allsessions 


Queries:
Below, provide the SQL queries you used to clean your data.

For allsessions table


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


--Update city column 

UPDATE allsessions 

SET city = null

WHERE city = 'not available in demo dataset' OR city = '(not set)'


--Drop/Delete productrefundamount column because it offers no value

ALTER TABLE allsessions

DROP COLUMN productrefundamount


--Drop/Delete itemquantity column because it offers no value

ALTER TABLE allsessions

DROP COLUMN itemquantity


--Drop/Delete itemrevenue column because it offers no value

ALTER TABLE allsessions

DROP COLUMN itemrevenue


For analytics table


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
