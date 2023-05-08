**What is our overall conversion rate?**

WITH overall_conversion_rate AS (
  SELECT
    SUM(number_of_orders) AS total_orders
    , SUM(session_views) AS total_session_views
    , (SUM(number_of_orders) * 100.0) / SUM(session_views) AS conversion_rate
  FROM DEV_DB.DBT_VICTORIAPLUM13GMAILCOM.FCT__PRODUCT_CONVERSION_RATE
)

SELECT
  total_orders
  , total_session_views
  , conversion_rate
FROM overall_conversion_rate

46.720867

**What is our conversion rate by product?**

SELECT
  product_id
  , session_views
  , number_of_orders
  , conversion_rate
FROM DEV_DB.DBT_VICTORIAPLUM13GMAILCOM.FCT__PRODUCT_CONVERSION_RATE
ORDER BY
    4 DESC
