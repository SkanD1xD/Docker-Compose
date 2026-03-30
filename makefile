.PHONY: help compose-install compose-up compose-down compose-build compose-push ci test

help:
	@echo "Available commands:"
	@echo "  make compose-install    Install dependencies inside container"
	@echo "  make compose-up         Start all services"
	@echo "  make compose-down       Stop all services"
	@echo "  make compose-build      Build Docker image"
	@echo "  make compose-push       Push image to Docker Hub"
	@echo "  make ci                 Run tests in CI mode"

compose-install:
	docker compose run --rm app npm install

compose-up:
	docker compose up -d

compose-down:
	docker compose down

compose-build:
	docker compose build app

compose-push:
	@echo "Tagging and pushing image..."
	docker tag js-fastify-blog-app your-dockerhub-username/js-fastify-blog:latest
	docker push your-dockerhub-username/js-fastify-blog:latest

ci: compose-up
	@echo "Waiting for services to be ready..."
	sleep 10
	docker compose exec app npm test
	docker compose down

test:
	npm test