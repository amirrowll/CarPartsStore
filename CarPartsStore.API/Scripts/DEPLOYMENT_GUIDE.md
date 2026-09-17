# CarPartsStore.API Deployment Guide

This guide provides step-by-step instructions for deploying the CarPartsStore.API application with PostgreSQL and Redis.

## Prerequisites

### 1. PostgreSQL Installation
- Install PostgreSQL 14+ on your server
- Create a database named `carpartsstore`
- Create a user with appropriate permissions

### 2. Redis Installation
- Install Redis 6+ on your server
- Configure Redis for production use

### 3. .NET Runtime
- Install .NET 8.0+ Runtime on your server

## Deployment Steps

### Step 1: Database Setup

#### 1.1 Create PostgreSQL Database
```bash
# Connect to PostgreSQL
sudo -u postgres psql

# Create database
CREATE DATABASE carpartsstore;

# Create user (optional)
CREATE USER carpartsuser WITH PASSWORD 'your_secure_password';

# Grant privileges
GRANT ALL PRIVILEGES ON DATABASE carpartsstore TO carpartsuser;
```

#### 1.2 Run Migration Script
```bash
# Run the PostgreSQL migration script
psql -U postgres -d carpartsstore -f Scripts/PostgreSQL_Migration.sql
```

### Step 2: Application Configuration

#### 2.1 Update Production Configuration
Edit `appsettings.Production.json` with your actual database credentials:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Host=localhost;Database=carpartsstore;Username=postgres;Password=your_password",
    "Redis": "localhost:6379"
  },
  "Jwt": {
    "Key": "your_secure_jwt_key_here_minimum_32_characters",
    "Issuer": "CarPartsStore.API",
    "Audience": "CarPartsStore.Client",
    "ExpireDays": 7
  },
  "FileStorage": {
    "UploadPath": "/var/www/carpartsstore/uploads"
  }
}
```

#### 2.2 Set Environment Variables
```bash
# Set ASPNETCORE_ENVIRONMENT
export ASPNETCORE_ENVIRONMENT=Production

# Set connection string (optional)
export ConnectionStrings__DefaultConnection="Host=localhost;Database=carpartsstore;Username=postgres;Password=your_password"
```

### Step 3: Build and Publish Application

#### 3.1 Build the Application
```bash
# Navigate to project directory
cd CarPartsStore.API

# Restore packages
dotnet restore

# Build the project
dotnet build --configuration Release
```

#### 3.2 Publish the Application
```bash
# Publish for Linux x64
dotnet publish --configuration Release --runtime linux-x64 --self-contained false --output ./publish

# Or publish for Windows
dotnet publish --configuration Release --runtime win-x64 --self-contained false --output ./publish
```

### Step 4: Deploy to Server

#### 4.1 Copy Files to Server
```bash
# Copy published files
scp -r ./publish/* user@yourserver:/var/www/carpartsstore/

# Copy uploads directory
scp -r wwwroot/uploads/* user@yourserver:/var/www/carpartsstore/uploads/
```

#### 4.2 Create Uploads Directory
```bash
# Create uploads directory on server
sudo mkdir -p /var/www/carpartsstore/uploads
sudo mkdir -p /var/www/carpartsstore/uploads/products
sudo mkdir -p /var/www/carpartsstore/uploads/slides
sudo mkdir -p /var/www/carpartsstore/uploads/stories

# Set permissions
sudo chown -R www-data:www-data /var/www/carpartsstore/uploads
sudo chmod -R 755 /var/www/carpartsstore/uploads
```

### Step 5: Configure Web Server

#### 5.1 Nginx Configuration (Linux)
Create `/etc/nginx/sites-available/carpartsstore`:

```nginx
server {
    listen 80;
    server_name yourdomain.com;
    
    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection keep-alive;
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    
    # Static files
    location /uploads/ {
        alias /var/www/carpartsstore/uploads/;
        expires 30d;
        add_header Cache-Control "public";
    }
}
```

Enable the site:
```bash
sudo ln -s /etc/nginx/sites-available/carpartsstore /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

#### 5.2 IIS Configuration (Windows)
1. Install IIS and ASP.NET Core Hosting Bundle
2. Create a new website in IIS Manager
3. Set physical path to publish directory
4. Configure application pool to use "No Managed Code"
5. Set up URL Rewrite rules if needed

### Step 6: Run Application as Service

#### 6.1 Systemd Service (Linux)
Create `/etc/systemd/system/carpartsstore.service`:

```ini
[Unit]
Description=CarPartsStore.API
After=network.target postgresql.service redis-server.service

[Service]
Type=exec
User=www-data
WorkingDirectory=/var/www/carpartsstore
ExecStart=/usr/bin/dotnet /var/www/carpartsstore/CarPartsStore.API.dll
Restart=always
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=carpartsstore
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false

[Install]
WantedBy=multi-user.target
```

Enable and start the service:
```bash
sudo systemctl enable carpartsstore.service
sudo systemctl start carpartsstore.service
sudo systemctl status carpartsstore.service
```

#### 6.2 Windows Service
```bash
# Create Windows Service
sc create CarPartsStoreService binPath="C:\path\to\CarPartsStore.API.exe"
sc start CarPartsStoreService
```

### Step 7: SSL/TLS Configuration (Optional but Recommended)

#### 7.1 Obtain SSL Certificate
```bash
# Using Let's Encrypt with Certbot
sudo certbot --nginx -d yourdomain.com
```

#### 7.2 Update Nginx Configuration
```nginx
server {
    listen 443 ssl http2;
    server_name yourdomain.com;
    
    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;
    
    # ... rest of configuration
}

server {
    listen 80;
    server_name yourdomain.com;
    return 301 https://$server_name$request_uri;
}
```

### Step 8: Data Migration (If migrating from SQLite)

#### 8.1 Install Python Dependencies
```bash
pip install psycopg2-binary
```

#### 8.2 Run Data Migration Script
```bash
# Copy SQLite database to server
scp carpartsstore.db user@yourserver:/tmp/

# Run migration script
python3 Scripts/Data_Migration_Script.py
```

### Step 9: Monitoring and Maintenance

#### 9.1 Logs
```bash
# View application logs
sudo journalctl -u carpartsstore.service -f

# View Nginx logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

#### 9.2 Backup Script
Create `/usr/local/bin/backup-carpartsstore.sh`:

```bash
#!/bin/bash
BACKUP_DIR="/backup/carpartsstore"
DATE=$(date +%Y%m%d_%H%M%S)

# Backup PostgreSQL database
pg_dump -U postgres carpartsstore > $BACKUP_DIR/carpartsstore_$DATE.sql

# Backup uploads directory
tar -czf $BACKUP_DIR/uploads_$DATE.tar.gz /var/www/carpartsstore/uploads/

# Keep only last 7 days of backups
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete
```

Make executable and schedule with cron:
```bash
chmod +x /usr/local/bin/backup-carpartsstore.sh
# Add to crontab: 0 2 * * * /usr/local/bin/backup-carpartsstore.sh
```

## Troubleshooting

### Common Issues

1. **Database Connection Failed**
   - Check PostgreSQL is running: `sudo systemctl status postgresql`
   - Verify connection string in appsettings
   - Check firewall rules

2. **Redis Connection Failed**
   - Check Redis is running: `sudo systemctl status redis-server`
   - Verify Redis configuration

3. **File Upload Permission Issues**
   - Check uploads directory permissions
   - Verify www-data user has write access

4. **Application Won't Start**
   - Check logs: `sudo journalctl -u carpartsstore.service -f`
   - Verify .NET runtime is installed
   - Check port 5000 is not in use

### Health Check Endpoints
- API Status: `https://yourdomain.com/api/health`
- Database Status: `https://yourdomain.com/api/stats`
- Swagger UI: `https://yourdomain.com/swagger`

## Security Considerations

1. **Use Strong Passwords** for database and JWT keys
2. **Regularly Update** .NET runtime and packages
3. **Enable Firewall** and restrict access to necessary ports
4. **Monitor Logs** for suspicious activity
5. **Regular Backups** of database and uploads
6. **SSL/TLS** for all production traffic

## Performance Optimization

1. **Enable Redis Caching** for frequently accessed data
2. **Configure Nginx Caching** for static files
3. **Database Indexing** for frequently queried columns
4. **Connection Pooling** in PostgreSQL configuration
5. **CDN Integration** for static assets (optional)

## Support

For issues or questions:
1. Check application logs
2. Review this deployment guide
3. Contact system administrator