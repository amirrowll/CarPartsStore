using CarPartsStore.API.Models;
using Microsoft.EntityFrameworkCore;

namespace CarPartsStore.API.Data
{
    public static class DbSeeder
    {
        public static async Task SeedAsync(ApplicationDbContext context)
        {
            // Check if there's already an admin user
            var adminExists = await context.Users.AnyAsync(u => u.Email == "admin@carparts.com");
            
            if (!adminExists)
            {
                var adminUser = new User
                {
                    FirstName = "Admin",
                    LastName = "System",
                    Email = "admin@carparts.com",
                    PasswordHash = BCrypt.Net.BCrypt.HashPassword("Admin@123"),
                    PhoneNumber = "09937101060",
                    Address = "تهران",
                    Role = UserRole.Admin,
                    CreatedAt = DateTime.UtcNow,
                    IsActive = true
                };

                context.Users.Add(adminUser);
                await context.SaveChangesAsync();
                
                Console.WriteLine("Admin user created successfully!");
            }
            else
            {
                // Update existing admin with new credentials
                var existingAdmin = await context.Users.FirstOrDefaultAsync(u => u.Email == "admin@carparts.com");
                if (existingAdmin != null)
                {
                    existingAdmin.FirstName = "Admin";
                    existingAdmin.LastName = "System";
                    existingAdmin.PhoneNumber = "09937101060";
                    existingAdmin.PasswordHash = BCrypt.Net.BCrypt.HashPassword("Amirwelo83");
                    existingAdmin.UpdatedAt = DateTime.UtcNow;
                    await context.SaveChangesAsync();
                    Console.WriteLine("Admin user updated with new credentials!");
                }
            }
            
            // Always create or update the phone number admin user
            var phoneAdminUser = await context.Users.FirstOrDefaultAsync(u => u.Email == "09937101060");
            
            if (phoneAdminUser == null)
            {
                phoneAdminUser = new User
                {
                    FirstName = "امیرحسین",
                    LastName = "ولایی",
                    Email = "09937101060",
                    PasswordHash = BCrypt.Net.BCrypt.HashPassword("Amirwelo83"),
                    PhoneNumber = "09937101060",
                    Address = "تهران",
                    Role = UserRole.Admin,
                    CreatedAt = DateTime.UtcNow,
                    IsActive = true
                };

                context.Users.Add(phoneAdminUser);
                await context.SaveChangesAsync();
                
                Console.WriteLine("Phone number admin user created successfully!");
            }
            else
            {
                // Update existing phone admin user
                phoneAdminUser.FirstName = "امیرحسین";
                phoneAdminUser.LastName = "ولایی";
                phoneAdminUser.PasswordHash = BCrypt.Net.BCrypt.HashPassword("Amirwelo83");
                phoneAdminUser.PhoneNumber = "09937101060";
                phoneAdminUser.UpdatedAt = DateTime.UtcNow;
                await context.SaveChangesAsync();
                Console.WriteLine("Phone number admin user updated successfully!");
            }
            
            // Check if there are any categories
            var categoriesExist = await context.Categories.AnyAsync();
            
            if (!categoriesExist)
            {
                // Create default categories
                var defaultCategories = new List<Category>
                {
                    new Category
                    {
                        Name = "قطعات برقی",
                        Description = "قطعات سیستم برقی خودرو",
                        ImageUrl = "/uploads/categories/electrical.jpg",
                        DisplayOrder = 1,
                        IsActive = true,
                        CreatedAt = DateTime.UtcNow
                    },
                    new Category
                    {
                        Name = "موتور و قطعات موتور",
                        Description = "قطعات مربوط به موتور خودرو",
                        ImageUrl = "/uploads/categories/engine.jpg",
                        DisplayOrder = 2,
                        IsActive = true,
                        CreatedAt = DateTime.UtcNow
                    },
                    new Category
                    {
                        Name = "سیستم تعلیق و فرمان",
                        Description = "قطعات سیستم تعلیق و فرمان خودرو",
                        ImageUrl = "/uploads/categories/suspension.jpg",
                        DisplayOrder = 3,
                        IsActive = true,
                        CreatedAt = DateTime.UtcNow
                    },
                    new Category
                    {
                        Name = "تجهیزات داخلی",
                        Description = "قطعات و تجهیزات داخلی خودرو",
                        ImageUrl = "/uploads/categories/interior.jpg",
                        DisplayOrder = 4,
                        IsActive = true,
                        CreatedAt = DateTime.UtcNow
                    },
                    new Category
                    {
                        Name = "قطعات بدنه",
                        Description = "قطعات مربوط به بدنه و اسکلت خودرو",
                        ImageUrl = "/uploads/categories/body.jpg",
                        DisplayOrder = 5,
                        IsActive = true,
                        CreatedAt = DateTime.UtcNow
                    }
                };
                
                await context.Categories.AddRangeAsync(defaultCategories);
                await context.SaveChangesAsync();
                Console.WriteLine($"{defaultCategories.Count} default categories created successfully!");
            }
            else
            {
                Console.WriteLine("Categories already exist in the database");
            }

            // Check if there are any products
            var productsExist = await context.Products.AnyAsync();
            
            if (!productsExist)
            {
                // Get existing categories
                var existingCategories = await context.Categories.ToListAsync();
                
                if (existingCategories.Any())
                {
                    // Create sample products
                    var sampleProducts = new List<Product>
                    {
                        new Product
                        {
                            Name = "فیلتر هوای پراید",
                            Description = "فیلتر هوای اصلی پراید با کیفیت عالی",
                            CategoryId = existingCategories[0].Id,
                            ImageUrl = "https://images.unsplash.com/photo-1608484606126-dacb4b5a5514?w=400&h=300&fit=crop",
                            Tags = new[] { "پراید", "فیلتر هوا", "قطعات اصلی" },
                            Hashtags = new[] { "پراید", "فیلتر", "هوا" },
                            Brand = "Original",
                            PartNumber = "FA-1001",
                            CompatibleCars = "پراید، تیبا، ساینا",
                            CarBrand = "Saipa",
                            CarModel = "Pride",
                            Material = "کاغذ فیلتر",
                            Warranty = "6 ماه",
                            DisplayOrder = 1,
                            IsFeatured = true,
                            IsActive = true,
                            CreatedAt = DateTime.UtcNow
                        },
                        new Product
                        {
                            Name = "لنت ترمز 206",
                            Description = "لنت ترمز اصلی پژو 206 با کیفیت اروپایی",
                            CategoryId = existingCategories[1].Id,
                            ImageUrl = "https://images.unsplash.com/photo-1593941707882-a5bba533b6d1?w=400&h=300&fit=crop",
                            Tags = new[] { "پژو", "ترمز", "لنت", "206" },
                            Hashtags = new[] { "پژو", "ترمز", "لنت" },
                            Brand = "Bosch",
                            PartNumber = "BR-206",
                            CompatibleCars = "پژو 206، 207",
                            CarBrand = "Other",
                            CarModel = "Peugeot206",
                            Material = "کربن",
                            Warranty = "1 سال",
                            DisplayOrder = 2,
                            IsFeatured = true,
                            IsActive = true,
                            CreatedAt = DateTime.UtcNow
                        },
                        new Product
                        {
                            Name = "آمپر سنسور آب",
                            Description = "آمپر نمایشگر دمای آب موتور برای خودروهای ایرانی",
                            CategoryId = existingCategories[0].Id,
                            ImageUrl = "https://images.unsplash.com/photo-1608484606126-dacb4b5a5514?w=400&h=300&fit=crop",
                            Tags = new[] { "سنسور", "آمپر", "آب", "موتور" },
                            Hashtags = new[] { "الکترونیک", "موتور", "آب" },
                            Brand = "IranKhodro",
                            PartNumber = "SW-5001",
                            CompatibleCars = "سمند، سورن، پژو پارس",
                            CarBrand = "IranKhodro",
                            CarModel = "Samand",
                            Material = "پلاستیک",
                            Warranty = "1 سال",
                            DisplayOrder = 3,
                            IsFeatured = true,
                            IsActive = true,
                            CreatedAt = DateTime.UtcNow
                        },
                        new Product
                        {
                            Name = "سیبک فرمان پژو پارس",
                            Description = "سیبک فرمان اصلی پژو پارس",
                            CategoryId = existingCategories[2].Id,
                            ImageUrl = "https://images.unsplash.com/photo-1593941707882-a5bba533b6d1?w=400&h=300&fit=crop",
                            Tags = new[] { "سیبک", "فرمان", "پژو", "پارس" },
                            Hashtags = new[] { "فرمان", "سیستم تعلیق", "پژو" },
                            Brand = "Original",
                            PartNumber = "TR-1002",
                            CompatibleCars = "پژو پارس",
                            CarBrand = "Other",
                            CarModel = "PeugeotPars",
                            Material = "فولاد",
                            Warranty = "1 سال",
                            DisplayOrder = 4,
                            IsFeatured = true,
                            IsActive = true,
                            CreatedAt = DateTime.UtcNow
                        }
                    };
                    
                    await context.Products.AddRangeAsync(sampleProducts);
                    await context.SaveChangesAsync();
                    Console.WriteLine($"{sampleProducts.Count} sample products created successfully!");
                }
            }
            else
            {
                Console.WriteLine("Products already exist in the database");
            }
        }
    }
}