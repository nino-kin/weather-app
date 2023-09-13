.PHONY: cmake build clean run
.DEFAULT_GOAL := help

SHELL := /bin/bash

ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
PROJECT_NAME := weather_app
BUILD_DIR := build
SCRIPT_DIR := scripts

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
