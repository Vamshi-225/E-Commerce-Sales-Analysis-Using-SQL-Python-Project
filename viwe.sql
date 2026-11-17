Create Database Shop;
use shop;
create table customers_shop(
customer_id int,
name varchar(50),
city varchar(50)
);

INSERT INTO Customers_Shop VALUES
(1, 'Vamshi', 'Hyderabad'),
(2, 'Rahul', 'Chennai'),
(3, 'Priya', 'Bangalore'),
(4, 'Kiran', 'Hyderabad');
select * From Customers_Shop;
-- Adding Primary Key to The Cust_id 
alter table customers_shop
add Constraint primary key(customer_id);
-- Adding age Column to the Table 
alter table customers_shop
add column age int;

-- creating the store procedure to enter age 
delimiter $$
create procedure enter_age(in e_age int,cust_id int)
begin
update Customers_Shop
set age = e_age
where Customer_id = cust_id;
end $$
delimiter ;
call enter_age(22,1);
call enter_age(23,2);
call enter_age(24,3);
call enter_age(25,4);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    foreign key orders(customer_id) references customers_shop(customer_id));
    
INSERT INTO Orders VALUES
(101, 1, '2026-01-10', 5000),
(102, 1, '2026-01-12', 3000),
(103, 2, '2026-01-15', 7000),
(104, 3, '2026-01-18', 2000),
(105, 4, '2026-01-20', 9000),

(106, 2, '2026-01-21', 4500),
(107, 3, '2026-01-22', 8000),
(108, 4, '2026-01-23', 1200),
(109, 1, '2026-01-24', 6500),
(110, 2, '2026-01-25', 7000),

(111, 3, '2026-01-26', 3000),
(112, 4, '2026-01-27', 9500),
(113, 1, '2026-01-28', 4000),
(114, 2, '2026-01-29', 5000),
(115, 3, '2026-01-30', 6000),

(116, 4, '2026-02-01', 11000),
(117, 1, '2026-02-02', 7500),
(118, 2, '2026-02-03', 8200),
(119, 3, '2026-02-04', 3100),
(120, 4, '2026-02-05', 9900),

(121, 1, '2026-02-06', 4300),
(122, 2, '2026-02-07', 6700),
(123, 3, '2026-02-08', 5400),
(124, 4, '2026-02-09', 8800),
(125, 1, '2026-02-10', 9200),

(126, 2, '2026-02-11', 3600),
(127, 3, '2026-02-12', 4700),
(128, 4, '2026-02-13', 5300),
(129, 1, '2026-02-14', 6100),
(130, 2, '2026-02-15', 7800),

(131, 3, '2026-02-16', 8400),
(132, 4, '2026-02-17', 2900),
(133, 1, '2026-02-18', 9900),
(134, 2, '2026-02-19', 1500),
(135, 3, '2026-02-20', 7600),

(136, 4, '2026-02-21', 8100),
(137, 1, '2026-02-22', 4200),
(138, 2, '2026-02-23', 3300),
(139, 3, '2026-02-24', 5700),
(140, 4, '2026-02-25', 6800),

(141, 1, '2026-02-26', 9100),
(142, 2, '2026-02-27', 2500),
(143, 3, '2026-02-28', 6400),
(144, 4, '2026-03-01', 8700),
(145, 1, '2026-03-02', 3900),

(146, 2, '2026-03-03', 7200),
(147, 3, '2026-03-04', 5600),
(148, 4, '2026-03-05', 9400),
(149, 1, '2026-03-06', 4600),
(150, 2, '2026-03-07', 8300);

select * From orders;

-- views 
-- 1.customer view
create view customer_view as
select customer_id,name,city
from customers_shop;

select * from customer_view;

-- 2.order_view
create view order_view as 
select order_id,customer_id,order_date,amount
from orders;
select * from order_view;

-- 3. customer order view
create view customer_order_view as 
select cs.name,cs.city,o.order_id,o.order_date,o.amount
from customers_shop as cs
join orders as o
on cs.customer_id = o.customer_id;
select * from customer_order_view;

-- 4.Hyderabad Customers Orders
create view Hyderabad_Customers_Orders as
select * 
from customer_order_view 
where city="Hyderabad";

select count(order_id) from Hyderabad_Customers_Orders;

-- 5.High Value Orders View
create view High_Value_Orders_View as
select name,order_id,amount
from customer_order_view
where amount>7000;

select * from High_Value_Orders_View;

-- 6.Total Spending per Customer 
create view Total_Spending_per_Customer as
select name,sum(amount) as total_amount_spend
from High_Value_Orders_View
group by name
order by total_amount_spend desc;

select * from Total_Spending_per_Customer;

-- 7.Order Count per Customer

create view Order_Count_per_Customer as 
select name,count(order_id) as Order_count
from customer_order_view
group by name
order by  Order_count desc;

select * from Order_Count_per_Customer;

-- Monthly Sales View
create view Monthly_Sales_View as
select month(order_date) as Month,sum(amount) as Total_speding_in_a_month
from orders
group by Month
order by Total_speding_in_a_month desc;

select * from Monthly_Sales_View;

/*Create a view that shows:
all customers
even those who have NOT placed any order
order details if available*/

create view cust_ord_p_np as
select cs.name,o.order_id
from customers_shop as cs
left join orders as o
on cs.customer_id = o.customer_id
where o.order_id is null;

select * from cust_ord_p_np;







