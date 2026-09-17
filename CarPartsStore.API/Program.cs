using CarPartsStore.API.Data;
using CarPartsStore.API.Middleware;
using CarPartsStore.API.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.RateLimiting;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Threading.RateLimiting;
using System.Text;
using Npgsql;

await MainAsync();

async Task MainAsync()
{
    var builder = WebApplication.CreateBuilder(args);

    // Add services to the container
    builder.Services.AddControllers();
    builder.Services.AddEndpointsApiExplorer();

    // Configure Swagger with JWT support
    builder.Services.AddSwaggerGen(c =>
    {
        c.SwaggerDoc("v1", new OpenApiInfo { Title = "Car Parts Store API", Version = "v1" });

        c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
        {
            Description = "JWT Authorization header using the Bearer scheme",
            Name = "Authorization",
            In = ParameterLocation.Header,
            Type = SecuritySchemeType.ApiKey,
            Scheme = "Bearer"
        });

        c.AddSecurityRequirement(new OpenApiSecurityRequirement
        {
            {
                new OpenApiSecurityScheme
                {
                    Reference = new OpenApiReference
                    {
                        Type = ReferenceType.SecurityScheme,
                        Id = "Bearer"
                    }
                },
                new string[] {}
            }
        });
    });

    // Configure Database
    var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
    if (string.IsNullOrEmpty(connectionString))
    {
        // Fallback to SQLite for development
        connectionString = "Data Source=./carpartsstore.db";
        builder.Services.AddDbContext<ApplicationDbContext>(options =>
            options.UseSqlite(connectionString));
    }
    else if (connectionString.Contains("Host=") || connectionString.Contains("Server="))
    {
        // PostgreSQL connection
        builder.Services.AddDbContext<ApplicationDbContext>(options =>
            options.UseNpgsql(connectionString,
                npgsqlOptions => npgsqlOptions.EnableRetryOnFailure())
            .ConfigureWarnings(w => w.Ignore(RelationalEventId.PendingModelChangesWarning)));
    }
    else
    {
        // SQLite connection
        builder.Services.AddDbContext<ApplicationDbContext>(options =>
            options.UseSqlite(connectionString));
    }

    // Configure Redis for caching
    var redisConnection = builder.Configuration.GetConnectionString("Redis");
    if (!string.IsNullOrEmpty(redisConnection))
    {
        builder.Services.AddStackExchangeRedisCache(options =>
        {
            options.Configuration = redisConnection;
            options.InstanceName = "PinpartStore_";
        });
    }
    else
    {
        builder.Services.AddDistributedMemoryCache();
    }

    // Configure JWT Authentication
    var jwtSettings = builder.Configuration.GetSection("JwtSettings");
    var secretKey = jwtSettings["SecretKey"] ?? throw new InvalidOperationException("JWT SecretKey is not configured");

    builder.Services.AddAuthentication(options =>
    {
        options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    })
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = jwtSettings["Issuer"],
            ValidAudience = jwtSettings["Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey))
        };
    });

    // Add CORS - restricted to configured origins
    var allowedOrigins = builder.Configuration.GetSection("AllowedOrigins").Get<string[]>()
                         ?? new[] { "https://pinparts.ir", "https://www.pinparts.ir" };

    builder.Services.AddCors(options =>
    {
        options.AddPolicy("AllowSpecificOrigins",
            policy =>
            {
                policy.WithOrigins(allowedOrigins)
                      .AllowAnyMethod()
                      .AllowAnyHeader()
                      .AllowCredentials();
            });
    });

    // Register Services
    builder.Services.AddScoped<IAuthService, AuthService>();
    builder.Services.AddScoped<IProductService, ProductService>();

    // Add Response Caching
    builder.Services.AddResponseCaching();
    builder.Services.AddMemoryCache();

    // Add Response Compression for better performance
    builder.Services.AddResponseCompression(options =>
    {
        options.EnableForHttps = true;
        options.MimeTypes = new[]
        {
            "text/plain",
            "text/html",
            "text/css",
            "application/javascript",
            "text/javascript",
            "application/json",
            "text/json",
            "application/xml",
            "text/xml",
            "image/svg+xml"
        };
    });

    // Add Health Checks
    builder.Services.AddHealthChecks()
        .AddDbContextCheck<ApplicationDbContext>("database");

    // Add Rate Limiting
    builder.Services.AddRateLimiter(options =>
    {
        options.GlobalLimiter = PartitionedRateLimiter.Create<HttpContext, string>(httpContext =>
            RateLimitPartition.GetFixedWindowLimiter(
                partitionKey: httpContext.Connection.RemoteIpAddress?.ToString() ?? "anonymous",
                factory: partition => new FixedWindowRateLimiterOptions
                {
                    AutoReplenishment = true,
                    PermitLimit = 100,
                    QueueLimit = 0,
                    Window = TimeSpan.FromMinutes(1)
                }));
    });

    var app = builder.Build();

    // Add response compression for better performance
    app.UseResponseCompression();

    // Configure the HTTP request pipeline
    // Enable Swagger only in Development
    if (app.Environment.IsDevelopment())
    {
        app.UseSwagger();
        app.UseSwaggerUI();
    }

    // Enable static files with caching
    app.UseStaticFiles(new StaticFileOptions
    {
        OnPrepareResponse = ctx =>
        {
            ctx.Context.Response.Headers.Append(
                "Cache-Control",
                "public,max-age=31536000,immutable"
            );
        }
    });

    // Enable Response Caching
    app.UseResponseCaching();

    // Enable Rate Limiting
    app.UseRateLimiter();

    // app.UseHttpsRedirection(); // HTTPS handled by Nginx reverse proxy

    app.UseCors("AllowSpecificOrigins");
    app.UseAuthentication();
    app.UseAuthorization();
    app.UseMiddleware<ErrorHandlingMiddleware>();

    app.MapControllers();

    // Health check endpoints
    app.MapHealthChecks("/health");
    app.MapGet("/health/detailed", async (ApplicationDbContext dbContext) =>
    {
        try
        {
            var dbStatus = await dbContext.Database.CanConnectAsync() ? "connected" : "disconnected";
            var productCount = await dbContext.Products.CountAsync();
            var categoryCount = await dbContext.Categories.CountAsync();

            return Results.Ok(new
            {
                status = "healthy",
                timestamp = DateTime.UtcNow,
                database = dbStatus,
                products = productCount,
                categories = categoryCount,
                uptime = DateTime.UtcNow - System.Diagnostics.Process.GetCurrentProcess().StartTime.ToUniversalTime()
            });
        }
        catch (Exception ex)
        {
            return Results.Problem(detail: ex.Message, statusCode: 500);
        }
    });

    // Seed database and ensure directories exist
    using (var scope = app.Services.CreateScope())
    {
        var dbContext = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();

        // NOTE: EnsureCreated is removed because we use EF Core Migrations.
        // Migrations are applied via: dotnet ef database update

        await DbSeeder.SeedAsync(dbContext);

        var webHostEnvironment = scope.ServiceProvider.GetRequiredService<IWebHostEnvironment>();
        var uploadsPathSlides = Path.Combine(webHostEnvironment.WebRootPath ?? "wwwroot", "uploads", "slides");
        if (!Directory.Exists(uploadsPathSlides))
        {
            Directory.CreateDirectory(uploadsPathSlides);
        }

        var uploadsPathProducts = Path.Combine(webHostEnvironment.WebRootPath ?? "wwwroot", "uploads", "products");
        if (!Directory.Exists(uploadsPathProducts))
        {
            Directory.CreateDirectory(uploadsPathProducts);
        }

        var uploadsPathStories = Path.Combine(webHostEnvironment.WebRootPath ?? "wwwroot", "uploads", "stories");
        if (!Directory.Exists(uploadsPathStories))
        {
            Directory.CreateDirectory(uploadsPathStories);
        }
    }

    await app.RunAsync();
}