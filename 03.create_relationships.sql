USE retail_toy_sales;

ALTER TABLE sales
ADD CONSTRAINT fk_sales_store
FOREIGN KEY (store_id) REFERENCES stores(store_id);

ALTER TABLE sales
ADD CONSTRAINT fk_sales_product
FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE sales
ADD CONSTRAINT fk_sales_date
FOREIGN KEY (date) REFERENCES calendar(date);

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_store
FOREIGN KEY (store_id) REFERENCES stores(store_id);

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_product
FOREIGN KEY (product_id) REFERENCES products(product_id);