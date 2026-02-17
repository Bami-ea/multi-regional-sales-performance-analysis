-- 04_master_sales_analytics.sql
-- Purpose: Combine aggregated sales performance with product-level YoY growth metrics
-- This is a final reporting table used in Tableau

SELECT
  a.sales_year,
  a.product_family,
  a.Zones,
  a.state,
  a.total_quantity,
  a.total_revenue,
  b.quantity_yoy_growth_percent,
  b.revenue_yoy_growth_percent
FROM `your_project_id.Sales_Report.Sales Performance Overview` a
LEFT JOIN `your_project_id.Sales_Report.YoY percentage Growth — Quantity vs Revenue ` b
ON a.sales_year = b.sales_year
AND a.product_family = b.product_family