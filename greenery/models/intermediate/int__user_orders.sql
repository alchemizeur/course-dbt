{{
  config(
    materialized='table'
  )
}}

WITH orders AS (
    SELECT
          stgpo.user_id
        , COUNT(stgpo.order_id) AS number_of_orders
    FROM {{ ref('stg_postgres__orders') }} AS stgpo
    GROUP BY user_id
)

SELECT 
    * 
FROM orders