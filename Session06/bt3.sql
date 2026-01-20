CREATE DATABASE ss06;
USE ss06;

CREATE TABLE Customers (
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255),
    city VARCHAR(255) 
);

CREATE TABLE Orders (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE DEFAULT(CURRENT_DATE),
    status ENUM('pending', 'completed', 'cancelled'),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Customers (full_name, city) VALUES
('Nguyễn Văn An', 'Hà Nội'),
('Trần Thị Bình', 'TP. Hồ Chí Minh'),
('Lê Văn Cường', 'Đà Nẵng'),
('Phạm Thị Dung', 'Cần Thơ'),
('Hoàng Văn Em', 'Hải Phòng');

ALTER TABLE Orders
ADD COLUMN total_amount INT;

INSERT INTO Orders (customer_id, order_date, status, total_amount) VALUES
(1, '2025-01-01', 'completed', 2500000),
(1, '2025-01-01', 'pending', 100000),
(3, '2025-01-02', 'completed', 6000000),
(4, '2025-01-03', 'cancelled', 200000),
(5, '2025-01-03', 'pending', 1500000);

SELECT o.order_date, SUM(o.total_amount)
FROM Orders o
GROUP BY o.order_date
ORDER BY o.order_date ASC;

SELECT o.order_date, COUNT(o.order_date) as total_order
FROM Orders o
GROUP BY o.order_date
ORDER BY o.order_date ASC;

SELECT o.order_date, SUM(o.total_amount) AS total_amount
FROM Orders o
GROUP BY o.order_date
HAVING total_amount > 1800000
ORDER BY o.order_date ASC;

