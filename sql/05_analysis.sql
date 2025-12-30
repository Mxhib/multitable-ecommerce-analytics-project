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

    