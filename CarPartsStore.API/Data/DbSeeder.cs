using CarPartsStore.API.Models;
using Microsoft.EntityFrameworkCore;

namespace CarPartsStore.API.Data
{
    public static class DbSeeder
    {
        public static async Task SeedAsync(ApplicationDbContext context)
        {
            // Create admin user if not exists
            var adminExists = await context.Users.AnyAsync(u => u.Email == "09937101060");

            if (!adminExists)
            {
                var adminUser = new User
                {
                    FirstName = "امیرحسین",
                    LastName = "ولایی",
                    Email = "09937101060",
                    PasswordHash = BCrypt.Net.BCrypt.HashPassword("Pinpart@Admin2026!"),
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
                Console.WriteLine("Admin user already exists");
            }

            // No categories, products, slides are seeded in Production.
            // They will be added via the Admin Panel.
        }
    }
}
