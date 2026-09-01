SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customers,
    SUM(customer_revenue) AS total_revenue,
    ROUND(
        SUM(customer_revenue) * 100.0
        / SUM(SUM(customer_revenue)) OVER (),
        2
    ) AS revenue_share_pct
FROM (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(revenue) AS customer_revenue
    FROM ecommerce_sales
    GROUP BY customer_id
) AS customer_summary
GROUP BY customer_type
ORDER BY total_revenue DESC;
