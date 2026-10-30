#!/usr/bin/env bash

install_gui() {
    if [[ "$KIT_START_NO_GUI" == "1" ]]; then
        log_info "GUI installation disabled"
        return 0
    fi

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would install Flatpak, Flathub, VS Code, DBeaver and Bruno"
        return 0
    fi

    install_packages flatpak

    run_root flatpak remote-add \
        --if-not-exists \
        --system \
        flathub \
        https://flathub.org/repo/flathub.flatpakrepo

    run_root flatpak install --system -y flathub \
        com.visualstudio.code \
        io.dbeaver.DBeaverCommunity \
        com.usebruno.Bruno

    log_success "GUI applications installed"
}
