SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(revenue) AS total_revenue,
    ROUND(AVG(revenue), 2) AS average_order_value,
    SUM(quantity) AS total_units_sold
FROM ecommerce_sales;
