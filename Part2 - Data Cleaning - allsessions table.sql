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

--Update country column 
UPDATE allsessions 
SET country = null
WHERE country = '(not set)'

--Update category column 
UPDATE allsessions 
SET v2productcategory = null
WHERE v2productcategory = '(not set)'

--Drop/Delete productrefundamount column because it offers no value
ALTER TABLE allsessions
DROP COLUMN productrefundamount

--Drop/Delete itemquantity column because it offers no value
ALTER TABLE allsessions
DROP COLUMN itemquantity

--Drop/Delete itemrevenue column because it offers no value
ALTER TABLE allsessions
DROP COLUMN itemrevenue