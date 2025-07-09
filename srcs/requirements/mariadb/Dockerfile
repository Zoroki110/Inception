FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Copy MariaDB configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb_start.sh /usr/local/bin/mariadb_start.sh

# Make script executable
RUN chmod +x /usr/local/bin/mariadb_start.sh

# Create MySQL directories
RUN mkdir -p /var/run/mysqld /var/lib/mysql
RUN chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

# Expose port 3306
EXPOSE 3306

# Start MariaDB
CMD ["/usr/local/bin/mariadb_start.sh"]