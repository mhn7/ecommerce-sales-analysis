SELECT
    customer_rating,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS order_share_pct
FROM ecommerce_sales
GROUP BY customer_rating
ORDER BY customer_rating; 



