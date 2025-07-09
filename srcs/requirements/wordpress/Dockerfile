FROM debian:bullseye

# Install PHP and required extensions
RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-soap \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-zip \
    curl \
    wget \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Create directory for WordPress
RUN mkdir -p /var/www/html

# Download and install WordPress CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/master/bin/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    || (wget https://raw.githubusercontent.com/wp-cli/wp-cli/master/bin/wp-cli.phar \
        && chmod +x wp-cli.phar \
        && mv wp-cli.phar /usr/local/bin/wp)

# Configure PHP-FPM
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i 's/;listen.owner = www-data/listen.owner = www-data/' /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i 's/;listen.group = www-data/listen.group = www-data/' /etc/php/7.4/fpm/pool.d/www.conf

# Copy WordPress configuration and startup script
COPY conf/wp-config.php /var/www/html/wp-config.php
COPY tools/wordpress_start.sh /usr/local/bin/wordpress_start.sh

# Make script executable
RUN chmod +x /usr/local/bin/wordpress_start.sh

# Create PHP-FPM run directory
RUN mkdir -p /run/php

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 9000
EXPOSE 9000

# Start WordPress
CMD ["/usr/local/bin/wordpress_start.sh"]