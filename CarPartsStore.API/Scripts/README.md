# CarPartsStore.API Migration and Deployment Scripts

This directory contains scripts for migrating from SQLite to PostgreSQL and deploying the application.

## Files Overview

### 1. PostgreSQL_Migration.sql
- **Purpose**: Creates the PostgreSQL database schema
- **Usage**: Run this script on your PostgreSQL database before deployment
- **Features**:
  - Creates all required tables with proper constraints
  - Sets up indexes for performance
  - Creates triggers for automatic timestamp updates
  - Inserts default data (admin user and categories)

### 2. Data_Migration_Script.py
- **Purpose**: Migrates data from SQLite to PostgreSQL
- **Prerequisites**: Python 3.x, psycopg2-binary package
- **Usage**: Run after creating PostgreSQL schema
- **Features**:
  - Migrates all tables: Users, Categories, Products, Slides, Stories, Orders, OrderItems, ProductReviews
  - Preserves all data relationships
  - Provides migration statistics

### 3. DEPLOYMENT_GUIDE.md
- **Purpose**: Comprehensive deployment guide
- **Covers**: PostgreSQL setup, Redis configuration, Nginx setup, monitoring, backups
- **Target**: Both Linux and Windows deployment

### 4. Deploy-Windows.ps1
- **Purpose**: Automated deployment script for Windows
- **Requirements**: Administrator privileges, Docker, .NET SDK
- **Features**:
  - Checks prerequisites
  - Creates environment configuration
  - Builds application
  - Starts Docker containers (PostgreSQL, Redis, Nginx)
  - Runs database migration
  - Verifies deployment

## Quick Start Guide

### Option 1: Docker Compose (Recommended)
```bash
# 1. Copy .env.example to .env and update values
cp .env.example .env

# 2. Start all services
docker-compose up -d

# 3. Check status
docker-compose ps

# 4. View logs
docker-compose logs -f
```

### Option 2: Manual Deployment

#### Step 1: Database Setup
```bash
# Create PostgreSQL database
psql -U postgres -c "CREATE DATABASE carpartsstore;"

# Run migration script
psql -U postgres -d carpartsstore -f Scripts/PostgreSQL_Migration.sql
```

#### Step 2: Application Setup
```bash
# Build application
dotnet restore
dotnet build --configuration Release
dotnet publish --configuration Release --output ./publish

# Run application
cd publish
dotnet CarPartsStore.API.dll
```

### Option 3: Windows Deployment
```powershell
# Run as Administrator
.\Scripts\Deploy-Windows.ps1
```

## Migration Steps (SQLite to PostgreSQL)

1. **Backup SQLite database**
   ```bash
   cp carpartsstore.db carpartsstore.db.backup
   ```

2. **Create PostgreSQL schema**
   ```bash
   psql -U postgres -d carpartsstore -f Scripts/PostgreSQL_Migration.sql
   ```

3. **Install Python dependencies**
   ```bash
   pip install psycopg2-binary
   ```

4. **Run data migration**
   ```bash
   python Scripts/Data_Migration_Script.py
   ```

5. **Update connection string** in `appsettings.Production.json`

## Environment Variables

Key environment variables to configure:

- `POSTGRES_PASSWORD`: PostgreSQL database password
- `JWT_KEY`: JWT secret key (minimum 32 characters)
- `ASPNETCORE_ENVIRONMENT`: Set to "Production"
- `ConnectionStrings__DefaultConnection`: PostgreSQL connection string
- `ConnectionStrings__Redis`: Redis connection string

## Troubleshooting

### Common Issues

1. **Database Connection Failed**
   - Check PostgreSQL service is running
   - Verify connection string in appsettings
   - Check firewall rules

2. **Migration Script Errors**
   - Ensure PostgreSQL extension "uuid-ossp" is enabled
   - Check user permissions on database

3. **Docker Container Issues**
   - Check Docker daemon is running
   - Verify port 5432, 6379, 5000 are not in use
   - Check container logs: `docker-compose logs`

4. **File Upload Issues**
   - Verify uploads directory exists and has proper permissions
   - Check `FileStorage__UploadPath` configuration

## Monitoring

### Health Check Endpoints
- `GET /api/health` - Application health status
- `GET /api/stats` - Database and system statistics
- `GET /swagger` - API documentation

### Logs
- **Docker**: `docker-compose logs -f`
- **Application**: Check `logs` directory or Docker container logs
- **Nginx**: `/var/log/nginx/` (Linux) or Docker container logs

## Backup and Recovery

### Database Backup
```bash
# PostgreSQL backup
pg_dump -U postgres carpartsstore > backup_$(date +%Y%m%d).sql

# Restore from backup
psql -U postgres -d carpartsstore < backup_file.sql
```

### Uploads Backup
```bash
# Backup uploads directory
tar -czf uploads_backup_$(date +%Y%m%d).tar.gz /path/to/uploads

# Restore uploads
tar -xzf uploads_backup.tar.gz -C /path/to/restore
```

## Security Considerations

1. **Change default passwords** in production
2. **Use strong JWT keys** (minimum 32 characters)
3. **Enable SSL/TLS** for production traffic
4. **Configure firewall** to restrict access
5. **Regular updates** of .NET runtime and packages
6. **Monitor logs** for suspicious activity

## Support

For issues or questions:
1. Check application logs
2. Review deployment guide
3. Check Docker container status
4. Verify database connectivity