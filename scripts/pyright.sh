#!/usr/bin/env bash


install_pyright() {
    log_info "Installing Pyright"

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would install Pyright through npm"
        return 0
    fi


    command -v npm >/dev/null 2>&1 ||
        die "npm is not installed. Run the nodejs module first."

    npm install --global pyright

    command -v pyright-langserver >/dev/null 2>&1 ||
        die "Pyright language server installation failed"

    log_success "Pyright: $(pyright --version)"
}
