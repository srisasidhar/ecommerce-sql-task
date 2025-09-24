-- 1️⃣ Drop database if exists and create a fresh one
DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ecommerce_db;

-- 2️⃣ Users table
CREATE TABLE users (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3️⃣ Categories table
CREATE TABLE categories (
    category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    parent_id INT UNSIGNED DEFAULT NULL,
    description TEXT,
    CONSTRAINT fk_cat_parent FOREIGN KEY (parent_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

-- 4️⃣ Products table
CREATE TABLE products (
    product_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(64) UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    category_id INT UNSIGNED,
    stock_quantity INT UNSIGNED DEFAULT 0,
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_prod_cat FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

-- 5️⃣ Product Images table
CREATE TABLE product_images (
    image_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,
    url VARCHAR(512),
    alt_text VARCHAR(255),
    is_primary TINYINT(1) DEFAULT 0,
    CONSTRAINT fk_img_prod FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- 6️⃣ Addresses table
CREATE TABLE addresses (
    address_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    line1 VARCHAR(255) NOT NULL,
    line2 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    is_default_shipping TINYINT(1) DEFAULT 0,
    is_default_billing TINYINT(1) DEFAULT 0,
    CONSTRAINT fk_addr_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 7️⃣ Orders table
CREATE TABLE orders (
    order_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    order_status ENUM('pending','processing','shipped','delivered','cancelled','returned') DEFAULT 'pending',
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    shipping_address_id INT UNSIGNED,
    billing_address_id INT UNSIGNED,
    payment_id BIGINT UNSIGNED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_order_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_order_ship_addr FOREIGN KEY (shipping_address_id) REFERENCES addresses(address_id) ON DELETE SET NULL,
    CONSTRAINT fk_order_bill_addr FOREIGN KEY (billing_address_id) REFERENCES addresses(address_id) ON DELETE SET NULL
);

-- 8️⃣ Order Items table
CREATE TABLE order_items (
    order_item_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_oi_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_oi_prod FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT
);

-- 9️⃣ Cart table
CREATE TABLE cart (
    cart_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 🔟 Cart Items table
CREATE TABLE cart_items (
    cart_item_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cart_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL DEFAULT 1,
    CONSTRAINT fk_ci_cart FOREIGN KEY (cart_id) REFERENCES cart(cart_id) ON DELETE CASCADE,
    CONSTRAINT fk_ci_prod FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT
);

-- 1️⃣1️⃣ Payments table
CREATE TABLE payments (
    payment_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    order_id BIGINT UNSIGNED DEFAULT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_method ENUM('card','netbanking','upi','cod') DEFAULT 'card',
    status ENUM('initiated','success','failed','refunded') DEFAULT 'initiated',
    transaction_id VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pay_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_pay_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE SET NULL
);

-- 1️⃣2️⃣ Reviews table (fixed)
CREATE TABLE reviews (
    review_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,  -- NOT NULL
    rating TINYINT UNSIGNED NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_rev_prod FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    CONSTRAINT fk_rev_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE  -- CASCADE instead of SET NULL
);
