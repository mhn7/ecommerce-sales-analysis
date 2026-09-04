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

timing_data AS (
    SELECT
        customer_id,
        second_order - first_order AS days_to_second_order
    FROM second_orders
    WHERE second_order IS NOT NULL
),

timing_bands AS (
    SELECT
        customer_id,
        CASE
            WHEN days_to_second_order <= 30 THEN '0-30 days'
            WHEN days_to_second_order <= 90 THEN '31-90 days'
            WHEN days_to_second_order <= 180 THEN '91-180 days'
            WHEN days_to_second_order <= 365 THEN '181-365 days'
            WHEN days_to_second_order <= 730 THEN '366-730 days'
            ELSE '730+ days'
        END AS timing_band
    FROM timing_data
)

SELECT
    timing_band,
    COUNT(*) AS customers,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS customer_share_pct
FROM timing_bands
GROUP BY timing_band
ORDER BY
    CASE
        WHEN timing_band = '0-30 days' THEN 1
        WHEN timing_band = '31-90 days' THEN 2
        WHEN timing_band = '91-180 days' THEN 3
        WHEN timing_band = '181-365 days' THEN 4
        WHEN timing_band = '366-730 days' THEN 5
        WHEN timing_band = '730+ days' THEN 6
    END;
