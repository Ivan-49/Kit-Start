#!/usr/bin/env bash

install_neovim() {

    local config_dir="$HOME/.config/nvim"

    local repo="https://github.com/Ivan-49/nvim.git"

    log_info "Installing Neovim"

    install_packages neovim

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would clone $repo into $config_dir if safe"
        return 0
    fi



    # Existing Git repository: do not overwrite it.

    if [[ -d "$config_dir/.git" ]]; then

        log_info "Neovim configuration repository already exists"

    # Existing non-empty directory: refuse to overwrite.

    elif [[ -d "$config_dir" ]] &&
         [[ -n "$(find "$config_dir" -mindepth 1 -maxdepth 1 -print -quit)" ]]; then

        log_warn "$config_dir is not empty"
        log_warn "Refusing to overwrite existing configuration"

    else

        mkdir -p "$(dirname "$config_dir")"

        rmdir "$config_dir" 2>/dev/null || true

        git clone "$repo" "$config_dir"


    fi

    log_success "Neovim configuration checked"
}
