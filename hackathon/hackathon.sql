DROP DATABASE IF EXISTS SalesManagement;
-- Tạo database SalesManagement --
CREATE DATABASE SalesManagement;
-- Dùng database SalesManagement --
USE SalesManagement;

-- Tạo bảng Customer --
CREATE TABLE Customer (
    customer_id VARCHAR(5) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL UNIQUE,
    customer_phone VARCHAR(15) NOT NULL UNIQUE,
    customer_address VARCHAR(255) NOT NULL,
    PRIMARY KEY (customer_id)
);

-- Tạo bảng Product --
CREATE TABLE Product (
    product_id INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    product_price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(20) NOT NULL,
    stock_quantity INT NOT NULL,
    PRIMARY KEY (product_id)
);

-- Tạo bảng Order --
CREATE TABLE `Order` (
    order_id INT NOT NULL AUTO_INCREMENT,
    customer_id VARCHAR(5) NOT NULL,
    product_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Tạo bảng Payment --
CREATE TABLE Payment (
    payment_id INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_date DATE NOT NULL,
    payment_status VARCHAR(50) NOT NULL,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
);

-- Thêm các bản ghi vào bảng Customer --
INSERT INTO Customer (customer_id, customer_name, customer_email, customer_phone, customer_address) VALUES
('C001', 'Nguyen Anh Tu', 'tu.nguyen@example.com', '0987654321', 'Hanoi'),
('C002', 'Tran Thi Mai', 'mai.tran@example.com', '0987654322', 'Ho Chi Minh'),
('C003', 'Le Minh Hoang', 'hoang.le@example.com', '0987654323', 'Danang'),
('C004', 'Pham Hoang Nam', 'nam.pham@example.com', '0987654324', 'Hue'),
('C005', 'Vu Minh Thu', 'thu.vu@example.com', '0987654325', 'Hai Phong');

-- Thêm các bản ghi vào bảng Product --
INSERT INTO Product (product_id, product_name, category, product_price, stock_quantity) VALUES
(1, 'Laptop Dell', 'Electronics', 15000.00, 10),
(2, 'iPhone 15', 'Electronics', 20000.00, 5),
(3, 'T-Shirt', 'Clothing', 200.00, 50),
(4, 'Running Shoes', 'Footwear', 1500.00, 20),
(5, 'Table Lamp', 'Furniture', 500.00, 15);

-- Thêm các bản ghi vào bảng Order --
INSERT INTO `Order` (order_id, customer_id, product_id, order_date, order_quantity, total_amount) VALUES
(1, 'C001', 1, '2025-06-01', 1, 15000.00),
(2, 'C002', 3, '2025-06-02', 2, 400.00),
(3, 'C003', 2, '2025-06-03', 1, 20000.00),
(4, 'C001', 4, '2025-06-03', 1, 1500.00),
(5, 'C005', 1, '2025-06-04', 2, 30000.00);


-- Thêm các bản ghi vào bảng Payment --
INSERT INTO Payment (payment_id, order_id, payment_date, payment_method, payment_status) VALUES
(1, 1, '2025-06-01', 'Banking', 'Paid'),
(2, 2, '2025-06-02', 'Cash', 'Paid'),
(3, 3, '2025-06-03', 'Credit Card', 'Paid'),
(4, 4, '2025-06-04', 'Banking', 'Pending'),
(5, 5, '2025-06-05', 'Credit Card', 'Paid');

-- Cập nhật thông tin khách hàng: thay đổi số điện thoại của khách hàng có customer_id = 'C001' thành "0999888777" --
UPDATE Customer
SET customer_phone = '0999888777'
WHERE customer_id = 'C001';

-- Thay đổi kho hàng: cập nhật stock_quantity tăng thêm 50 đơn vị và tăng product_price lên 10% của sản phẩm có ID là 3 --
UPDATE Product
SET stock_quantity = stock_quantity + 50,
    product_price = product_price * 1.10
WHERE product_id = 3;

-- Xóa tất cả các bản ghi trong bảng Payment có payment_status là "Pending" và phương thức thanh toán là "Banking" --
-- Sử dụng AND payment_id = 4 vì safe update mode --
DELETE FROM Payment
WHERE payment_status = 'Pending' AND payment_method = 'Banking' AND payment_id = 4;

-- Liệt kê danh sách sản phẩm gồm các cột: product_id, product_name, product_price thuộc danh mục 'Electronics' và có giá lớn hơn 10000 --
SELECT product_id, product_name, product_price
FROM Product
WHERE category = 'Electronics' AND product_price > 10000;

-- Lấy thông tin customer_name, customer_email, customer_address của những khách hàng có họ là 'Nguyen' --
SELECT customer_name, customer_email, customer_address
FROM Customer
WHERE customer_name LIKE 'Nguyen%';

-- Hiển thị danh sách tất cả các đơn hàng gồm: order_id, order_date, total_amount. Kết quả sắp xếp theo total_amount giảm dần --
SELECT order_id, order_date, total_amount
FROM `Order`
ORDER BY total_amount DESC;

-- Lấy thông tin 3 bản ghi thanh toán mới nhất theo payment_date trong bảng Payment --
SELECT *
FROM Payment
ORDER BY payment_date DESC
LIMIT 3;

-- Hiển thị thông tin các sản phẩm (product_id, product_name) từ bảng Product, bỏ qua 2 bản ghi đầu tiên và lấy 3 bản ghi tiếp theo --
SELECT product_id, product_name
FROM Product
LIMIT 3 OFFSET 2;


-- Hiển thị danh sách đơn hàng gồm: order_id, customer_name , product_name và total_amount. Chỉ lấy những đơn hàng có total_amount lớn hơn 1000 --
SELECT o.order_id, c.customer_name, p.product_name, o.total_amount
FROM `Order` o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Product p ON o.product_id = p.product_id
WHERE o.total_amount > 1000;

-- Liệt kê tất cả các sản phẩm trong hệ thống gồm: product_id, product_name và order_id tương ứng (nếu có). Kết quả bao gồm cả những sản phẩm chưa từng được đặt hàng --
SELECT p.product_id, p.product_name, o.order_id
FROM Product p
LEFT JOIN `Order` o ON p.product_id = o.product_id;

-- Tính tổng danh thu cho từng loại sản phẩm. Kết quả hiển thị 2 cột: category và Total_Revenue --
SELECT p.category, SUM(o.total_amount) AS Total_Revenue
FROM Product p
JOIN `Order` o ON p.product_id = o.product_id
GROUP BY p.category;

-- Thống kê số lượng đơn hàng của mỗi khách hàng. Hiển thị customer_name và Order_Count. Chỉ hiện những khách hàng đã đặt từ 2 đơn trở lên --
SELECT c.customer_name, COUNT(o.order_id) AS Order_Count
FROM Customer c
JOIN `Order` o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) >= 2;

-- Lấy thông tin chi tiết các đơn hàng (order_id, customer_name, rototal_amount) có giá trị đơn hàng cao hơn giá trị trung bình của tất cả các đơn hàng trong bảng Order --
SELECT order_id, customer_id, total_amount
FROM `Order`
WHERE total_amount > (SELECT AVG(total_amount) FROM `Order`);

-- Hiển thị customer_name và customer_phone của những khách hàng đã từng mua sản phẩm có danh mục là 'Electronics' --
SELECT DISTINCT c.customer_name, c.customer_phone
FROM Customer c
JOIN `Order` o ON c.customer_id = o.customer_id
JOIN Product p ON o.product_id = p.product_id
WHERE p.category = 'Electronics';

-- Hiển thị thông tin tổng hợp gồm: order_id, customer_name, product_name, payment_method và payment_status --
SELECT o.order_id, c.customer_name, p.product_name, py.payment_method, py.payment_status
FROM `Order` o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Product p ON o.product_id = p.product_id
JOIN Payment py ON o.order_id = py.order_id;