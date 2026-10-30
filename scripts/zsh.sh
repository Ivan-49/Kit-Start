#!/usr/bin/env bash


install_zsh() {


    if ! command -v zsh >/dev/null 2>&1; then
        install_packages zsh
    fi

    log_success "Zsh is available"
}
