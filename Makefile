# NAME = inception

# # Colors for output
# RED = \033[0;31m
# GREEN = \033[0;32m
# YELLOW = \033[0;33m
# NC = \033[0m # No Color

# all: up

# up: build
# 	@echo "$(GREEN)Starting containers...$(NC)"
# 	@sudo mkdir -p /home/$(USER)/data/mariadb
# 	@sudo mkdir -p /home/$(USER)/data/wordpress
# 	@docker compose -f ./docker-compose.yml up -d

# build:
# 	@echo "$(YELLOW)Building images...$(NC)"
# 	@docker compose -f ./docker-compose.yml build

# down:
# 	@echo "$(RED)Stopping containers...$(NC)"
# 	@docker compose -f ./docker-compose.yml down

# restart: down up

# clean: down
# 	@echo "$(RED)Cleaning up...$(NC)"
# 	@docker system prune -a -f
# 	@docker volume prune -f

# fclean: clean
# 	@echo "$(RED)Full cleanup...$(NC)"
# 	@sudo rm -rf /home/$(USER)/data/mariadb
# 	@sudo rm -rf /home/$(USER)/data/wordpress
# 	@docker system prune -a -f --volumes

# re: fclean all

# logs:
# 	@docker compose -f ./docker-compose.yml logs -f

# status:
# 	@docker compose -f ./docker-compose.yml ps

# exec-nginx:
# 	@docker exec -it nginx /bin/bash

# exec-wordpress:
# 	@docker exec -it wordpress /bin/bash

# exec-mariadb:
# 	@docker exec -it mariadb /bin/bash

# .PHONY: all up build down restart clean fclean re logs status exec-nginx exec-wordpress exec-mariadb
NAME = inception

# Colors for output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

all: up

up: build
	@echo "$(GREEN)Starting containers...$(NC)"
	@sudo mkdir -p /home/$(USER)/data/mariadb
	@sudo mkdir -p /home/$(USER)/data/wordpress
	@docker compose -f ./docker-compose.yml up -d

build:
	@echo "$(YELLOW)Building images...$(NC)"
	@docker compose -f ./docker-compose.yml build

down:
	@echo "$(RED)Stopping containers...$(NC)"
	@docker compose -f ./docker-compose.yml down

restart: down up

clean: down
	@echo "$(RED)Cleaning up...$(NC)"
	@docker system prune -a -f
	@docker volume prune -f

fclean: clean
	@echo "$(RED)Full cleanup...$(NC)"
	@sudo rm -rf /home/$(USER)/data/mariadb
	@sudo rm -rf /home/$(USER)/data/wordpress
	@docker system prune -a -f --volumes

re: fclean all

logs:
	@docker compose -f ./docker-compose.yml logs -f

status:
	@docker compose -f ./docker-compose.yml ps

# Individual service commands
mariadb:
	@echo "$(BLUE)Starting MariaDB service...$(NC)"
	@sudo mkdir -p /home/$(USER)/data/mariadb
	@docker compose -f ./docker-compose.yml up -d mariadb

wordpress:
	@echo "$(BLUE)Starting WordPress service...$(NC)"
	@sudo mkdir -p /home/$(USER)/data/mariadb
	@sudo mkdir -p /home/$(USER)/data/wordpress
	@docker compose -f ./docker-compose.yml up -d mariadb wordpress

nginx:
	@echo "$(BLUE)Starting Nginx service...$(NC)"
	@sudo mkdir -p /home/$(USER)/data/mariadb
	@sudo mkdir -p /home/$(USER)/data/wordpress
	@docker compose -f ./docker-compose.yml up -d

# Service-specific builds
build-mariadb:
	@echo "$(YELLOW)Building MariaDB image...$(NC)"
	@docker compose -f ./docker-compose.yml build mariadb

build-wordpress:
	@echo "$(YELLOW)Building WordPress image...$(NC)"
	@docker compose -f ./docker-compose.yml build wordpress

build-nginx:
	@echo "$(YELLOW)Building Nginx image...$(NC)"
	@docker compose -f ./docker-compose.yml build nginx

# Service-specific stops
stop-mariadb:
	@echo "$(RED)Stopping MariaDB service...$(NC)"
	@docker compose -f ./docker-compose.yml stop mariadb

stop-wordpress:
	@echo "$(RED)Stopping WordPress service...$(NC)"
	@docker compose -f ./docker-compose.yml stop wordpress

stop-nginx:
	@echo "$(RED)Stopping Nginx service...$(NC)"
	@docker compose -f ./docker-compose.yml stop nginx

# Service-specific restarts
restart-mariadb:
	@echo "$(BLUE)Restarting MariaDB service...$(NC)"
	@docker compose -f ./docker-compose.yml restart mariadb

restart-wordpress:
	@echo "$(BLUE)Restarting WordPress service...$(NC)"
	@docker compose -f ./docker-compose.yml restart wordpress

restart-nginx:
	@echo "$(BLUE)Restarting Nginx service...$(NC)"
	@docker compose -f ./docker-compose.yml restart nginx

# Execute commands in containers
exec-nginx:
	@docker exec -it nginx /bin/bash

exec-wordpress:
	@docker exec -it wordpress /bin/bash

exec-mariadb:
	@docker exec -it mariadb /bin/bash

# Logs for specific services
logs-mariadb:
	@docker compose -f ./docker-compose.yml logs -f mariadb

logs-wordpress:
	@docker compose -f ./docker-compose.yml logs -f wordpress

logs-nginx:
	@docker compose -f ./docker-compose.yml logs -f nginx

# Service health checks
health:
	@echo "$(BLUE)Checking service health...$(NC)"
	@docker compose -f ./docker-compose.yml ps --format table

# Help command
help:
	@echo "$(GREEN)Available commands:$(NC)"
	@echo "  $(YELLOW)all$(NC)           - Build and start all services"
	@echo "  $(YELLOW)up$(NC)            - Start all services"
	@echo "  $(YELLOW)build$(NC)         - Build all images"
	@echo "  $(YELLOW)down$(NC)          - Stop all services"
	@echo "  $(YELLOW)restart$(NC)       - Restart all services"
	@echo "  $(YELLOW)clean$(NC)         - Clean Docker system"
	@echo "  $(YELLOW)fclean$(NC)        - Full cleanup including data"
	@echo "  $(YELLOW)re$(NC)            - Full rebuild"
	@echo "  $(YELLOW)logs$(NC)          - Show all logs"
	@echo "  $(YELLOW)status$(NC)        - Show container status"
	@echo "  $(YELLOW)health$(NC)        - Check service health"
	@echo ""
	@echo "$(GREEN)Individual services:$(NC)"
	@echo "  $(YELLOW)mariadb$(NC)       - Start MariaDB only"
	@echo "  $(YELLOW)wordpress$(NC)     - Start WordPress (with MariaDB)"
	@echo "  $(YELLOW)nginx$(NC)         - Start all services"
	@echo ""
	@echo "$(GREEN)Service-specific commands:$(NC)"
	@echo "  $(YELLOW)build-[service]$(NC)   - Build specific service"
	@echo "  $(YELLOW)stop-[service]$(NC)    - Stop specific service"
	@echo "  $(YELLOW)restart-[service]$(NC) - Restart specific service"
	@echo "  $(YELLOW)logs-[service]$(NC)    - Show logs for specific service"
	@echo "  $(YELLOW)exec-[service]$(NC)    - Execute bash in specific service"

.PHONY: all up build down restart clean fclean re logs status help health \
        mariadb wordpress nginx \
        build-mariadb build-wordpress build-nginx \
        stop-mariadb stop-wordpress stop-nginx \
        restart-mariadb restart-wordpress restart-nginx \
        logs-mariadb logs-wordpress logs-nginx \
        exec-nginx exec-wordpress exec-mariadb