using System.ComponentModel.DataAnnotations;

namespace CarPartsStore.API.DTOs
{
    public class ProductDto
    {
        public int Id { get; set; }
        
        [Required]
        [StringLength(200)]
        public string Name { get; set; } = string.Empty;
        
        [StringLength(2000)]
        public string Description { get; set; } = string.Empty;
        
        [Required]
        public int CategoryId { get; set; }
        
        [Required]
        [StringLength(500)]
        public string ImageUrl { get; set; } = string.Empty;
        
        public string[] Tags { get; set; } = Array.Empty<string>();
        public string[] AdditionalImages { get; set; } = Array.Empty<string>();
        public string[] Hashtags { get; set; } = Array.Empty<string>();
        
        [StringLength(100)]
        public string Brand { get; set; } = string.Empty;
        
        [StringLength(50)]
        public string PartNumber { get; set; } = string.Empty;
        
        [StringLength(200)]
        public string CompatibleCars { get; set; } = string.Empty;

        [StringLength(100)]
        public string CarBrand { get; set; } = string.Empty; // Chinese, Saipa, IranKhodro, Other

        [StringLength(100)]
        public string CarModel { get; set; } = string.Empty;

        [StringLength(50)]
        public string Material { get; set; } = string.Empty;

        [StringLength(50)]
        public string Warranty { get; set; } = string.Empty;

        public int DisplayOrder { get; set; } = 0;

        public bool IsFeatured { get; set; } = false;

        public bool IsActive { get; set; } = true;
        
        public DateTime CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        
        public string CategoryName { get; set; } = string.Empty;
    }
    
    public class CreateProductDto
    {
        [Required]
        [StringLength(200)]
        public string Name { get; set; } = string.Empty;
        
        [StringLength(2000)]
        public string Description { get; set; } = string.Empty;
        
        [Required]
        public int CategoryId { get; set; }
        
        [Required]
        [StringLength(500)]
        public string ImageUrl { get; set; } = string.Empty;
        
        public string[]? Tags { get; set; }
        public string[]? AdditionalImages { get; set; }
        public string[]? Hashtags { get; set; }
        
        [StringLength(100)]
        public string Brand { get; set; } = string.Empty;
        
        [StringLength(50)]
        public string PartNumber { get; set; } = string.Empty;
        
        [StringLength(200)]
        public string CompatibleCars { get; set; } = string.Empty;
        
        [StringLength(100)]
        public string CarBrand { get; set; } = string.Empty;
        
        [StringLength(100)]
        public string CarModel { get; set; } = string.Empty;
        
        [StringLength(50)]
        public string Material { get; set; } = string.Empty;
        
        [StringLength(50)]
        public string Warranty { get; set; } = string.Empty;
        
        public int DisplayOrder { get; set; } = 0;
        
        public bool IsFeatured { get; set; } = false;
        
        public bool IsActive { get; set; } = true;
    }

    public class UpdateProductDto
    {
        [StringLength(200)]
        public string? Name { get; set; }

        [StringLength(2000)]
        public string? Description { get; set; }

        public int? CategoryId { get; set; }

        [StringLength(500)]
        public string? ImageUrl { get; set; }

        public string[]? Tags { get; set; }
        public string[]? Hashtags { get; set; }

        public string[]? AdditionalImages { get; set; }

        // Product specifications for static site
        [StringLength(100)]
        public string? Brand { get; set; }

        [StringLength(50)]
        public string? PartNumber { get; set; }

        [StringLength(200)]
        public string? CompatibleCars { get; set; }

        [StringLength(100)]
        public string? CarBrand { get; set; }

        [StringLength(100)]
        public string? CarModel { get; set; }

        [StringLength(50)]
        public string? Material { get; set; }

        [StringLength(50)]
        public string? Warranty { get; set; }

        public int? DisplayOrder { get; set; }

        public bool? IsFeatured { get; set; }
        public bool? IsActive { get; set; }
    }

    public class ProductFilterDto
    {
        public string? Search { get; set; }
        public int? CategoryId { get; set; }
        public bool? IsFeatured { get; set; }
        public bool? IsActive { get; set; } = true;
        public string? Brand { get; set; }
        public string? CarBrand { get; set; } // Chinese, Saipa, IranKhodro, Other
        public string? CarModel { get; set; }
        public string? PartNumber { get; set; }
        public string? CompatibleCars { get; set; }
        public string[]? Tags { get; set; }
        public string[]? Hashtags { get; set; }
        public string? Material { get; set; }
        public string? Warranty { get; set; }
        public string? SortBy { get; set; } = "createdAt"; // createdAt, displayOrder, name
        public bool SortDescending { get; set; } = true;
        public int Page { get; set; } = 1;
        public int PageSize { get; set; } = 20;
    }

    public class ProductResponseDto
    {
        public List<ProductDto> Products { get; set; } = new();
        public int TotalCount { get; set; }
        public int Page { get; set; }
        public int PageSize { get; set; }
        public int TotalPages { get; set; }
    }
}