/* 1.Avg room rate */
SELECT 
    h.city,
    AVG(b.amount) AS average_room_rate,
    COUNT(b.booking_id) AS total_bookings
FROM 
    bookings b
JOIN 
    hotels h ON b.hotel_id = h.hotel_id
WHERE 
    b.status = 'Stayed' -- Only consider completed stays
GROUP BY 
    h.city
ORDER BY 
    average_room_rate DESC;

/* 2.Booking by city */


SELECT 
    h.city,
    COUNT(CASE WHEN MONTH(b.date_of_booking) = 1 THEN b.booking_id END) AS jan_bookings,
    COUNT(CASE WHEN MONTH(b.date_of_booking) = 2 THEN b.booking_id END) AS feb_bookings,
    COUNT(CASE WHEN MONTH(b.date_of_booking) = 3 THEN b.booking_id END) AS mar_bookings,
    COUNT(b.booking_id) AS total_bookings
FROM 
    bookings b
JOIN 
    hotels h ON b.hotel_id = h.hotel_id
GROUP BY 
    h.city
ORDER BY 
    total_bookings DESC;

/* 3.cancellation_rate_by_city.sql */

SELECT 
    h.city,
    COUNT(b.booking_id) AS total_bookings,
    SUM(CASE WHEN b.status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_bookings,
    ROUND(SUM(CASE WHEN b.status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(b.booking_id), 2) AS cancellation_rate
FROM 
    bookings b
JOIN 
    hotels h ON b.hotel_id = h.hotel_id
GROUP BY 
    h.city
ORDER BY 
    cancellation_rate DESC;


/* 4. Gross revenue */


SELECT 
    SUM(amount) AS gross_revenue
FROM 
    bookings;


/* 5. Net Revenue  */


SELECT 
    SUM(CASE WHEN status = 'Stayed' THEN amount - discount ELSE 0 END) AS net_revenue
FROM 
    bookings;


/* 6. New_customers_on_january  */


WITH jan_customers AS (
    SELECT DISTINCT customer_id
    FROM bookings
    WHERE MONTH(date_of_booking) = 1
),
prior_customers AS (
    SELECT DISTINCT customer_id
    FROM bookings
    WHERE date_of_booking < '2022-01-01'
)
SELECT 
    COUNT(j.customer_id) AS new_customers_jan,
    (SELECT COUNT(DISTINCT customer_id) FROM bookings WHERE MONTH(date_of_booking) = 1) AS total_customers_jan,
    ROUND(COUNT(j.customer_id) * 100.0 / 
        (SELECT COUNT(DISTINCT customer_id) FROM bookings WHERE MONTH(date_of_booking) = 1), 2) AS percentage_new
FROM 
    jan_customers j
LEFT JOIN 
    prior_customers p ON j.customer_id = p.customer_id
WHERE 
    p.customer_id IS NULL;