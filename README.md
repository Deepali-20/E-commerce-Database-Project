# E-commerce-Database-Project
A complete SQL-based E-commerce Database Project demonstrating database creation, table relationships, data insertion, and multi-level SQL queries — from basic SELECT to advanced concepts like views, subqueries, and indexes.
📘 Project Overview



This project simulates a small e-commerce system containing customers, products, orders, and order items.
It includes:

Database and table creation scripts
Sample data insertion
Basic, Intermediate, and Advanced SQL queries
Demonstrations of JOINs, GROUP BY, subqueries, views, and indexing
🧩 Database Schema
Tables
customers — stores customer information
products — contains product details
orders — represents customer orders
order_items — links orders with specific products
Relationships
Each customer can have multiple orders
Each order can include multiple order items
Each order item corresponds to one product
⚙️ Setup Instructions

Create and use the database

CREATE DATABASE ecommerce_db;
USE ecommerce_db;


Run the provided SQL script to create tables and insert sample data.

Execute the queries section by section (Easy → Medium → Advanced) to explore different SQL features.

📊 Sample Data Highlights
Table	Example Columns	Example Row
customers	customer_id, customer_name, city, state	1, John Smith, Delhi, Delhi
products	product_id, product_name, category, price	102, Laptop, Electronics, 55000
orders	order_id, customer_id, order_date, total_amount	1001, 1, 2024-06-10, 17500
order_items	order_item_id, order_id, product_id, quantity, price	1, 1001, 101, 1, 15000
🧠 Query Sections
🟢 Easy Level Queries



Covers basic SQL operations like:

SELECT, WHERE, ORDER BY, LIKE
Filtering, sorting, and counting records



Example:

SELECT product_name, price 
FROM products 
ORDER BY price DESC;

🟡 Medium Level Queries



Focus on aggregation, joins, and grouping:

SUM, AVG, COUNT, GROUP BY, HAVING
Inner and left joins
Customer and product-level analysis



Example:

SELECT c.customer_name, SUM(o.total_amount) AS total_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

🔵 Advanced Level Queries



Introduces:

Subqueries
Views
Indexes
Analytical Queries



Example View:

CREATE VIEW category_sales_summary AS
SELECT 
    p.category,
    AVG(p.price) AS avg_price,
    SUM(o.quantity * o.price) AS total_sales
FROM products p
JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.category;




Example Index:

CREATE INDEX idx_customer_id ON orders(customer_id);

📈 Key Analytical Queries
Task	Query Description
Top 3 customers	Highest total spending using LIMIT 3
Product performance	Highest total sales value
Monthly insights	Month-wise total orders & revenue
Customer behavior	Who bought “Laptop” (via subquery)
Optimization	Index creation for faster joins
⚡ Performance Insight



After creating the index on orders(customer_id):

Planning time slightly increases (optimizer evaluates index usage)
Execution time significantly decreases (faster lookups & joins)



✅ This demonstrates the trade-off between planning cost and execution efficiency.

📂 Project Structure
📦 ecommerce-database-project
 ┣ 📜 ecommerce_db.sql        # Full SQL script (tables, data, queries)
 ┣ 📘 README.md               # Project documentation
 ┗ 🧩 sample_outputs/         # (Optional) screenshots or query results
