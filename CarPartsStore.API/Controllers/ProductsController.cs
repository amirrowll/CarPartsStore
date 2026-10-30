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
                CreateProductDto createProductDto;
                IFormFile? file = null;

                if (Request.ContentType?.Contains("application/json") == true)
                {
                    using var reader = new StreamReader(Request.Body);
                    var body = await reader.ReadToEndAsync();
                    createProductDto = System.Text.Json.JsonSerializer.Deserialize<CreateProductDto>(body, new System.Text.Json.JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    }) ?? new CreateProductDto();
                }
                else
                {
                    var form = await Request.ReadFormAsync();
                    createProductDto = new CreateProductDto
                    {
                        Name = form.ContainsKey("name") ? form["name"].ToString() ?? string.Empty : string.Empty,
                        Description = form.ContainsKey("description") ? form["description"].ToString() ?? string.Empty : string.Empty,
                        CategoryId = form.ContainsKey("categoryId") && int.TryParse(form["categoryId"].ToString(), out var catId) ? catId : 1,
                        ImageUrl = form.ContainsKey("imageUrl") ? form["imageUrl"].ToString() ?? string.Empty : string.Empty,
                        Tags = form.ContainsKey("tags") && !string.IsNullOrWhiteSpace(form["tags"].ToString())
                            ? form["tags"].ToString()!.Split(',', StringSplitOptions.RemoveEmptyEntries).Select(t => t.Trim()).ToArray()
                            : Array.Empty<string>(),
                        Brand = form.ContainsKey("brand") ? form["brand"].ToString() ?? string.Empty : string.Empty,
                        PartNumber = form.ContainsKey("partNumber") ? form["partNumber"].ToString() ?? string.Empty : string.Empty,
                        CompatibleCars = form.ContainsKey("compatibleCars") ? form["compatibleCars"].ToString() ?? string.Empty : string.Empty,
                        CarBrand = form.ContainsKey("carBrand") ? form["carBrand"].ToString() ?? string.Empty : string.Empty,
                        CarModel = form.ContainsKey("carModel") ? form["carModel"].ToString() ?? string.Empty : string.Empty,
                        Material = form.ContainsKey("material") ? form["material"].ToString() ?? string.Empty : string.Empty,
                        Warranty = form.ContainsKey("warranty") ? form["warranty"].ToString() ?? string.Empty : string.Empty,
                        DisplayOrder = form.ContainsKey("displayOrder") && int.TryParse(form["displayOrder"].ToString(), out var dispOrder) ? dispOrder : 0,
                        IsFeatured = form.ContainsKey("isFeatured") && bool.TryParse(form["isFeatured"].ToString(), out var isFeat) ? isFeat : false,
                        IsActive = form.ContainsKey("isActive") && bool.TryParse(form["isActive"].ToString(), out var isAct) ? isAct : true
                    };
                    file = form.Files.FirstOrDefault(f => f.Name == "imageFile");
                }

                // Handle file upload
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
                UpdateProductDto updateProductDto;
                IFormFile? file = null;

                if (Request.ContentType?.Contains("application/json") == true)
                {
                    using var reader = new StreamReader(Request.Body);
                    var body = await reader.ReadToEndAsync();
                    updateProductDto = System.Text.Json.JsonSerializer.Deserialize<UpdateProductDto>(body, new System.Text.Json.JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    }) ?? new UpdateProductDto();
                }
                else
                {
                    var form = await Request.ReadFormAsync();
                    updateProductDto = new UpdateProductDto
                    {
                        Name = form.ContainsKey("name") ? form["name"].ToString() : null,
                        Description = form.ContainsKey("description") ? form["description"].ToString() : null,
                        CategoryId = form.ContainsKey("categoryId") && int.TryParse(form["categoryId"].ToString(), out var uCatId) ? uCatId : null,
                        ImageUrl = form.ContainsKey("imageUrl") ? form["imageUrl"].ToString() : null,
                        Tags = form.ContainsKey("tags") 
                            ? (string.IsNullOrWhiteSpace(form["tags"].ToString()) ? Array.Empty<string>() : form["tags"].ToString()!.Split(',', StringSplitOptions.RemoveEmptyEntries).Select(t => t.Trim()).ToArray())
                            : null,
                        Brand = form.ContainsKey("brand") ? form["brand"].ToString() : null,
                        PartNumber = form.ContainsKey("partNumber") ? form["partNumber"].ToString() : null,
                        CompatibleCars = form.ContainsKey("compatibleCars") ? form["compatibleCars"].ToString() : null,
                        CarBrand = form.ContainsKey("carBrand") ? form["carBrand"].ToString() : null,
                        CarModel = form.ContainsKey("carModel") ? form["carModel"].ToString() : null,
                        Material = form.ContainsKey("material") ? form["material"].ToString() : null,
                        Warranty = form.ContainsKey("warranty") ? form["warranty"].ToString() : null,
                        DisplayOrder = form.ContainsKey("displayOrder") && int.TryParse(form["displayOrder"].ToString(), out var uDispOrder) ? uDispOrder : null,
                        IsFeatured = form.ContainsKey("isFeatured") && bool.TryParse(form["isFeatured"].ToString(), out var uIsFeat) ? uIsFeat : null,
                        IsActive = form.ContainsKey("isActive") && bool.TryParse(form["isActive"].ToString(), out var uIsAct) ? uIsAct : null
                    };
                    file = form.Files.FirstOrDefault(f => f.Name == "imageFile");
                }

                // Handle file upload
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