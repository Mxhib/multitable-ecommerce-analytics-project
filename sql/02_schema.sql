-- 02_schema.sql
-- Purpose: create schema + core tables for multi-table ecommerce analytics

-- keep everything in one schema for simplicity and core tables 

CREATE SCHEMA IF NOT EXISTS ecomm_analytics;

SET SEARCH_PATH to ecomm_analytics;

-- Drop the table if it already exists so this script can be safely re-run from scratch

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- Customers table

CREATE TABLE df_customers (
    customer_id VARCHAR PRIMARY KEY,
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR,
    customer_state VARCHAR
);

-- Orders table (each row is an order placed by a customer)

CREATE TABLE df_Orders (
  order_id                      VARCHAR(50) PRIMARY KEY,
  customer_id                   VARCHAR(50),
  order_status                  VARCHAR(30),
  order_purchase_timestamp      TIMESTAMP,
  order_approved_at             TIMESTAMP,
  order_delivered_timestamp     TIMESTAMP,
  order_estimated_delivery_date DATE
);

--  Order items table Each row represents a product included in an order
CREATE TABLE df_order_items (
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    price NUMERIC(10,2),
    shipping_charges NUMERIC(10,2),

    PRIMARY KEY (order_id, product_id)
);

-- Products table Contains product-level attributes such as category and physical dimensions

CREATE TABLE df_products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

-- Payments table Each row represents a payment made for an order

CREATE TABLE df_payments (
    order_id VARCHAR(50),
    payment_sequential INTEGER,
    payment_type VARCHAR(30),
    payment_installments INTEGER,
    payment_value NUMERIC(10,2),
    PRIMARY KEY (order_id, payment_sequential)
);

