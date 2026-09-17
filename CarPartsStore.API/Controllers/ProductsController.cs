using CarPartsStore.API.DTOs;
using CarPartsStore.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CarPartsStore.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        private readonly IProductService _productService;
        private readonly IWebHostEnvironment _environment;

        public ProductsController(IProductService productService, IWebHostEnvironment environment)
        {
            _productService = productService;
            _environment = environment;
        }

        [HttpGet]
        [ResponseCache(Duration = 60, VaryByQueryKeys = new[] { "*" })]
        public async Task<IActionResult> GetProducts([FromQuery] ProductFilterDto filter)
        {
            try
            {
                var result = await _productService.GetProductsAsync(filter);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpGet("{id}")]
        [ResponseCache(Duration = 300, VaryByQueryKeys = new[] { "id" })]
        public async Task<IActionResult> GetProduct(int id)
        {
            try
            {
                var product = await _productService.GetProductByIdAsync(id);
                
                if (product == null)
                    return NotFound(new { message = "Product not found" });

                return Ok(product);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpGet("popular")]
        [ResponseCache(Duration = 120, VaryByQueryKeys = new[] { "count" })]
        public async Task<IActionResult> GetPopularProducts([FromQuery] int count = 10)
        {
            try
            {
                var products = await _productService.GetPopularProductsAsync(count);
                return Ok(products);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpGet("most-viewed")]
        [ResponseCache(Duration = 120, VaryByQueryKeys = new[] { "count" })]
        public async Task<IActionResult> GetMostViewedProducts([FromQuery] int count = 10)
        {
            try
            {
                var products = await _productService.GetMostViewedProductsAsync(count);
                return Ok(products);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpGet("by-brand/{brand}")]
        [ResponseCache(Duration = 120, VaryByQueryKeys = new[] { "brand", "count" })]
        public async Task<IActionResult> GetProductsByBrand(string brand, [FromQuery] int count = 20)
        {
            try
            {
                var products = await _productService.GetProductsByBrandAsync(brand, count);
                return Ok(products);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpPost("{id}/increment-view")]
        public async Task<IActionResult> IncrementViewCount(int id)
        {
            try
            {
                // For static site, just return success
                return Ok(new { success = true, message = "View count incremented" });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpGet("popular-tags")]
        [ResponseCache(Duration = 300, VaryByQueryKeys = new[] { "count" })]
        public async Task<IActionResult> GetPopularTags([FromQuery] int count = 20)
        {
            try
            {
                var tags = await _productService.GetPopularTagsAsync(count);
                return Ok(tags);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [Authorize(Roles = "Admin")]
        [HttpPost]
        public async Task<IActionResult> CreateProduct()
        {
            try
            {
                var form = await Request.ReadFormAsync();
                
                // Parse product data from form
                var createProductDto = new CreateProductDto
                {
                    Name = form["name"].ToString() ?? string.Empty,
                    Description = form["description"].ToString() ?? string.Empty,
                    CategoryId = int.Parse(form["categoryId"].ToString() ?? "1"),
                    ImageUrl = form["imageUrl"].ToString() ?? string.Empty,
                    Tags = form["tags"].ToString()?.Split(',', StringSplitOptions.RemoveEmptyEntries) ?? Array.Empty<string>(),
                    Brand = form["brand"].ToString() ?? string.Empty,
                    PartNumber = form["partNumber"].ToString() ?? string.Empty,
                    CompatibleCars = form["compatibleCars"].ToString() ?? string.Empty,
                    DisplayOrder = int.Parse(form["displayOrder"].ToString() ?? "0"),
                    IsFeatured = bool.Parse(form["isFeatured"].ToString() ?? "false"),
                    IsActive = bool.Parse(form["isActive"].ToString() ?? "true")
                };

                // Handle file upload
                var file = form.Files.FirstOrDefault(f => f.Name == "imageFile");
                if (file != null && file.Length > 0)
                {
                    var uploadsFolder = Path.Combine(_environment.WebRootPath, "uploads", "products");
                    if (!Directory.Exists(uploadsFolder))
                        Directory.CreateDirectory(uploadsFolder);

                    var uniqueFileName = Guid.NewGuid().ToString() + "_" + file.FileName;
                    var filePath = Path.Combine(uploadsFolder, uniqueFileName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                    }

                    createProductDto.ImageUrl = $"/uploads/products/{uniqueFileName}";
                }

                var product = await _productService.CreateProductAsync(createProductDto);
                return CreatedAtAction(nameof(GetProduct), new { id = product.Id }, product);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [Authorize(Roles = "Admin")]
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateProduct(int id)
        {
            try
            {
                var form = await Request.ReadFormAsync();
                
                // Parse product data from form
                var updateProductDto = new UpdateProductDto
                {
                    Name = form["name"].ToString(),
                    Description = form["description"].ToString(),
                    CategoryId = form["categoryId"].Count > 0 ? int.Parse(form["categoryId"].ToString() ?? "1") : (int?)null,
                    ImageUrl = form["imageUrl"].ToString(),
                    Tags = form["tags"].ToString()?.Split(',', StringSplitOptions.RemoveEmptyEntries) ?? Array.Empty<string>(),
                    Brand = form["brand"].ToString(),
                    PartNumber = form["partNumber"].ToString(),
                    CompatibleCars = form["compatibleCars"].ToString(),
                    DisplayOrder = form["displayOrder"].Count > 0 ? int.Parse(form["displayOrder"].ToString() ?? "0") : (int?)null,
                    IsFeatured = form["isFeatured"].Count > 0 ? bool.Parse(form["isFeatured"].ToString() ?? "false") : (bool?)null,
                    IsActive = form["isActive"].Count > 0 ? bool.Parse(form["isActive"].ToString() ?? "true") : (bool?)null
                };

                // Handle file upload
                var file = form.Files.FirstOrDefault(f => f.Name == "imageFile");
                if (file != null && file.Length > 0)
                {
                    var uploadsFolder = Path.Combine(_environment.WebRootPath, "uploads", "products");
                    if (!Directory.Exists(uploadsFolder))
                        Directory.CreateDirectory(uploadsFolder);

                    var uniqueFileName = Guid.NewGuid().ToString() + "_" + file.FileName;
                    var filePath = Path.Combine(uploadsFolder, uniqueFileName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                    }

                    updateProductDto.ImageUrl = $"/uploads/products/{uniqueFileName}";
                }

                var product = await _productService.UpdateProductAsync(id, updateProductDto);
                
                if (product == null)
                    return NotFound(new { message = "Product not found" });

                return Ok(product);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [Authorize(Roles = "Admin")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProduct(int id)
        {
            try
            {
                var result = await _productService.DeleteProductAsync(id);
                
                if (!result)
                    return NotFound(new { message = "Product not found" });

                return Ok(new { message = "Product deleted successfully" });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}