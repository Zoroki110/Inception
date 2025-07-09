FROM debian:bullseye

# Install nginx and openssl
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate SSL certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=localhost/UID=login"

# Copy nginx configuration
COPY conf/default.conf /etc/nginx/sites-available/default
COPY tools/nginx_start.sh /usr/local/bin/nginx_start.sh

# Make script executable
RUN chmod +x /usr/local/bin/nginx_start.sh

# Create nginx directories
RUN mkdir -p /var/run/nginx

# Expose port 443
EXPOSE 443

# Start nginx
CMD ["/usr/local/bin/nginx_start.sh"]