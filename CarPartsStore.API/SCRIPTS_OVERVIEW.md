# CarPartsStore.API - Scripts Overview

## 📁 Scripts Directory Structure

```
Scripts/
├── 📄 PostgreSQL_Migration.sql          # PostgreSQL schema creation
├── 📄 Data_Migration_Script.py          # SQLite to PostgreSQL data migration
├── 📄 DEPLOYMENT_GUIDE.md              # Comprehensive deployment guide
├── 📄 deploy-linux.sh                  # Linux deployment script
├── 📄 Deploy-Windows.ps1               # Windows deployment script
├── 📄 test-connection.ps1              # Connection testing script
├── 📄 backup-database.ps1              # Database backup script
├── 📄 restore-database.ps1             # Database restore script
├── 📄 requirements.txt                 # Python dependencies
└── 📄 README.md                        # Scripts documentation
```

## 🚀 Quick Start Guide

### Option 1: Docker Compose (Easiest)
```bash
# 1. Copy environment template
cp .env.example .env

# 2. Update .env with your values
# 3. Start all services
docker-compose up -d

# 4. Verify deployment
docker-compose ps
curl http://localhost:5000/api/health
```

### Option 2: Windows Deployment
```powershell
# Run as Administrator
.\Scripts\Deploy-Windows.ps1
```

### Option 3: Linux Deployment
```bash
# Make script executable
chmod +x Scripts/deploy-linux.sh

# Run as root
sudo ./Scripts/deploy-linux.sh
```

## 📋 Script Details

### 1. Database Migration Scripts

#### `PostgreSQL_Migration.sql`
- **Purpose**: Creates PostgreSQL database schema
- **Features**:
  - Creates all tables with proper constraints
  - Sets up indexes for performance
  - Creates triggers for automatic timestamp updates
  - Inserts default admin user and categories
- **Usage**:
  ```bash
  psql -U postgres -d carpartsstore -f Scripts/PostgreSQL_Migration.sql
  ```

#### `Data_Migration_Script.py`
- **Purpose**: Migrates data from SQLite to PostgreSQL
- **Requirements**: Python 3.x, `pip install psycopg2-binary`
- **Features**:
  - Migrates all tables with relationships
  - Preserves data integrity
  - Provides migration statistics
- **Usage**:
  ```bash
  python Scripts/Data_Migration_Script.py
  ```

### 2. Deployment Scripts

#### `Deploy-Windows.ps1`
- **Purpose**: Automated Windows deployment
- **Requirements**: Administrator privileges, Docker, .NET SDK
- **Features**:
  - Checks prerequisites
  - Creates environment configuration
  - Builds application
  - Starts Docker containers
  - Runs database migration
  - Verifies deployment
- **Usage**:
  ```powershell
  .\Scripts\Deploy-Windows.ps1
  ```

#### `deploy-linux.sh`
- **Purpose**: Automated Linux deployment
- **Requirements**: Root access, Docker, .NET SDK
- **Features**:
  - Color-coded output
  - Step-by-step execution
  - Error handling
  - Deployment verification
- **Usage**:
  ```bash
  sudo ./Scripts/deploy-linux.sh
  ```

### 3. Maintenance Scripts

#### `test-connection.ps1`
- **Purpose**: Tests PostgreSQL and Redis connections
- **Features**:
  - Tests service status
  - Tests port accessibility
  - Tests API health endpoint
- **Usage**:
  ```powershell
  .\Scripts\test-connection.ps1
  ```

#### `backup-database.ps1`
- **Purpose**: Automated database and uploads backup
- **Features**:
  - Backups PostgreSQL database
  - Backups uploads directory
  - Automatic cleanup of old backups
  - Backup verification
- **Usage**:
  ```powershell
  .\Scripts\backup-database.ps1
  ```

#### `restore-database.ps1`
- **Purpose**: Restores database and uploads from backup
- **Features**:
  - Finds latest backup automatically
  - Stops services before restore
  - Restores database and uploads
  - Restarts services
  - Verifies restoration
- **Usage**:
  ```powershell
  .\Scripts\restore-database.ps1
  ```

## 🐳 Docker Configuration

### Files:
- `Dockerfile`: Multi-stage build for the application
- `docker-compose.yml`: Complete stack with PostgreSQL, Redis, Nginx
- `nginx.conf`: Nginx reverse proxy configuration

### Services:
1. **PostgreSQL**: Database with migration script
2. **Redis**: Caching and session storage
3. **App**: CarPartsStore.API application
4. **Nginx**: Reverse proxy and static file serving

### Quick Commands:
```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Restart services
docker-compose restart

# View status
docker-compose ps
```

## 🔧 Environment Configuration

### `.env.example` Template:
```bash
# Copy and update for your environment
cp .env.example .env
```

### Key Variables:
```bash
POSTGRES_PASSWORD=YourSecurePassword
JWT_KEY=YourSecureJwtKeyHereMinimum32Characters
ASPNETCORE_ENVIRONMENT=Production
```

## 📊 Monitoring and Health Checks

### Health Endpoints:
- `GET /api/health` - Application health status
- `GET /api/stats` - Database and system statistics
- `GET /swagger` - API documentation

### Logs:
```bash
# Docker logs
docker-compose logs -f

# Application logs
docker logs carpartsstore-api -f

# Database logs
docker logs carpartsstore-postgres -f
```

## 🔒 Security Considerations

### Before Production:
1. **Change all default passwords**
2. **Use strong JWT keys** (minimum 32 characters)
3. **Enable SSL/TLS** for all traffic
4. **Configure firewall rules**
5. **Set up proper backups**

### Security Scripts:
- Use `backup-database.ps1` for regular backups
- Test with `test-connection.ps1` after configuration changes
- Review `DEPLOYMENT_GUIDE.md` for security best practices

## 🚨 Troubleshooting

### Common Issues:

#### 1. Database Connection Failed
```powershell
# Test connection
.\Scripts\test-connection.ps1

# Check PostgreSQL service
Get-Service postgresql*

# Check port
Test-Connection localhost -Port 5432
```

#### 2. Migration Errors
- Ensure PostgreSQL extension "uuid-ossp" is enabled
- Check user permissions on database
- Verify backup file integrity

#### 3. Docker Issues
```bash
# Check Docker daemon
docker version

# Check container status
docker-compose ps

# View container logs
docker-compose logs
```

#### 4. File Upload Issues
- Verify uploads directory permissions
- Check `FileStorage__UploadPath` configuration
- Ensure enough disk space

## 📈 Performance Optimization

### Database:
- Indexes created by migration script
- Connection pooling configured
- Query optimization recommendations

### Caching:
- Redis configured for session caching
- Nginx caching for static files
- CDN integration ready

### Application:
- Async/await patterns implemented
- Efficient data loading
- Pagination support

## 🔄 Backup and Recovery

### Automated Backups:
```powershell
# Manual backup
.\Scripts\backup-database.ps1

# Schedule with Task Scheduler (Windows)
# or cron (Linux)
```

### Restoration:
```powershell
# Restore from latest backup
.\Scripts\restore-database.ps1

# Restore specific backup
.\Scripts\restore-database.ps1 -BackupFile "C:\Backups\backup_20240101.sql"
```

## 📚 Additional Resources

### Documentation:
- `DEPLOYMENT_GUIDE.md` - Complete deployment instructions
- `README.md` in Scripts directory - Script-specific documentation
- `MIGRATION_SUMMARY.md` - Migration overview and status

### Support:
1. Check application logs
2. Review deployment guide
3. Test connections with provided scripts
4. Verify Docker container status

## ✅ Success Checklist

- [ ] Database migration tested in staging
- [ ] Connection strings updated for production
- [ ] SSL/TLS certificates configured
- [ ] Monitoring and alerts set up
- [ ] Backup procedures tested
- [ ] Security configurations reviewed
- [ ] Performance testing completed
- [ ] Documentation updated

---

**Last Updated**: $(date)

**Status**: ✅ READY FOR PRODUCTION DEPLOYMENT