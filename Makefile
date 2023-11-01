include .env
DEFAULT_GOAL := help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-40s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build: ## Build all docker images.
	docker compose build

##@ [Application]
new: ## Create a new laravel application
	mkdir src
	docker compose run --rm laravel composer create-project --prefer-dist laravel/laravel .
	sed -i 's/DB_USERNAME=root/DB_USERNAME=${MYSQL_USER}/g' src/.env
	sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=${MYSQL_PASSWORD}/g' src/.env
	sed -i 's/DB_HOST=.*/DB_HOST=mysql/g' src/.env
	# poi fai stessa cosa per redis e porta DB_HOST

start: ## Start the application
	docker compose up -d
