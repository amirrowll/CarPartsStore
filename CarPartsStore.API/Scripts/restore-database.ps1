# Database Restore Script for CarPartsStore.API
# Restores PostgreSQL database and uploads from backup

param(
    [string]$BackupFile,
    [string]$UploadsBackupFile,
    [string]$PostgresPassword = "ChangeMe123!",
    [switch]$Force
)

Write-Host "CarPartsStore.API Database Restore Script" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green

# Check if backup file is provided
if (-not $BackupFile) {
    # Find latest backup
    $backupDir = "C:\Backups\CarPartsStore"
    if (Test-Path $backupDir) {
        $latestBackup = Get-ChildItem -Path $backupDir -Filter "*.sql" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
        if ($latestBackup) {
            $BackupFile = $latestBackup.FullName
            Write-Host "Using latest backup: $BackupFile" -ForegroundColor Yellow
        } else {
            Write-Host "No backup files found in $backupDir" -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "Backup directory not found: $backupDir" -ForegroundColor Red
        exit 1
    }
}

# Check if uploads backup is provided
if (-not $UploadsBackupFile) {
    # Find latest uploads backup
    $backupDir = "C:\Backups\CarPartsStore"
    if (Test-Path $backupDir) {
        $latestUploads = Get-ChildItem -Path $backupDir -Filter "*.zip" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
        if ($latestUploads) {
            $UploadsBackupFile = $latestUploads.FullName
            Write-Host "Using latest uploads backup: $UploadsBackupFile" -ForegroundColor Yellow
        } else {
            Write-Host "No uploads backup files found" -ForegroundColor Yellow
        }
    }
}

# Verify backup files exist
if (-not (Test-Path $BackupFile)) {
    Write-Host "Backup file not found: $BackupFile" -ForegroundColor Red
    exit 1
}

if ($UploadsBackupFile -and -not (Test-Path $UploadsBackupFile)) {
    Write-Host "Uploads backup file not found: $UploadsBackupFile" -ForegroundColor Red
    exit 1
}

# Display warning
Write-Host "`nWARNING: This will restore the database and overwrite existing data!" -ForegroundColor Red
Write-Host "Database: carpartsstore" -ForegroundColor Yellow
Write-Host "Backup file: $BackupFile" -ForegroundColor Yellow
if ($UploadsBackupFile) {
    Write-Host "Uploads backup: $UploadsBackupFile" -ForegroundColor Yellow
}

if (-not $Force) {
    $confirmation = Read-Host "`nAre you sure you want to continue? (yes/no)"
    if ($confirmation -ne 'yes') {
        Write-Host "Restore cancelled." -ForegroundColor Yellow
        exit 0
    }
}

# Step 1: Stop application services
Write-Host "`nStep 1: Stopping application services..." -ForegroundColor Cyan
try {
    # Stop Docker containers if running
    $dockerStatus = docker-compose ps 2>$null
    if ($dockerStatus -and $dockerStatus -notlike "*Exited*") {
        Write-Host "Stopping Docker containers..." -ForegroundColor Yellow
        docker-compose down
        Write-Host "✓ Docker containers stopped" -ForegroundColor Green
    } else {
        Write-Host "✓ No running Docker containers found" -ForegroundColor Green
    }
    
    # Stop application process if running
    $appProcess = Get-Process -Name "CarPartsStore.API" -ErrorAction SilentlyContinue
    if ($appProcess) {
        Write-Host "Stopping application process..." -ForegroundColor Yellow
        Stop-Process -Name "CarPartsStore.API" -Force
        Write-Host "✓ Application process stopped" -ForegroundColor Green
    }
    
} catch {
    Write-Host "⚠ Warning: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Step 2: Restore PostgreSQL database
Write-Host "`nStep 2: Restoring PostgreSQL database..." -ForegroundColor Cyan
try {
    # Set PostgreSQL password environment variable
    $env:PGPASSWORD = $PostgresPassword
    
    # Drop and recreate database
    Write-Host "Recreating database..." -ForegroundColor Yellow
    & "C:\Program Files\PostgreSQL\15\bin\psql.exe" -U postgres -h localhost -c "DROP DATABASE IF EXISTS carpartsstore;"
    & "C:\Program Files\PostgreSQL\15\bin\psql.exe" -U postgres -h localhost -c "CREATE DATABASE carpartsstore;"
    
    # Restore from backup
    Write-Host "Restoring from backup file..." -ForegroundColor Yellow
    & "C:\Program Files\PostgreSQL\15\bin\psql.exe" -U postgres -h localhost -d carpartsstore -f $BackupFile
    
    Write-Host "✓ Database restored successfully" -ForegroundColor Green
    
} catch {
    Write-Host "✗ Database restore failed: $_" -ForegroundColor Red
    exit 1
}

# Step 3: Restore uploads directory
if ($UploadsBackupFile) {
    Write-Host "`nStep 3: Restoring uploads directory..." -ForegroundColor Cyan
    try {
        $uploadsPath = "C:\carpartsstore\uploads"
        
        # Create uploads directory if it doesn't exist
        if (-not (Test-Path $uploadsPath)) {
            New-Item -ItemType Directory -Path $uploadsPath -Force | Out-Null
        }
        
        # Clear existing uploads
        Write-Host "Clearing existing uploads..." -ForegroundColor Yellow
        Remove-Item -Path "$uploadsPath\*" -Recurse -Force -ErrorAction SilentlyContinue
        
        # Restore from backup
        Write-Host "Restoring uploads from backup..." -ForegroundColor Yellow
        Expand-Archive -Path $UploadsBackupFile -DestinationPath $uploadsPath -Force
        
        Write-Host "✓ Uploads restored successfully" -ForegroundColor Green
        
    } catch {
        Write-Host "✗ Uploads restore failed: $_" -ForegroundColor Red
    }
}

# Step 4: Restart services
Write-Host "`nStep 4: Restarting services..." -ForegroundColor Cyan
try {
    # Start Docker containers
    Write-Host "Starting Docker containers..." -ForegroundColor Yellow
    docker-compose up -d
    
    # Wait for services to start
    Write-Host "Waiting for services to start (30 seconds)..." -ForegroundColor Yellow
    Start-Sleep -Seconds 30
    
    # Check container status
    $containers = docker-compose ps
    Write-Host "`nContainer Status:" -ForegroundColor Cyan
    $containers
    
    Write-Host "✓ Services restarted successfully" -ForegroundColor Green
    
} catch {
    Write-Host "✗ Failed to restart services: $_" -ForegroundColor Red
}

# Step 5: Verify restoration
Write-Host "`nStep 5: Verifying restoration..." -ForegroundColor Cyan
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
        Write-Host "⚠ API did not become ready in time" -ForegroundColor Yellow
    }
    
    # Test database connection through API
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:5000/api/stats" -UseBasicParsing -TimeoutSec 5
        if ($response.StatusCode -eq 200) {
            Write-Host "✓ Database connection verified through API" -ForegroundColor Green
        }
    } catch {
        Write-Host "⚠ Could not verify database through API" -ForegroundColor Yellow
    }
    
} catch {
    Write-Host "⚠ Verification warning: $_" -ForegroundColor Yellow
}

# Summary
Write-Host "`n" -NoNewline
Write-Host "=" * 50 -ForegroundColor Green
Write-Host "DATABASE RESTORE COMPLETED!" -ForegroundColor Green
Write-Host "=" * 50 -ForegroundColor Green

Write-Host "`nRestoration Summary:" -ForegroundColor Cyan
Write-Host "  Database: carpartsstore" -ForegroundColor White
Write-Host "  Backup file: $BackupFile" -ForegroundColor White
if ($UploadsBackupFile) {
    Write-Host "  Uploads restored: Yes" -ForegroundColor White
} else {
    Write-Host "  Uploads restored: No" -ForegroundColor White
}
Write-Host "  Completed at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor White

Write-Host "`nNext Steps:" -ForegroundColor Yellow
Write-Host "1. Test the application: http://localhost:5000/swagger" -ForegroundColor White
Write-Host "2. Verify data integrity" -ForegroundColor White
Write-Host "3. Check application logs for any errors" -ForegroundColor White
Write-Host "4. Monitor application performance" -ForegroundColor White

Write-Host "`nTroubleshooting:" -ForegroundColor Yellow
Write-Host "- Check Docker container logs: docker-compose logs" -ForegroundColor White
Write-Host "- Verify database connection: .\Scripts\test-connection.ps1" -ForegroundColor White
Write-Host "- Check application logs" -ForegroundColor White

Write-Host "`n" -NoNewline
Write-Host "=" * 50 -ForegroundColor Green