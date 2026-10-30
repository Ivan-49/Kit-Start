#!/usr/bin/env bash


install_optional() {


    log_info "Installing optional development utilities"

    install_if_available \
        shellcheck \
        shfmt \
        gh

    log_success "Optional utilities checked"
}
