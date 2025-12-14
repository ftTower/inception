# Inception

A Docker infrastructure project from the 42 school curriculum. This project involves setting up a small infrastructure composed of different services using Docker and Docker Compose.

## 📋 Project Overview

Inception is a system administration and DevOps project that requires building a small infrastructure with multiple Docker containers. Each service runs in a dedicated container built from Debian Bullseye base images.

### Architecture

The infrastructure consists of three main services:
- **NGINX**: Web server with TLSv1.2 or TLSv1.3
- **WordPress**: PHP-FPM content management system
- **MariaDB**: MySQL database server

All services communicate through a Docker bridge network and use persistent volumes for data storage.

## 🔧 Technical Requirements

### Services

1. **NGINX Container**
   - Debian Bullseye base image
   - TLS/SSL configuration with self-signed certificate
   - Serves as the only entry point via port 443
   - Reverse proxy for WordPress

2. **WordPress Container**
   - Debian Bullseye base image
   - PHP-FPM 7.4
   - WP-CLI for WordPress configuration
   - Connects to MariaDB database

3. **MariaDB Container**
   - Debian Bullseye base image
   - MySQL database server
   - Persistent data storage
   - Exposed only to the internal network

### Volumes

Two persistent volumes are configured:
- `/home/tauer/data/wordpress`: WordPress website files
- `/home/tauer/data/mariadb`: Database data

### Network

- Custom Docker bridge network named `inception`
- Internal communication between services
- Only NGINX is exposed to the host (port 443)

## 🚀 Installation

### Prerequisites

- Docker
- Docker Compose
- sudo privileges

### Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd inception
```

2. Create the required directories:
```bash
sudo mkdir -p /home/tauer/data/wordpress
sudo mkdir -p /home/tauer/data/mariadb
```

3. Create a `.env` file in the `srcs/` directory with your configuration:
```bash
# Database Configuration
MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_DATABASE=wordpress
MYSQL_USER=your_user
MYSQL_PASSWORD=your_password

# WordPress Configuration
WORDPRESS_DB_HOST=mariadb:3306
WORDPRESS_DB_NAME=wordpress
WORDPRESS_DB_USER=your_user
WORDPRESS_DB_PASSWORD=your_password
WORDPRESS_ADMIN_USER=admin
WORDPRESS_ADMIN_PASSWORD=admin_password
WORDPRESS_ADMIN_EMAIL=admin@example.com

# Domain
DOMAIN_NAME=tauer.42.fr
```

## 📦 Usage

### Build and Start

Build and start all services:
```bash
make
```

This command will:
- Add the domain name to `/etc/hosts`
- Build all Docker images
- Start all containers in detached mode

### Access the Website

Open your browser and navigate to:
```
https://tauer.42.fr
```

Note: You'll need to accept the self-signed certificate warning.

### Stop Services

Stop and remove all containers:
```bash
make clean
```

### Complete Cleanup

Remove everything including volumes and hosts entry:
```bash
make fclean
```

### Restart

Clean and rebuild everything:
```bash
make re
```

### Check Status

List running containers and images:
```bash
make ls
```

## 🐳 Docker Commands Reference

### Container Management
```bash
# List all containers
docker ps -a

# Execute commands in a container
docker exec -it <container_name> sh

# View container logs
docker logs <container_name>

# Stop a container
docker stop <container_name>

# Remove a container
docker rm <container_name>
```

### Image Management
```bash
# List images
docker image ls

# Remove an image
docker image rm <image_name>

# Remove all unused images
docker system prune -a
```

### Docker Compose Commands
```bash
# Start services
docker compose up -d

# Stop services
docker compose down

# View logs
docker compose logs -f

# Rebuild services
docker compose up -d --build
```

## 📁 Project Structure

```
inception/
├── Makefile                          # Build automation
├── readme.md                         # This file
└── srcs/
    ├── docker-compose.yml           # Service orchestration
    ├── .env                         # Environment variables (not in repo)
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile
        │   └── conf/
        │       ├── 50-server.cnf    # MariaDB configuration
        │       └── script.sh         # Database initialization
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/
        │       └── nginx.conf        # NGINX configuration
        └── wordpress/
            ├── Dockerfile
            └── conf/
                ├── auto_config.sh    # WordPress setup script
                └── www.conf          # PHP-FPM configuration
```

## ⚙️ Configuration Details

### NGINX
- Listens on port 443 (HTTPS)
- SSL/TLS self-signed certificate
- Configured to proxy requests to WordPress PHP-FPM

### WordPress
- Automated installation via WP-CLI
- PHP-FPM listening on port 9000
- Connected to MariaDB database

### MariaDB
- Listens on port 3306 (internal network only)
- Persistent storage in `/home/tauer/data/mariadb`
- Configured with custom user and database

## 🔒 Security Notes

- All passwords should be stored in the `.env` file (not committed to git)
- SSL certificate is self-signed (for development purposes)
- Database is not exposed to the host network
- Root passwords should be strong and unique

## 🐛 Troubleshooting

### Permission Issues
If you encounter permission issues with volumes:
```bash
sudo chown -R $USER:$USER /home/tauer/data
```

### Port Already in Use
If port 443 is already in use:
```bash
sudo lsof -i :443
# Kill the process using the port
```

### Database Connection Issues
Check if MariaDB is running:
```bash
docker logs mariadb
```

### Reset Everything
For a complete reset:
```bash
make fclean
sudo rm -rf /home/tauer/data/*
make
```

## 📚 Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [WordPress CLI](https://wp-cli.org/)
- [MariaDB Documentation](https://mariadb.org/documentation/)

## 👤 Author

**tauer** - 42 School Student

## 📝 License

This project is part of the 42 school curriculum.

