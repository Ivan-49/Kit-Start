#!/usr/bin/env bash

install_optional() {
    log_info "Installing optional developer utilities"
    install_if_available shellcheck shfmt gh

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        return 0
    fi

    log_success "Optional utilities checked"
}
