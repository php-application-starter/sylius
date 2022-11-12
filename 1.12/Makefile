#========== symfony
SYMFONY = symfony
SYMFONY_SERVER_UP = $(SYMFONY) serve -d
SYMFONY_SERVER_DOWN = $(SYMFONY) server:stop


#========== docker compose
DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_UP = $(DOCKER_COMPOSE) up -d
DOCKER_COMPOSE_DOWN = $(DOCKER_COMPOSE) down

#========== Makefile
up:
	$(DOCKER_COMPOSE_UP) && $(SYMFONY_SERVER_UP)
.PHONY: up

down:
	$(DOCKER_COMPOSE_DOWN) && $(SYMFONY_SERVER_DOWN)
.PHONY: down

reload:
	$(DOWN) && $(UP)
.PHONY: RELOAD

test:
	docker  run  --name test_sylius_112_2 -it sylius_112
rm:
	docker  rm  test_sylius_112_2
