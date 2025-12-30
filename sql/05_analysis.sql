-- 05_analysis.sql - exploratory data analysis + basic analytics queries

-- Purpose: join multiple tables to analyze order items with product and customer context combining order items with product, order, and customer context
SET search_path TO ecomm_analytics, public;

SELECT
    oi.order_id,
    o.customer_id,
    o.order_purchase_timestamp,

    oi.product_id,
    p.product_category_name,

    oi.price,
    oi.shipping_charges,
    (oi.price + oi.shipping_charges) AS item_revenue

FROM df_order_items oi
JOIN df_orders o
    ON o.order_id = oi.order_id
JOIN df_products p
    ON p.product_id = oi.product_id;

-- Overall revenue and basic stats

WITH fact_order_items AS (
    SELECT
        oi.order_id,
        o.customer_id,
        o.order_purchase_timestamp,
        oi.product_id,
        p.product_category_name,
        oi.price,
        oi.shipping_charges,
        (oi.price + oi.shipping_charges) AS item_revenue
    FROM ecomm_analytics.df_order_items oi
    JOIN ecomm_analytics.df_orders o ON o.order_id = oi.order_id
    JOIN ecomm_analytics.df_products p ON p.product_id = oi.product_id
)
SELECT
    COUNT(*) AS line_items,

    COUNT(DISTINCT order_id) AS orders,

    COUNT(DISTINCT customer_id) AS customers,

    SUM(item_revenue) AS total_revenue,

    AVG(item_revenue) AS avg_item_revenue,

    MIN(item_revenue) AS min_item_revenue,

    MAX(item_revenue) AS max_item_revenue
FROM fact_order_items;

-- Top 20 products by revenue descending with category and times sold

WITH fact_order_items AS (
    SELECT
        oi.order_id,
        o.customer_id,
        o.order_purchase_timestamp,
        oi.product_id,
        p.product_category_name,
        oi.price,
        oi.shipping_charges,
        (oi.price + oi.shipping_charges) AS item_revenue

    FROM ecomm_analytics.df_order_items oi
    JOIN ecomm_analytics.df_orders   o ON o.order_id = oi.order_id
    JOIN ecomm_analytics.df_products p ON p.product_id = oi.product_id
)
SELECT
    product_id,
    COALESCE(product_category_name, 'unknown') AS category,
    COUNT(*)                                   AS times_sold,
    SUM(item_revenue)                          AS revenue

FROM fact_order_items
GROUP BY product_id, category
ORDER BY revenue DESC
LIMIT 20;

-- Top 20 customers by total revenue descending
WITH fact_order_items AS (
    SELECT
        oi.order_id,
        o.customer_id,
        o.order_purchase_timestamp,
        (oi.price + oi.shipping_charges) AS item_revenue
    FROM df_order_items oi
    JOIN df_orders o ON o.order_id = oi.order_id
),
customer_rollup AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(item_revenue)        AS total_revenue,
        AVG(item_revenue)        AS avg_item_revenue
    FROM fact_order_items
    GROUP BY 1
)
SELECT
    customer_id,
    total_orders,
    total_revenue,
    avg_item_revenue
FROM customer_rollup
ORDER BY total_revenue DESC
LIMIT 20;


-- Average Order Value (AOV) + items per order with rollup


WITH fact_order_items AS (
    SELECT
        oi.order_id,
        o.customer_id,
        o.order_purchase_timestamp,
        oi.product_id,
        p.product_category_name,
        (oi.price + oi.shipping_charges) AS item_revenue
    FROM ecomm_analytics.df_order_items oi
    JOIN ecomm_analytics.df_orders   o ON o.order_id = oi.order_id
    JOIN ecomm_analytics.df_products p ON p.product_id = oi.product_id
),
order_rollup AS (
    SELECT
        order_id,
        customer_id,
        DATE_TRUNC('day', order_purchase_timestamp) AS order_date,
        COUNT(*) AS items_in_order,
        SUM(item_revenue) AS order_revenue
    FROM fact_order_items
    GROUP BY 1, 2, 3
)
SELECT
    COUNT(*)                  AS orders,
    AVG(items_in_order)       AS avg_items_per_order,
    AVG(order_revenue)        AS avg_order_value,
    MIN(order_revenue)        AS min_order_value,
    MAX(order_revenue)        AS max_order_value
FROM order_rollup;



