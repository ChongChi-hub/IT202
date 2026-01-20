CREATE DATABASE ss07;
USE ss07;
CREATE TABLE Customers(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE Orders (
	id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE DEFAULT(CURRENT_DATE),
	FOREIGN KEY (customer_id) REFERENCES Customers(id),
    total_amount INT
);

INSERT INTO Customer (name, email) VALUES
('Nguyen Van A', 'a.nguyen@gmail.com'),
('Tran Thi B', 'b.tran@gmail.com'),
('Le Van C', 'c.le@gmail.com'),
('Pham Thi D', 'd.pham@gmail.com'),
('Hoang Van E', 'e.hoang@gmail.com'),
('Do Thi F', 'f.do@gmail.com'),
('Vu Van G', 'g.vu@gmail.com'),
('Bui Thi H', 'h.bui@gmail.com'),
('Dang Van I', 'i.dang@gmail.com'),
('Phan Thi K', 'k.phan@gmail.com');

INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2025-01-01', 150000),
(2, '2025-01-02', 230000),
(3, '2025-01-03', 99000),
(4, '2025-01-04', 450000),
(5, '2025-01-05', 320000),
(6, '2025-01-06', 78000),
(7, '2025-01-07', 560000),
(8, '2025-01-08', 210000),
(9, '2025-01-09', 125000),
(10,'2025-01-10', 670000);

SELECT *
FROM Customers
WHERE id = (
	SELECT customer_id
    FROM (
		SELECT customer_id, SUM(total_amount) AS TongTien_outer
        FROM Orders
        GROUP BY customer_id
    ) T1
    WHERE TongTien_outer = (
        SELECT MAX(TongTien_inner)
        FROM (
            SELECT customer_id, SUM(total_amount) AS TongTien_inner
            FROM Orders
            GROUP BY customer_id
        ) T2
    )
);



