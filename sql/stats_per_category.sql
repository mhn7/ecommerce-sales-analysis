SELECT
    product_category,
    COUNT(*) AS orders,
    SUM(quantity) AS units_sold,
    SUM(revenue) AS revenue,
    ROUND(AVG(revenue), 2) AS average_order_value
FROM ecommerce_sales
GROUP BY product_category
ORDER BY revenue DESC;
