using CarPartsStore.API.Data;
using CarPartsStore.API.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CarPartsStore.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Roles = "Admin")]
    public class StatsController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public StatsController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet("dashboard")]
        public async Task<IActionResult> GetDashboardStats()
        {
            try
            {
                // آمار داینامیک از دیتابیس
                var activeProductsCount = await _context.Products
                    .Where(p => p.IsActive)
                    .CountAsync();

                var totalCategoriesCount = await _context.Categories.CountAsync();

                var totalUsersCount = await _context.Users.CountAsync();

                var featuredProductsCount = await _context.Products
                    .Where(p => p.IsFeatured && p.IsActive)
                    .CountAsync();

                // محصولات جدید
                var latestProducts = await _context.Products
                    .Include(p => p.Category)
                    .Where(p => p.IsActive)
                    .OrderByDescending(p => p.CreatedAt)
                    .Take(5)
                    .Select(p => new 
                    {
                        p.Id,
                        p.Name,
                        CategoryName = p.Category.Name,
                        p.CreatedAt,
                        p.ImageUrl
                    })
                    .ToListAsync();

                // محصولات بر اساس برند ماشین
                var productsByCarBrand = await _context.Products
                    .Where(p => p.IsActive && !string.IsNullOrEmpty(p.CarBrand))
                    .GroupBy(p => p.CarBrand)
                    .Select(g => new
                    {
                        CarBrand = g.Key,
                        Count = g.Count()
                    })
                    .OrderByDescending(g => g.Count)
                    .ToListAsync();

                var stats = new DashboardStatsDto
                {
                    ActiveProducts = activeProductsCount,
                    TotalCategories = totalCategoriesCount,
                    TotalUsers = totalUsersCount,
                    FeaturedProducts = featuredProductsCount,
                    LatestProducts = latestProducts,
                    ProductsByCarBrand = productsByCarBrand
                };

                return Ok(stats);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }

    public class DashboardStatsDto
    {
        public int ActiveProducts { get; set; }
        public int TotalCategories { get; set; }
        public int TotalUsers { get; set; }
        public int FeaturedProducts { get; set; }
        public dynamic LatestProducts { get; set; } = null!;
        public dynamic ProductsByCarBrand { get; set; } = null!;
    }
}