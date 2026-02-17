-- 03_yoy_growth_analysis.sql
-- Purpose: Calculate Year-over-Year growth percentages for quantity and revenue
-- Level: Product Family × Year

WITH yearly_metrics AS (
  SELECT
    EXTRACT(YEAR FROM DATE(order_date)) AS sales_year,

    CASE
      WHEN LOWER(Product_type) LIKE '%glucose%' THEN 'Glucose'
      WHEN LOWER(Product_type) LIKE '%custard%' THEN 'Custard'
      WHEN LOWER(Product_type) LIKE '%icing sugar%' THEN 'Icing Sugar'
      WHEN LOWER(Product_type) LIKE '%table water%' THEN 'Table Water'
      WHEN LOWER(Product_type) LIKE '%cocoa%' THEN 'Cocoa'
      WHEN LOWER(Product_type) LIKE '%gaw%' THEN 'Gaw Black Soap'
      WHEN LOWER(Product_type) LIKE '%water jar%' THEN 'Water Jar'
      WHEN LOWER(Product_type) LIKE '%corn flour%' THEN 'Corn Flour'
      WHEN LOWER(Product_type) LIKE '%mac-vita%' 
        OR LOWER(Product_type) LIKE '%mac vita%' THEN 'Mac Vita'
      WHEN LOWER(Product_type) LIKE '%corn starch%' THEN 'Corn Starch'
      ELSE 'Other Products'
    END AS product_family,

    SUM(CAST(quantity AS INT64)) AS total_quantity,
    SUM(CAST(total_amount AS FLOAT64)) AS total_revenue
  FROM `your_project_id.Sales_Report.Fincap Sales Report`
  GROUP BY sales_year, product_family
)

SELECT
  product_family,
  sales_year,

  SAFE_DIVIDE(
    total_quantity - LAG(total_quantity) OVER (
      PARTITION BY product_family ORDER BY sales_year
    ),
    LAG(total_quantity) OVER (
      PARTITION BY product_family ORDER BY sales_year
    )
  ) * 100 AS quantity_yoy_growth_percent,

  SAFE_DIVIDE(
    total_revenue - LAG(total_revenue) OVER (
      PARTITION BY product_family ORDER BY sales_year
    ),
    LAG(total_revenue) OVER (
      PARTITION BY product_family ORDER BY sales_year
    )
  ) * 100 AS revenue_yoy_growth_percent

FROM yearly_metrics
ORDER BY product_family, sales_year;