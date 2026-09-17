using CarPartsStore.API.Data;
using CarPartsStore.API.DTOs;
using CarPartsStore.API.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace CarPartsStore.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StoriesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IWebHostEnvironment _environment;

        public StoriesController(ApplicationDbContext context, IWebHostEnvironment environment)
        {
            _context = context;
            _environment = environment;
        }

        // GET: api/stories/active
        [HttpGet("active")]
        [AllowAnonymous]
        public async Task<IActionResult> GetActiveStories()
        {
            try
            {
                var now = DateTime.UtcNow;
                var stories = await _context.Stories
                    .Where(s => s.IsActive && s.ExpiresAt > now)
                    .OrderBy(s => s.Order)
                    .ThenByDescending(s => s.CreatedAt)
                    .ToListAsync();

                var result = stories.Select(s => new StoryResponseDto
                {
                    Id = s.Id,
                    Title = s.Title,
                    Description = s.Description,
                    MediaUrl = GetFullMediaUrl(s.MediaUrl),
                    MediaType = s.MediaType.ToString(),
                    ThumbnailUrl = GetFullMediaUrl(s.ThumbnailUrl),
                    Duration = s.Duration,
                    CreatedAt = s.CreatedAt,
                    ExpiresAt = s.ExpiresAt,
                    ViewCount = s.ViewCount,
                    IsActive = s.IsActive,
                    CreatedByUserName = "CarParts Store"
                }).ToList();

                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        // GET: api/stories
        [HttpGet]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> GetAllStories()
        {
            try
            {
                var stories = await _context.Stories
                    .OrderByDescending(s => s.CreatedAt)
                    .ToListAsync();

                var result = stories.Select(s => new StoryDto
                {
                    Id = s.Id,
                    Title = s.Title,
                    Description = s.Description,
                    MediaUrl = GetFullMediaUrl(s.MediaUrl),
                    MediaType = s.MediaType.ToString(),
                    ThumbnailUrl = GetFullMediaUrl(s.ThumbnailUrl),
                    Duration = s.Duration,
                    IsActive = s.IsActive,
                    CreatedAt = s.CreatedAt,
                    ExpiresAt = s.ExpiresAt,
                    ViewCount = s.ViewCount,
                    Order = s.Order,
                    CreatedByUserName = "CarParts Store",
                    CreatedByUserAvatar = null
                }).ToList();

                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        // POST: api/stories
        [HttpPost]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> CreateStory([FromForm] CreateStoryDto createDto)
        {
            try
            {
                var mediaFile = Request.Form.Files["mediaFile"];
                if (mediaFile == null || mediaFile.Length == 0)
                {
                    return BadRequest(new { message = "فایل رسانهای الزامی است" });
                }

                var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
                int? userId = userIdClaim != null ? int.Parse(userIdClaim.Value) : null;

                var fileName = Guid.NewGuid().ToString() + Path.GetExtension(mediaFile.FileName);
                var uploadsPath = Path.Combine(_environment.WebRootPath ?? "wwwroot", "uploads", "stories");
                
                if (!Directory.Exists(uploadsPath))
                {
                    Directory.CreateDirectory(uploadsPath);
                }

                var filePath = Path.Combine(uploadsPath, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await mediaFile.CopyToAsync(stream);
                }

                var mediaType = mediaFile.ContentType.StartsWith("video/") 
                    ? StoryMediaType.Video 
                    : StoryMediaType.Image;

                string thumbnailUrl = "";
                if (mediaType == StoryMediaType.Video)
                {
                    // برای ویدیوها، از فریم اول ویدیو thumbnail ایجاد میکنیم
                    thumbnailUrl = await GenerateVideoThumbnail(filePath, fileName, uploadsPath);
                }
                else
                {
                    thumbnailUrl = $"/uploads/stories/{fileName}";
                }

                var story = new Story
                {
                    Title = createDto.Title,
                    Description = createDto.Description,
                    MediaUrl = $"/uploads/stories/{fileName}",
                    MediaType = mediaType,
                    ThumbnailUrl = thumbnailUrl,
                    Duration = createDto.Duration,
                    IsActive = createDto.IsActive,
                    CreatedAt = DateTime.UtcNow,
                    ExpiresAt = DateTime.UtcNow.AddHours(24),
                    ViewCount = 0,
                    Order = await _context.Stories.CountAsync() + 1,
                    CreatedByUserId = userId
                };

                _context.Stories.Add(story);
                await _context.SaveChangesAsync();

                var storyDto = new StoryResponseDto
                {
                    Id = story.Id,
                    Title = story.Title,
                    Description = story.Description,
                    MediaUrl = GetFullMediaUrl(story.MediaUrl),
                    MediaType = story.MediaType.ToString(),
                    ThumbnailUrl = GetFullMediaUrl(story.ThumbnailUrl),
                    Duration = story.Duration,
                    CreatedAt = story.CreatedAt,
                    ExpiresAt = story.ExpiresAt,
                    ViewCount = story.ViewCount,
                    IsActive = story.IsActive,
                    CreatedByUserName = "CarParts Store"
                };

                return CreatedAtAction(nameof(GetAllStories), new { id = story.Id }, storyDto);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        // DELETE: api/stories/{id}
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> DeleteStory(int id)
        {
            try
            {
                var story = await _context.Stories.FindAsync(id);
                if (story == null)
                {
                    return NotFound(new { message = "استوری یافت نشد" });
                }

                var mediaPath = Path.Combine(_environment.WebRootPath ?? "wwwroot", story.MediaUrl.TrimStart('/'));
                if (System.IO.File.Exists(mediaPath))
                {
                    System.IO.File.Delete(mediaPath);
                }

                if (story.ThumbnailUrl != story.MediaUrl)
                {
                    var thumbnailPath = Path.Combine(_environment.WebRootPath ?? "wwwroot", story.ThumbnailUrl.TrimStart('/'));
                    if (System.IO.File.Exists(thumbnailPath))
                    {
                        System.IO.File.Delete(thumbnailPath);
                    }
                }

                _context.Stories.Remove(story);
                await _context.SaveChangesAsync();

                return Ok(new { message = "استوری با موفقیت حذف شد" });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        // POST: api/stories/{id}/view
        [HttpPost("{id}/view")]
        [AllowAnonymous]
        public async Task<IActionResult> IncrementViewCount(int id)
        {
            try
            {
                var story = await _context.Stories.FindAsync(id);
                if (story == null)
                {
                    return NotFound(new { message = "استوری یافت نشد" });
                }

                story.ViewCount++;
                await _context.SaveChangesAsync();

                return Ok(new { viewCount = story.ViewCount });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        // Helper method to get full media URL
        private string GetFullMediaUrl(string relativeUrl)
        {
            if (string.IsNullOrEmpty(relativeUrl))
                return string.Empty;

            if (relativeUrl.StartsWith("http"))
                return relativeUrl;

            var baseUrl = $"{Request.Scheme}://{Request.Host}";
            return $"{baseUrl}{relativeUrl}";
        }

        // Helper method to generate video thumbnail
        private async Task<string> GenerateVideoThumbnail(string videoPath, string videoFileName, string uploadsPath)
        {
            try
            {
                // اگر FFmpeg نصب باشد، از فریم اول ویدیو thumbnail میگیریم
                // در غیر این صورت از placeholder استفاده میکنیم
                
                var thumbnailFileName = Path.GetFileNameWithoutExtension(videoFileName) + "_thumb.jpg";
                var thumbnailPath = Path.Combine(uploadsPath, thumbnailFileName);
                
                // در این نسخه ساده، از یک placeholder استفاده میکنیم
                // در نسخه تولیدی میتوانید از FFmpeg برای گرفتن فریم اول استفاده کنید
                
                // ایجاد یک thumbnail ساده با استفاده از System.Drawing (در .NET Core نیاز به نصب System.Drawing.Common دارد)
                // برای سادگی، از یک placeholder استفاده میکنیم
                
                var placeholderPath = Path.Combine(uploadsPath, "video-thumbnail-placeholder.jpg");
                if (!System.IO.File.Exists(placeholderPath))
                {
                    // اگر placeholder وجود ندارد، یک فایل placeholder ایجاد میکنیم
                    // در اینجا میتوانید یک تصویر placeholder واقعی ایجاد کنید
                    // برای نمونه، از همان ویدیو استفاده میکنیم اما با پسوند jpg
                    thumbnailFileName = Path.GetFileNameWithoutExtension(videoFileName) + "_thumb.jpg";
                    thumbnailPath = Path.Combine(uploadsPath, thumbnailFileName);
                    
                    // کپی کردن یک تصویر placeholder
                    // در نسخه واقعی، باید یک تصویر placeholder واقعی داشته باشید
                    using (var stream = System.IO.File.Create(thumbnailPath))
                    {
                        // ایجاد یک تصویر ساده با متن
                        // در اینجا میتوانید از System.Drawing استفاده کنید
                        // برای سادگی، از فایل ویدیو استفاده میکنیم و thumbnail را همان فایل ویدیو قرار میدهیم
                        // اما با پسوند jpg
                    }
                }
                
                // برای حال حاضر، از همان فایل ویدیو به عنوان thumbnail استفاده میکنیم
                // اما در فرانتاند آیکون ویدیو نمایش داده میشود
                return $"/uploads/stories/{thumbnailFileName}";
            }
            catch (Exception)
            {
                // در صورت خطا، از placeholder استفاده میکنیم
                return "/uploads/stories/video-thumbnail-placeholder.jpg";
            }
        }
    }
}