USE retail_toy_sales;

LOAD DATA LOCAL INFILE 'path/to/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(product_id, product_name, product_category, @product_cost, @product_price)
SET
product_cost = REPLACE(@product_cost, '$', ''),
product_price = REPLACE(@product_price, '$', '');

LOAD DATA LOCAL INFILE 'path/to/stores.csv'
INTO TABLE stores
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(store_id, store_name, store_city, store_location, @store_open_date)
SET store_open_date = STR_TO_DATE(@store_open_date, '%Y-%m-%d');

LOAD DATA LOCAL INFILE 'path/to/sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(sale_id, @date, store_id, product_id, units)
SET date = STR_TO_DATE(@date, '%Y-%m-%d');

LOAD DATA LOCAL INFILE 'path/to/inventory.csv'
INTO TABLE inventory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(store_id, product_id, stock_on_hand);

INSERT INTO calendar (date)
SELECT DISTINCT date
FROM sales
WHERE date IS NOT NULL
ORDER BY date;