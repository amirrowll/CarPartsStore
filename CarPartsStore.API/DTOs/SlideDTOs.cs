using System;
using Microsoft.AspNetCore.Http;

namespace CarPartsStore.API.DTOs
{
    public class SlideDto
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string ImageUrl { get; set; } = string.Empty;
        public int Order { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
    }

    public class CreateSlideDto
    {
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public IFormFile Image { get; set; } = null!;
        public bool IsActive { get; set; } = true;
    }

    public class UpdateSlideDto
    {
        public string? Title { get; set; }
        public string? Description { get; set; }
        public int? Order { get; set; }
        public bool? IsActive { get; set; }
    }

    public class SlideOrderDto
    {
        public int Id { get; set; }
        public int Order { get; set; }
    }

    public class UpdateSlideOrderDto
    {
        public List<SlideOrderDto> Slides { get; set; } = new List<SlideOrderDto>();
    }
}