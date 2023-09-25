.PHONY: setup build test run exec kill clean mkdocs-build mkdocs-serve
.DEFAULT_GOAL := help

SHELL := /bin/bash

PROJECT_NAME := weather_app

PWD := $(shell pwd)
ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
BUILD_DIR := build
SCRIPT_DIR := scripts

# Docker
DOCKER_PORT := 8000 # Local web server port

# For more information on this technique, see
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

help: ## Show this help message
	@echo -e "\nUsage: make TARGET\n\nTargets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

setup: ## Set up environment
	@echo -e "\nINFO: Set up your environment..."
	@echo "================================================================================"
	@$(ROOT_DIR)/$(SCRIPT_DIR)/docker.sh setup
	@echo "================================================================================"

build: ## Build the project
	@echo -e "\nINFO: Building $(PROJECT_NAME)..."
	@echo "================================================================================"
	@$(ROOT_DIR)/$(SCRIPT_DIR)/docker.sh build
	@echo "================================================================================"

test: ## Test the projct
	@echo -e "\nINFO: Testing $(PROJECT_NAME)..."
	@echo "================================================================================"
	@$(ROOT_DIR)/$(SCRIPT_DIR)/docker.sh test
	@echo "================================================================================"

run: ## Run Docker conatainer
	@echo -e "\nINFO: Running a container..."
	@echo "================================================================================"
	@$(ROOT_DIR)/$(SCRIPT_DIR)/docker.sh run
	@echo "================================================================================"

exec: ## Run Docker conatainer
	@echo -e "\nINFO: You can execute commands in a running container..."
	@echo "================================================================================"
	@$(ROOT_DIR)/$(SCRIPT_DIR)/docker.sh exec
	@echo "================================================================================"

kill: ## Kill Docker container
	@echo -e "\nINFO: Kill a running container..."
	@echo "================================================================================"
	@$(ROOT_DIR)/$(SCRIPT_DIR)/docker.sh kill
	@echo "================================================================================"

clean: ## Clean all artifacts
	@echo -e "\nINFO: Cleaning up..."
	@sudo rm -rf $(BUILD_DIR)
	@[ -z "$$(find . -maxdepth 1 -type d -name 'site')" ] || sudo chmod -R 777 site/ && rm -rf site/
	@[ -z "$$(find . -maxdepth 1 -type d -name 'out')" ] || sudo chmod -R 777 out/ && rm -rf out/

#---------------------------------------#
# Docker                                #
#---------------------------------------#
docker-compose-up: ## Create and start containers
	@docker-compose up --build

docker-compose-down: ## Remove containers, networks, images and named volumes
	@docker-compose down --rmi all --volumes

#---------------------------------------#
# MkDocs                                #
#---------------------------------------#
mkdocs-build: ## Build documentation for MkDocs
	@docker run --rm -it -v $(PWD):/docs squidfunk/mkdocs-material build

mkdocs-serve: ## Serve documentation for MkDocs
	@docker run --rm -it -p $(DOCKER_PORT):8000 -v $(PWD):/docs squidfunk/mkdocs-material
