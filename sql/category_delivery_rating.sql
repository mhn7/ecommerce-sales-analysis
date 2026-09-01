SELECT
    product_category,
    COUNT(*) AS orders,
    ROUND(AVG(customer_rating), 2) AS average_rating,
    ROUND(AVG(delivery_days), 2) AS avg_delivery_days
FROM ecommerce_sales
GROUP BY product_category
ORDER BY average_rating DESC;
