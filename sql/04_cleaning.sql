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

-- Duplicate checks (PASS / FAIL summary)
SELECT
  'df_customers customer_id uniqueness' AS check_name,
  CASE WHEN EXISTS (
    SELECT 1 FROM df_customers GROUP BY customer_id HAVING COUNT(*) > 1
  ) THEN 'FAIL ' ELSE 'PASS ' END AS result
UNION ALL
SELECT
  'df_orders order_id uniqueness',
  CASE WHEN EXISTS (
    SELECT 1 FROM df_orders GROUP BY order_id HAVING COUNT(*) > 1
  ) THEN 'FAIL ' ELSE 'PASS ' END
UNION ALL
SELECT
  'df_products product_id uniqueness',
  CASE WHEN EXISTS (
    SELECT 1 FROM df_products GROUP BY product_id HAVING COUNT(*) > 1
  ) THEN 'FAIL ' ELSE 'PASS ' END
UNION ALL
SELECT
  'df_order_items (order_id, product_id) uniqueness',
  CASE WHEN EXISTS (
    SELECT 1 FROM df_order_items GROUP BY order_id, product_id HAVING COUNT(*) > 1
  ) THEN 'FAIL ' ELSE 'PASS ' END
UNION ALL
SELECT
  'df_payments (order_id, payment_sequential) uniqueness',
  CASE WHEN EXISTS (
    SELECT 1 FROM df_payments GROUP BY order_id, payment_sequential HAVING COUNT(*) > 1
  ) THEN 'FAIL ' ELSE 'PASS ' END;


-- NULL / missing value checks

SELECT
  SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id
FROM df_customers;

SELECT
  SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
  SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id
FROM df_orders;

SELECT
  SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_product_id
FROM df_products;

SELECT
  SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
  SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_product_id
FROM df_order_items;

SELECT
  SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id
FROM df_payments;

-- range / checks for any weird values

-- Price + shipping should not be negative
SELECT
  'order_items.non_negative_price_shipping' AS check_name,
  CASE
    WHEN COUNT(*) = 0 THEN 'PASS'
    ELSE 'FAIL'
  END AS result,
  COUNT(*) AS bad_rows
FROM df_order_items
WHERE price < 0
   OR shipping_charges < 0;


-- Product dimensions should not be negative
SELECT
  'products.non_negative_dimensions' AS check_name,
  CASE
    WHEN COUNT(*) = 0 THEN 'PASS'
    ELSE 'FAIL'
  END AS result,
  COUNT(*) AS bad_rows
FROM df_products
WHERE product_weight_g < 0
   OR product_length_cm < 0
   OR product_height_cm < 0
   OR product_width_cm < 0;

-