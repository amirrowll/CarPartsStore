using CarPartsStore.API.Data;
using CarPartsStore.API.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace CarPartsStore.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public CategoriesController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        [ResponseCache(Duration = 300, VaryByQueryKeys = new[] { "includeProducts" })]
        public async Task<IActionResult> GetCategories([FromQuery] bool includeProducts = false)
        {
            try
            {
                var categories = await _context.Categories
                    .Where(c => c.IsActive)
                    .OrderBy(c => c.DisplayOrder)
                    .Select(c => new CategoryDto
                    {
                        Id = c.Id,
                        Name = c.Name,
                        Description = c.Description,
                        ImageUrl = c.ImageUrl,
                        DisplayOrder = c.DisplayOrder,
                        IsActive = c.IsActive,
                        ProductCount = c.Products.Count(p => p.IsActive)
                    })
                    .ToListAsync();

                return Ok(categories);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpGet("hierarchy")]
        [ResponseCache(Duration = 300)]
        public async Task<IActionResult> GetCategoryHierarchy()
        {
            try
            {
                var allCategories = await _context.Categories
                    .Where(c => c.IsActive)
                    .OrderBy(c => c.DisplayOrder)
                    .ToListAsync();

                var rootCategories = allCategories
                    .Where(c => c.ParentCategoryId == null)
                    .Select(c => new CategoryHierarchyDto
                    {
                        Id = c.Id,
                        Name = c.Name,
                        Description = c.Description,
                        ImageUrl = c.ImageUrl,
                        DisplayOrder = c.DisplayOrder,
                        SubCategories = allCategories
                            .Where(sc => sc.ParentCategoryId == c.Id)
                            .OrderBy(sc => sc.DisplayOrder)
                            .Select(sc => new CategorySimpleDto
                            {
                                Id = sc.Id,
                                Name = sc.Name,
                                Description = sc.Description,
                                ImageUrl = sc.ImageUrl,
                                DisplayOrder = sc.DisplayOrder
                            })
                            .ToList()
                    })
                    .ToList();

                return Ok(rootCategories);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetCategoryById(int id, [FromQuery] bool includeProducts = false)
        {
            try
            {
                var category = await _context.Categories
                    .Select(c => new CategoryDto
                    {
                        Id = c.Id,
                        Name = c.Name,
                        Description = c.Description,
                        ImageUrl = c.ImageUrl,
                        DisplayOrder = c.DisplayOrder,
                        IsActive = c.IsActive,
                        ProductCount = c.Products.Count(p => p.IsActive)
                    })
                    .FirstOrDefaultAsync(c => c.Id == id);

                if (category == null)
                    return NotFound(new { message = "دستهبندی پیدا نشد" });

                return Ok(category);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpGet("{id}/products")]
        [ResponseCache(Duration = 60, VaryByQueryKeys = new[] { "page", "pageSize" })]
        public async Task<IActionResult> GetCategoryProducts(int id, [FromQuery] int page = 1, [FromQuery] int pageSize = 20)
        {
            try
            {
                var query = _context.Products
                    .Where(p => p.IsActive && p.CategoryId == id)
                    .Include(p => p.Category)
                    .OrderByDescending(p => p.DisplayOrder)
                    .ThenByDescending(p => p.CreatedAt);

                var totalCount = await query.CountAsync();
                
                var products = await query
                    .Skip((page - 1) * pageSize)
                    .Take(pageSize)
                    .Select(p => new
                    {
                        p.Id,
                        p.Name,
                        p.Description,
                        p.CategoryId,
                        CategoryName = p.Category.Name,
                        p.ImageUrl,
                        p.Tags,
                        p.AdditionalImages,
                        p.Hashtags,
                        p.Brand,
                        p.PartNumber,
                        p.CompatibleCars,
                        p.CarBrand,
                        p.CarModel,
                        p.Material,
                        p.Warranty,
                        p.DisplayOrder,
                        p.IsFeatured,
                        p.IsActive,
                        p.CreatedAt,
                        p.UpdatedAt
                    })
                    .ToListAsync();

                return Ok(new
                {
                    Products = products,
                    TotalCount = totalCount,
                    Page = page,
                    PageSize = pageSize,
                    TotalPages = (int)Math.Ceiling(totalCount / (double)pageSize)
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [Authorize(Roles = "Admin")]
        [HttpPost]
        public async Task<IActionResult> CreateCategory([FromBody] CreateCategoryDto createCategoryDto)
        {
            try
            {
                var existingCategory = await _context.Categories
                    .FirstOrDefaultAsync(c => c.Name == createCategoryDto.Name);

                if (existingCategory != null)
                    return BadRequest(new { message = "دستهبندی با این نام از قبل وجود دارد" });

                var category = new Category
                {
                    Name = createCategoryDto.Name,
                    Description = createCategoryDto.Description,
                    ImageUrl = createCategoryDto.ImageUrl,
                    ParentCategoryId = createCategoryDto.ParentCategoryId,
                    DisplayOrder = createCategoryDto.DisplayOrder,
                    IsActive = true,
                    CreatedAt = DateTime.UtcNow
                };

                _context.Categories.Add(category);
                await _context.SaveChangesAsync();

                return Ok(new CategoryDto
                {
                    Id = category.Id,
                    Name = category.Name,
                    Description = category.Description,
                    ImageUrl = category.ImageUrl,
                    DisplayOrder = category.DisplayOrder,
                    IsActive = category.IsActive,
                    ProductCount = 0
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [Authorize(Roles = "Admin")]
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCategory(int id, [FromBody] UpdateCategoryDto updateCategoryDto)
        {
            try
            {
                var category = await _context.Categories.FindAsync(id);
                
                if (category == null)
                    return NotFound(new { message = "دستهبندی پیدا نشد" });

                if (!string.IsNullOrEmpty(updateCategoryDto.Name) && updateCategoryDto.Name != category.Name)
                {
                    var existingCategory = await _context.Categories
                        .FirstOrDefaultAsync(c => c.Name == updateCategoryDto.Name && c.Id != id);

                    if (existingCategory != null)
                        return BadRequest(new { message = "دستهبندی با این نام از قبل وجود دارد" });
                }

                if (!string.IsNullOrEmpty(updateCategoryDto.Name))
                    category.Name = updateCategoryDto.Name;

                if (!string.IsNullOrEmpty(updateCategoryDto.Description))
                    category.Description = updateCategoryDto.Description;

                if (!string.IsNullOrEmpty(updateCategoryDto.ImageUrl))
                    category.ImageUrl = updateCategoryDto.ImageUrl;

                if (updateCategoryDto.ParentCategoryId.HasValue)
                    category.ParentCategoryId = updateCategoryDto.ParentCategoryId.Value;

                if (updateCategoryDto.DisplayOrder.HasValue)
                    category.DisplayOrder = updateCategoryDto.DisplayOrder.Value;

                if (updateCategoryDto.IsActive.HasValue)
                    category.IsActive = updateCategoryDto.IsActive.Value;

                category.UpdatedAt = DateTime.UtcNow;

                await _context.SaveChangesAsync();

                var productCount = await _context.Products
                    .CountAsync(p => p.CategoryId == id && p.IsActive);

                return Ok(new CategoryDto
                {
                    Id = category.Id,
                    Name = category.Name,
                    Description = category.Description,
                    ImageUrl = category.ImageUrl,
                    DisplayOrder = category.DisplayOrder,
                    IsActive = category.IsActive,
                    ProductCount = productCount
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [Authorize(Roles = "Admin")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCategory(int id)
        {
            try
            {
                var category = await _context.Categories.FindAsync(id);
                
                if (category == null)
                    return NotFound(new { message = "دستهبندی پیدا نشد" });

                var hasProducts = await _context.Products.AnyAsync(p => p.CategoryId == id && p.IsActive);
                
                if (hasProducts)
                    return BadRequest(new { message = "این دستهبندی دارای محصول فعال است و نمیتوان آن را حذف کرد" });

                category.IsActive = false;
                category.UpdatedAt = DateTime.UtcNow;

                await _context.SaveChangesAsync();

                return Ok(new { message = "دستهبندی با موفقیت حذف شد" });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }

    public class CategoryDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string ImageUrl { get; set; } = string.Empty;
        public int DisplayOrder { get; set; }
        public bool IsActive { get; set; }
        public int ProductCount { get; set; }
    }

    public class CategoryHierarchyDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string ImageUrl { get; set; } = string.Empty;
        public int DisplayOrder { get; set; }
        public List<CategorySimpleDto> SubCategories { get; set; } = new();
    }

    public class CategorySimpleDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string ImageUrl { get; set; } = string.Empty;
        public int DisplayOrder { get; set; }
    }

    public class CreateCategoryDto
    {
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty;

        [StringLength(500)]
        public string Description { get; set; } = string.Empty;

        [StringLength(500)]
        public string ImageUrl { get; set; } = string.Empty;

        public int? ParentCategoryId { get; set; }
        public int DisplayOrder { get; set; } = 0;
    }

    public class UpdateCategoryDto
    {
        [StringLength(100)]
        public string? Name { get; set; }

        [StringLength(500)]
        public string? Description { get; set; }

        [StringLength(500)]
        public string? ImageUrl { get; set; }

        public int? ParentCategoryId { get; set; }
        public int? DisplayOrder { get; set; }
        public bool? IsActive { get; set; }
    }
}