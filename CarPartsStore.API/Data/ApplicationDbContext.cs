using CarPartsStore.API.Models;
using Microsoft.EntityFrameworkCore;using System;

namespace CarPartsStore.API.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<User> Users { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderItem> OrderItems { get; set; }
        public DbSet<ProductReview> ProductReviews { get; set; }
        public DbSet<Slide> Slides { get; set; }
        public DbSet<Story> Stories { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // User configuration
            modelBuilder.Entity<User>()
                .HasIndex(u => u.Email)
                .IsUnique();

            // Product configuration
            modelBuilder.Entity<Product>()
                .HasIndex(p => p.PartNumber)
                .IsUnique();

            modelBuilder.Entity<Product>()
                .HasOne(p => p.Category)
                .WithMany(c => c.Products)
                .HasForeignKey(p => p.CategoryId)
                .OnDelete(DeleteBehavior.Restrict);

            // Category hierarchy
            modelBuilder.Entity<Category>()
                .HasOne(c => c.ParentCategory)
                .WithMany(c => c.SubCategories)
                .HasForeignKey(c => c.ParentCategoryId)
                .OnDelete(DeleteBehavior.Restrict);

            // Order relationships
            modelBuilder.Entity<Order>()
                .HasOne(o => o.User)
                .WithMany(u => u.Orders)
                .HasForeignKey(o => o.UserId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<OrderItem>()
                .HasOne(oi => oi.Order)
                .WithMany(o => o.OrderItems)
                .HasForeignKey(oi => oi.OrderId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<OrderItem>()
                .HasOne(oi => oi.Product)
                .WithMany()
                .HasForeignKey(oi => oi.ProductId)
                .OnDelete(DeleteBehavior.Restrict);

            // Product reviews
            modelBuilder.Entity<ProductReview>()
                .HasOne(pr => pr.Product)
                .WithMany()
                .HasForeignKey(pr => pr.ProductId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<ProductReview>()
                .HasOne(pr => pr.User)
                .WithMany()
                .HasForeignKey(pr => pr.UserId)
                .OnDelete(DeleteBehavior.Restrict);

            // Configure Slide
            modelBuilder.Entity<Slide>()
                .HasIndex(s => s.Order);
            
            modelBuilder.Entity<Slide>()
                .Property(s => s.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP");

            // Configure Story
            modelBuilder.Entity<Story>()
                .HasIndex(s => s.Order);
            
            modelBuilder.Entity<Story>()
                .HasIndex(s => s.ExpiresAt);
            
            modelBuilder.Entity<Story>()
                .Property(s => s.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP");
            
            modelBuilder.Entity<Story>()
                .Property(s => s.ExpiresAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP + INTERVAL '24 hours'");
            
            modelBuilder.Entity<Story>()
                .HasOne(s => s.CreatedByUser)
                .WithMany()
                .HasForeignKey(s => s.CreatedByUserId)
                .OnDelete(DeleteBehavior.SetNull);

            // Seed initial data
            // SeedData(modelBuilder);
        }

        private void SeedData(ModelBuilder modelBuilder)
        {
            // Seed categories
            var categories = new List<Category>
            {
                new Category { Id = 1, Name = "موتور و قطعات موتور", Description = "قطعات مربوط به موتور خودرو", DisplayOrder = 1 },
                new Category { Id = 2, Name = "سیستم تعلیق و فرمان", Description = "قطعات سیستم تعلیق و فرمان", DisplayOrder = 2 },
                new Category { Id = 3, Name = "سیستم ترمز", Description = "قطعات سیستم ترمز", DisplayOrder = 3 },
                new Category { Id = 4, Name = "سیستم الکتریکی", Description = "قطعات سیستم الکتریکی خودرو", DisplayOrder = 4 },
                new Category { Id = 5, Name = "بدنه و شیشه", Description = "قطعات بدنه و شیشه خودرو", DisplayOrder = 5 },
                new Category { Id = 6, Name = "سیستم خنک‌کننده", Description = "قطعات سیستم خنک‌کننده", DisplayOrder = 6 },
                new Category { Id = 7, Name = "سیستم اگزوز", Description = "قطعات سیستم اگزوز", DisplayOrder = 7 },
                new Category { Id = 8, Name = "لوازم داخلی", Description = "لوازم داخلی خودرو", DisplayOrder = 8 }
            };

            modelBuilder.Entity<Category>().HasData(categories);

            // Seed admin user
            var adminUser = new User
            {
                Id = 1,
                FirstName = "مدیر",
                LastName = "سیستم",
                Email = "admin@carparts.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("Admin@123"),
                PhoneNumber = "09123456789",
                Role = UserRole.Admin,
                IsActive = true,
                CreatedAt = new DateTime(2024, 1, 1, 0, 0, 0, DateTimeKind.Utc)
            };

            modelBuilder.Entity<User>().HasData(adminUser);

            // Seed default slides with online images
            var defaultSlides = new List<Slide>
            {
                new Slide 
                { 
                    Id = 1, 
                    Title = "قطعات خودرو با کیفیت", 
                    Description = "بزرگترین مجموعه قطعات یدکی خودرو با گارانتی کیفیت و قیمت مناسب", 
                    ImageUrl = "https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=1600&q=80", 
                    Order = 1, 
                    IsActive = true, 
                    CreatedAt = new DateTime(2024, 1, 1, 0, 0, 0, DateTimeKind.Utc) 
                },
                new Slide 
                { 
                    Id = 2, 
                    Title = "انواع قطعات موتور", 
                    Description = "قطعات اصلی موتور با بهترین کیفیت و تضمین اصالت", 
                    ImageUrl = "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=1600&q=80", 
                    Order = 2, 
                    IsActive = true, 
                    CreatedAt = new DateTime(2024, 1, 1, 0, 0, 0, DateTimeKind.Utc) 
                },
                new Slide 
                { 
                    Id = 3, 
                    Title = "سیستم تعلیق و ترمز", 
                    Description = "قطعات سیستم تعلیق و ترمز با استانداردهای جهانی", 
                    ImageUrl = "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=1600&q=80", 
                    Order = 3, 
                    IsActive = true, 
                    CreatedAt = new DateTime(2024, 1, 1, 0, 0, 0, DateTimeKind.Utc) 
                }
            };

            modelBuilder.Entity<Slide>().HasData(defaultSlides);
        }
    }
}
