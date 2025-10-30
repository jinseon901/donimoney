# Makefile (Node.js CI)

SHELL := /bin/bash
NPM ?= npm

.PHONY: check-npm ci test lint

check-npm:
	@command -v $(NPM) >/dev/null 2>&1 || { \
	  echo "[ERROR] '$(NPM)' not found in PATH."; exit 127; }

# 패키지가 루트에 있는 일반 구조
ci: check-npm
	@echo "==== CI: install & test ===="
	$(NPM) ci
	$(NPM) test -- --verbose

test: check-npm
	@echo "==== Running Node.js tests... ===="
	$(NPM) ci
	$(NPM) test

# ESLint 쓰는 경우
lint: check-npm
	@echo "==== ESLint ===="
	npx eslint . 

