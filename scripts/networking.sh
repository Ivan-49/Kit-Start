#!/usr/bin/env bash

install_networking() {
    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Network utilities verification skipped"
        return 0
    fi

    local cmd
    local -a required=(curl ip ss dig nmap tcpdump mtr traceroute http nc)
    local -a missing=()

    for cmd in "${required[@]}"; do
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
    done

    ((${#missing[@]} == 0)) || die "Missing network utilities: ${missing[*]}"
    log_success "Networking utilities are ready"
}
