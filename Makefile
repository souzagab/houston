DEVELOPMENT_PATH = docker-compose.yml

## Misc
list: # List all available targets for this Makefile
	@grep '^[^#[:space:]].*:' Makefile

## Development
start: # Start all containers
	docker compose -f $(DEVELOPMENT_PATH) up -d

stop: # Stop all containers
	docker compose -f $(DEVELOPMENT_PATH) down

purge: # Stop and remove all containers, volumes and images
	docker compose -f $(DEVELOPMENT_PATH) down --rmi all --volumes --remove-orphans

test: # Run rspec tests
	bundle exec rspec

setup: start # Setup the project
	rails db:create db:migrate db:seed

server: start # Start the server
	bin/rails s -p 3001
