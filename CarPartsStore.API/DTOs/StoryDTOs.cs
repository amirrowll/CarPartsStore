using System;
using System.ComponentModel.DataAnnotations;

namespace CarPartsStore.API.DTOs
{
    public class StoryDto
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string MediaUrl { get; set; } = string.Empty;
        public string MediaType { get; set; } = string.Empty;
        public string ThumbnailUrl { get; set; } = string.Empty;
        public int Duration { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime ExpiresAt { get; set; }
        public int ViewCount { get; set; }
        public int Order { get; set; }
        public string? CreatedByUserName { get; set; }
        public string? CreatedByUserAvatar { get; set; }
    }

    public class CreateStoryDto
    {
        [Required]
        [MaxLength(200)]
        public string Title { get; set; } = string.Empty;

        [MaxLength(500)]
        public string Description { get; set; } = string.Empty;

        [Required]
        public string MediaType { get; set; } = "Image";

        [Required]
        [Range(1, 30)]
        public int Duration { get; set; } = 5;

        public bool IsActive { get; set; } = true;
    }

    public class UpdateStoryDto
    {
        [MaxLength(200)]
        public string? Title { get; set; }

        [MaxLength(500)]
        public string? Description { get; set; }

        [Range(1, 30)]
        public int? Duration { get; set; }

        public bool? IsActive { get; set; }
    }

    public class StoryResponseDto
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string MediaUrl { get; set; } = string.Empty;
        public string MediaType { get; set; } = string.Empty;
        public string ThumbnailUrl { get; set; } = string.Empty;
        public int Duration { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime ExpiresAt { get; set; }
        public int ViewCount { get; set; }
        public bool IsActive { get; set; }
        public string? CreatedByUserName { get; set; }
    }
}