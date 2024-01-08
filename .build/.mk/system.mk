##@ System:

ENV=dev
COLOR_GREEN=\033[1;32m
COLOR_END=\033[0m

up: ## up project [make up] [make up build=1 watch=1]
ifdef build
	$(eval OPTS=${OPTS} --build)
	sudo rm -rf .build/dev/db
	make db-load
endif
ifdef watch
else
	$(eval OPTS=${OPTS} -d)
endif
	docker-compose up ${OPTS} --remove-orphans

down: ## down project [make down]
	docker-compose down --remove-orphans

start: ## start service [make start php]
	docker-compose start $(ARGS)

stop: ## stop service [make stop php]
	docker-compose stop $(ARGS)

exec: ## call exec service [make exec php bin/console]
ifdef su
	$(eval OPTS=${OPTS} -u root)
endif
	docker-compose exec ${OPTS} $(ARGS)

run: ## call run service [make run php composer install]
	docker-compose run $(ARGS)

ps: ## show ps [make ps]
	docker-compose ps

logs: ## show last 100 lines of logs [make logs php]
	docker-compose logs --tail=100 $(ARGS)

restart: ## restart service [make restart php]
	docker-compose restart $(ARGS)
