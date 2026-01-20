create database w3join;
use w3join;

create table customers (
	CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    ContactName VARCHAR(255),
    Country VARCHAR(50)
);

create table orders (
	OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID)
);

INSERT INTO customers (CustomerID, CustomerName, ContactName, Country)
VALUES 
(1, 'Alfreds Futterkiste', 'Maria Anders', 'Germany'),
(2, 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Mexico'),
(3, 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mexico');

INSERT INTO orders (OrderID, CustomerID, OrderDate)
VALUES 
(10308, 2, '1996-09-18'),
(10309, 1, '1996-09-19'),
(10310, 3, '1996-09-20');

select customers.CustomerID, CustomerName, ContactName, Country, OrderID, OrderDate
from customers 
inner join orders on orders.CustomerID = customers.CustomerID;


select customers.CustomerID, CustomerName, ContactName, Country, OrderID, OrderDate
from customers 
left join orders on orders.CustomerID = customers.CustomerID;


select customers.CustomerID, CustomerName, ContactName, Country, OrderID, OrderDate
from customers 
right join orders on orders.CustomerID = customers.CustomerID;

-- select *

-- from table chứa khoá chính

-- [loại join] bảng chứa khoá phụ on bảng chứa khoá phụ.khoá phụ = bảng chứa khoá chính.khoá chính