CHART_DIR ?= $(CURDIR)/charts
DOCKER_DIR ?= /helm-charts
LINT_CMD ?= ct lint --chart-yaml-schema=lint/chart_schema.yaml --config=lint/ct.yaml --lint-conf=lint/lintconf.yaml

.PHONY: all lint

all: lint

lint: dependencies
	@echo "==> Linting Charts..."
	@docker run --rm -t -v $(CURDIR):$(DOCKER_DIR) -w $(DOCKER_DIR) quay.io/helmpack/chart-testing:v3.0.0-rc.1 $(LINT_CMD)

dependencies:
	@command -v docker >/dev/null || ( echo "ERROR: Docker binary not found. Exiting." && exit 1)
	@docker info >/dev/null || ( echo "ERROR: command "docker info" is in error. Exiting." && exit 1)
