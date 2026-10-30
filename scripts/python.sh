#!/usr/bin/env bash

install_python() {

    log_info "Installing Python development tools"

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would install uv, Ruff, pytest, mypy, pre-commit and ipython"
        return 0
    fi

    mkdir -p "$HOME/.local/bin"

    # Install uv.

    if ! command -v uv >/dev/null 2>&1; then

        curl -LsSf https://astral.sh/uv/install.sh |
            env UV_INSTALL_DIR="$HOME/.local/bin" sh


    fi

    export PATH="$HOME/.local/bin:$PATH"


    # Python developer tools.

    uv tool install --upgrade ruff
    uv tool install --upgrade pytest
    uv tool install --upgrade mypy
    uv tool install --upgrade pre-commit
    uv tool install --upgrade ipython

    log_success "Python development tools installed"
}
