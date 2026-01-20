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

CREATE TABLE Products (
	product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255),
    price DECIMAL(10,2)
);

CREATE TABLE Order_items (
	order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders (order_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id)
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

INSERT INTO Products (product_name, price) VALUES
('Laptop Dell', 15000000.00),
('Chuột Logitech', 500000.00),
('Bàn phím cơ', 1200000.00),
('Tai nghe Sony', 2000000.00),
('Màn hình LG 24 inch', 4500000.00);

INSERT INTO Order_items (order_id, product_id, quantity) VALUES
(1, 1, 1), 
(1, 2, 1),  
(2, 2, 1),
(3, 3, 1),  
(3, 4, 1),  
(4, 4, 1),
(5, 5, 1);



SELECT p.product_id, p.product_name, COUNT(oi.product_id) as count_order
FROM Products p
JOIN Order_items oi
ON p.product_id = oi.product_id 
GROUP BY p.product_id, p.product_name;

SELECT p.product_id, p.product_name, SUM(o.total_amount) as total_amount
FROM Products p
JOIN Order_items oi
ON p.product_id = oi.product_id
JOIN Orders o
ON oi.order_id = o.order_id 
GROUP BY p.product_id, p.product_name;

SELECT p.product_id, p.product_name, SUM(o.total_amount) as total_amount
FROM Products p
JOIN Order_items oi
ON p.product_id = oi.product_id
JOIN Orders o
ON oi.order_id = o.order_id 
GROUP BY p.product_id, p.product_name
HAVING total_amount > 5000000

