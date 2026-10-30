#!/usr/bin/env bash

install_system() {
    local -a required=(tree btop htop ncdu jq lsof tmux screen)
    local cmd
    local -a missing=()

    # eza is a useful enhancement, but not present in every supported Ubuntu
    # release. fd and bat have Ubuntu-specific executable names.
    install_if_available eza

    if command -v fdfind >/dev/null 2>&1 &&
       ! command -v fd >/dev/null 2>&1; then
        mkdir -p "$HOME/.local/bin"
        ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
    fi

    if command -v batcat >/dev/null 2>&1 &&
       ! command -v bat >/dev/null 2>&1; then
        mkdir -p "$HOME/.local/bin"
        ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
    fi

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] System utilities will be verified after installation"
        return 0
    fi

    for cmd in "${required[@]}"; do
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
    done
    ((${#missing[@]} == 0)) || die "Missing system utilities: ${missing[*]}"

    log_success "System utilities are ready"
}
