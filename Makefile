INFO=\033[0;33m
ENDINFO=\033[0m

install:
	export COMPOSE_FILE=docker-compose.dev.yml
	docker-compose build
up:
	export COMPOSE_FILE=docker-compose.dev.yml
	docker-compose up -d
	docker-compose run web rails db:migrate

debug:
	docker attach snackbox_rails_web_1