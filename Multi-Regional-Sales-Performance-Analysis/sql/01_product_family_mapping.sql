-- 01_product_family_mapping.sql
-- Purpose: Standardize product naming into defined product families
-- This transformation ensures consistent aggregation and reporting

SELECT
  *,
  CASE
    WHEN LOWER(Product_type) LIKE '%glucose%' THEN 'Glucose'
    WHEN LOWER(Product_type) LIKE '%custard%' THEN 'Custard'
    WHEN LOWER(Product_type) LIKE '%icing sugar%' THEN 'Icing Sugar'
    WHEN LOWER(Product_type) LIKE '%table water%' THEN 'Table Water'
    WHEN LOWER(Product_type) LIKE '%cocoa%' THEN 'Cocoa'
    WHEN LOWER(Product_type) LIKE '%gaw%' THEN 'Gaw Black Soap'
    WHEN LOWER(Product_type) LIKE '%water jar%' THEN 'Water Jar'
    WHEN LOWER(Product_type) LIKE '%corn flour%' THEN 'Corn Flour'
    WHEN LOWER(Product_type) LIKE '%mac-vita%' OR LOWER(Product_type) LIKE '%mac vita%' THEN 'Mac Vita'
    WHEN LOWER(Product_type) LIKE '%corn starch%' THEN 'Corn Starch'
    ELSE 'Other Products'
  END AS product_family
FROM `your_project_id.Sales_Report.Fincap Sales Report`;