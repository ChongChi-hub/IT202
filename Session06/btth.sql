/* =========================================================
   FILE SQL: ecommerce_practice.sql
   MÔN HỌC : CƠ SỞ DỮ LIỆU / SQL
   CHỦ ĐỀ  : JOIN – AGGREGATE – GROUP BY – HAVING
   MÔ TẢ   : CSDL mẫu hệ thống thương mại điện tử (eCommerce)
   ========================================================= */


/* =========================================================
   1. TẠO CƠ SỞ DỮ LIỆU
   ========================================================= */

CREATE DATABASE ecommerce_db;
USE ecommerce_db;


/* =========================================================
   2. TẠO BẢNG KHÁCH HÀNG
   ========================================================= */

CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,        -- Mã khách hàng
    customer_name VARCHAR(100),            -- Tên khách hàng
    email         VARCHAR(100),            -- Email
    city          VARCHAR(50)               -- Thành phố
);


/* =========================================================
   3. TẠO BẢNG SẢN PHẨM
   ========================================================= */

CREATE TABLE products (
    product_id   INT PRIMARY KEY,          -- Mã sản phẩm
    product_name VARCHAR(100),              -- Tên sản phẩm
    price        DECIMAL(12,2),              -- Giá bán
    category     VARCHAR(50)                -- Loại sản phẩm
);


/* =========================================================
   4. TẠO BẢNG ĐƠN HÀNG
   ========================================================= */

CREATE TABLE orders (
    order_id    INT PRIMARY KEY,            -- Mã đơn hàng
    customer_id INT,                        -- Khách hàng đặt
    order_date  DATE,                       -- Ngày đặt hàng
    status      VARCHAR(30),                -- Trạng thái đơn
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


/* =========================================================
   5. TẠO BẢNG CHI TIẾT ĐƠN HÀNG
   ========================================================= */

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,          -- Mã chi tiết đơn
    order_id      INT,                      -- Mã đơn hàng
    product_id    INT,                      -- Mã sản phẩm
    quantity      INT,                      -- Số lượng
    unit_price    DECIMAL(12,2),             -- Giá bán tại thời điểm đặt
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


/* =========================================================
   6. DỮ LIỆU MẪU - KHÁCH HÀNG
   ========================================================= */

INSERT INTO customers VALUES
(1, 'Nguyen Van An',  'an@gmail.com',   'Ha Noi'),
(2, 'Tran Thi Binh',  'binh@gmail.com', 'Da Nang'),
(3, 'Le Van Cuong',   'cuong@gmail.com','Ho Chi Minh'),
(4, 'Pham Thi Dao',   'dao@gmail.com',  'Ha Noi'),
(5, 'Hoang Van Em',   'em@gmail.com',   'Can Tho'),
(6, 'Do Minh Giang',  'giang@gmail.com', 'Ha Noi'),
(7, 'Vu Thi Hoa',    'hoa@gmail.com',   'Da Nang'),
(8, 'Nguyen Duc Hung','hung@gmail.com', 'Ho Chi Minh'),
(9, 'Tran Van Khoa', 'khoa@gmail.com',  'Ha Noi'),
(10,'Le Thi Lan',    'lan@gmail.com',   'Can Tho');


/* =========================================================
   7. DỮ LIỆU MẪU - SẢN PHẨM
   ========================================================= */

INSERT INTO products VALUES
(1, 'Laptop Dell',          20000000, 'Electronics'),
(2, 'iPhone 15',            25000000, 'Electronics'),
(3, 'Tai nghe Bluetooth',    1500000, 'Accessories'),
(4, 'Chuột không dây',        500000, 'Accessories'),
(5, 'Bàn phím cơ',           2000000, 'Accessories'),
(6, 'Màn hình LG 27 inch',  7000000,  'Electronics'),
(7, 'SSD Samsung 1TB',     3500000,  'Electronics'),
(8, 'Webcam Logitech',     2500000,  'Accessories'),
(9, 'Tai nghe Gaming',     1800000,  'Accessories'),
(10,'Chuột Gaming RGB',     900000,  'Accessories');

/* =========================================================
   8. DỮ LIỆU MẪU - ĐƠN HÀNG
   ========================================================= */

INSERT INTO orders VALUES
(101, 1, '2025-01-05', 'Completed'),
(102, 2, '2025-01-06', 'Completed'),
(103, 3, '2025-01-07', 'Completed'),
(104, 1, '2025-01-08', 'Completed'),
(105, 4, '2025-01-09', 'Completed'),
(106, 5, '2025-01-10', 'Completed'),
(107, 2, '2025-01-11', 'Completed'),
(108, 3, '2025-01-12', 'Completed'),
(109, 6, '2025-01-13', 'Completed'),
(110, 7, '2025-01-14', 'Completed'),
(111, 8, '2025-01-15', 'Completed'),
(112, 9, '2025-01-16', 'Completed'),
(113, 10,'2025-01-17', 'Completed'),
(114, 1, '2025-01-18', 'Completed'),
(115, 1, '2025-01-19', 'Completed'),
(116, 2, '2025-01-20', 'Completed');


/* =========================================================
   9. DỮ LIỆU MẪU - CHI TIẾT ĐƠN HÀNG
   ========================================================= */

INSERT INTO order_items VALUES
-- Đơn 101
(1, 101, 1, 1, 20000000),
(2, 101, 3, 2, 1500000),

-- Đơn 102
(3, 102, 2, 1, 25000000),
(4, 102, 4, 1, 500000),

-- Đơn 103
(5, 103, 5, 2, 2000000),
(6, 103, 3, 1, 1500000),

-- Đơn 104
(7, 104, 1, 1, 20000000),
(8, 104, 5, 1, 2000000),

-- Đơn 105
(9, 105, 4, 3, 500000),

-- Đơn 106
(10, 106, 3, 5, 1500000),

-- Đơn 107
(11, 107, 2, 1, 25000000),
(12, 107, 3, 2, 1500000),

-- Đơn 108
(13, 108, 1, 1, 20000000),
(14, 108, 4, 2, 500000),
(15, 109, 3, 30, 1500000),
(16, 109, 4, 20, 500000),

-- Đơn 110
(17, 110, 3, 25, 1500000),
(18, 110, 10, 15, 900000),

-- Đơn 111
(19, 111, 3, 40, 1500000),
(20, 111, 9, 20, 1800000),

-- Đơn 112
(21, 112, 4, 50, 500000),

-- Đơn 113
(22, 113, 5, 35, 2000000),

-- Đơn 114
(23, 114, 1, 2, 20000000),
(24, 114, 7, 3, 3500000),

-- Đơn 115
(25, 115, 2, 1, 25000000),
(26, 115, 6, 2, 7000000),

-- Đơn 116
(27, 116, 3, 20, 1500000),
(28, 116, 8, 10, 2500000);



/* =========================================================
   10. KIỂM TRA NHANH DỮ LIỆU (OPTIONAL)
   ========================================================= */

-- Kiểm tra số lượng bản ghi
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_products  FROM products;
SELECT COUNT(*) AS total_orders    FROM orders;
SELECT COUNT(*) AS total_items     FROM order_items;

/* =========================================================
   KẾT THÚC FILE SQL
   ========================================================= */
   
SELECT o.order_id, c.customer_id , c.customer_name FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT o.order_id, p.product_name, oi.quantity FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p 
    ON oi.product_id = p.product_id
order by order_id asc;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT SUM(quantity * unit_price)  total_revenue
FROM order_items;

-- 5  Cho biết tổng tiền của mỗi đơn hàng.
SELECT 
    orders.order_id AS id_don_hang,
    SUM(order_items.quantity * order_items.unit_price) AS tong_tien
FROM orders
INNER JOIN order_items 
    ON orders.order_id = order_items.order_id
INNER JOIN products 
    ON products.product_id = order_items.product_id
GROUP BY orders.order_id
ORDER BY orders.order_id;

-- 6  Cho biết tổng số tiền mà mỗi khách hàng đã chi tiêu.
select
	customers.customer_id as ma_khach_hang,
	customers.customer_name as ten_khach_hang,
	SUM(order_items.quantity * order_items.unit_price) as Tong_tien
from customers 
inner join orders on customers.customer_id = orders.customer_id
inner join order_items on order_items.order_id = orders.order_id
group by customers.customer_id, customers.customer_name;

-- Câu 7:  Tính doanh thu theo từng sản phẩm.

SELECT
    products.product_id,
    products.product_name,
    SUM(order_items.quantity * order_items.unit_price) AS product_revenue
FROM products
LEFT JOIN order_items ON products.product_id = order_items.product_id
GROUP BY products.product_id, products.product_name;


-- Câu 8:  Liệt kê các khách hàng có tổng chi tiêu lớn hơn 5.000.000.

SELECT
    customers.customer_id,
    customers.customer_name,
    SUM(order_items.quantity * order_items.unit_price) as spent
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
LEFT JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY customers.customer_id, customers.customer_name
HAVING spent > 5000000;

-- Câu 9
SELECT p.product_id, p.product_name, SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) > 100
ORDER BY total_quantity_sold DESC;

-- Câu 10
SELECT c.city, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING COUNT(o.order_id) > 5
ORDER BY total_orders DESC;




