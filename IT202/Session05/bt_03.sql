create table products (
	product_id int,
    product_name varchar(255),
    price decimal (10,2),
    stock int, 
    status enum ('active', 'inactive')
);

select * from products;

insert into products (product_id, product_name, price, stock, status)
values 
	(1, 'Tủ lạnh', '4000000', 10, 'inactive'),
    (2, 'Máy lạnh', '20000', 20, 'active'),
    (3, 'Máy giặt', '3000000', 30, 'inactive'),
    (4, 'Máy rửa bát', '10000', 40, 'active'),
    (5, 'Bếp gas', '2000000', 50, 'inactive');
    
select * from products
where status = 'active';

select * from products
where price > 1000000;

select * from products
where status = 'active' 
order by price asc;

create table customers (
	customer_id int,
    full_name varchar(255),
    email varchar(255),
    city varchar(255),
    status enum ('active','inactive')
);

insert into customers (customer_id, full_name, email, city, status)
values 
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

create table orders (
	order_id int,
    customer_id int,
    total_amount decimal (10,2),
    order_date date,
    status enum ('pending','completed','cancelled')
);

insert into orders (order_id, customer_id, total_amount, order_date, status)
values 
    (1, 1, 6000000, '2023-10-01', 'completed'),
    (2, 2, 4000000, '2023-10-02', 'pending'),
    (3, 3, 8000000, '2023-10-03', 'completed'),
    (4, 4, 1000000, '2023-10-04', 'cancelled'),
    (5, 5, 2000000, '2023-10-05', 'completed'),
    (6, 1, 7000000, '2023-10-06', 'pending');
    
select * from orders 
where status = 'completed' ;

select * from orders 
where total_amount > 5000000;

select * from orders
order by order_date desc
limit 5;

select * from orders
where status = 'completed'
order by total_amount desc;



