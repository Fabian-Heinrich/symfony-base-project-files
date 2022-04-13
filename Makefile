SHELL := /bin/bash

.DEFAULT_GOAL = help

help:
	echo "Commands: tests, setup. Running these commands will drop existing databases!"
.PHONY: help

setup:
	composer install
	bin/console doctrine:database:drop --force || true
	bin/console doctrine:database:create
	bin/console doctrine:migrations:migrate -n
	bin/console doctrine:fixtures:load -n
.PHONY: setup

tests:
	bin/console doctrine:database:drop --force --env=test || true
	bin/console doctrine:database:create --env=test
	bin/console doctrine:migrations:migrate -n --env=test
	bin/console doctrine:fixtures:load -n --env=test
	bin/phpunit $@
.PHONY: tests
