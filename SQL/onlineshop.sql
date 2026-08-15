-- ************ Create Tables *************

DROP TABLE IF EXISTS customers CASCADE;
CREATE TABLE customers
(
customer_id INT PRIMARY KEY,
first_name	VARCHAR(30),
last_name	VARCHAR(30),
address	TEXT,
email	VARCHAR(255),
phone_number VARCHAR(20)
);
SELECT * FROM customers;

DROP TABLE IF EXISTS order_items CASCADE;
CREATE TABLE order_items
(
order_item_id	INT PRIMARY KEY,
order_id	INT,
product_id	INT,
quantity	INT,
price_at_purchase NUMERIC(10,2)
);
SELECT * FROM order_items;

DROP TABLE IF EXISTS orders CASCADE;
CREATE TABLE orders
(
order_id	INT PRIMARY KEY,
order_date	DATE,
customer_id	INT,
total_price NUMERIC(10,2)
);
SELECT * FROM orders;

DROP TABLE IF EXISTS payment CASCADE;
CREATE TABLE payment
(
payment_id	INT PRIMARY KEY,
order_id	INT,
payment_method	VARCHAR(50),
amount	NUMERIC(5,2),
transaction_status TEXT
);
SELECT * FROM payment;

DROP TABLE IF EXISTS products CASCADE;
CREATE TABLE products
(
product_id	INT PRIMARY KEY,
product_name	TEXT,
category	TEXT,
price	NUMERIC(5,2),
supplier_id INT
);
SELECT * FROM products;

DROP TABLE IF EXISTS reviews CASCADE;
CREATE TABLE reviews
(
review_id	INT PRIMARY KEY,
product_id	INT,
customer_id	INT,
rating	INT,
review_text	TEXT,
review_date DATE
);
SELECT * FROM reviews;

DROP TABLE IF EXISTS shipments CASCADE;
CREATE TABLE shipments
(
shipment_id	INT PRIMARY KEY,
order_id	INT,
shipment_date	DATE,
carrier	VARCHAR(15),
tracking_number	VARCHAR(30),
delivery_date	DATE,
shipment_status VARCHAR(30)
);
SELECT * FROM shipments;

DROP TABLE IF EXISTS suppliers CASCADE;
CREATE TABLE suppliers
(
supplier_id	INT PRIMARY KEY,
supplier_name	TEXT,
contact_name	TEXT,
address	TEXT,
phone_number VARCHAR(20),	
email VARCHAR(255)
);
SELECT * FROM suppliers;

-- ******** Add foreign keys *************

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY(customer_id) REFERENCES customers(customer_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_order
FOREIGN KEY(order_id) REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_product
FOREIGN KEY(product_id) REFERENCES products(product_id);

ALTER TABLE payment
ADD CONSTRAINT fk_payment_order
FOREIGN KEY(order_id) REFERENCES orders(order_id);

ALTER TABLE products
ADD CONSTRAINT fk_product_supplier
FOREIGN KEY(supplier_id) REFERENCES suppliers(supplier_id);

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_product
FOREIGN KEY(product_id) REFERENCES products(product_id);

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_customer
FOREIGN KEY(customer_id) REFERENCES customers(customer_id);

ALTER TABLE shipments
ADD CONSTRAINT fk_shipment_order
FOREIGN KEY(order_id) REFERENCES orders(order_id);

-- Validate the data imported
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'payment', COUNT(*) FROM payment
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'shipments', COUNT(*) FROM shipments
UNION ALL
SELECT 'suppliers', COUNT(*) FROM suppliers;

-- Split address in customer
select * from customers;
select address,
SPLIT_PART(address,',',1) as address_line,
SPLIT_PART(address,',',2) as city,
SPLIT_PART(address,',',3) as state_name
from customers;

alter table customers
ADD COLUMN address_line TEXT,
ADD COLUMN city TEXT,
ADD COLUMN state TEXT;

update customers set address_line = TRIM(SPLIT_PART(address,',',1));
update customers set city = TRIM(SPLIT_PART(address,',',2));
update customers set state = TRIM(SPLIT_PART(address,',',3));

alter table customers drop column address;

select first_name,last_name,CONCAT(first_name,' ',last_name) as customer_name from customers;
alter table customers add column customer_name VARCHAR(50);
update customers set customer_name = TRIM(CONCAT(first_name,' ',last_name))
alter table customers drop column first_name;
alter table customers drop column last_name;

select * from suppliers;

-- ***************** Join tables ****************

-- Customer -> Order -> Order Item -> Product -> Supplier
select c.customer_id,o.order_id,oi.order_item_id,p.product_id,s.supplier_id,c.customer_name,c.email as customer_email,c.phone_number as customer_phone_number,
c.city,c.state_name,o.order_date,
oi.quantity,oi.quantity * oi.price_at_purchase as line_revenue,
p.product_name,p.category,p.price as product_price,
s.supplier_name from customers c
LEFT JOIN orders o
ON o.customer_id = c.customer_id
LEFT JOIN order_items oi
ON oi.order_id = o.order_id
LEFT JOIN products p
ON p.product_id = oi.product_id
LEFT JOIN suppliers s
ON s.supplier_id = p.supplier_id

-- check duplicates got populated when we applied left join
SELECT
    oi.order_item_id,
    COUNT(*) AS row_count
FROM customers c
LEFT JOIN orders o
    ON o.customer_id = c.customer_id
LEFT JOIN order_items oi
    ON oi.order_id = o.order_id
LEFT JOIN products p
    ON p.product_id = oi.product_id
LEFT JOIN suppliers s
    ON s.supplier_id = p.supplier_id
WHERE oi.order_item_id IS NOT NULL
GROUP BY oi.order_item_id
HAVING COUNT(*) > 1;

-- Order -> Payment
select * from payment;

select o.order_id,p.payment_id,p.payment_method,p.amount as payment_amount,p.transaction_status from orders o
LEFT JOIN payment p 
ON p.order_id = o.order_id

-- Order -> Shipment
select * from shipments;

select o.order_id,s.shipment_id,s.shipment_date,s.carrier,s.delivery_date,s.shipment_status from orders o
LEFT JOIN shipments s
ON s.order_id = o.order_id

-- Review -> Customer -> Product
select * from reviews;

select r.review_id,c.customer_id,c.customer_name,p.product_id,p.product_name,r.rating,r.review_text,r.review_date from reviews r
LEFT JOIN customers c
ON c.customer_id = r.customer_id
LEFT JOIN products p
ON p.product_id = r.product_id

-- *************** Create BI views for analysis *****************

CREATE OR REPLACE VIEW sale_analysis AS
select c.customer_id,o.order_id,oi.order_item_id,p.product_id,s.supplier_id,c.customer_name,c.email as customer_email,c.phone_number as customer_phone_number,
c.city,c.state_name,o.order_date,
oi.quantity,oi.quantity * oi.price_at_purchase as line_revenue,
p.product_name,p.category,p.price as product_price,
s.supplier_name from customers c
LEFT JOIN orders o
ON o.customer_id = c.customer_id
LEFT JOIN order_items oi
ON oi.order_id = o.order_id
LEFT JOIN products p
ON p.product_id = oi.product_id
LEFT JOIN suppliers s
ON s.supplier_id = p.supplier_id;

CREATE OR REPLACE VIEW payment_analysis AS
select o.order_id,p.payment_id,p.payment_method,p.amount as payment_amount,p.transaction_status,o.order_date,o.customer_id from orders o
LEFT JOIN payment p 
ON p.order_id = o.order_id;


CREATE OR REPLACE VIEW shipment_analysis AS
select o.order_id,s.shipment_id,s.shipment_date,s.carrier,s.delivery_date,s.shipment_status,o.order_date,o.customer_id from orders o
LEFT JOIN shipments s
ON s.order_id = o.order_id;

CREATE OR REPLACE VIEW review_analysis AS
select r.review_id,c.customer_id,c.customer_name,p.product_id,p.product_name,r.rating,r.review_text,r.review_date from reviews r
LEFT JOIN customers c
ON c.customer_id = r.customer_id
LEFT JOIN products p
ON p.product_id = r.product_id

select * from sale_analysis;
select * from payment_analysis;
select * from shipment_analysis;
select * from review_analysis;

-- Dim customer
CREATE OR REPLACE VIEW dim_customer AS
select customer_id,customer_name,email,phone_number,city,state_name from customers;
-- Dim product
CREATE OR REPLACE VIEW dim_product AS
select product_id,product_name,category, price as product_price from products;
-- Dim supplier
CREATE OR REPLACE VIEW dim_supplier AS
select supplier_id,supplier_name,contact_name,phone_number,email from suppliers;

-- ************* KPI and Business questions ***************

-- TOTAL SALES
SELECT SUM(line_revenue) as "Total sales" from sale_analysis;
-- TOTAL ORDERS
SELECT COUNT(DISTINCT order_id) as "Total orders" from sale_analysis;
-- AVERAGE ORDER VALUE (AOV)
SELECT ROUND(SUM(line_revenue)/(COUNT(DISTINCT order_id)),2) as "Average Order Value (AOV)" from sale_analysis;
-- TOTAL QUANTITY SOLD
SELECT SUM(quantity) as "Total Quantity" from sale_analysis;
-- CUSTOMER AVERAGE RATING
select ROUND(AVG(rating),2) as "Average Customer rating" from review_analysis;

-- 1. Which product generated the highest sales?
select product_name,SUM(line_revenue) as "total_sales" from sale_analysis
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 1;

-- 2. Which category generated the highest sales?
select category, SUM(line_revenue) as "total_sales" from sale_analysis
GROUP BY category
ORDER BY total_sales DESC
LIMIT 1;

-- 3. Which are the top 5 products by revenue? (DENSE_RANK() used to handle ties)
WITH Top5_Products AS
(
select product_name, SUM(line_revenue) as "revenue",
DENSE_RANK() OVER(ORDER BY SUM(line_revenue) DESC) as rn
from sale_analysis GROUP BY product_name
)
select product_name,revenue from Top5_Products WHERE rn<=5;

-- 4. Which customers are the top 10 customers by spending? (DENSE_RANK() used to handle ties)
WITH Top10_Customers AS
(
select customer_id, customer_name, SUM(line_revenue) as "total_spent",
DENSE_RANK() OVER(ORDER BY SUM(line_revenue) DESC) as rn
from sale_analysis 
GROUP BY customer_id, customer_name
)
select customer_id, customer_name,total_spent from Top10_Customers WHERE rn<=10;

-- 5. What is the monthly sales trend? 
select EXTRACT(MONTH from order_date) as month_no,
TO_CHAR(order_date,'Month') as month_name,
SUM(line_revenue) as total_sales
from sale_analysis
GROUP BY month_no,month_name
ORDER BY month_no,month_name;

-- 6. Which month generated the highest sales?
select EXTRACT(MONTH from order_date) as month_no,
TO_CHAR(order_date,'Month') as month_name,
SUM(line_revenue) as total_sales
from sale_analysis
GROUP BY month_no,month_name
ORDER BY total_sales DESC
LIMIT 1;

-- 7. What is the average rating for each product along with total reviews?
select product_name,
ROUND(AVG(rating),2) as avg_rating,
COUNT(review_id) as total_reviews
from review_analysis
GROUP BY product_name;

-- 8. Which products have an average rating above 4?
select product_name,
ROUND(AVG(rating),2) as avg_rating
from review_analysis
GROUP BY product_name
HAVING ROUND(AVG(rating),2) > 4;

-- 9. What is the payment success rate for each payment method?
select payment_method,
COUNT(*) as total_transactions,
COUNT(*) FILTER(WHERE transaction_status = 'Completed') as successful_transactions,
CONCAT(ROUND(COUNT(*) FILTER(WHERE transaction_status = 'Completed') * 100.00/COUNT(*),2),'%') as success_rate
from payment_analysis
GROUP BY payment_method

-- 10. What is the average delivery time for each carrier?
select carrier,
AVG(delivery_date - shipment_date)::int2 as avg_delivery_days
from shipment_analysis
WHERE delivery_date IS NOT NULL AND shipment_date IS NOT NULL
GROUP BY carrier;

-- 11. Rank products by revenue within each category
WITH Product_rank AS
(
select product_id,product_name,category,SUM(line_revenue) as revenue,
RANK() OVER(PARTITION BY category ORDER BY SUM(line_revenue) DESC) as rn
from sale_analysis
GROUP BY product_id,product_name,category
)
select product_id,product_name,category, revenue
from Product_rank
ORDER BY category,rn;

-- 12. What percentage of total sales does each category contribute?
WITH TotalSale_contribution AS
(
select category,SUM(line_revenue) as revenue
from sale_analysis
GROUP BY category
)
select category, revenue, ROUND((revenue * 100) / SUM(revenue) OVER(),2) as sales_perc
from TotalSale_contribution
ORDER BY category

-- 13. Which customers have spent more than the average customer spending?
WITH Customer_spending AS
(
select customer_id,customer_name,SUM(line_revenue) as total_spent from sale_analysis
GROUP BY customer_id,customer_name
)
select customer_id,customer_name, total_spent from Customer_spending
WHERE total_spent > (select AVG(total_spent) from Customer_spending)
ORDER BY total_spent DESC;

-- 14. What are the top 3 customers by revenue in each city?
WITH Top3_customer AS
(
select customer_id,customer_name,city, SUM(line_revenue) as revenue,
RANK() OVER(PARTITION BY city ORDER BY SUM(line_revenue) DESC) as rn
from sale_analysis
GROUP BY customer_id,customer_name,city
)
select customer_id,customer_name,city, revenue from Top3_customer WHERE rn<=3
ORDER BY city;

-- 15. What is the month-over-month sales growth?
WITH monthly_sales AS
(
select EXTRACT(MONTH from order_date) as month_no, SUM(line_revenue) as sales
from sale_analysis GROUP BY EXTRACT(MONTH from order_date)
ORDER BY month_no
),
previous_month_sales_cte AS
(
select month_no,sales,LAG(sales)OVER(ORDER BY month_no) as previous_month_sales from monthly_sales
ORDER BY month_no
)
select month_no,sales,COALESCE(previous_month_sales,0),
COALESCE(ROUND(((sales-previous_month_sales)/COALESCE(previous_month_sales,0)) * 100.00,2),0) as MOM_growth_perc
from previous_month_sales_cte