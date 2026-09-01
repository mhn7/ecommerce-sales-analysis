WITH customer_summary AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(revenue) AS customer_revenue
    FROM ecommerce_sales
    GROUP BY customer_id
)

SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time'
        WHEN order_count <= 3 THEN 'Low-frequency'
        WHEN order_count <= 6 THEN 'Medium-frequency'
        ELSE 'High-frequency'
    END AS customer_segment,
    COUNT(*) AS customers,
    SUM(order_count) AS orders,
    SUM(customer_revenue) AS total_revenue,
    ROUND(AVG(customer_revenue), 2) AS avg_revenue_per_customer
FROM customer_summary
GROUP BY customer_segment
ORDER BY total_revenue DESC;
