DROP DATABASE ss05;
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

INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2025-01-01', 'completed'),
(1, '2025-01-03', 'pending'),
(3, '2025-01-05', 'completed'),
(4, '2025-01-07', 'cancelled'),
(5, '2025-01-10', 'pending');

SELECT c.full_name, o.order_id, o.order_date, o.status FROM Orders o
JOIN Customers c  
ON c.customer_id = o.customer_id;

SELECT c.customer_id, c.customer_name, COUNT(o.order_id) as total_order FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT c.customer_id, c.customer_name, COUNT(o.order_id) as total_order FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING total_order > 1;