#!/bin/bash

# Initialize MariaDB data directory if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

# Start MariaDB in background to set up users and database
echo "Starting MariaDB temporarily..."
mysqld_safe --user=mysql --datadir=/var/lib/mysql &

# Wait for MariaDB to start
echo "Waiting for MariaDB to start..."
while ! mysqladmin ping -h"localhost" --silent; do
    sleep 1
done

# Set up root password and create database
echo "Setting up MariaDB..."
mysql -u root << EOF
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Stop the temporary MariaDB instance
echo "Stopping temporary MariaDB instance..."
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

# Start MariaDB in foreground
echo "Starting MariaDB in foreground..."
exec mysqld_safe --user=mysql --datadir=/var/lib/mysql