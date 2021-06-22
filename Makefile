SHELL = /bin/bash
APP ?= simple-traefik-http-provider
APP_PATH    := $(shell pwd)
APP_VERSION := $(shell bash ./ci/version.sh 2>&- || cat VERSION)
LATEST_VERSION := latest

# docker-compose vars
DC       := $(shell type -p docker-compose)
DC_BUILD_ARGS := --pull --no-cache --force-rm
DC_RUN_ARGS   := -d --no-build
#
DC_BUILD_FILE := docker-compose.yml
DC_RUN_FILE := docker-compose.yml
#
# # detect tty
DOCKER_USE_TTY := $(shell test -t 1 && echo "-t" )
DC_USE_TTY     := $(shell test -t 1 || echo "-T" )
#
#
#
# up/down app
#
check-run-config:
	${DC} -f ${DC_RUN_FILE} config -q

up: check-run-config
	${DC} -f ${DC_RUN_FILE} up ${DC_RUN_ARGS}
up-%: check-run-config
	${DC} -f ${DC_RUN_FILE} up ${DC_RUN_ARGS} $*
stop:
	${DC} -f ${DC_RUN_FILE} stop
stop-%:
	${DC} -f ${DC_RUN_FILE} stop $*
down:
	${DC} -f ${DC_RUN_FILE} down
