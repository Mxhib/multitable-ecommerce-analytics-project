-- 03_load_data.sql
-- Purpose: load raw CSV files into Postgres tables (schema: ecomm_analytics)

SET search_path TO ecomm_analytics;

-- Reset tables to rerun this script safely
TRUNCATE TABLE
  df_payments,
  df_order_items,
  df_orders,
  df_products,
  df_customers,
  stg_products;

-- 1) Customers
COPY df_customers
FROM '/Users/mohibabbas/Data Analyst Projects/multitable-ecommerce-analytics-project/data/raw/df_Customers.csv'
WITH (FORMAT csv, HEADER true);

-- 2) Orders
COPY df_orders
FROM '/Users/mohibabbas/Data Analyst Projects/multitable-ecommerce-analytics-project/data/raw/df_Orders.csv'
WITH (FORMAT csv, HEADER true);

-- 3) Products (load raw -> staging, then dedupe into df_products)
COPY stg_products
FROM '/Users/mohibabbas/Data Analyst Projects/multitable-ecommerce-analytics-project/data/raw/df_Products.csv'
WITH (FORMAT csv, HEADER true);

INSERT INTO df_products
SELECT DISTINCT ON (product_id)
  product_id,
  product_category_name,
  product_weight_g,
  product_length_cm,
  product_height_cm,
  product_width_cm
FROM stg_products
WHERE product_id IS NOT NULL
ORDER BY product_id;

-- 4) Order Items  (FIXED filename)
COPY df_order_items
FROM '/Users/mohibabbas/Data Analyst Projects/multitable-ecommerce-analytics-project/data/raw/df_OrderItems.csv'
WITH (FORMAT csv, HEADER true);

-- 5) Payments
COPY df_payments
FROM '/Users/mohibabbas/Data Analyst Projects/multitable-ecommerce-analytics-project/data/raw/df_Payments.csv'
WITH (FORMAT csv, HEADER true);

-- Quick row-count checks
SELECT 'df_customers'   AS table_name, COUNT(*) AS rows FROM df_customers
UNION ALL
SELECT 'df_orders',     COUNT(*) FROM df_orders
UNION ALL
SELECT 'df_products',   COUNT(*) FROM df_products
UNION ALL
SELECT 'df_order_items',COUNT(*) FROM df_order_items
UNION ALL
SELECT 'df_payments',   COUNT(*) FROM df_payments;

-- Optional: show how many duplicate product rows were in the raw file
SELECT
  COUNT(*) AS stg_rows,
  COUNT(DISTINCT product_id) AS distinct_product_ids
FROM stg_products;
