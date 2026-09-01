SELECT
    CASE
        WHEN discount < 0.10 THEN '0-10%'
        WHEN discount < 0.20 THEN '10-20%'
        WHEN discount < 0.30 THEN '20-30%'
        ELSE '30%+'
    END AS discount_band,
    product_category,
    COUNT(*) AS orders,
    SUM(revenue) AS total_revenue,
    ROUND(AVG(revenue), 2) AS average_order_value
FROM ecommerce_sales
GROUP BY discount_band, product_category
ORDER BY discount_band;
