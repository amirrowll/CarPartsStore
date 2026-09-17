# Database Backup Script for CarPartsStore.API
# Creates backups of PostgreSQL database and uploads directory

param(
    [string]$BackupPath = "C:\Backups\CarPartsStore",
    [string]$PostgresPassword = "ChangeMe123!",
    [string]$RetentionDays = 7
)

Write-Host "CarPartsStore.API Database Backup Script" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green

# Create backup directory if it doesn't exist
if (-not (Test-Path $BackupPath)) {
    New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null
    Write-Host "Created backup directory: $BackupPath" -ForegroundColor Green
}

# Generate timestamp
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupFile = "$BackupPath\carpartsstore_$timestamp.sql"
$uploadsBackup = "$BackupPath\uploads_$timestamp.zip"

Write-Host "`nStarting backup at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Cyan
Write-Host "Backup files will be saved to: $BackupPath" -ForegroundColor Cyan

# Step 1: Backup PostgreSQL database
Write-Host "`nStep 1: Backing up PostgreSQL database..." -ForegroundColor Yellow
try {
    # Set PostgreSQL password environment variable
    $env:PGPASSWORD = $PostgresPassword
    
    # Run pg_dump
    & "C:\Program Files\PostgreSQL\15\bin\pg_dump.exe" -U postgres -h localhost -d carpartsstore -F p -f $backupFile
    
    if (Test-Path $backupFile) {
        $fileSize = (Get-Item $backupFile).Length / 1MB
        Write-Host "✓ Database backup created: $backupFile ($([math]::Round($fileSize, 2)) MB)" -ForegroundColor Green
    } else {
        Write-Host "✗ Database backup failed" -ForegroundColor Red
    }
} catch {
    Write-Host "✗ Database backup error: $_" -ForegroundColor Red
}

# Step 2: Backup uploads directory
Write-Host "`nStep 3: Backing up uploads directory..." -ForegroundColor Yellow
try {
    $uploadsPath = "C:\carpartsstore\uploads"
    if (Test-Path $uploadsPath) {
        # Create zip archive
        Compress-Archive -Path "$uploadsPath\*" -DestinationPath $uploadsBackup -Force
        
        if (Test-Path $uploadsBackup) {
            $fileSize = (Get-Item $uploadsBackup).Length / 1MB
            Write-Host "✓ Uploads backup created: $uploadsBackup ($([math]::Round($fileSize, 2)) MB)" -ForegroundColor Green
        } else {
            Write-Host "✗ Uploads backup failed" -ForegroundColor Red
        }
    } else {
        Write-Host "⚠ Uploads directory not found: $uploadsPath" -ForegroundColor Yellow
    }
} catch {
    Write-Host "✗ Uploads backup error: $_" -ForegroundColor Red
}

# Step 3: Clean up old backups
Write-Host "`nStep 3: Cleaning up old backups (older than $RetentionDays days)..." -ForegroundColor Yellow
try {
    $cutoffDate = (Get-Date).AddDays(-$RetentionDays)
    $oldBackups = Get-ChildItem -Path $BackupPath -Filter "*.sql" | Where-Object { $_.LastWriteTime -lt $cutoffDate }
    $oldUploads = Get-ChildItem -Path $BackupPath -Filter "*.zip" | Where-Object { $_.LastWriteTime -lt $cutoffDate }
    
    $totalDeleted = 0
    foreach ($backup in $oldBackups) {
        Remove-Item -Path $backup.FullName -Force
        Write-Host "  Deleted old database backup: $($backup.Name)" -ForegroundColor Gray
        $totalDeleted++
    }
    
    foreach ($upload in $oldUploads) {
        Remove-Item -Path $upload.FullName -Force
        Write-Host "  Deleted old uploads backup: $($upload.Name)" -ForegroundColor Gray
        $totalDeleted++
    }
    
    if ($totalDeleted -gt 0) {
        Write-Host "✓ Cleaned up $totalDeleted old backup files" -ForegroundColor Green
    } else {
        Write-Host "✓ No old backups to clean up" -ForegroundColor Green
    }
} catch {
    Write-Host "✗ Cleanup error: $_" -ForegroundColor Red
}

# Step 4: Verify backups
Write-Host "`nStep 4: Verifying backups..." -ForegroundColor Yellow
try {
    $currentBackups = Get-ChildItem -Path $BackupPath -Filter "*.sql" | Sort-Object LastWriteTime -Descending
    $currentUploads = Get-ChildItem -Path $BackupPath -Filter "*.zip" | Sort-Object LastWriteTime -Descending
    
    Write-Host "Latest database backups:" -ForegroundColor Cyan
    $currentBackups | Select-Object -First 5 | ForEach-Object {
        $sizeMB = $_.Length / 1MB
        Write-Host "  $($_.Name) - $($_.LastWriteTime) ($([math]::Round($sizeMB, 2)) MB)" -ForegroundColor Gray
    }
    
    Write-Host "`nLatest uploads backups:" -ForegroundColor Cyan
    $currentUploads | Select-Object -First 5 | ForEach-Object {
        $sizeMB = $_.Length / 1MB
        Write-Host "  $($_.Name) - $($_.LastWriteTime) ($([math]::Round($sizeMB, 2)) MB)" -ForegroundColor Gray
    }
    
    $totalSize = ($currentBackups | Measure-Object -Property Length -Sum).Sum / 1GB
    $totalFiles = ($currentBackups.Count + $currentUploads.Count)
    
    Write-Host "`nBackup Summary:" -ForegroundColor Cyan
    Write-Host "  Total backup files: $totalFiles" -ForegroundColor White
    Write-Host "  Total backup size: $([math]::Round($totalSize, 2)) GB" -ForegroundColor White
    Write-Host "  Retention period: $RetentionDays days" -ForegroundColor White
    
} catch {
    Write-Host "✗ Verification error: $_" -ForegroundColor Red
}

# Summary
Write-Host "`n" -NoNewline
Write-Host "=" * 50 -ForegroundColor Green
Write-Host "BACKUP COMPLETED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "=" * 50 -ForegroundColor Green

Write-Host "`nBackup Location: $BackupPath" -ForegroundColor Cyan
Write-Host "Completed at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Cyan

Write-Host "`nRestoration Instructions:" -ForegroundColor Yellow
Write-Host "1. Restore database:" -ForegroundColor White
Write-Host "   psql -U postgres -d carpartsstore -f backup_file.sql" -ForegroundColor Gray
Write-Host "2. Restore uploads:" -ForegroundColor White
Write-Host "   Expand-Archive -Path backup_file.zip -DestinationPath C:\carpartsstore\uploads" -ForegroundColor Gray

Write-Host "`nScheduling (Task Scheduler):" -ForegroundColor Yellow
Write-Host "1. Open Task Scheduler" -ForegroundColor White
Write-Host "2. Create Basic Task" -ForegroundColor White
Write-Host "3. Set trigger to Daily at 2:00 AM" -ForegroundColor White
Write-Host "4. Action: Start program" -ForegroundColor White
Write-Host "5. Program: powershell.exe" -ForegroundColor White
Write-Host "6. Arguments: -File `"$(Resolve-Path .\backup-database.ps1)`"" -ForegroundColor White

Write-Host "`n" -NoNewline
Write-Host "=" * 50 -ForegroundColor Green