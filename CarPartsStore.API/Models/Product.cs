using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarPartsStore.API.Models
{
    public class Product
    {
        [Key]
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
        
        // For static site - no price or stock
        public bool IsActive { get; set; } = true;
        
        public bool IsFeatured { get; set; } = false;
        
        // Brand information
        [StringLength(100)]
        public string Brand { get; set; } = string.Empty;
        
        [StringLength(50)]
        public string PartNumber { get; set; } = string.Empty;
        
        // Car compatibility
        [StringLength(200)]
        public string CompatibleCars { get; set; } = string.Empty;
        
        [StringLength(100)]
        public string CarBrand { get; set; } = string.Empty; // Chinese, Saipa, IranKhodro, Other
        
        [StringLength(100)]
        public string CarModel { get; set; } = string.Empty;
        
        // Product specifications
        [StringLength(50)]
        public string Material { get; set; } = string.Empty;
        
        [StringLength(50)]
        public string Warranty { get; set; } = string.Empty;
        
        // Hashtags for search and categorization
        public string[] Hashtags { get; set; } = Array.Empty<string>();
        
        // Position in category (for ordering)
        public int DisplayOrder { get; set; } = 0;
        
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime? UpdatedAt { get; set; }
        
        // Navigation properties
        [ForeignKey("CategoryId")]
        public virtual Category Category { get; set; } = null!;
    }
}