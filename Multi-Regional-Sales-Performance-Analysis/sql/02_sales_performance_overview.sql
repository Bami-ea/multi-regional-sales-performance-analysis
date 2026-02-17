-- 02_sales_performance_overview.sql
-- Purpose: Aggregate yearly sales performance by region and product family
-- Generates total revenue and total quantity metrics

SELECT
  EXTRACT(YEAR FROM DATE(order_date)) AS sales_year,
  zones,
  state,
  product_family,
  SUM(CAST(quantity AS INT64)) AS total_quantity,
  SUM(CAST(Total_Amount AS NUMERIC)) AS total_revenue
FROM `your_project_id.Sales_Report.Create Product Family Mapping`
GROUP BY sales_year, Zones, state, product_family