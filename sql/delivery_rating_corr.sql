SELECT
    ROUND(
        CORR(delivery_days, customer_rating)::numeric,
        3
    ) AS delivery_rating_correlation
FROM ecommerce_sales;
