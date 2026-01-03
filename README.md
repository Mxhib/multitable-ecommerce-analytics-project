# Multitable E-Commerce Analytics Project

**SQL + PostgreSQL + Tableau Executive Dashboard**

---

## Project Overview

This project is an end-to-end e-commerce analytics case study built using a realistic multi-table dataset. The objective was to simulate a real data analyst workflow: designing a relational schema, validating and analyzing data using SQL, and presenting insights through an executive-level Tableau dashboard.

The final output is an **Executive Overview Dashboard** designed for non-technical stakeholders to quickly understand business performance.

---

## Objectives

- Model and analyze a relational e-commerce dataset  
- Practice SQL joins, aggregations, and rollups  
- Perform data quality checks and validation  
- Translate analysis into clear, executive-friendly visualizations  
- Build a portfolio-ready project suitable for internship applications  

---

## Tableau Executive Dashboard

### Dashboard Purpose

The Tableau dashboard provides a high-level view of business performance and answers:

> **“How is the business performing, and where should we focus?”**

### Included Visuals

- **KPI Cards**
- **Monthly Revenue Trend**
- **Top 10 Product Categories by Revenue**
- **Revenue by Payment Method (Bar Chart)**
- **Payment Method Revenue Share (Pie Chart)**

### Design Decisions

- Minimal clutter  
- Clear visual hierarchy  
- Appropriate chart types for each metric  
- Avoiding visuals unsupported by data (e.g., geographic maps)  

---

## Tools & Technologies

### Database & Querying
- PostgreSQL  
- SQL (JOINs, GROUP BY, CTEs, aggregations)  

### Visualization
- Tableau Desktop  
- KPI cards, line charts, bar charts, pie charts  
- Dashboard layout and formatting  

### Version Control
- Git & GitHub  

---

## Dataset Description

The dataset represents a fictional e-commerce platform and includes the following tables:

- **Orders** – order-level metadata (IDs, timestamps)  
- **Order Items** – line-item pricing and shipping details  
- **Products** – product categories and attributes  
- **Payments** – payment method and installment information  

Analysis was performed primarily at the **order-item grain**, with rollups applied where necessary.

---

## Data Limitations & Design Decisions

### One Item per Order

During validation, it was discovered that:

- Each `order_id` appears only once in the order items table  
- As a result: **line items = orders = unique buyers**

Rather than forcing misleading metrics, the analysis was adjusted:

- The **Unique Buyers KPI was removed**
- **Average Order Value (AOV)** was calculated using order-level rollups
- Metrics were chosen to reflect what the data could accurately support

This mirrors real-world analytics work, where understanding data limitations is critical.

---

## Data Validation & Quality Checks

The following checks were performed:

- Duplicate detection on primary and composite keys  
- Revenue sanity checks (non-negative prices and shipping)  
- Join integrity checks across orders, products, and payments  
- Validation of aggregation levels before computing KPIs  

Any misleading or redundant metrics were intentionally excluded from the final dashboard.

---

## How to View the Dashboard

1. Download the `.twbx` file from the `tableau/` folder  
2. Open it using **Tableau Desktop**  
3. Navigate to the **Executive Overview Dashboard** tab  

---

## Key Takeaways

- Revenue is concentrated in a small number of product categories  
- Credit cards dominate payment behavior, contributing most revenue  
- Order-level rollups provide more meaningful insights than item-level averages  
- Understanding data limitations is essential for accurate analysis  

---

## Future Improvements

- Introduce customer location data for geographic analysis  
- Use a dataset with multiple items per order to analyze basket size  
- Add time-based filters for interactive exploration  
- Automate data refresh using a database connection  
