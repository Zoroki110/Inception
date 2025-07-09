#!/bin/bash

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
while ! mysql -h mariadb -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1" >/dev/null 2>&1; do
    sleep 1
done

# Change to WordPress directory
cd /var/www/html

# Download and install WordPress if not already present
if [ ! -f index.php ]; then
    echo "Downloading WordPress..."
    
    # Download WordPress using wget instead of WP-CLI
    cd /tmp
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -r wordpress/* /var/www/html/
    
    # Create the database if it doesn't exist
    echo "Setting up database..."
    mysql -h mariadb -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
    
    echo "WordPress download completed!"
else
    echo "WordPress already installed, skipping installation..."
fi

# Generate wp-config.php with actual values instead of getenv()
echo "Generating wp-config.php..."
cat > /var/www/html/wp-config.php << EOF
<?php
/**
 * The base configuration for WordPress
 */
// ** MySQL settings ** //
define('DB_NAME', '$MYSQL_DATABASE');
define('DB_USER', '$MYSQL_USER');
define('DB_PASSWORD', '$MYSQL_PASSWORD');
define('DB_HOST', 'mariadb:3306');
define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

// ** Authentication Unique Keys and Salts ** //
define('AUTH_KEY', 'put your unique phrase here');
define('SECURE_AUTH_KEY', 'put your unique phrase here');
define('LOGGED_IN_KEY', 'put your unique phrase here');
define('NONCE_KEY', 'put your unique phrase here');
define('AUTH_SALT', 'put your unique phrase here');
define('SECURE_AUTH_SALT', 'put your unique phrase here');
define('LOGGED_IN_SALT', 'put your unique phrase here');
define('NONCE_SALT', 'put your unique phrase here');

// ** WordPress Database Table prefix ** //
\$table_prefix = 'wp_';

// ** For developers: WordPress debugging mode ** //
define('WP_DEBUG', false);

// ** WordPress Home and Site URL ** //
define('WP_HOME', '$WORDPRESS_URL');
define('WP_SITEURL', '$WORDPRESS_URL');

// ** Disable file editing ** //
define('DISALLOW_FILE_EDIT', true);

// ** Memory limit ** //
define('WP_MEMORY_LIMIT', '256M');

// ** WordPress Cache ** //
define('WP_CACHE', true);

// ** Force SSL ** //
define('FORCE_SSL_ADMIN', true);

// ** Absolute path to the WordPress directory ** //
if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

// ** Sets up WordPress vars and included files ** //
require_once ABSPATH . 'wp-settings.php';
EOF

# Set proper permissions
echo "Setting permissions..."
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Start PHP-FPM
echo "Starting PHP-FPM..."
exec php-fpm7.4 -F