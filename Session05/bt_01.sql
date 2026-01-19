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