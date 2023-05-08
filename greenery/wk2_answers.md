What is our user repeat rate?

```
WITH repeat_users_stats AS (
    SELECT
        COUNT(*) AS total_users
        , SUM(CASE WHEN is_repeat_user = TRUE THEN 1 ELSE 0 END) AS repeat_users
    FROM DEV_DB.DBT_VICTORIAPLUM13GMAILCOM.FCT__USER_ORDER_STATS
)

SELECT
    (repeat_users * 100.0) / total_users AS user_repeat_rate
FROM repeat_users_stats;
```

79.83871