.PHONY: clean mkdocs-build mkdocs-serve
.DEFAULT_GOAL := help

SHELL := /bin/bash

PROJECT_NAME := weather_app

PWD := $(shell pwd)
ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

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

#---------------------------------------#
# MkDocs                                #
#---------------------------------------#
mkdocs-build: ## Build documentation for MkDocs
	@docker run --rm -it -v $(PWD):/docs squidfunk/mkdocs-material build

mkdocs-serve: ## Serve documentation for MkDocs
	@docker run --rm -it -p $(DOCKER_PORT):8000 -v $(PWD):/docs squidfunk/mkdocs-material
