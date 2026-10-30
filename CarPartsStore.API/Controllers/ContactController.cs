using Microsoft.AspNetCore.Mvc;
using System.Collections.Concurrent;
using System.Net;
using System.Net.Mail;

namespace CarPartsStore.API.Controllers
{
    public class CallRequestDto
    {
        public string PhoneNumber { get; set; } = string.Empty;
        public string? Name { get; set; }
        public string? Category { get; set; }
        public string? Note { get; set; }
        public string? Email { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }

    [ApiController]
    [Route("api/[controller]")]
    public class ContactController : ControllerBase
    {
        private static readonly ConcurrentBag<CallRequestDto> _callRequests = new();
        private readonly IConfiguration _configuration;

        public ContactController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpPost("call-request")]
        public async Task<IActionResult> CreateCallRequest([FromBody] CallRequestDto request)
        {
            if (string.IsNullOrWhiteSpace(request.PhoneNumber))
            {
                return BadRequest(new { message = "شماره تلفن الزامی است." });
            }

            request.CreatedAt = DateTime.UtcNow;
            _callRequests.Add(request);

            Console.WriteLine($"[CallRequest Received] From: {request.PhoneNumber}, Name: {request.Name}, Category: {request.Category}, Note: {request.Note}");

            // Send Email Notification in Background Task (non-blocking)
            _ = Task.Run(async () =>
            {
                await SendAdminNotificationEmailAsync(request);
            });

            return Ok(new 
            { 
                success = true, 
                message = "درخواست استعلام شما با موفقیت ثبت گردید. کارشناسان واحد فروش پین‌پارت به زودی با شما تماس خواهند گرفت." 
            });
        }

        [HttpGet("call-requests")]
        public IActionResult GetCallRequests()
        {
            return Ok(_callRequests.OrderByDescending(r => r.CreatedAt).ToList());
        }

        private async Task SendAdminNotificationEmailAsync(CallRequestDto request)
        {
            try
            {
                var adminEmail = _configuration["EmailSettings:AdminEmail"] ?? "pinparts.ir@gmail.com";
                var smtpHost = _configuration["EmailSettings:SmtpHost"];
                var smtpPortStr = _configuration["EmailSettings:SmtpPort"];
                var smtpUser = _configuration["EmailSettings:SmtpUsername"];
                var smtpPass = _configuration["EmailSettings:SmtpPassword"];
                var enableSsl = bool.TryParse(_configuration["EmailSettings:EnableSsl"], out var ssl) && ssl;

                var subject = $"[استعلام عمده پین‌پارت] درخواست تماس جدید از {request.PhoneNumber}";
                var bodyHtml = $@"
                    <div dir='rtl' style='font-family: Tahoma, Arial, sans-serif; background-color: #f8fafc; padding: 25px; border-radius: 12px; color: #1e293b; max-width: 600px; margin: 0 auto; border: 1px solid #e2e8f0;'>
                        <div style='background: linear-gradient(to right, #991b1b, #dc2626); color: white; padding: 15px 20px; border-radius: 8px; margin-bottom: 20px;'>
                            <h2 style='margin: 0; font-size: 18px;'>درخواست استعلام قیمت عمده و تماس جدید</h2>
                            <p style='margin: 5px 0 0 0; font-size: 13px; opacity: 0.9;'>پین‌پارت؛ تولید و پخش ملزومات خودرویی چراغ برق</p>
                        </div>
                        <table style='width: 100%; border-collapse: collapse; font-size: 14px;'>
                            <tr style='border-bottom: 1px solid #e2e8f0;'>
                                <td style='padding: 10px; font-weight: bold; width: 35%; color: #475569;'>شماره موبایل مشتری:</td>
                                <td style='padding: 10px; font-weight: bold; color: #dc2626; font-size: 16px; direction: ltr; text-align: right;'>{request.PhoneNumber}</td>
                            </tr>
                            <tr style='border-bottom: 1px solid #e2e8f0;'>
                                <td style='padding: 10px; font-weight: bold; color: #475569;'>نام متقاضی / فروشگاه:</td>
                                <td style='padding: 10px; color: #0f172a;'>{(string.IsNullOrWhiteSpace(request.Name) ? "ثبت نشده" : request.Name)}</td>
                            </tr>
                            <tr style='border-bottom: 1px solid #e2e8f0;'>
                                <td style='padding: 10px; font-weight: bold; color: #475569;'>دسته‌بندی یا خانواده خودرو:</td>
                                <td style='padding: 10px; color: #0f172a;'>{(string.IsNullOrWhiteSpace(request.Category) ? "عمومی / نامشخص" : request.Category)}</td>
                            </tr>
                            <tr style='border-bottom: 1px solid #e2e8f0;'>
                                <td style='padding: 10px; font-weight: bold; color: #475569;'>لیست اقلام یا توضیحات:</td>
                                <td style='padding: 10px; color: #0f172a;'>{(string.IsNullOrWhiteSpace(request.Note) ? "بدون توضیحات" : request.Note)}</td>
                            </tr>
                            <tr>
                                <td style='padding: 10px; font-weight: bold; color: #475569;'>زمان ثبت درخواست:</td>
                                <td style='padding: 10px; color: #64748b;'>{DateTime.UtcNow.AddHours(3.5):yyyy/MM/dd HH:mm} (به وقت تهران)</td>
                            </tr>
                        </table>
                        <div style='margin-top: 25px; padding-top: 15px; border-top: 1px solid #e2e8f0; text-align: center;'>
                            <a href='tel:{request.PhoneNumber}' style='display: inline-block; background-color: #dc2626; color: white; padding: 10px 20px; border-radius: 6px; text-decoration: none; font-weight: bold; font-size: 13px;'>تماس فوری با مشتری</a>
                        </div>
                    </div>
                ";

                if (!string.IsNullOrWhiteSpace(smtpHost) && !string.IsNullOrWhiteSpace(smtpUser) && !string.IsNullOrWhiteSpace(smtpPass))
                {
                    int port = int.TryParse(smtpPortStr, out var p) ? p : 587;
                    using var client = new SmtpClient(smtpHost, port)
                    {
                        Credentials = new NetworkCredential(smtpUser, smtpPass),
                        EnableSsl = enableSsl
                    };

                    using var mail = new MailMessage
                    {
                        From = new MailAddress(smtpUser, _configuration["EmailSettings:SenderName"] ?? "پین‌پارت"),
                        Subject = subject,
                        Body = bodyHtml,
                        IsBodyHtml = true
                    };

                    mail.To.Add(adminEmail);
                    await client.SendMailAsync(mail);
                    Console.WriteLine($"[Email Notification] Successfully sent call request email to: {adminEmail}");
                }
                else
                {
                    Console.WriteLine($"[Email Notification Logged] Call request from {request.PhoneNumber} ready to send. Target: {adminEmail}. (Configure EmailSettings:SmtpUsername/Password in appsettings.json to dispatch live SMTP).");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[Email Notification Error] Could not send email: {ex.Message}");
            }
        }
    }
}
