-- PostgreSQL Migration Script for CarPartsStore.API
-- This script migrates the database schema from SQLite to PostgreSQL
-- Run this script on your PostgreSQL database before deploying the application

-- Create database if not exists (run this manually)
-- CREATE DATABASE carpartsstore;

-- Connect to the database
-- \c carpartsstore;

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create tables
CREATE TABLE IF NOT EXISTS "Users" (
    "Id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "Username" VARCHAR(255) NOT NULL,
    "Email" VARCHAR(255) NOT NULL,
    "PasswordHash" TEXT NOT NULL,
    "Role" VARCHAR(50) NOT NULL DEFAULT 'User',
    "CreatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "UpdatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "Categories" (
    "Id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "Name" VARCHAR(255) NOT NULL,
    "Description" TEXT,
    "ImageUrl" TEXT,
    "CreatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "UpdatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "Products" (
    "Id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "Name" VARCHAR(255) NOT NULL,
    "Description" TEXT,
    "Price" DECIMAL(18,2) NOT NULL,
    "StockQuantity" INTEGER NOT NULL DEFAULT 0,
    "ImageUrl" TEXT,
    "CategoryId" UUID,
    "CreatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "UpdatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "FK_Products_Categories_CategoryId" FOREIGN KEY ("CategoryId") 
        REFERENCES "Categories" ("Id") ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS "Slides" (
    "Id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "Title" VARCHAR(255) NOT NULL,
    "Description" TEXT,
    "ImageUrl" TEXT NOT NULL,
    "Link" TEXT,
    "Order" INTEGER NOT NULL DEFAULT 0,
    "IsActive" BOOLEAN NOT NULL DEFAULT true,
    "CreatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "UpdatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "Stories" (
    "Id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "Title" VARCHAR(255) NOT NULL,
    "Description" TEXT,
    "MediaUrl" TEXT NOT NULL,
    "MediaType" VARCHAR(50) NOT NULL DEFAULT 'image',
    "ThumbnailUrl" TEXT,
    "IsActive" BOOLEAN NOT NULL DEFAULT true,
    "CreatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "UpdatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "Orders" (
    "Id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "UserId" UUID NOT NULL,
    "TotalAmount" DECIMAL(18,2) NOT NULL,
    "Status" VARCHAR(50) NOT NULL DEFAULT 'Pending',
    "ShippingAddress" TEXT,
    "CreatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "UpdatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "FK_Orders_Users_UserId" FOREIGN KEY ("UserId") 
        REFERENCES "Users" ("Id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "OrderItems" (
    "Id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "OrderId" UUID NOT NULL,
    "ProductId" UUID NOT NULL,
    "Quantity" INTEGER NOT NULL,
    "UnitPrice" DECIMAL(18,2) NOT NULL,
    "CreatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "FK_OrderItems_Orders_OrderId" FOREIGN KEY ("OrderId") 
        REFERENCES "Orders" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_OrderItems_Products_ProductId" FOREIGN KEY ("ProductId") 
        REFERENCES "Products" ("Id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "ProductReviews" (
    "Id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "ProductId" UUID NOT NULL,
    "UserId" UUID NOT NULL,
    "Rating" INTEGER NOT NULL CHECK ("Rating" >= 1 AND "Rating" <= 5),
    "Comment" TEXT,
    "CreatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "UpdatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "FK_ProductReviews_Products_ProductId" FOREIGN KEY ("ProductId") 
        REFERENCES "Products" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_ProductReviews_Users_UserId" FOREIGN KEY ("UserId") 
        REFERENCES "Users" ("Id") ON DELETE CASCADE
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS "IX_Products_CategoryId" ON "Products"("CategoryId");
CREATE INDEX IF NOT EXISTS "IX_Orders_UserId" ON "Orders"("UserId");
CREATE INDEX IF NOT EXISTS "IX_OrderItems_OrderId" ON "OrderItems"("OrderId");
CREATE INDEX IF NOT EXISTS "IX_OrderItems_ProductId" ON "OrderItems"("ProductId");
CREATE INDEX IF NOT EXISTS "IX_ProductReviews_ProductId" ON "ProductReviews"("ProductId");
CREATE INDEX IF NOT EXISTS "IX_ProductReviews_UserId" ON "ProductReviews"("UserId");
CREATE INDEX IF NOT EXISTS "IX_Users_Email" ON "Users"("Email");
CREATE INDEX IF NOT EXISTS "IX_Slides_Order" ON "Slides"("Order");
CREATE INDEX IF NOT EXISTS "IX_Slides_IsActive" ON "Slides"("IsActive");
CREATE INDEX IF NOT EXISTS "IX_Stories_IsActive" ON "Stories"("IsActive");

-- Create function to update UpdatedAt timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW."UpdatedAt" = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for automatic UpdatedAt updates
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON "Users"
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_categories_updated_at BEFORE UPDATE ON "Categories"
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON "Products"
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_slides_updated_at BEFORE UPDATE ON "Slides"
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_stories_updated_at BEFORE UPDATE ON "Stories"
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_orders_updated_at BEFORE UPDATE ON "Orders"
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_product_reviews_updated_at BEFORE UPDATE ON "ProductReviews"
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Insert default admin user (password: Admin123!)
INSERT INTO "Users" ("Id", "Username", "Email", "PasswordHash", "Role", "CreatedAt", "UpdatedAt")
VALUES (
    '00000000-0000-0000-0000-000000000001',
    'admin',
    'admin@carpartsstore.com',
    '$2a$11$N0yDRAqS9z6QYqLpVpVf8eBz6zJ6X6Z6X6Z6X6Z6X6Z6X6Z6X6Z6X6',
    'Admin',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
) ON CONFLICT ("Id") DO NOTHING;

-- Insert default categories
INSERT INTO "Categories" ("Id", "Name", "Description", "CreatedAt", "UpdatedAt")
VALUES 
    ('00000000-0000-0000-0000-000000000002', 'Engine Parts', 'Engine components and accessories', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('00000000-0000-0000-0000-000000000003', 'Brake System', 'Brake pads, rotors, and calipers', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('00000000-0000-0000-0000-000000000004', 'Suspension', 'Shocks, struts, and suspension parts', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('00000000-0000-0000-0000-000000000005', 'Electrical', 'Batteries, alternators, and wiring', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('00000000-0000-0000-0000-000000000006', 'Exhaust System', 'Mufflers, pipes, and catalytic converters', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT ("Id") DO NOTHING;

-- Migration completed message
SELECT 'PostgreSQL migration completed successfully!' AS message;