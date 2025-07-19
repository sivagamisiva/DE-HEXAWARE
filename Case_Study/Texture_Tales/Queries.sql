/*  Queries   */

/* 1.Total quantity sold for all products */

SELECT SUM(qty) AS total_quantity_sold                       
FROM sales;



/* 2.Average discount value per transaction */

SELECT AVG(discount_value) 
AS avg_discount_per_transaction
FROM (
    SELECT txn_id, SUM(discount * qty) AS discount_value
    FROM sales
    GROUP BY txn_id
) AS txn_discounts;


/* 3.Top selling product for each segment*/

WITH SegmentSales AS (
SELECT 
        pd.segment_name,
        pd.product_name,
        s.prod_id,
        SUM(s.qty) AS total_quantity,
        ROW_NUMBER() OVER (
            PARTITION BY pd.segment_name 
            ORDER BY SUM(s.qty) DESC
        ) AS rn
    FROM sales s JOIN product_details pd ON s.prod_id = pd.product_id
    GROUP BY pd.segment_name, pd.product_name, s.prod_id
)
SELECT segment_name, product_name, prod_id, total_quantity
FROM SegmentSales
WHERE rn = 1;



/* 4.Top 3 products by total revenue before discount */

SELECT TOP 3 
    pd.product_name,
    s.prod_id,
    SUM(s.qty * s.price) AS total_revenue
FROM sales s
JOIN product_details pd ON s.prod_id = pd.product_id
GROUP BY pd.product_name, s.prod_id
ORDER BY total_revenue DESC;



/* 5.total quantity, total revenue (before discount), and total discount for each segment */

SELECT 
    pd.segment_name,
    SUM(s.qty) AS total_quantity,
    SUM(s.qty * s.price) AS total_revenue,
    SUM(s.qty * s.discount) AS total_discount
FROM sales s
JOIN product_details pd ON s.prod_id = pd.product_id
GROUP BY pd.segment_name;

