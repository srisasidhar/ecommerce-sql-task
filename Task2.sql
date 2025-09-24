USE ecommerce_db;

-- Task 2: Data Insertion & Null Handling

-- ✅ Insert example (new unique user so no duplicate error)
INSERT INTO users (first_name, last_name, email, password_hash, phone) 
VALUES ('Sneha', 'Reddy', 'sneha3@example.com', 'dummy_password_hash', NULL);

-- ✅ Update example (reduce stock of product_id = 1)
UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1;

-- ✅ Delete example (delete a user instead of Customers table)
DELETE FROM users
WHERE email = 'rahul@example.com';

-- ✅ NULL check (find users without phone numbers)
SELECT * FROM users WHERE phone IS NULL;
