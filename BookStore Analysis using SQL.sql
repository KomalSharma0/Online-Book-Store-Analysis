--------------------------------------Online Book Store Analysis--------------------------------

---------- Create Tables -----------
create table Books(
Book_ID int primary key,
Title varchar(100),
Author varchar(100),
Genre varchar(50),
Published_Year int, 
Price numeric(10, 2),
Stock int
);


create table Customers(
Customer_ID int primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(15),
City varchar(100),
Country varchar(150)
);


create table Orders(
Order_ID int primary key,
Customer_ID int references Customers(Customer_ID),
Book_ID int references Books(Book_ID),
Order_Date date,
Quantity int,
Total_Amount numeric(10, 2)
);


select * from Books;
select * from Customers;
select * from Orders;


--- Import data into 'Books', 'Customers', and 'Orders' Table

--- Check for missing Data
select * 
from Books
where Price is null 
or Stock is null;


select * 
from Customers 
where email is null;


---------------------------  BASIC QUERIES  -------------------------------

-- 1.) Retrieve all books in the "Fiction" genre.
select * from Books
	where genre = 'Fiction';


-- 2.) Find books published after the year 1950.
select * from books
	where published_year > 1950;


-- 3.) List all customers from the Canada.
select * from customers
	where country = 'Canada';


-- 4.) Show orders placed in Nov 2023.
select * from orders
	where order_date between '2023-11-01' and '2023-11-30'; 


-- 5.) Retrieve the total stock of books available.
select sum(stock) as Total_Stock
	from books;


-- 6.) Find the details of the most expensive book.
select * from books
	order by price desc
	limit 1;


-- 7.) Show all customers who ordered more than 1 quantity of a book.
select * from orders
	where quantity > 1;


-- 8.) Retrieve all orders where the total amount exceeds $20.
select * from orders
	where total_amount > 20;


-- 9.) List all genres available in the Books table.
select distinct(genre)
	from books;


-- 10.) Find the book with the lowest stock.
select * from books
	order by stock asc
	limit 1;


-- 11.) Calculate the total revenue generated from all orders.
select sum(total_amount) as Total_Revenue
	from orders;




---------------------------  Advanced QUERIES  -------------------------------

-- 1.) Retrieve the total number of books sold for each genre.
select *  from orders;
select *  from books;

select sum(o.quantity) as total_qty, b.genre 
from orders o
join books b
on o.book_id = b.book_id
group by b.genre;
	

-- 2.) Find the average price of books in the "Fantasy" genre.
select *  from books;

select avg(price) as avg_price 
from books
where genre = 'Fantasy';


-- 3.) List customers who have placed at least 2 orders.
select *  from orders;
select *  from customers;

select c.customer_id, c.name, count(o.order_id) from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id
having count(o.order_id) >= 2;


-- 4.) Find the most frequently ordered book.
select *  from orders;
select *  from books;

select o.book_id, b.title, count(o.order_id) as order_count
from orders o
join books b
on o.book_id = b.book_id
group by o.book_id, b.title
order by count(o.order_id) desc
limit 1;


-- 5.) Show the Top 3 most expensive books of "Fantasy" genre.
select *  from books;

select * from books
where genre = 'Fantasy'
order by price desc
limit 3;


-- 6.) Retrieve the total quantity of books sold by each author.
select *  from orders;
select *  from books;

select b.author, sum(o.quantity) as Total_books_sold
from orders o
join books b
on o.book_id = b.book_id
group by b.author;


-- 7.) List the cities where customers who spent over $30 are located.
select *  from orders;
select *  from customers;

select c.city, o.total_amount as Total_spent
from orders o
join customers c
on o.customer_id = c.customer_id
where o.total_amount > 30;


-- 8.) Find the customer who spent the most on orders.
select *  from orders;
select *  from customers;

select c.customer_id, c.name, sum(o.total_amount) as Total_spent
from orders o
join customers c
on o.customer_id = c.customer_id
group by c.customer_id, c.name
order by Total_spent desc
limit 1;


-- 9.) Calculate the stock remaining after fulfilling all orders. 
select *  from orders;
select *  from books;

select b.book_id, b.title, b.stock  as Initial_Stock,
	coalesce(sum(o.quantity),0) as Ordered_Stock,
	b.stock - coalesce(sum(o.quantity),0) as Remaining_Stock
from books b
left join orders o
on b.book_id = o.book_id
group by b.book_id
order by b.book_id;



------------------------------------------------ The End ------------------------------------------------------






