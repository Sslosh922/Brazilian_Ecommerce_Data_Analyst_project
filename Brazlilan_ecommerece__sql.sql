
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR(100),
    customer_state VARCHAR(5)
);


CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR(100),
    seller_state VARCHAR(5)
);


CREATE TABLE product_category_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);


CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght NUMERIC,
    product_description_lenght NUMERIC,
    product_photos_qty NUMERIC,
    product_weight_g NUMERIC,
    product_length_cm NUMERIC,
    product_height_cm NUMERIC,
    product_width_cm NUMERIC,

    CONSTRAINT fk_products_category
        FOREIGN KEY (product_category_name)
        REFERENCES product_category_translation(product_category_name)
);


CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(30),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,

    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INTEGER,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(12,2),
    freight_value NUMERIC(12,2),

    CONSTRAINT pk_order_items
        PRIMARY KEY (order_id, order_item_id),

    CONSTRAINT fk_order_items_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_order_items_products
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT fk_order_items_sellers
        FOREIGN KEY (seller_id)
        REFERENCES sellers(seller_id)
);


CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INTEGER,
    payment_type VARCHAR(50),
    payment_installments INTEGER,
    payment_value NUMERIC(12,2),

    CONSTRAINT pk_order_payments
        PRIMARY KEY (order_id, payment_sequential),

    CONSTRAINT fk_payments_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

CREATE TABLE order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,

    CONSTRAINT fk_reviews_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);


CREATE TABLE geolocation (
    geolocation_zip_code_prefix INTEGER,
    geolocation_lat NUMERIC(10,7),
    geolocation_lng NUMERIC(10,7),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(5)
);

-- Monthly sales and order performance

select
TO_CHAR(DATE_TRUNC('month', o.order_purchase_timestamp), 'YYYY-MM') AS sales_month,
COUNT(DISTINCT o.order_id) AS total_orders,
ROUND(SUM(oi.price), 2) AS total_gmv,
ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id),2) AS average_order_value
from orders o join order_items oi 
on o.order_id = oi.order_id
where o.order_status = 'delivered'
group by DATE_TRUNC('month', o.order_purchase_timestamp)
order by DATE_TRUNC('month', o.order_purchase_timestamp);

 -- top 5 months by GMV

select to_char(date_trunc('month', o.order_purchase_timestamp), 'yyyy-mm') as sales_month,
count(distinct o.order_id) as total_orders,
round(sum(oi.price), 2) as total_gmv,
round(sum(oi.price) / count(distinct o.order_id), 2) as average_order_value
from orders o join order_items oi
on o.order_id = oi.order_id
where o.order_status = 'delivered'
group by date_trunc('month', o.order_purchase_timestamp)
order by sum(oi.price) desc
limit 5;


-- product category performance


select coalesce(pct.product_category_name_english, p.product_category_name, 'unknown') as category,
count(distinct o.order_id) as total_orders,
round(sum(oi.price), 2) as total_gmv,
round(avg(oi.price), 2) as average_item_price
from order_items oi
join orders o on oi.order_id = o.order_id
join products p on oi.product_id = p.product_id
left join product_category_translation pct
on p.product_category_name = pct.product_category_name
where o.order_status = 'delivered'
group by coalesce(pct.product_category_name_english, p.product_category_name, 'unknown')
order by sum(oi.price) desc
limit 10;


-- top 10 sellers by GMV


select oi.seller_id,s.seller_state,
count(distinct o.order_id) as total_orders,
round(sum(oi.price), 2) as total_gmv
from order_items oi join orders o
on oi.order_id = o.order_id
join sellers s
on oi.seller_id = s.seller_id
where o.order_status = 'delivered'
group by oi.seller_id, s.seller_state
order by sum(oi.price) desc
limit 10;


-- payment behavior


select payment_type,count(*) as total_payments,
count(distinct order_id) as total_orders,
round(sum(payment_value), 2) as total_payment_value,
round(avg(payment_value), 2) as average_payment_value
from order_payments
group by payment_type
order by sum(payment_value) desc;


