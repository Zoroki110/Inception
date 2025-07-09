# Créer un wp-config.php simplifié qui fonctionne
docker exec wordpress /bin/bash -c 'cat > /var/www/html/wp-config-new.php << "EOF"
<?php
define("DB_NAME", "wordpress");
define("DB_USER", "wpuser");
define("DB_PASSWORD", "inception");
define("DB_HOST", "mariadb:3306");
define("DB_CHARSET", "utf8mb4");
define("DB_COLLATE", "");

define("AUTH_KEY", "put your unique phrase here");
define("SECURE_AUTH_KEY", "put your unique phrase here");
define("LOGGED_IN_KEY", "put your unique phrase here");
define("NONCE_KEY", "put your unique phrase here");
define("AUTH_SALT", "put your unique phrase here");
define("SECURE_AUTH_SALT", "put your unique phrase here");
define("LOGGED_IN_SALT", "put your unique phrase here");
define("NONCE_SALT", "put your unique phrase here");

$table_prefix = "wp_";
define("WP_DEBUG", false);

if (!defined("ABSPATH")) {
    define("ABSPATH", __DIR__ . "/");
}
require_once ABSPATH . "wp-settings.php";
EOF'

# Remplacer l'ancien par le nouveau
docker exec wordpress mv /var/www/html/wp-config.php /var/www/html/wp-config-old.php
docker exec wordpress mv /var/www/html/wp-config-new.php /var/www/html/wp-config.php