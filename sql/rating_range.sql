SELECT
    ROUND(AVG(customer_rating), 2) AS average_rating,
    MIN(customer_rating) AS lowest_rating,
    MAX(customer_rating) AS highest_rating
FROM ecommerce_sales; 
