.PHONY: license


help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[0m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

init: ## Initialize the project
	@echo "Initializing the project..."
	npm ci
	npx husky-init


##@ Development

zip: ## Create the spectrocloud package
	./scripts/create_zip.sh
	./scripts/create_zip.sh spectrocloud-docs-internal


## Management

license:
	@echo "Applying license headers..."
	 copywrite headers