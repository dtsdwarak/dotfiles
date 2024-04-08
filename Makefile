.PHONY: install
install: ## Installs dotfiles.
	./install.sh

check-install: ## Checks dotfile installation within a Debian docker container
	@if podman ps >/dev/null 2>&1; then \
		echo "Podman is available and working"; \
		DOCKER_RUNTIME='podman'; \
	else \
		echo "Podman is not available OR not configured to work correctly"; \
		DOCKER_RUNTIME='docker'; \
	fi; \
	echo "Setting docker runtime to $$DOCKER_RUNTIME"
	$(DOCKER_RUNTIME) run --rm -i \
		--name dotfile-check-install \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		debian ./install.sh

.PHONY: test
test: shellcheck ## Runs shellcheck tests on dotfiles

.PHONY: shellcheck
shellcheck: ## Runs the shellcheck tests on the scripts.
	@shell_files=$$(find . -type f  \
		-not \( -path "./.git/*" \
		-o -path "*/LICENSE" \
		-o -path "*.md" \
		-o -path "*.zsh*" \
		-o -path "*.conf" \
		-o -path "*/git/*" \
		-o -path "*.vim*" \
		-o -path "*/batconfig" \
		-o -path "*/.gitconfig" \
		-o -path "*/diff-so-fancy" \
		-prune \) \
		-print); \
	for f in $$shell_files; \
	do \
		shellcheck -e SC1091 -s bash $$f; \
	done

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'