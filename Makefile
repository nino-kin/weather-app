.PHONY: clean debug mkdocs-build mkdocs-serve
.DEFAULT_GOAL := help

SHELL := /bin/bash

PROJECT_NAME := weather_app

PWD := $(shell pwd)
ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

# TODO: Define your OpenWeather API key
# https://openweathermap.org/api
API_KEY := YOUR_API_KEY
DEVICE := Chrome

# For more information on this technique, see
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

#---------------------------------------#
# General                               #
#---------------------------------------#
help: ## Show this help message
	@echo -e "\nUsage: make <command>\n\nCommands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

#---------------------------------------#
# flutter                               #
#---------------------------------------#
clean: ## Clean all artifacts
	@echo -e "\nINFO: Cleaning up..."
	@flutter clean
	@[ -z "$$(find . -maxdepth 1 -type d -name 'site')" ] || sudo chmod -R 777 site/ && rm -rf site/

debug: ## Run a flutter app in debug mode
	@echo -e "\nINFO: Running the app in debug mode..."
	@flutter run --debug -d $(DEVICE) --dart-define=API_KEY=$(API_KEY)

#---------------------------------------#
# MkDocs                                #
#---------------------------------------#
mkdocs-build: ## Build documentation for MkDocs
	@docker run --rm -it -v $(PWD):/docs squidfunk/mkdocs-material build

mkdocs-serve: ## Serve documentation for MkDocs
	@docker run --rm -it -p $(DOCKER_PORT):8000 -v $(PWD):/docs squidfunk/mkdocs-material
