
.PHONY: install dev test build up down logs clean

install:       
	npm install

dev:            
	npm run dev

test:           
	npm test

build:          
	docker build -t nodeapp:latest .

up:             
	docker compose up -d

down:          
	docker compose down

logs:           
	docker compose logs -f app

clean:         
	docker compose down -v --rmi local

dev-up:         
	docker compose --profile dev up -d app-dev redis

shell:          
	docker exec -it nodeapp sh

help:           
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
