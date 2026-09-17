#!/usr/bin/env python3
"""
Data Migration Script for CarPartsStore.API
This script migrates data from SQLite to PostgreSQL
"""

import sqlite3
import psycopg2
import uuid
from datetime import datetime

def migrate_data():
    # Connect to SQLite database
    sqlite_conn = sqlite3.connect('carpartsstore.db')
    sqlite_cursor = sqlite_conn.cursor()
    
    # PostgreSQL connection parameters (update these with your actual credentials)
    pg_conn_params = {
        'host': 'localhost',
        'database': 'carpartsstore',
        'user': 'postgres',
        'password': 'your_password',
        'port': 5432
    }
    
    try:
        # Connect to PostgreSQL
        pg_conn = psycopg2.connect(**pg_conn_params)
        pg_cursor = pg_conn.cursor()
        
        print("Starting data migration from SQLite to PostgreSQL...")
        
        # 1. Migrate Users
        print("Migrating Users...")
        sqlite_cursor.execute("SELECT * FROM Users")
        users = sqlite_cursor.fetchall()
        
        for user in users:
            pg_cursor.execute("""
                INSERT INTO "Users" ("Id", "Username", "Email", "PasswordHash", "Role", "CreatedAt", "UpdatedAt")
                VALUES (%s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT ("Id") DO NOTHING
            """, user)
        
        # 2. Migrate Categories
        print("Migrating Categories...")
        sqlite_cursor.execute("SELECT * FROM Categories")
        categories = sqlite_cursor.fetchall()
        
        for category in categories:
            pg_cursor.execute("""
                INSERT INTO "Categories" ("Id", "Name", "Description", "ImageUrl", "CreatedAt", "UpdatedAt")
                VALUES (%s, %s, %s, %s, %s, %s)
                ON CONFLICT ("Id") DO NOTHING
            """, category)
        
        # 3. Migrate Products
        print("Migrating Products...")
        sqlite_cursor.execute("SELECT * FROM Products")
        products = sqlite_cursor.fetchall()
        
        for product in products:
            pg_cursor.execute("""
                INSERT INTO "Products" ("Id", "Name", "Description", "Price", "StockQuantity", "ImageUrl", "CategoryId", "CreatedAt", "UpdatedAt")
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT ("Id") DO NOTHING
            """, product)
        
        # 4. Migrate Slides
        print("Migrating Slides...")
        sqlite_cursor.execute("SELECT * FROM Slides")
        slides = sqlite_cursor.fetchall()
        
        for slide in slides:
            pg_cursor.execute("""
                INSERT INTO "Slides" ("Id", "Title", "Description", "ImageUrl", "Link", "Order", "IsActive", "CreatedAt", "UpdatedAt")
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT ("Id") DO NOTHING
            """, slide)
        
        # 5. Migrate Stories
        print("Migrating Stories...")
        sqlite_cursor.execute("SELECT * FROM Stories")
        stories = sqlite_cursor.fetchall()
        
        for story in stories:
            pg_cursor.execute("""
                INSERT INTO "Stories" ("Id", "Title", "Description", "MediaUrl", "MediaType", "ThumbnailUrl", "IsActive", "CreatedAt", "UpdatedAt")
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT ("Id") DO NOTHING
            """, story)
        
        # 6. Migrate Orders
        print("Migrating Orders...")
        sqlite_cursor.execute("SELECT * FROM Orders")
        orders = sqlite_cursor.fetchall()
        
        for order in orders:
            pg_cursor.execute("""
                INSERT INTO "Orders" ("Id", "UserId", "TotalAmount", "Status", "ShippingAddress", "CreatedAt", "UpdatedAt")
                VALUES (%s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT ("Id") DO NOTHING
            """, order)
        
        # 7. Migrate OrderItems
        print("Migrating OrderItems...")
        sqlite_cursor.execute("SELECT * FROM OrderItems")
        order_items = sqlite_cursor.fetchall()
        
        for item in order_items:
            pg_cursor.execute("""
                INSERT INTO "OrderItems" ("Id", "OrderId", "ProductId", "Quantity", "UnitPrice", "CreatedAt")
                VALUES (%s, %s, %s, %s, %s, %s)
                ON CONFLICT ("Id") DO NOTHING
            """, item)
        
        # 8. Migrate ProductReviews
        print("Migrating ProductReviews...")
        sqlite_cursor.execute("SELECT * FROM ProductReviews")
        reviews = sqlite_cursor.fetchall()
        
        for review in reviews:
            pg_cursor.execute("""
                INSERT INTO "ProductReviews" ("Id", "ProductId", "UserId", "Rating", "Comment", "CreatedAt", "UpdatedAt")
                VALUES (%s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT ("Id") DO NOTHING
            """, review)
        
        # Commit changes
        pg_conn.commit()
        
        print("Data migration completed successfully!")
        
        # Show migration statistics
        print("\nMigration Statistics:")
        print("Users migrated:", len(users))
        print("Categories migrated:", len(categories))
        print("Products migrated:", len(products))
        print("Slides migrated:", len(slides))
        print("Stories migrated:", len(stories))
        print("Orders migrated:", len(orders))
        print("OrderItems migrated:", len(order_items))
        print("ProductReviews migrated:", len(reviews))
        
    except Exception as e:
        print(f"Error during migration: {e}")
        if 'pg_conn' in locals():
            pg_conn.rollback()
    finally:
        # Close connections
        sqlite_cursor.close()
        sqlite_conn.close()
        if 'pg_cursor' in locals():
            pg_cursor.close()
        if 'pg_conn' in locals():
            pg_conn.close()

if __name__ == "__main__":
    print("CarPartsStore Data Migration Tool")
    print("=" * 40)
    print("Before running this script:")
    print("1. Run the PostgreSQL_Migration.sql script to create the database schema")
    print("2. Update the PostgreSQL connection parameters in this script")
    print("3. Install required packages: pip install psycopg2-binary")
    print("=" * 40)
    
    response = input("Do you want to proceed with data migration? (yes/no): ")
    if response.lower() == 'yes':
        migrate_data()
    else:
        print("Migration cancelled.")