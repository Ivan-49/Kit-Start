#!/usr/bin/env bash


install_nodejs() {

    local nvm_dir="$HOME/.nvm"


    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would install nvm and Node.js LTS"
        return 0
    fi

    # Install nvm.

    if [[ ! -s "$nvm_dir/nvm.sh" ]]; then


        log_info "Installing nvm"

        git clone https://github.com/nvm-sh/nvm.git "$nvm_dir"

        local latest_tag

        latest_tag="$(git -C "$nvm_dir" describe --abbrev=0 --tags)"


        git -C "$nvm_dir" checkout "$latest_tag"

    fi


    # Load nvm.

    export NVM_DIR="$nvm_dir"

    source "$NVM_DIR/nvm.sh"


    # Install Node.js LTS.

    nvm install --lts
    nvm alias default 'lts/*'

    log_success "Node.js LTS installed"
}
