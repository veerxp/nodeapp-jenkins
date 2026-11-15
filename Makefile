# ── Makefile — handy shortcuts ───────────────────────────
.PHONY: install dev test build up down logs clean

install:        ## Install npm dependencies
	npm install

dev:            ## Run app in dev mode (hot-reload)
	npm run dev

test:           ## Run tests with coverage
	npm test

build:          ## Build Docker image
	docker build -t nodeapp:latest .

up:             ## Start all services (production mode)
	docker compose up -d

down:           ## Stop all services
	docker compose down

logs:           ## Tail logs from app container
	docker compose logs -f app

clean:          ## Remove containers, images, volumes
	docker compose down -v --rmi local

dev-up:         ## Start dev mode with hot-reload
	docker compose --profile dev up -d app-dev redis

shell:          ## Open shell in running container
	docker exec -it nodeapp sh

help:           ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
