WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date)::int AS year,
        COUNT(*) AS orders,
        SUM(revenue) AS total_revenue,
        AVG(revenue) AS average_order_value
    FROM ecommerce_sales
    GROUP BY year
)

SELECT
    year,
    orders,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(average_order_value, 2) AS average_order_value,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY year))
        / LAG(total_revenue) OVER (ORDER BY year) * 100,
        2
    ) AS revenue_growth_pct
FROM yearly_sales
ORDER BY year;
