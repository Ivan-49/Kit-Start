#!/usr/bin/env bash

install_neovim() {
    local config_dir="$HOME/.config/nvim"
    local repo="git@github.com:Ivan-49/nvim.git"

    log_info "Installing Neovim"
    install_packages neovim

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would clone $repo only if $config_dir is absent or empty"
        return 0
    fi

    if [[ -d "$config_dir/.git" ]]; then
        log_info "Neovim configuration repository already exists; leaving it unchanged"
    elif [[ -d "$config_dir" ]] &&
         [[ -n "$(find "$config_dir" -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
        log_warn "$config_dir is not empty; refusing to overwrite it"
    else
        mkdir -p "$(dirname "$config_dir")"
        rmdir "$config_dir" 2>/dev/null || true
        git clone "$repo" "$config_dir"
    fi

    log_success "Neovim configuration checked"
}
