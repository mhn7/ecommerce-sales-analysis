SELECT
    product_category,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_pct,
    ROUND(AVG(unit_price), 2) AS avg_unit_price,
    ROUND(AVG(revenue), 2) AS average_order_value,
    SUM(revenue) AS total_revenue
FROM ecommerce_sales
GROUP BY product_category
ORDER BY total_revenue DESC;
