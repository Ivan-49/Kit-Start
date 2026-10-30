#!/usr/bin/env bash

install_nodejs() {
    local nvm_dir="$HOME/.nvm"

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would install NVM and the current Node.js LTS"
        return 0
    fi

    if [[ ! -s "$nvm_dir/nvm.sh" ]]; then
        log_info "Cloning NVM"
        git clone https://github.com/nvm-sh/nvm.git "$nvm_dir"
    fi

    export NVM_DIR="$nvm_dir"
    # shellcheck disable=SC1090
    source "$NVM_DIR/nvm.sh"

    nvm install --lts
    nvm alias default 'lts/*'

    log_success "Node.js LTS installed through NVM"
}
