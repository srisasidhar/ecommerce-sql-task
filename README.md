# Ecommerce SQL Task

## Overview
This repository contains SQL scripts for an e-commerce database. The tasks include:

1. **Schema creation** (`schema.sql`)  
   - Creating tables: `users`, `categories`, `products`, `product_images`, `addresses`, `orders`, `order_items`, `cart`, `cart_items`, `payments`, `reviews`  
   - Defining primary keys, foreign keys, and constraints  

2. **Seed data** (`seed.sql`)  
   - Populating tables with initial data for users, categories, and products  

3. **Task 2: Data Insertion & Null Handling** (`task2.sql`)  
   - Inserting new data  
   - Updating existing records  
   - Deleting records  
   - Handling `NULL` values and performing checks  

## Key Concepts Practiced
- **DML Statements:** `INSERT`, `UPDATE`, `DELETE`  
- **NULL Handling:** Checking for missing values and using `NULL` appropriately  
- **Constraints:** Primary key, foreign key, unique, and default constraints  

## How to Use
1. Open MySQL Workbench (or any SQL client).  
2. Run `schema.sql` to create the database and tables.  
3. Run `seed.sql` to populate initial data.  
4. Run `task2.sql` to practice data insertion, updates, deletions, and NULL handling.  

## Notes
- Foreign key relationships enforce data consistency.  
- `task2.sql` contains examples of updating stock, deleting users, and checking for NULL values.  

---

**Author:** Sasidhar Kusumanchi  
**Date:** September 2025  
