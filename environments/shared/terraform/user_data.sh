#!/bin/bash

# Update system
yum update -y

# Install Docker
yum install -y docker
systemctl start docker
systemctl enable docker

# Add ec2-user to docker group
usermod -a -G docker ec2-user

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create application directory
mkdir -p /opt/digital-kudos-wall
cd /opt/digital-kudos-wall

# Create docker-compose.yml
cat > docker-compose.yml << EOF

services:
  frontend:
    image: $${FRONTEND_IMAGE_URI_WITH_TAG:-${frontend_image}}
    ports:
      - "${frontend_port}:80"
    environment:
      - NODE_ENV=${environment}
      - REACT_APP_API_URL=http://localhost:${backend_port}/api
    restart: unless-stopped
    depends_on:
      - backend

  backend:
    image: $${BACKEND_IMAGE_URI_WITH_TAG:-${backend_image}}
    ports:
      - "${backend_port}:3001"
    environment:
      - NODE_ENV=${environment}
      - PORT=3001
    volumes:
      - ./data:/app/data
    restart: unless-stopped

volumes:
  data:
EOF

# Create data directory for SQLite database
mkdir -p data

# Create a simple nginx config for reverse proxy (optional)
cat > nginx.conf << EOF
events {
    worker_connections 1024;
}

http {
    upstream frontend {
        server frontend:80;
    }
    
    upstream backend {
        server backend:3001;
    }

    server {
        listen 80;
        
        location / {
            proxy_pass http://frontend;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
        }
        
        location /api/ {
            proxy_pass http://backend;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
        }
    }
}
EOF

# Start the application
docker-compose pull
docker-compose up -d

# Create a simple health check script
cat > health-check.sh << 'EOF'
#!/bin/bash
echo "Checking application health..."
echo "Frontend: $(curl -s -o /dev/null -w "%%{http_code}" http://localhost:${frontend_port})"
echo "Backend: $(curl -s -o /dev/null -w "%%{http_code}" http://localhost:${backend_port}/health)"
EOF

chmod +x health-check.sh

# Set up log rotation
cat > /etc/logrotate.d/docker-compose << EOF
/opt/digital-kudos-wall/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
}
EOF

# Create a startup script for reboots
cat > /etc/systemd/system/digital-kudos-wall.service << EOF
[Unit]
Description=Digital Kudos Wall Application
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/opt/digital-kudos-wall
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF

systemctl enable digital-kudos-wall.service

echo "Digital Kudos Wall setup complete!"
echo "Frontend available at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):${frontend_port}"
echo "Backend available at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):${backend_port}" 