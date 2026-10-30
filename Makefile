SHELL := /usr/bin/env bash

.PHONY: syntax check lint test

syntax:
	@bash tests/syntax.sh

check:
	@bash tests/check.sh

lint:
	@shellcheck install.sh scripts/*.sh scripts/lib/*.sh tests/*.sh

test: syntax check
