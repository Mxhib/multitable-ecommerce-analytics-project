-- 04_data_quality.sql -  data quality checks + light cleaning helpers

SET search_path TO ecomm_analytics, public;
SHOW search_path;
SELECT current_schema();


-- sanity checks : table exists and row counts
SELECT 'df_customers'   AS table_name, COUNT(*) AS rows FROM df_customers
UNION ALL
SELECT 'df_orders',     COUNT(*) FROM df_orders
UNION ALL
SELECT 'df_products',   COUNT(*) FROM df_products
UNION ALL
SELECT 'df_order_items',COUNT(*) FROM df_order_items
UNION ALL
SELECT 'df_payments',   COUNT(*) FROM df_payments;


-- check for duplicates

-- Customers: customer_id should be unique
SELECT customer_id, COUNT(*) AS cnt
FROM df_customers
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY cnt DESC;

-- Orders: order_id should be unique
SELECT order_id, COUNT(*) AS cnt
FROM df_orders
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY cnt DESC;

-- Products: product_id should be unique
SELECT product_id, COUNT(*) AS cnt
FROM df_products
GROUP BY product_id
HAVING COUNT(*) > 1
ORDER BY cnt DESC;

-- Order items: (order_id, product_id) should be unique (based on your schema)
SELECT order_id, product_id, COUNT(*) AS cnt
FROM df_order_items
GROUP BY order_id, product_id
HAVING COUNT(*) > 1
ORDER BY cnt DESC;

-- Payments: (order_id, payment_sequential) should be unique (if that’s how you designed it)
SELECT order_id, payment_sequential, COUNT(*) AS cnt
FROM df_payments
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1
ORDER BY cnt DESC;
