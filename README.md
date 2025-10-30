# 🛒 E-commerce Database Project

A complete **SQL-based E-commerce Database Project** demonstrating database creation, table relationships, data insertion, and multi-level SQL queries — from basic `SELECT` statements to advanced concepts like **views**, **subqueries**, and **indexes**.

---

## 📘 Project Overview

This project simulates a small **E-commerce system** containing customers, products, orders, and order items.

It includes:

* Database and table creation scripts
* Sample data insertion
* Basic, Intermediate, and Advanced SQL queries
* Demonstrations of `JOINs`, `GROUP BY`, subqueries, views, and indexing

---

## 🧩 Database Schema

### Tables

| Table Name    | Description                         |
| ------------- | ----------------------------------- |
| `customers`   | Stores customer information         |
| `products`    | Contains product details            |
| `orders`      | Represents customer orders          |
| `order_items` | Links orders with specific products |

### Relationships

* Each **customer** can have multiple **orders**
* Each **order** can include multiple **order items**
* Each **order item** corresponds to one **product**

---

## ⚙️ Setup Instructions

1. **Create and use the database:**

   ```sql
   CREATE DATABASE ecommerce_db;
   USE ecommerce_db;
   ```

2. **Run the provided SQL script** to create tables and insert sample data.

3. **Execute queries** section by section (Easy → Medium → Advanced) to explore SQL features.

---

## 📊 Sample Data Highlights

| Table         | Example Columns                                      | Example Row                     |
| ------------- | ---------------------------------------------------- | ------------------------------- |
| `customers`   | customer_id, customer_name, city, state              | 1, John Smith, Delhi, Delhi     |
| `products`    | product_id, product_name, category, price            | 102, Laptop, Electronics, 55000 |
| `orders`      | order_id, customer_id, order_date, total_amount      | 1001, 1, 2024-06-10, 17500      |
| `order_items` | order_item_id, order_id, product_id, quantity, price | 1, 1001, 101, 1, 15000          |

---

## 🧠 Query Sections

### 🟢 Easy Level Queries

Covers basic SQL operations like:

* `SELECT`, `WHERE`, `ORDER BY`, `LIKE`
* Filtering, sorting, and counting records

**Example:**

```sql
SELECT product_name, price 
FROM products 
ORDER BY price DESC;
```

---

### 🟡 Medium Level Queries

Focus on aggregation, joins, and grouping:

* `SUM`, `AVG`, `COUNT`, `GROUP BY`, `HAVING`
* `INNER JOIN` and `LEFT JOIN`
* Customer and product-level analysis

**Example:**

```sql
SELECT c.customer_name, SUM(o.total_amount) AS total_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
```

---

### 🔵 Advanced Level Queries

Introduces:

* Subqueries
* Views
* Indexes
* Analytical Queries

**Example View:**

```sql
CREATE VIEW category_sales_summary AS
SELECT 
    p.category,
    AVG(p.price) AS avg_price,
    SUM(o.quantity * o.price) AS total_sales
FROM products p
JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.category;
```

**Example Index:**

```sql
CREATE INDEX idx_customer_id ON orders(customer_id);
```

---

## 💡 Example Queries and Outputs

### 🎯 Query 1 – Total Sales per Customer

```sql
SELECT 
    c.customer_name,
    SUM(o.total_amount) AS total_sales
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_sales DESC;
```

#### 📊 Example Output

| customer_name | total_sales |
| ------------- | ----------- |
| John Smith    | 87,500      |
| Priya Sharma  | 55,000      |
| Rahul Mehta   | 42,300      |
| Sneha Patel   | 25,000      |

#### 🧠 Explanation

* **JOIN** combines `customers` and `orders`.
* **SUM** totals order values for each customer.
* **GROUP BY** groups results by customer.
* **ORDER BY DESC** ranks customers from highest to lowest sales.

---

### 🎯 Query 2 – Customers Who Spent More Than Average Order Amount

```sql
SELECT 
    c.customer_name,
    o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_amount > (
    SELECT AVG(total_amount) 
    FROM orders
);
```

#### 📊 Example Output

| customer_name | total_amount |
| ------------- | ------------ |
| John Smith    | 18,000       |
| Priya Sharma  | 17,500       |
| Rahul Mehta   | 19,200       |

#### 🧠 Explanation

* Subquery calculates the **average order amount**.
* Outer query filters customers whose orders **exceed the average**.

---

## 📈 Key Analytical Queries

| Task                   | Query Description                            |
| ---------------------- | -------------------------------------------- |
| 🏆 Top 3 Customers     | Highest total spending using `LIMIT 3`       |
| 📦 Product Performance | Highest total sales value                    |
| 📅 Monthly Insights    | Month-wise total orders & revenue            |
| 👥 Customer Behavior   | Customers who bought “Laptop” (via subquery) |
| ⚡ Optimization         | Index creation for faster joins              |

---

## ⚡ Performance Insight

After creating the index on `orders(customer_id)`:

* **Planning time** slightly increases (optimizer evaluates index usage)
* **Execution time** significantly decreases (faster lookups & joins)

✅ Demonstrates the trade-off between planning cost and execution efficiency.

---

## 📂 Project Structure

```
ecommerce-database-project/
│
├── ecommerce_db.sql          # Full SQL script (tables, data, queries)
├── README.md                 # Project documentation
└── sample_outputs/           # (Optional) screenshots or query results
```

---

## 👩‍💻 Author

** Deepali Rai**
SQL for Data Analysis – E-commerce Mini Project
Tools:  PostgreSQL 
