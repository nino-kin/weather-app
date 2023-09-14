.PHONY: cmake build clean run mkdocs-build mkdocs-serve
.DEFAULT_GOAL := help

SHELL := /bin/bash

PROJECT_NAME := weather_app

PWD := $(shell pwd)
ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
BUILD_DIR := build
SCRIPT_DIR := scripts

# Local web server port
DOCKER_PORT := 8000

# For more information on this technique, see
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

help: ## Show this help message
	@echo -e "\nUsage: make TARGET\n\nTargets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

cmake: ## Running cmake
	@echo -e "\nINFO: Running CMake..."
	@echo "================================================================================"
	@mkdir -p $(BUILD_DIR)
	@cd $(BUILD_DIR) && cmake ..
	@echo "================================================================================"

build: cmake ## Build the project
	@echo -e "\nINFO: Building $(PROJECT_NAME)..."
	@echo "================================================================================"
	@$(MAKE) -C $(BUILD_DIR)
	@echo "================================================================================"

run: build ## Run services
	@echo -e "\nINFO: Running $(PROJECT_NAME)..."
	@echo "================================================================================"
	@$(ROOT_DIR)/$(SCRIPT_DIR)/udp_sample.sh
	@echo "================================================================================"

clean: ## Clean all artifacts
	@echo -e "\nINFO: Cleaning up..."
	@rm -rf $(BUILD_DIR)
	@[ -z "$$(find . -maxdepth 1 -type d -name 'site')" ] || sudo chmod -R 777 site/ && rm -rf site/

#---------------------------------------#
# MkDocs                                #
#---------------------------------------#
mkdocs-build: ## Build documentation for MkDocs
	@docker run --rm -it -v $(PWD):/docs squidfunk/mkdocs-material build

mkdocs-serve: ## Serve documentation for MkDocs
	@docker run --rm -it -p $(DOCKER_PORT):8000 -v $(PWD):/docs squidfunk/mkdocs-material
