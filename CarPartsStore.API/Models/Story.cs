using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarPartsStore.API.Models
{
    public class Story
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Required]
        [MaxLength(200)]
        public string Title { get; set; } = string.Empty;

        [MaxLength(500)]
        public string Description { get; set; } = string.Empty;

        [Required]
        [MaxLength(500)]
        public string MediaUrl { get; set; } = string.Empty;

        [Required]
        public StoryMediaType MediaType { get; set; } = StoryMediaType.Image;

        [Required]
        public string ThumbnailUrl { get; set; } = string.Empty;

        [Required]
        public int Duration { get; set; } = 5; // Duration in seconds

        [Required]
        public bool IsActive { get; set; } = true;

        [Required]
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        [Required]
        public DateTime ExpiresAt { get; set; } = DateTime.UtcNow.AddHours(24); // Stories expire after 24 hours

        public DateTime? UpdatedAt { get; set; }

        public int ViewCount { get; set; } = 0;

        [Required]
        public int Order { get; set; } = 1;

        // Navigation properties
        public int? CreatedByUserId { get; set; }
        public virtual User? CreatedByUser { get; set; }
    }

    public enum StoryMediaType
    {
        Image,
        Video
    }
}