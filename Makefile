CHART_DIR ?= $(CURDIR)/charts
DOCKER_DIR ?= /helm-charts
LINT_CMD ?= ct lint --config=lint/ct.yaml --all

.PHONY: all lint

all: lint

lint: dependencies
	@echo "==> Linting Charts..."
	@docker run --rm -t -v $(CURDIR):$(DOCKER_DIR) -w $(DOCKER_DIR) quay.io/helmpack/chart-testing:v3.4.0 $(LINT_CMD)

dependencies:
	@command -v docker >/dev/null || ( echo "ERROR: Docker binary not found. Exiting." && exit 1)
	@docker info >/dev/null || ( echo "ERROR: command "docker info" is in error. Exiting." && exit 1)
