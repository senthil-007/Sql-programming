CREATE DATABASE ecommerce_db;

USE ecommerce_db;

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50),
    created_at DATE
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(30),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- Insert Customers
INSERT INTO customers
(customer_name, email, city, created_at)
VALUES
('Arun Kumar', 'arun@gmail.com', 'Chennai', '2026-01-10'),
('Rahul Raj', 'rahul@gmail.com', 'Bangalore', '2026-01-15'),
('Priya Sharma', 'priya@gmail.com', 'Mumbai', '2026-02-05'),
('Karthik S', 'karthik@gmail.com', 'Coimbatore', '2026-02-15'),
('Divya R', 'divya@gmail.com', 'Pondicherry', '2026-03-01');

-- Insert Products
INSERT INTO products
(product_name, category, price, stock)
VALUES
('Laptop', 'Electronics', 65000, 20),
('Smartphone', 'Electronics', 25000, 35),
('Headphones', 'Accessories', 2500, 50),
('Keyboard', 'Accessories', 1500, 40),
('Office Chair', 'Furniture', 8500, 15),
('Monitor', 'Electronics', 15000, 25);

-- Insert Orders
INSERT INTO orders
(customer_id, order_date, total_amount, status)
VALUES
(1, '2026-03-10', 67500, 'Delivered'),
(2, '2026-03-12', 25000, 'Delivered'),
(3, '2026-03-15', 10000, 'Shipped'),
(4, '2026-03-18', 15000, 'Processing'),
(5, '2026-03-20', 28000, 'Delivered');

-- Insert Order Items
INSERT INTO order_items
(order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 65000),
(1, 3, 1, 2500),
(2, 2, 1, 25000),
(3, 5, 1, 8500),
(3, 4, 1, 1500),
(4, 6, 1, 15000),
(5, 2, 1, 25000),
(5, 3, 1, 2500);

-- View Customers
SELECT * FROM customers;

-- View Products
SELECT * FROM products;

-- Customer Orders
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

-- Total Revenue
SELECT
    SUM(total_amount) AS total_revenue
FROM orders;

-- Average Order Value
SELECT
    AVG(total_amount) AS average_order_value
FROM orders;

-- Orders by Status
SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status;

-- Top Customers
SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- Product Sales
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC;

-- Products with Low Stock
SELECT *
FROM products
WHERE stock < 20;
