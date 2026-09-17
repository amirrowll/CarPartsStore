# Windows Deployment Script for CarPartsStore.API
# Run this script as Administrator

param(
    [string]$Environment = "Production",
    [string]$PostgresPassword = "ChangeMe123!",
    [string]$JwtKey = "YourSecureJwtKeyHereMinimum32Characters"
)

Write-Host "CarPartsStore.API Windows Deployment Script" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    exit 1
}

# Function to check if a command exists
function Test-Command {
    param($command)
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'stop'
    try {
        if(Get-Command $command) { return $true }
    } catch {
        return $false
    } finally {
        $ErrorActionPreference = $oldPreference
    }
}

# Check prerequisites
Write-Host "`nChecking prerequisites..." -ForegroundColor Cyan

$prerequisites = @{
    "dotnet" = "dotnet --version";
    "docker" = "docker --version";
    "docker-compose" = "docker-compose --version";
}

foreach ($prereq in $prerequisites.GetEnumerator()) {
    if (Test-Command $prereq.Name) {
        Write-Host "✓ $($prereq.Name) is installed" -ForegroundColor Green
    } else {
        Write-Host "✗ $($prereq.Name) is NOT installed" -ForegroundColor Red
        Write-Host "  Please install $($prereq.Name) before continuing" -ForegroundColor Yellow
    }
}

Write-Host "`nDeployment Configuration:" -ForegroundColor Cyan
Write-Host "Environment: $Environment" -ForegroundColor White
Write-Host "PostgreSQL Password: ******" -ForegroundColor White
Write-Host "JWT Key: ******" -ForegroundColor White

$confirmation = Read-Host "`nDo you want to proceed with deployment? (yes/no)"
if ($confirmation -ne 'yes') {
    Write-Host "Deployment cancelled." -ForegroundColor Yellow
    exit 0
}

# Step 1: Create .env file
Write-Host "`nStep 1: Creating environment configuration..." -ForegroundColor Cyan
$envContent = @"
# PostgreSQL Configuration
POSTGRES_PASSWORD=$PostgresPassword
POSTGRES_USER=postgres
POSTGRES_DB=carpartsstore
POSTGRES_HOST=localhost
POSTGRES_PORT=5432

# Redis Configuration
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=

# JWT Configuration
JWT_KEY=$JwtKey
JWT_ISSUER=CarPartsStore.API
JWT_AUDIENCE=CarPartsStore.Client
JWT_EXPIRE_DAYS=7

# Application Configuration
ASPNETCORE_ENVIRONMENT=$Environment
ASPNETCORE_URLS=http://+:8080;https://+:8081
FILE_UPLOAD_PATH=C:\carpartsstore\uploads
MAX_FILE_SIZE_MB=100
"@

$envContent | Out-File -FilePath ".env" -Encoding UTF8
Write-Host "✓ Created .env file" -ForegroundColor Green

# Step 2: Create uploads directory
Write-Host "`nStep 2: Creating uploads directory..." -ForegroundColor Cyan
$uploadsPath = "C:\carpartsstore\uploads"
if (-not (Test-Path $uploadsPath)) {
    New-Item -ItemType Directory -Path $uploadsPath -Force | Out-Null
    New-Item -ItemType Directory -Path "$uploadsPath\products" -Force | Out-Null
    New-Item -ItemType Directory -Path "$uploadsPath\slides" -Force | Out-Null
    New-Item -ItemType Directory -Path "$uploadsPath\stories" -Force | Out-Null
    Write-Host "✓ Created uploads directory at $uploadsPath" -ForegroundColor Green
} else {
    Write-Host "✓ Uploads directory already exists" -ForegroundColor Green
}

# Step 3: Build the application
Write-Host "`nStep 3: Building application..." -ForegroundColor Cyan
try {
    dotnet restore
    dotnet build --configuration Release
    Write-Host "✓ Application built successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Build failed: $_" -ForegroundColor Red
    exit 1
}

# Step 4: Start Docker containers
Write-Host "`nStep 4: Starting Docker containers..." -ForegroundColor Cyan
try {
    # Stop any existing containers
    docker-compose down
    
    # Start containers
    docker-compose up -d
    
    # Wait for services to be ready
    Write-Host "Waiting for services to start..." -ForegroundColor Yellow
    Start-Sleep -Seconds 30
    
    # Check container status
    $containers = docker-compose ps
    Write-Host "`nContainer Status:" -ForegroundColor Cyan
    $containers
    
    Write-Host "✓ Docker containers started" -ForegroundColor Green
} catch {
    Write-Host "✗ Docker failed: $_" -ForegroundColor Red
    exit 1
}

# Step 5: Run database migration
Write-Host "`nStep 5: Running database migration..." -ForegroundColor Cyan
try {
    # Wait for PostgreSQL to be ready
    Write-Host "Waiting for PostgreSQL to be ready..." -ForegroundColor Yellow
    $maxRetries = 30
    $retryCount = 0
    $postgresReady = $false
    
    while ($retryCount -lt $maxRetries -and -not $postgresReady) {
        try {
            $result = docker exec carpartsstore-postgres pg_isready -U postgres
            if ($result -like "*accepting connections*") {
                $postgresReady = $true
                Write-Host "✓ PostgreSQL is ready" -ForegroundColor Green
            }
        } catch {
            # Ignore errors and retry
        }
        
        if (-not $postgresReady) {
            $retryCount++
            Write-Host "  Waiting... ($retryCount/$maxRetries)" -ForegroundColor Yellow
            Start-Sleep -Seconds 2
        }
    }
    
    if (-not $postgresReady) {
        Write-Host "✗ PostgreSQL did not become ready in time" -ForegroundColor Red
        exit 1
    }
    
    # Run migration script
    Write-Host "Running migration script..." -ForegroundColor Yellow
    docker exec carpartsstore-postgres psql -U postgres -d carpartsstore -f /docker-entrypoint-initdb.d/init.sql
    
    Write-Host "✓ Database migration completed" -ForegroundColor Green
} catch {
    Write-Host "✗ Migration failed: $_" -ForegroundColor Red
    exit 1
}

# Step 6: Verify deployment
Write-Host "`nStep 6: Verifying deployment..." -ForegroundColor Cyan
try {
    # Wait for API to be ready
    Write-Host "Waiting for API to be ready..." -ForegroundColor Yellow
    $maxRetries = 30
    $retryCount = 0
    $apiReady = $false
    
    while ($retryCount -lt $maxRetries -and -not $apiReady) {
        try {
            $response = Invoke-WebRequest -Uri "http://localhost:5000/api/health" -UseBasicParsing -TimeoutSec 5
            if ($response.StatusCode -eq 200) {
                $apiReady = $true
                Write-Host "✓ API is responding" -ForegroundColor Green
            }
        } catch {
            # Ignore errors and retry
        }
        
        if (-not $apiReady) {
            $retryCount++
            Write-Host "  Waiting... ($retryCount/$maxRetries)" -ForegroundColor Yellow
            Start-Sleep -Seconds 2
        }
    }
    
    if (-not $apiReady) {
        Write-Host "✗ API did not become ready in time" -ForegroundColor Red
        exit 1
    }
    
    # Test Swagger UI
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:5000/swagger" -UseBasicParsing -TimeoutSec 5
        Write-Host "✓ Swagger UI is accessible" -ForegroundColor Green
    } catch {
        Write-Host "⚠ Swagger UI may not be accessible" -ForegroundColor Yellow
    }
    
    Write-Host "✓ Deployment verification completed" -ForegroundColor Green
} catch {
    Write-Host "✗ Verification failed: $_" -ForegroundColor Red
    exit 1
}

# Step 7: Display deployment information
Write-Host "`n" -NoNewline
Write-Host "=" * 50 -ForegroundColor Green
Write-Host "DEPLOYMENT COMPLETED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "=" * 50 -ForegroundColor Green
Write-Host "`nApplication URLs:" -ForegroundColor Cyan
Write-Host "  API: http://localhost:5000" -ForegroundColor White
Write-Host "  Swagger UI: http://localhost:5000/swagger" -ForegroundColor White
Write-Host "  Health Check: http://localhost:5000/api/health" -ForegroundColor White
Write-Host "`nServices:" -ForegroundColor Cyan
Write-Host "  PostgreSQL: localhost:5432" -ForegroundColor White
Write-Host "  Redis: localhost:6379" -ForegroundColor White
Write-Host "  Nginx: localhost:80" -ForegroundColor White
Write-Host "`nDefault Admin Credentials:" -ForegroundColor Cyan
Write-Host "  Username: admin" -ForegroundColor White
Write-Host "  Email: admin@carpartsstore.com" -ForegroundColor White
Write-Host "  Password: Admin123!" -ForegroundColor White
Write-Host "`nManagement Commands:" -ForegroundColor Cyan
Write-Host "  View logs: docker-compose logs -f" -ForegroundColor White
Write-Host "  Stop services: docker-compose down" -ForegroundColor White
Write-Host "  Restart services: docker-compose restart" -ForegroundColor White
Write-Host "  View status: docker-compose ps" -ForegroundColor White
Write-Host "`nNext Steps:" -ForegroundColor Cyan
Write-Host "  1. Update the JWT key in .env file for production" -ForegroundColor Yellow
Write-Host "  2. Configure SSL/TLS for production" -ForegroundColor Yellow
Write-Host "  3. Set up proper backups" -ForegroundColor Yellow
Write-Host "  4. Configure monitoring and alerts" -ForegroundColor Yellow
Write-Host "`n" -NoNewline
Write-Host "=" * 50 -ForegroundColor Green