SELECT
    CASE
        WHEN discount < 0.10 THEN '0-10%'
        WHEN discount < 0.20 THEN '10-20%'
        WHEN discount < 0.30 THEN '20-30%'
        ELSE '30%+'
    END AS discount_band,
    COUNT(*) AS orders,
    ROUND(AVG(quantity), 2) AS avg_quantity_per_order
FROM ecommerce_sales
GROUP BY discount_band
ORDER BY discount_band;
