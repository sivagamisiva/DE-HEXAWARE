use OyoBusiness;

select * from bookings;
select * from hotels;

-- 1. Average Room Rates of Different Cities

SELECT h.city,
       MIN(b.amount) AS min_amount,
       MAX(b.amount) AS max_amount,
       AVG(b.amount) AS avg_amount
FROM bookings b
JOIN hotels h ON b.hotel_id = h.hotel_id
WHERE b.status = 'Stayed'
GROUP BY h.city;

-- 2. Frequency of Bookings by Number of Rooms

SELECT b.no_of_rooms,
       COUNT(*) AS frequency
FROM bookings b
WHERE b.status = 'Stayed'
GROUP BY b.no_of_rooms
ORDER BY b.no_of_rooms;

-- 3. Total Revenue per City (After Discount, Stayed Bookings)

SELECT h.city,
       SUM(b.amount - b.discount) AS total_revenue_after_discount
FROM bookings b
JOIN hotels h ON b.hotel_id = h.hotel_id
WHERE b.status = 'Stayed'
GROUP BY h.city
HAVING SUM(b.amount - b.discount) > 3000;

-- 4. Number of Bookings of Different Cities in Jan, Feb, Mar

SELECT h.city,
       DATENAME(MONTH, b.date_of_booking) AS booking_month,
       COUNT(*) AS total_bookings
FROM bookings b
JOIN hotels h ON b.hotel_id = h.hotel_id
WHERE MONTH(b.date_of_booking) IN (1, 2, 3)
  AND b.status = 'Stayed'
GROUP BY h.city, DATENAME(MONTH, b.date_of_booking);


