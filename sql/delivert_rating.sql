SELECT
    delivery_days,
    COUNT(*) AS orders,
    ROUND(AVG(customer_rating), 2) AS average_rating
FROM ecommerce_sales
GROUP BY delivery_days
ORDER BY delivery_days;
