# Test connection script for CarPartsStore.API
# Tests PostgreSQL and Redis connections

param(
    [string]$PostgresConnection = "Host=localhost;Database=carpartsstore;Username=postgres;Password=ChangeMe123!",
    [string]$RedisConnection = "localhost:6379"
)

Write-Host "CarPartsStore.API Connection Test" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Green

# Test PostgreSQL Connection
Write-Host "`nTesting PostgreSQL Connection..." -ForegroundColor Cyan
try {
    # Try to connect using .NET
    Add-Type -Path "C:\Program Files\dotnet\shared\Microsoft.NETCore.App\8.0.0\System.Data.dll" -ErrorAction SilentlyContinue
    
    $connectionString = $PostgresConnection
    Write-Host "Connection String: $($connectionString -replace 'Password=.*?;', 'Password=******;')" -ForegroundColor Gray
    
    # Check if PostgreSQL service is running
    $postgresService = Get-Service -Name postgresql* -ErrorAction SilentlyContinue
    if ($postgresService) {
        if ($postgresService.Status -eq 'Running') {
            Write-Host "✓ PostgreSQL service is running" -ForegroundColor Green
        } else {
            Write-Host "✗ PostgreSQL service is not running" -ForegroundColor Red
            Write-Host "  Start service: Start-Service -Name '$($postgresService.Name)'" -ForegroundColor Yellow
        }
    } else {
        Write-Host "⚠ PostgreSQL service not found" -ForegroundColor Yellow
    }
    
    # Test with telnet (if available)
    if (Test-Connection localhost -Port 5432 -Count 1 -Quiet) {
        Write-Host "✓ Port 5432 is accessible" -ForegroundColor Green
    } else {
        Write-Host "✗ Port 5432 is not accessible" -ForegroundColor Red
    }
    
} catch {
    Write-Host "✗ PostgreSQL test failed: $_" -ForegroundColor Red
}

# Test Redis Connection
Write-Host "`nTesting Redis Connection..." -ForegroundColor Cyan
try {
    # Check if Redis service is running
    $redisService = Get-Service -Name redis* -ErrorAction SilentlyContinue
    if ($redisService) {
        if ($redisService.Status -eq 'Running') {
            Write-Host "✓ Redis service is running" -ForegroundColor Green
        } else {
            Write-Host "✗ Redis service is not running" -ForegroundColor Red
            Write-Host "  Start service: Start-Service -Name '$($redisService.Name)'" -ForegroundColor Yellow
        }
    } else {
        Write-Host "⚠ Redis service not found" -ForegroundColor Yellow
    }
    
    # Test with telnet (if available)
    if (Test-Connection localhost -Port 6379 -Count 1 -Quiet) {
        Write-Host "✓ Port 6379 is accessible" -ForegroundColor Green
    } else {
        Write-Host "✗ Port 6379 is not accessible" -ForegroundColor Red
    }
    
} catch {
    Write-Host "✗ Redis test failed: $_" -ForegroundColor Red
}

# Test Application Health
Write-Host "`nTesting Application Health..." -ForegroundColor Cyan
try {
    $healthUrl = "http://localhost:5000/api/health"
    Write-Host "Health endpoint: $healthUrl" -ForegroundColor Gray
    
    # Check if application is running
    $process = Get-Process -Name "CarPartsStore.API" -ErrorAction SilentlyContinue
    if ($process) {
        Write-Host "✓ Application process is running" -ForegroundColor Green
    } else {
        Write-Host "⚠ Application process not found" -ForegroundColor Yellow
    }
    
    # Try to call health endpoint
    try {
        $response = Invoke-WebRequest -Uri $healthUrl -UseBasicParsing -TimeoutSec 5 -ErrorAction SilentlyContinue
        if ($response.StatusCode -eq 200) {
            Write-Host "✓ Health endpoint responded with 200 OK" -ForegroundColor Green
            $healthData = $response.Content | ConvertFrom-Json
            Write-Host "  Status: $($healthData.status)" -ForegroundColor Gray
            Write-Host "  Timestamp: $($healthData.timestamp)" -ForegroundColor Gray
        }
    } catch {
        Write-Host "✗ Health endpoint not accessible" -ForegroundColor Red
    }
    
} catch {
    Write-Host "✗ Application health test failed: $_" -ForegroundColor Red
}

# Summary
Write-Host "`n" -NoNewline
Write-Host "=" * 50 -ForegroundColor Cyan
Write-Host "CONNECTION TEST SUMMARY" -ForegroundColor Cyan
Write-Host "=" * 50 -ForegroundColor Cyan

Write-Host "`nNext Steps:" -ForegroundColor Yellow
Write-Host "1. Ensure PostgreSQL and Redis services are running" -ForegroundColor White
Write-Host "2. Update connection strings in appsettings.Production.json" -ForegroundColor White
Write-Host "3. Run database migration: .\Scripts\Deploy-Windows.ps1" -ForegroundColor White
Write-Host "4. Test the application: http://localhost:5000/swagger" -ForegroundColor White

Write-Host "`nTroubleshooting:" -ForegroundColor Yellow
Write-Host "- Check firewall rules for ports 5432 and 6379" -ForegroundColor White
Write-Host "- Verify database credentials" -ForegroundColor White
Write-Host "- Check application logs" -ForegroundColor White
Write-Host "- Review deployment guide: Scripts\DEPLOYMENT_GUIDE.md" -ForegroundColor White

Write-Host "`n" -NoNewline
Write-Host "=" * 50 -ForegroundColor Cyan