CREATE DATABASE mini_project_ss08;
USE mini_project_ss08;

CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type VARCHAR(50),
    price_per_day DECIMAL(10,0)
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

INSERT INTO guests (guest_name, phone) VALUES
('Nguyễn Văn An', '0901111111'),
('Trần Thị Bình', '0902222222'),
('Lê Văn Cường', '0903333333'),
('Phạm Thị Dung', '0904444444'),
('Hoàng Văn Em', '0905555555');

INSERT INTO rooms (room_type, price_per_day) VALUES
('Standard', 500000),
('Deluxe', 1000000),
('Suite', 2000000),
('Standard', 550000),
('Deluxe', 1200000);

INSERT INTO bookings (guest_id, room_id, check_in, check_out) VALUES
(1, 1, '2023-12-20', '2023-12-25'),
(2, 2, '2023-12-21', '2023-12-23'),
(3, 3, '2024-01-05', '2024-01-10'),
(4, 4, '2024-01-15', '2024-01-20'),
(5, 5, '2024-02-01', '2024-02-05'),
(1, 2, '2024-03-10', '2024-03-15'),
(2, 3, '2024-04-01', '2024-04-04'),
(3, 1, '2024-05-01', '2024-05-07'),
(1, 4, '2024-06-01', '2024-06-03'),
(2, 5, '2024-07-01', '2024-07-05');

SELECT guest_name, phone 
FROM guests;

SELECT DISTINCT room_type 
FROM rooms;

SELECT room_type, price_per_day 
FROM rooms 
ORDER BY price_per_day ASC;

SELECT * FROM rooms 
WHERE price_per_day > 1000000;

SELECT * FROM bookings 
WHERE YEAR(check_in) = 2024;

SELECT room_type, COUNT(*) as total_rooms
FROM rooms 
GROUP BY room_type;

SELECT 
    g.guest_name, 
    r.room_type, 
    b.check_in
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
JOIN rooms r ON b.room_id = r.room_id;

SELECT
    g.guest_name, 
    COUNT(b.booking_id) as total_bookings
FROM guests g
JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_id, g.guest_name;

SELECT 
    b.booking_id,
    g.guest_name,
    r.room_type,
    (DATEDIFF(b.check_out, b.check_in) * r.price_per_day) as revenue
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
JOIN rooms r ON b.room_id = r.room_id;

SELECT 
    r.room_type,
    SUM(DATEDIFF(b.check_out, b.check_in) * r.price_per_day) as total_revenue
FROM bookings b
JOIN rooms r ON b.room_id = r.room_id
GROUP BY r.room_type;

SELECT 
    g.guest_id,
    g.guest_name, 
    COUNT(b.booking_id) as booking_count
FROM guests g
JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_id, g.guest_name
HAVING booking_count >= 2;

SELECT 
    r.room_type, 
    COUNT(b.booking_id) as total_bookings
FROM rooms r
JOIN bookings b ON r.room_id = b.room_id
GROUP BY r.room_type
ORDER BY total_bookings DESC
LIMIT 1;

SELECT * FROM rooms 
WHERE price_per_day > (
    SELECT AVG(price_per_day) FROM rooms
);

SELECT * FROM guests 
WHERE guest_id NOT IN (
    SELECT DISTINCT guest_id FROM bookings
);

SELECT 
    r.room_id, 
    r.room_type, 
    COUNT(b.booking_id) as count_booking
FROM rooms r
JOIN bookings b ON r.room_id = b.room_id
GROUP BY r.room_id, r.room_type
HAVING count_booking >= ALL (
    SELECT COUNT(booking_id) 
    FROM bookings 
    GROUP BY room_id
);