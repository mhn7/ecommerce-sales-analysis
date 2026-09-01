WITH customer_orders AS (
    SELECT
        customer_id,
        order_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS order_number
    FROM ecommerce_sales
),

second_orders AS (
    SELECT
        customer_id,
        MAX(order_date) FILTER (WHERE order_number = 1) AS first_order,
        MAX(order_date) FILTER (WHERE order_number = 2) AS second_order
    FROM customer_orders
    GROUP BY customer_id
),

repeat_timing AS (
    SELECT
        customer_id,
        second_order - first_order AS days_to_second_order
    FROM second_orders
    WHERE second_order IS NOT NULL
)

SELECT
    CASE
        WHEN days_to_second_order <= 30 THEN '0-30 days'
        WHEN days_to_second_order <= 90 THEN '31-90 days'
        WHEN days_to_second_order <= 180 THEN '91-180 days'
        WHEN days_to_second_order <= 365 THEN '181-365 days'
        WHEN days_to_second_order <= 730 THEN '366-730 days'
        ELSE '730+ days'
    END AS repeat_timing,
    COUNT(*) AS customers,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS customer_share_pct
FROM repeat_timing
GROUP BY repeat_timing
ORDER BY
    CASE
        WHEN repeat_timing = '0-30 days' THEN 1
        WHEN repeat_timing = '31-90 days' THEN 2
        WHEN repeat_timing = '91-180 days' THEN 3
        WHEN repeat_timing = '181-365 days' THEN 4
        WHEN repeat_timing = '366-730 days' THEN 5
        ELSE 6
    END;
