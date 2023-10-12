##@ Help

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Lint

.PHONY: markdown-lint
markdown-lint: ## Run Markdown linter.
	npx markdownlint README.md content/ --disable MD013 MD041

.PHONY: css-lint
css-lint: ## Run CSS linter.
	npx stylelint assets/css/extended/*.css --fix

.PHONY: lint
lint: markdown-lint css-lint ## Run all linters.

##@ Start

.PHONY: start
start: ## Start the website locally.
	hugo server
