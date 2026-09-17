#!/bin/bash

# CarPartsStore.API Linux Deployment Script
# Run this script as root or with sudo

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
ENVIRONMENT="Production"
POSTGRES_PASSWORD="ChangeMe123!"
JWT_KEY="YourSecureJwtKeyHereMinimum32Characters"
UPLOADS_PATH="/var/www/carpartsstore/uploads"

print_header() {
    echo -e "${BLUE}"
    echo "============================================="
    echo "CarPartsStore.API Linux Deployment Script"
    echo "============================================="
    echo -e "${NC}"
}

print_step() {
    echo -e "${GREEN}[STEP $1]${NC} $2"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

check_prerequisites() {
    print_step "1" "Checking prerequisites..."
    
    # Check if running as root
    if [ "$EUID" -ne 0 ]; then 
        print_error "This script must be run as root or with sudo"
        exit 1
    fi
    
    # Check required commands
    local missing_commands=()
    
    for cmd in docker docker-compose dotnet curl; do
        if ! command -v $cmd &> /dev/null; then
            missing_commands+=("$cmd")
        fi
    done
    
    if [ ${#missing_commands[@]} -ne 0 ]; then
        print_error "Missing required commands: ${missing_commands[*]}"
        print_warning "Please install missing packages before continuing"
        exit 1
    fi
    
    print_success "All prerequisites met"
}

setup_environment() {
    print_step "2" "Setting up environment..."
    
    # Create .env file
    cat > .env << EOF
# PostgreSQL Configuration
POSTGRES_PASSWORD=$POSTGRES_PASSWORD
POSTGRES_USER=postgres
POSTGRES_DB=carpartsstore
POSTGRES_HOST=localhost
POSTGRES_PORT=5432

# Redis Configuration
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=

# JWT Configuration
JWT_KEY=$JWT_KEY
JWT_ISSUER=CarPartsStore.API
JWT_AUDIENCE=CarPartsStore.Client
JWT_EXPIRE_DAYS=7

# Application Configuration
ASPNETCORE_ENVIRONMENT=$ENVIRONMENT
ASPNETCORE_URLS=http://+:8080;https://+:8081
FILE_UPLOAD_PATH=$UPLOADS_PATH
MAX_FILE_SIZE_MB=100
EOF
    
    print_success "Created .env file"
    
    # Create uploads directory
    mkdir -p $UPLOADS_PATH/{products,slides,stories}
    chown -R www-data:www-data $UPLOADS_PATH
    chmod -R 755 $UPLOADS_PATH
    
    print_success "Created uploads directory at $UPLOADS_PATH"
}

build_application() {
    print_step "3" "Building application..."
    
    # Restore packages
    if ! dotnet restore; then
        print_error "Failed to restore packages"
        exit 1
    fi
    
    # Build application
    if ! dotnet build --configuration Release; then
        print_error "Failed to build application"
        exit 1
    fi
    
    print_success "Application built successfully"
}

start_services() {
    print_step "4" "Starting Docker services..."
    
    # Stop any existing containers
    docker-compose down 2>/dev/null || true
    
    # Start containers
    if ! docker-compose up -d; then
        print_error "Failed to start Docker containers"
        exit 1
    fi
    
    # Wait for services to start
    print_warning "Waiting for services to start (30 seconds)..."
    sleep 30
    
    # Check container status
    print_success "Docker containers started"
    echo ""
    docker-compose ps
}

wait_for_postgres() {
    print_step "5" "Waiting for PostgreSQL to be ready..."
    
    local max_retries=30
    local retry_count=0
    
    while [ $retry_count -lt $max_retries ]; do
        if docker exec carpartsstore-postgres pg_isready -U postgres 2>/dev/null | grep -q "accepting connections"; then
            print_success "PostgreSQL is ready"
            return 0
        fi
        
        retry_count=$((retry_count + 1))
        print_warning "Waiting... ($retry_count/$max_retries)"
        sleep 2
    done
    
    print_error "PostgreSQL did not become ready in time"
    return 1
}

run_migration() {
    print_step "6" "Running database migration..."
    
    if ! wait_for_postgres; then
        exit 1
    fi
    
    # Run migration script
    if ! docker exec carpartsstore-postgres psql -U postgres -d carpartsstore -f /docker-entrypoint-initdb.d/init.sql; then
        print_error "Failed to run migration script"
        exit 1
    fi
    
    print_success "Database migration completed"
}

verify_deployment() {
    print_step "7" "Verifying deployment..."
    
    local max_retries=30
    local retry_count=0
    
    while [ $retry_count -lt $max_retries ]; do
        if curl -f http://localhost:5000/api/health > /dev/null 2>&1; then
            print_success "API is responding"
            break
        fi
        
        retry_count=$((retry_count + 1))
        print_warning "Waiting for API... ($retry_count/$max_retries)"
        sleep 2
    done
    
    if [ $retry_count -eq $max_retries ]; then
        print_error "API did not become ready in time"
        exit 1
    fi
    
    # Test Swagger UI
    if curl -f http://localhost:5000/swagger > /dev/null 2>&1; then
        print_success "Swagger UI is accessible"
    else
        print_warning "Swagger UI may not be accessible"
    fi
    
    print_success "Deployment verification completed"
}

display_summary() {
    echo ""
    echo -e "${GREEN}=============================================${NC}"
    echo -e "${GREEN}    DEPLOYMENT COMPLETED SUCCESSFULLY!      ${NC}"
    echo -e "${GREEN}=============================================${NC}"
    echo ""
    echo -e "${BLUE}Application URLs:${NC}"
    echo "  API: http://localhost:5000"
    echo "  Swagger UI: http://localhost:5000/swagger"
    echo "  Health Check: http://localhost:5000/api/health"
    echo ""
    echo -e "${BLUE}Services:${NC}"
    echo "  PostgreSQL: localhost:5432"
    echo "  Redis: localhost:6379"
    echo "  Nginx: localhost:80"
    echo ""
    echo -e "${BLUE}Default Admin Credentials:${NC}"
    echo "  Username: admin"
    echo "  Email: admin@carpartsstore.com"
    echo "  Password: Admin123!"
    echo ""
    echo -e "${BLUE}Management Commands:${NC}"
    echo "  View logs: docker-compose logs -f"
    echo "  Stop services: docker-compose down"
    echo "  Restart services: docker-compose restart"
    echo "  View status: docker-compose ps"
    echo ""
    echo -e "${YELLOW}Next Steps:${NC}"
    echo "  1. Update the JWT key in .env file for production"
    echo "  2. Configure SSL/TLS for production"
    echo "  3. Set up proper backups"
    echo "  4. Configure monitoring and alerts"
    echo ""
    echo -e "${GREEN}=============================================${NC}"
}

main() {
    print_header
    
    echo -e "${YELLOW}Deployment Configuration:${NC}"
    echo "  Environment: $ENVIRONMENT"
    echo "  PostgreSQL Password: ******"
    echo "  JWT Key: ******"
    echo "  Uploads Path: $UPLOADS_PATH"
    echo ""
    
    read -p "Do you want to proceed with deployment? (yes/no): " confirmation
    if [ "$confirmation" != "yes" ]; then
        print_warning "Deployment cancelled"
        exit 0
    fi
    
    check_prerequisites
    setup_environment
    build_application
    start_services
    run_migration
    verify_deployment
    display_summary
}

# Run main function
main "$@"