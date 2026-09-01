SELECT
    region,
    product_category,
    COUNT(*) AS orders,
    SUM(revenue) AS revenue,
    ROUND(AVG(revenue), 2) AS average_order_value
FROM ecommerce_sales
GROUP BY region, product_category
ORDER BY revenue DESC;
