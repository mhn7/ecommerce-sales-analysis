SELECT
    order_count,
    COUNT(*) AS customers
FROM (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM ecommerce_sales
    GROUP BY customer_id
) AS customer_orders
GROUP BY order_count
ORDER BY order_count;
