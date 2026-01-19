create table customers (
	customer_id int,
    full_name varchar(255),
    email varchar(255),
    city varchar(255),
    status enum ('active','inactive')
);

INSERT INTO customers (customer_id, full_name, email, city, status)
VALUES 
    (1, 'Nguyễn Văn Anh', 'vananh.nguyen@gmail.com', 'Hà Nội', 'active'),
    (2, 'Trần Thị Mai', 'maitran@yahoo.com', 'Đà Nẵng', 'active'),
    (3, 'Lê Minh Tùng', 'tung.le@outlook.com', 'TP. Hồ Chí Minh', 'inactive'),
    (4, 'Phạm Hoàng Yến', 'yenpham88@gmail.com', 'Cần Thơ', 'active'),
    (5, 'Đặng Quốc Bảo', 'baodang@fpt.com.vn', 'Hải Phòng', 'inactive');

select * from customers;

select * from customers
where city = 'TP. Hồ Chí Minh';

select * from customers
where status = 'active' and city = 'Hà Nội';

select * from customers
order by full_name asc;