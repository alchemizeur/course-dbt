{{
  config(
    materialized='table'
  )
}}

WITH user_order_stats AS (
    SELECT
        iuo.user_id
        , iuo.number_of_orders
        , iru.is_repeat_user
        , AVG(stgpo.order_total) AS average_order_value
        , SUM(stgpo.order_total) AS total_rev
        , MAX(CASE
            WHEN stgpo.status = 'Delivered' THEN TRUE
            ELSE FALSE
          END) AS is_delivered
    FROM {{ ref('int__user_orders') }} AS iuo
    JOIN {{ ref('int__repeat_users') }} AS iru USING (user_id)
    JOIN {{ ref('stg_postgres__orders') }} AS stgpo ON iuo.user_id = stgpo.user_id
    GROUP BY iuo.user_id, iuo.number_of_orders, iru.is_repeat_user
)

SELECT 
    * 
FROM user_order_stats