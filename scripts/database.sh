#!/usr/bin/env bash

install_database() {
    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Database client verification skipped"
        return 0
    fi

    local cmd
    local -a required=(psql redis-cli sqlite3)
    local -a missing=()

    for cmd in "${required[@]}"; do
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
    done

    ((${#missing[@]} == 0)) || die "Missing database clients: ${missing[*]}"

    psql --version
    redis-cli --version
    sqlite3 --version
    log_success "Database clients are ready; PostgreSQL and Redis servers were not installed"
}
