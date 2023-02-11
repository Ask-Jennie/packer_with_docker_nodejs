# Init vars
MAKEFILE := $(lastword $(MAKEFILE_LIST))
BASENAME := $(shell basename "$(PWD)")
SHELL := /bin/bash

.PHONY: help
all: help
help: Makefile
	@echo
	@echo " Commands:"
	@echo
	@sed -n 's/^##//p' $< | sed -e 's/^/ /' | sort
	@echo

build:
	docker build -f Dockerfile -t dockerexamplecontainer .
	packer init .
	packer build $(PACKER_BUILD_ARGS) .

## run-container    Run the container
run:
	docker run --rm -it -p 8080:80 dockerexamplecontainer:latest

## fmt              Run formating
fmt:
	@packer fmt -write=true -recursive .	
