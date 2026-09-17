using CarPartsStore.API.Data;
using CarPartsStore.API.DTOs;
using CarPartsStore.API.Models;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace CarPartsStore.API.Services
{
    public interface IProductService
    {
        Task<ProductResponseDto> GetProductsAsync(ProductFilterDto filter);
        Task<ProductDto?> GetProductByIdAsync(int id);
        Task<ProductDto> CreateProductAsync(CreateProductDto createProductDto);
        Task<ProductDto?> UpdateProductAsync(int id, UpdateProductDto updateProductDto);
        Task<bool> DeleteProductAsync(int id);
        Task<List<ProductDto>> GetPopularProductsAsync(int count = 10);
        Task<List<ProductDto>> GetMostViewedProductsAsync(int count = 10);
        Task<List<string>> GetPopularTagsAsync(int count = 20);
        Task<List<ProductDto>> GetProductsByBrandAsync(string brand, int count = 20);
    }

    public class ProductService : IProductService
    {
        private readonly ApplicationDbContext _context;

        public ProductService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<ProductResponseDto> GetProductsAsync(ProductFilterDto filter)
        {
            var query = _context.Products
                .Include(p => p.Category)
                .Where(p => p.IsActive)
                .AsQueryable();

            // Apply filters
            if (!string.IsNullOrEmpty(filter.Search))
            {
                var searchTerm = filter.Search.ToLower();
                query = query.Where(p => 
                    p.Name.ToLower().Contains(searchTerm) || 
                    p.Description.ToLower().Contains(searchTerm) ||
                    p.PartNumber.ToLower().Contains(searchTerm) ||
                    p.Brand.ToLower().Contains(searchTerm) ||
                    p.CompatibleCars.ToLower().Contains(searchTerm) ||
                    p.CarBrand.ToLower().Contains(searchTerm) ||
                    p.CarModel.ToLower().Contains(searchTerm) ||
                    (p.Tags != null && p.Tags.Any(tag => tag.ToLower().Contains(searchTerm))));
            }

            if (filter.CategoryId.HasValue)
            {
                query = query.Where(p => p.CategoryId == filter.CategoryId.Value);
            }

            if (filter.IsFeatured.HasValue)
            {
                query = query.Where(p => p.IsFeatured == filter.IsFeatured.Value);
            }

            if (filter.IsActive.HasValue)
            {
                query = query.Where(p => p.IsActive == filter.IsActive.Value);
            }

            if (!string.IsNullOrEmpty(filter.Brand))
            {
                query = query.Where(p => p.Brand.ToLower() == filter.Brand.ToLower());
            }

            if (!string.IsNullOrEmpty(filter.CarBrand))
            {
                query = query.Where(p => p.CarBrand.ToLower() == filter.CarBrand.ToLower());
            }

            if (!string.IsNullOrEmpty(filter.CarModel))
            {
                query = query.Where(p => p.CarModel.ToLower() == filter.CarModel.ToLower());
            }

            if (!string.IsNullOrEmpty(filter.PartNumber))
            {
                query = query.Where(p => p.PartNumber.ToLower().Contains(filter.PartNumber.ToLower()));
            }

            if (!string.IsNullOrEmpty(filter.CompatibleCars))
            {
                query = query.Where(p => p.CompatibleCars.ToLower().Contains(filter.CompatibleCars.ToLower()));
            }

            // Filter by tags
            if (filter.Tags != null && filter.Tags.Length > 0)
            {
                query = query.Where(p => p.Tags != null && p.Tags.Any(tag => filter.Tags.Contains(tag)));
            }

            // Filter by hashtags
            if (filter.Hashtags != null && filter.Hashtags.Length > 0)
            {
                query = query.Where(p => p.Hashtags != null && p.Hashtags.Any(hashtag => filter.Hashtags.Contains(hashtag)));
            }

            // Filter by material
            if (!string.IsNullOrEmpty(filter.Material))
            {
                query = query.Where(p => p.Material.ToLower().Contains(filter.Material.ToLower()));
            }

            // Filter by warranty
            if (!string.IsNullOrEmpty(filter.Warranty))
            {
                query = query.Where(p => p.Warranty.ToLower().Contains(filter.Warranty.ToLower()));
            }

            // Apply sorting
            query = filter.SortBy?.ToLower() switch
            {
                "displayorder" => filter.SortDescending ? query.OrderByDescending(p => p.DisplayOrder) : query.OrderBy(p => p.DisplayOrder),
                "name" => filter.SortDescending ? query.OrderByDescending(p => p.Name) : query.OrderBy(p => p.Name),
                _ => filter.SortDescending ? query.OrderByDescending(p => p.CreatedAt) : query.OrderBy(p => p.CreatedAt)
            };

            // Get total count
            var totalCount = await query.CountAsync();

            // Apply pagination
            var products = await query
                .Skip((filter.Page - 1) * filter.PageSize)
                .Take(filter.PageSize)
                .Select(p => ProductService.MapToProductDto(p))
                .ToListAsync();

            return new ProductResponseDto
            {
                Products = products,
                TotalCount = totalCount,
                Page = filter.Page,
                PageSize = filter.PageSize,
                TotalPages = (int)Math.Ceiling(totalCount / (double)filter.PageSize)
            };
        }

        public async Task<ProductDto?> GetProductByIdAsync(int id)
        {
            var product = await _context.Products
                .Include(p => p.Category)
                .FirstOrDefaultAsync(p => p.Id == id);

            if (product == null)
                return null;

            return ProductService.MapToProductDto(product);
        }

        public async Task<ProductDto> CreateProductAsync(CreateProductDto createProductDto)
        {
            var product = new Product
            {
                Name = createProductDto.Name,
                Description = createProductDto.Description,
                CategoryId = createProductDto.CategoryId,
                ImageUrl = createProductDto.ImageUrl,
                Tags = createProductDto.Tags ?? Array.Empty<string>(),
                AdditionalImages = createProductDto.AdditionalImages ?? Array.Empty<string>(),
                Hashtags = createProductDto.Hashtags ?? Array.Empty<string>(),
                Brand = createProductDto.Brand,
                PartNumber = createProductDto.PartNumber,
                CompatibleCars = createProductDto.CompatibleCars,
                CarBrand = createProductDto.CarBrand,
                CarModel = createProductDto.CarModel,
                Material = createProductDto.Material,
                Warranty = createProductDto.Warranty,
                DisplayOrder = createProductDto.DisplayOrder,
                IsFeatured = createProductDto.IsFeatured,
                IsActive = createProductDto.IsActive,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };

            _context.Products.Add(product);
            await _context.SaveChangesAsync();

            return ProductService.MapToProductDto(product);
        }

        public async Task<ProductDto?> UpdateProductAsync(int id, UpdateProductDto updateProductDto)
        {
            var product = await _context.Products
                .Include(p => p.Category)
                .FirstOrDefaultAsync(p => p.Id == id);

            if (product == null)
                return null;

            // Update properties if provided
            if (!string.IsNullOrEmpty(updateProductDto.Name))
                product.Name = updateProductDto.Name;

            if (!string.IsNullOrEmpty(updateProductDto.Description))
                product.Description = updateProductDto.Description;

            if (updateProductDto.CategoryId.HasValue)
                product.CategoryId = updateProductDto.CategoryId.Value;

            if (!string.IsNullOrEmpty(updateProductDto.ImageUrl))
                product.ImageUrl = updateProductDto.ImageUrl;

            if (updateProductDto.Tags != null)
                product.Tags = updateProductDto.Tags;

            if (updateProductDto.Hashtags != null)
                product.Hashtags = updateProductDto.Hashtags;

            if (updateProductDto.AdditionalImages != null)
                product.AdditionalImages = updateProductDto.AdditionalImages;

            if (!string.IsNullOrEmpty(updateProductDto.Brand))
                product.Brand = updateProductDto.Brand;

            if (!string.IsNullOrEmpty(updateProductDto.PartNumber))
                product.PartNumber = updateProductDto.PartNumber;

            if (!string.IsNullOrEmpty(updateProductDto.CompatibleCars))
                product.CompatibleCars = updateProductDto.CompatibleCars;

            if (!string.IsNullOrEmpty(updateProductDto.CarBrand))
                product.CarBrand = updateProductDto.CarBrand;

            if (!string.IsNullOrEmpty(updateProductDto.CarModel))
                product.CarModel = updateProductDto.CarModel;

            if (!string.IsNullOrEmpty(updateProductDto.Material))
                product.Material = updateProductDto.Material;

            if (!string.IsNullOrEmpty(updateProductDto.Warranty))
                product.Warranty = updateProductDto.Warranty;

            if (updateProductDto.DisplayOrder.HasValue)
                product.DisplayOrder = updateProductDto.DisplayOrder.Value;

            if (updateProductDto.IsFeatured.HasValue)
                product.IsFeatured = updateProductDto.IsFeatured.Value;

            if (updateProductDto.IsActive.HasValue)
                product.IsActive = updateProductDto.IsActive.Value;

            product.UpdatedAt = DateTime.UtcNow;

            await _context.SaveChangesAsync();

            return ProductService.MapToProductDto(product);
        }

        public async Task<bool> DeleteProductAsync(int id)
        {
            var product = await _context.Products.FindAsync(id);
            
            if (product == null)
                return false;

            _context.Products.Remove(product);
            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<List<ProductDto>> GetPopularProductsAsync(int count = 10)
        {
            var products = await _context.Products
                .Where(p => p.IsActive)
                .OrderByDescending(p => p.DisplayOrder)
                .ThenByDescending(p => p.CreatedAt)
                .Take(count)
                .Include(p => p.Category)
                .Select(p => ProductService.MapToProductDto(p))
                .ToListAsync();

            return products;
        }

        public async Task<List<ProductDto>> GetMostViewedProductsAsync(int count = 10)
        {
            // برای سایت ایستاتیک، همان محصولات پاپولار را برمیگردانیم
            return await GetPopularProductsAsync(count);
        }

        public async Task<List<ProductDto>> GetProductsByBrandAsync(string brand, int count = 20)
        {
            // Map brand names for compatibility
            string brandFilter = brand.ToLower();
            
            // Handle different brand name variations
            if (brandFilter == "chinese")
                brandFilter = "chinese";
            else if (brandFilter == "saipa")
                brandFilter = "saipa";
            else if (brandFilter == "irankhodro")
                brandFilter = "irankhodro";
            else if (brandFilter == "iran khodro")
                brandFilter = "irankhodro";

            // Search in Brand field (case-insensitive)
            var products = await _context.Products
                .Where(p => p.IsActive && p.Brand.ToLower() == brandFilter)
                .OrderByDescending(p => p.DisplayOrder)
                .ThenByDescending(p => p.CreatedAt)
                .Take(count)
                .Include(p => p.Category)
                .Select(p => ProductService.MapToProductDto(p))
                .ToListAsync();

            return products;
        }

        public async Task<List<string>> GetPopularTagsAsync(int count = 20)
        {
            try
            {
                var allProducts = await _context.Products
                    .Where(p => p.IsActive && p.Tags != null && p.Tags.Length > 0)
                    .Select(p => p.Tags)
                    .ToListAsync();

                var allTags = new List<string>();
                foreach (var tagsArray in allProducts)
                {
                    if (tagsArray != null && tagsArray.Length > 0)
                    {
                        allTags.AddRange(tagsArray);
                    }
                }

                var tagGroups = allTags
                    .Where(tag => !string.IsNullOrEmpty(tag))
                    .GroupBy(tag => tag)
                    .Select(g => new { Tag = g.Key, Count = g.Count() })
                    .OrderByDescending(g => g.Count)
                    .Take(count)
                    .Select(g => g.Tag)
                    .ToList();

                return tagGroups;
            }
            catch (Exception)
            {
                // Return empty list if there's an error
                return new List<string>();
            }
        }



        public static ProductDto MapToProductDto(Product product)
        {
            return new ProductDto
            {
                Id = product.Id,
                Name = product.Name,
                Description = product.Description,
                CategoryId = product.CategoryId,
                CategoryName = product.Category?.Name ?? string.Empty,
                ImageUrl = product.ImageUrl,
                Tags = product.Tags,
                AdditionalImages = product.AdditionalImages,
                Hashtags = product.Hashtags,
                Brand = product.Brand,
                PartNumber = product.PartNumber,
                CompatibleCars = product.CompatibleCars,
                CarBrand = product.CarBrand,
                CarModel = product.CarModel,
                Material = product.Material,
                Warranty = product.Warranty,
                DisplayOrder = product.DisplayOrder,
                IsFeatured = product.IsFeatured,
                IsActive = product.IsActive,
                CreatedAt = product.CreatedAt,
                UpdatedAt = product.UpdatedAt
            };
        }
    }
}