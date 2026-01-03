# Multitable-ecommerce-analytics-project
Multi-Table E-Commerce Analytics Project

SQL + PostgreSQL + Tableau Executive Dashboard

Project Overview

This project is an end-to-end e-commerce analytics case study built using a realistic multi-table dataset. The objective was to simulate a real data analyst workflow: designing a relational schema, validating and analyzing data using SQL, and presenting insights through an executive-level Tableau dashboard.

The final output is an Executive Overview Dashboard designed for non-technical stakeholders to quickly understand business performance.

Objectives

Model and analyze a relational e-commerce dataset

Practice SQL joins, aggregations, and rollups

Perform data quality checks and validation

Translate analysis into clear, executive-friendly visualizations

Build a portfolio-ready project suitable for internship applications

🛠️ Tools & Technologies
Database & Querying

PostgreSQL

SQL (JOINs, GROUP BY, CTEs, aggregations)

Visualization

Tableau Desktop

KPI cards, line charts, bar charts, pie charts

Executive dashboard layout and formatting

Version Control

Git & GitHub

Logical, human-readable commit history

Dataset Description

The dataset represents a fictional e-commerce platform and includes the following tables:

Orders – order-level metadata (IDs, timestamps)

Order Items – line-item pricing and shipping details

Products – product categories and attributes

Payments – payment method and installment information

Analysis was performed primarily at the order-item grain, with rollups applied where necessary.

Data Limitations & Design Decisions
One Item per Order

During validation, it was discovered that:

Each order_id appears only once in the order items table

As a result, line items = orders = unique buyers

Rather than forcing misleading metrics, the analysis was adjusted:

Unique Buyers KPI was removed

Average Order Value (AOV) was calculated using order-level rollups

Metrics were chosen to reflect what the data could accurately support

This mirrors real-world analytics work, where understanding data limitations is critical.

Data Validation & Quality Checks

The following checks were performed:

Duplicate detection on primary and composite keys

Revenue sanity checks (non-negative prices and shipping)

Join integrity checks across orders, products, and payments

Validation of aggregation levels before computing KPIs

Any misleading or redundant metrics were intentionally excluded from the final dashboard.

Tableau Executive Dashboard
Dashboard Purpose

The Tableau dashboard provides a high-level view of business performance and answers:

“How is the business performing, and where should we focus?”

Included Visuals

KPI Cards

Total Revenue

Total Orders

Average Order Value (AOV)

Monthly Revenue Trend

Top 10 Product Categories by Revenue

Revenue by Payment Method (Bar Chart)

Payment Method Revenue Share (Pie Chart)

Design decisions emphasized:

Minimal clutter

Clear visual hierarchy

Appropriate chart types for each metric

Avoiding visuals unsupported by data (e.g., geographic maps)



