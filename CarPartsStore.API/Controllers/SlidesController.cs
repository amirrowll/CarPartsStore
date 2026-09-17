using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using CarPartsStore.API.Data;
using CarPartsStore.API.Models;
using CarPartsStore.API.DTOs;

namespace CarPartsStore.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SlidesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IWebHostEnvironment _environment;

        public SlidesController(ApplicationDbContext context, IWebHostEnvironment environment)
        {
            _context = context;
            _environment = environment;
        }

        // GET: api/Slides
        [HttpGet]
        public async Task<ActionResult<IEnumerable<SlideDto>>> GetSlides()
        {
            var slides = await _context.Slides
                .OrderBy(s => s.Order)
                .ToListAsync();

            return slides.Select(s => ToDto(s)).ToList();
        }

        // GET: api/Slides/active
        [HttpGet("active")]
        public async Task<ActionResult<IEnumerable<SlideDto>>> GetActiveSlides()
        {
            var slides = await _context.Slides
                .Where(s => s.IsActive)
                .OrderBy(s => s.Order)
                .ToListAsync();

            return slides.Select(s => ToDto(s)).ToList();
        }

        // GET: api/Slides/5
        [HttpGet("{id}")]
        public async Task<ActionResult<SlideDto>> GetSlide(int id)
        {
            var slide = await _context.Slides.FindAsync(id);

            if (slide == null)
            {
                return NotFound();
            }

            return ToDto(slide);
        }

        // POST: api/Slides
        [HttpPost]
        public async Task<ActionResult<SlideDto>> CreateSlide([FromForm] CreateSlideDto createSlideDto)
        {
            try
            {
                if (createSlideDto.Image == null || createSlideDto.Image.Length == 0)
                {
                    return BadRequest("تصویر الزامی است");
                }

                // Validate file type
                var allowedExtensions = new[] { ".jpg", ".jpeg", ".png", ".gif" };
                var extension = Path.GetExtension(createSlideDto.Image.FileName).ToLowerInvariant();
                if (!allowedExtensions.Contains(extension))
                {
                    return BadRequest("فرمت فایل مجاز نیست. فقط فرمت‌های JPG, PNG, GIF مجاز هستند");
                }

                // Validate file size (max 10MB)
                if (createSlideDto.Image.Length > 10 * 1024 * 1024)
                {
                    return BadRequest("حجم فایل نباید بیشتر از 10 مگابایت باشد");
                }

                // Create uploads directory if it doesn't exist
                var uploadsPath = Path.Combine(_environment.WebRootPath ?? "wwwroot", "uploads", "slides");
                if (!Directory.Exists(uploadsPath))
                {
                    Directory.CreateDirectory(uploadsPath);
                }

                // Generate unique filename
                var fileName = $"{Guid.NewGuid()}{extension}";
                var filePath = Path.Combine(uploadsPath, fileName);

                // Save file
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await createSlideDto.Image.CopyToAsync(stream);
                }

                // Get next order number
                var maxOrder = await _context.Slides.MaxAsync(s => (int?)s.Order) ?? 0;

                var slide = new Slide
                {
                    Title = createSlideDto.Title,
                    Description = createSlideDto.Description,
                    ImageUrl = $"/uploads/slides/{fileName}",
                    Order = maxOrder + 1,
                    IsActive = createSlideDto.IsActive,
                    CreatedAt = DateTime.UtcNow
                };

                _context.Slides.Add(slide);
                await _context.SaveChangesAsync();

                return CreatedAtAction(nameof(GetSlide), new { id = slide.Id }, ToDto(slide));
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"خطای داخلی سرور: {ex.Message}");
            }
        }

        // PUT: api/Slides/5
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateSlide(int id, UpdateSlideDto updateSlideDto)
        {
            var slide = await _context.Slides.FindAsync(id);
            if (slide == null)
            {
                return NotFound();
            }

            slide.Title = updateSlideDto.Title ?? slide.Title;
            slide.Description = updateSlideDto.Description ?? slide.Description;
            slide.Order = updateSlideDto.Order ?? slide.Order;
            slide.IsActive = updateSlideDto.IsActive ?? slide.IsActive;
            slide.UpdatedAt = DateTime.UtcNow;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SlideExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // PUT: api/Slides/order
        [HttpPut("order")]
        public async Task<IActionResult> UpdateSlideOrder(UpdateSlideOrderDto updateSlideOrderDto)
        {
            try
            {
                foreach (var slideOrder in updateSlideOrderDto.Slides)
                {
                    var slide = await _context.Slides.FindAsync(slideOrder.Id);
                    if (slide != null)
                    {
                        slide.Order = slideOrder.Order;
                        slide.UpdatedAt = DateTime.UtcNow;
                    }
                }

                await _context.SaveChangesAsync();
                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"خطا در به‌روزرسانی ترتیب: {ex.Message}");
            }
        }

        // PUT: api/Slides/5/toggle-status
        [HttpPut("{id}/toggle-status")]
        public async Task<IActionResult> ToggleSlideStatus(int id)
        {
            var slide = await _context.Slides.FindAsync(id);
            if (slide == null)
            {
                return NotFound();
            }

            slide.IsActive = !slide.IsActive;
            slide.UpdatedAt = DateTime.UtcNow;

            try
            {
                await _context.SaveChangesAsync();
                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"خطا در تغییر وضعیت: {ex.Message}");
            }
        }

        // DELETE: api/Slides/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSlide(int id)
        {
            var slide = await _context.Slides.FindAsync(id);
            if (slide == null)
            {
                return NotFound();
            }

            try
            {
                // Delete image file if exists
                if (!string.IsNullOrEmpty(slide.ImageUrl))
                {
                    var filePath = Path.Combine(_environment.WebRootPath ?? "wwwroot", slide.ImageUrl.TrimStart('/'));
                    if (System.IO.File.Exists(filePath))
                    {
                        System.IO.File.Delete(filePath);
                    }
                }

                _context.Slides.Remove(slide);
                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"خطا در حذف اسلاید: {ex.Message}");
            }
        }

        private bool SlideExists(int id)
        {
            return _context.Slides.Any(e => e.Id == id);
        }

        private static SlideDto ToDto(Slide slide)
        {
            return new SlideDto
            {
                Id = slide.Id,
                Title = slide.Title,
                Description = slide.Description,
                ImageUrl = slide.ImageUrl,
                Order = slide.Order,
                IsActive = slide.IsActive,
                CreatedAt = slide.CreatedAt,
                UpdatedAt = slide.UpdatedAt
            };
        }
    }
}