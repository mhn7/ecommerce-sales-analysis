SELECT
    EXTRACT(YEAR FROM order_date)::int AS year,
    COUNT(*) AS orders,
    SUM(revenue) AS total_revenue,
    ROUND(AVG(revenue), 2) AS average_order_value
FROM ecommerce_sales
GROUP BY year
ORDER BY year;
