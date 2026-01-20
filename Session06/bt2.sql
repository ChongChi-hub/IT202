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

SELECT c.customer_id, c.full_name, SUM(o.total_amount) as total_spent FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY customer_id, full_name;

SELECT c.customer_id, c.full_name, MAX(o.total_amount) as highest_order FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

SELECT c.customer_id, c.full_name, SUM(o.total_amount) as total_spent FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY customer_id, full_name
ORDER BY total_spent DESC;

