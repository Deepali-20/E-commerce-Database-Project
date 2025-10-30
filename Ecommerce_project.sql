-- =========================================
-- ECOMMERCE DATABASE CREATION SCRIPT
-- =========================================

-- 1. Create Database
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- 2. Create Tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30),
    state VARCHAR(30),
    email VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 3. Insert Sample Data into customers
INSERT INTO customers VALUES
(1, 'John Smith', 'Delhi', 'Delhi', 'john.smith@email.com'),
(2, 'Priya Patel', 'Mumbai', 'Maharashtra', 'priya.patel@email.com'),
(3, 'Amit Sharma', 'Bangalore', 'Karnataka', 'amit.sharma@email.com'),
(4, 'Sara Khan', 'Hyderabad', 'Telangana', 'sara.khan@email.com'),
(5, 'David Brown', 'Chennai', 'Tamil Nadu', 'david.brown@email.com');

-- 4. Insert Sample Data into products
INSERT INTO products VALUES
(101, 'Smartphone', 'Electronics', 15000.00),
(102, 'Laptop', 'Electronics', 55000.00),
(103, 'Headphones', 'Accessories', 2500.00),
(104, 'Smartwatch', 'Accessories', 8000.00),
(105, 'Tablet', 'Electronics', 22000.00);

-- 5. Insert Sample Data into orders
INSERT INTO orders VALUES
(1001, 1, '2024-06-10', 17500.00),
(1002, 2, '2024-06-11', 57500.00),
(1003, 3, '2024-06-13', 27000.00),
(1004, 4, '2024-06-14', 9000.00),
(1005, 5, '2024-06-15', 55000.00);

-- 6. Insert Sample Data into order_items
INSERT INTO order_items VALUES
(1, 1001, 101, 1, 15000.00),
(2, 1001, 103, 1, 2500.00),
(3, 1002, 102, 1, 55000.00),
(4, 1002, 104, 1, 2500.00),
(5, 1003, 105, 1, 22000.00),
(6, 1003, 103, 2, 5000.00),
(7, 1004, 104, 1, 8000.00),
(8, 1005, 102, 1, 55000.00);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

------ Queries to solve from this table------------

/*EASY LEVEL QUERIES (Basics: SELECT, WHERE, ORDER BY)

List all customer names and their cities.

Display all product names and their prices sorted from highest to lowest.

Show all orders placed after June 12, 2024.

Retrieve customer details who are from the city “Mumbai”.

Display all products that cost more than ₹10,000.

List the total number of customers in the database.

Show product details where category is “Electronics”.

Display all orders where total amount is between ₹10,000 and ₹30,000.

Retrieve the names of products that start with the letter “S”.

List all customers in alphabetical order by name. */
----1.List all customer names and their cities.
SELECT DISTINCT(customer_name),city FROM customers;
--2.Display all product names and their prices sorted from highest to lowest.

SELECT product_name , price FROM products ORDER BY price DESC;
---- 3.Show all orders placed after June 12, 2024.
SELECT * FROM orders WHERE order_date>' 2024-06-12';
----4.Retrieve customer details who are from the city “Mumbai”.
SELECT * FROM customers WHERE city = 'Mumbai';
----5.Display all products that cost more than ₹10,000.
SELECT * FROM products WHERE price > 10000;
----6.List the total number of customers in the database.
SELECT COUNT(*) total_customers FROM customers;
---7.Show product details where category is “Electronics”.
SELECT * FROM products WHERE category = 'Electronics';
---8.Display all orders where total amount is between ₹10,000 and ₹30,000.
SELECT * FROM orders WHERE total_amount BETWEEN 10000 AND 30000;
---9.Retrieve the names of products that start with the letter “S”.
SELECT * from products WHERE product_name  LIKE 'S%';
---List all customers in alphabetical order by name.
SELECT * FROM customers ORDER BY customer_name ;

------------------------------------------------
----    Medium level question  ----
------------------------------------------------
/*
Find the total sales amount from all orders.

Show the average product price for each category.

Display total sales per customer (use a JOIN between customers and orders).

Find the number of orders placed by each customer.

List all customers who have placed more than one order.

Retrieve the total quantity sold for each product (use JOIN between order_items and products).

Display category-wise total revenue from all order items.

Show each customer’s highest order value.

Display all customers and their orders, even if a customer has no orders (use LEFT JOIN).

Show all orders with their customer names and order dates (INNER JOIN).

*/
---1.Find the total sales amount from all orders.
SELECT sum(total_amount) AS total_sale FROM orders;
---2.Show the average product price for each category.
SELECT category , AVG(price) from products GROUP BY category;
--3.Display total sales per customer (use a JOIN between customers and orders).
SELECT c.customer_name , SUM (o.total_amount) as Total_sum
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
--Find the number of orders placed by each customer.

SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o 
  ON c.customer_id = o.customer_id
GROUP BY c.customer_name;



----4.List all customers who have placed more than one order.
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o 
  ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1;
----5.Retrieve the total quantity sold for each product ]
--(use JOIN between order_items and products).
SELECT SUM(o.quantity) AS total_order,p.product_name
FROM products p
join order_items o
ON p.product_id = o.product_id
GROUP BY 2;
---6.Display category-wise total revenue from all order items.
SELECT * FROM products;
SELECT * FROM order_items;
SELECT p.category, SUM(o.quantity * o.price) AS total_reveneue
FROM products p
JOIN order_items o
ON p.product_id = o.product_id
GROUP BY 1;
---7.Show each customer’s highest order value(amount).
SELECT c.customer_name, MAX(o.total_amount) 
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY 1;
---8.Display all customers and their orders, even if a customer has no orders (use LEFT JOIN).
SELECT * FROM
customers c
LEFT JOIN 
orders o
ON c.customer_id = o.customer_id;
--9.Show all orders with their customer names and order dates (INNER JOIN).
SELECT c.customer_name,o.order_id ,o.order_date
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;


/*
ADVANCED LEVEL QUERIES (Subqueries, Views, Indexes)

Find customers who spent more than the average order amount (use subquery).

Display products that have been ordered more than once (use subquery).

Retrieve the most expensive product(s) in each category.

Create a view named category_sales_summary that shows category, total sales, and average price.

Create a view to show monthly total sales (month, total_sales).

Display the top 3 customers by total spending (use LIMIT).

Find the product with the highest total sales value.

Write a subquery to display customers who have purchased “Laptop”.

Create an index on the orders(customer_id) column and explain why it’s useful.

Retrieve the month-wise total orders and revenue, sorted by month.
*/

--1.Find customers who spent more than the average order amount (use subquery).
SELECT c.customer_name,o.order_id,o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE total_amount>(SELECT AVG(total_amount) FROM orders);
---2.Retrieve the most expensive product(s) in each category.
SELECT P.category, P.product_name, P.price
FROM products P
WHERE
P.price = (SELECT MAX(price) FROM products
WHERE category = P.category)
;

---- other methods
SELECT category, product_name, price
FROM (
    SELECT 
        category,
        product_name,
        price,
        RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank_num
    FROM products
) ranked
WHERE rank_num = 1;

----4.Create a view named category_sales_summary that shows category, total sales, and average price.
CREATE VIEW  category_sales_summary AS
	SELECT P.category,AVG(p.price),SUM(o.quantity * o.price)
	FROM products P
	JOIN order_items o
	ON P.product_id = o.product_id
	GROUP BY 1;
SELECT * FROM category_sales_summary;
----5.Create a view to show monthly total sales (month, total_sales).
CREATE VIEW monthlys AS
SELECT SUM(oi. quantity * oi.price),
EXTRACT(Month FROM O.order_date) AS month_name
FROM order_items oi
JOIN orders o
ON oi.order_id = o.order_id
GROUP BY 2;
SELECT * FROM monthlys;
---6.Display the top 3 customers by total spending (use LIMIT).
SELECT c.customer_name,SUM(o.total_amount) AS TOTAL_SPENDING
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

---7.Find the product with the highest total sales value.
SELECT p.product_name,SUM(o.quantity * o.price) AS total_sale
FROM products p
JOIN order_items o
ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY 2 DESC
LIMIT 1;
SELECT * from products;
---8.Write a subquery to display customers who have purchased “Laptop”.

SELECT DISTINCT c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.product_name = 'Laptop';
---9.Create an index on the orders(customer_id) column and explain why it’s useful.
EXPLAIN ANALYZE
SELECT *
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
--- INDEX CREATION
CREATE INDEX idx_customer_id on orders(customer_id);
DROP INDEX idx_customer_id;

--10.Retrieve the month-wise total orders and revenue, sorted by month.
SELECT 
    TO_CHAR(o.order_date, 'Month') AS month_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue
FROM 
    orders o
GROUP BY 
    TO_CHAR(o.order_date, 'Month')
ORDER BY 
    TO_CHAR(o.order_date, 'Month');
