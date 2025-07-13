.PHONY: up down build logs clean

# Start all services
up:
	docker compose up

# start specific service
# usage: make up-mcp
up-%:
	docker compose up $*

# Stop services
down:
	docker compose down

down-%:
	docker compose down $*

# Build all images
build:
	docker compose build

# View logs
logs:
	docker compose logs -f

# Clean up 
# (stop and remove containers, 
#networks, volumes, local images)
clean:
	docker compose down -v --remove-orphans --rmi local
