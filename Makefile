app.shell:
	docker exec -ti todo-web sh

bootstrap:
	make build
	make up
	make composer.install
	make migrate
	make ide

composer.install:
	docker run -v `pwd`:/app -v ~/Source/eliatcodecov/laravel-codecov-opentelemetry:/var/deps/laravel-codecov-opentelemetry composer:2.0 composer install

composer.update:
	docker run -v `pwd`:/app -v ~/Source/eliatcodecov/laravel-codecov-opentelemetry:/var/deps/laravel-codecov-opentelemetry composer:2.0 composer update

composer.shell:
	docker run -it -v `pwd`:/app -v ~/Source/eliatcodecov/laravel-codecov-opentelemetry:/var/deps/laravel-codecov-opentelemetry composer:2.0 sh

up:
	docker-compose up -d

build:
	docker build -f docker/Dockerfile.base -t eliatcodecov/todo-base:latest .
	docker-compose build

migrate:
	docker exec todo-web php artisan migrate

migrate.fresh:
	docker exec todo-web php artisan migrate:fresh

format:
	docker exec todo-web vendor/bin/phpcbf --standard=psr2 app/

ide:
	docker exec todo-web php artisan ide-helper:generate
	docker exec todo-web php artisan ide-helper:meta

models:
	docker exec todo-web php artisan ide-helper:models --write