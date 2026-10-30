#!/usr/bin/env bash

install_zsh() {
    command -v zsh >/dev/null 2>&1 || install_packages zsh
    log_success "Zsh is available"
}
