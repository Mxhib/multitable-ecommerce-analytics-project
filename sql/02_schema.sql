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


