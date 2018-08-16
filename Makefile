
GO ?= go
FIRST_GOPATH := $(firstword $(subst :, ,$(shell $(GO) env GOPATH)))

PREFIX ?= _outputs

DOCKERFILE	?= Dockerfile
DOCKER_REPO ?= pytimer
DOCKER_IMAGE_NAME ?= gpu_exporter
DOCKER_IMAGE_TAG ?= 1.0.0

PROMU := $(FIRST_GOPATH)/bin/promu

.PHONY: promu
promu:
	GOOS= GOARCH= $(GO) get -v -u github.com/prometheus/promu

.PHONY: build
build: promu
	@echo ">> building binaries"
	$(PROMU) build --prefix $(PREFIX) -v

.PHONY: docker
docker: 
	@echo ">> building docker image from $(DOCKERFILE)"
	@docker build -t "$(DOCKER_REPO)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)" .