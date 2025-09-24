USE ecommerce_db;

INSERT INTO users (first_name, last_name, email, password_hash, phone)
VALUES ('Rahul','Kumar','rahul@example.com','hash123','9876543210');

INSERT INTO categories (name) VALUES ('Electronics'), ('Clothing');

INSERT INTO products (sku, name, description, price, category_id, stock_quantity)
VALUES ('SKU-001','USB Cable','Type-C Cable',199.00,1,100),
       ('SKU-002','T-Shirt','Cotton Tee',399.00,2,50);
