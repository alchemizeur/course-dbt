

{{
  config(
    materialized='table'
  )
}}

WITH product_views AS (
  SELECT
    fe.product_id
    , COUNT(DISTINCT fe.session_id) AS session_views
  FROM {{ ref('fct__events_extended') }} AS fe
  WHERE {{ product_view_filter() }}
  GROUP BY fe.product_id
),

product_orders AS (
  SELECT
    fpo.product_id
    , COUNT(DISTINCT fpo.order_id) AS number_of_orders
  FROM {{ ref('fct__order_items_extended') }} AS fpo
  GROUP BY fpo.product_id
),

product_conversion_rate AS (
  SELECT
    pv.product_id
    , pv.session_views
    , po.number_of_orders
    , CASE
        WHEN pv.session_views = 0 THEN 0
        ELSE (po.number_of_orders * 100.0) / pv.session_views
      END AS conversion_rate
  FROM product_views AS pv
  JOIN product_orders AS po USING (product_id)
)

SELECT 
  * 
FROM product_conversion_rate

