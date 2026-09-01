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
)

SELECT
    COUNT(*) AS repeat_customers,
    ROUND(
        AVG(second_order - first_order),
        1
    ) AS avg_days_to_second_order,
    MIN(second_order - first_order) AS fastest_days,
    MAX(second_order - first_order) AS slowest_days
FROM second_orders
WHERE second_order IS NOT NULL;
