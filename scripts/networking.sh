#!/usr/bin/env bash

install_networking() {

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Network tools verification skipped"
        return 0
    fi

    command -v curl >/dev/null ||
        die "curl is not installed"

    command -v ip >/dev/null ||
        die "iproute2 is not installed"

    log_success "Networking tools ready"
}
