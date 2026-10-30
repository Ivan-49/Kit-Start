#!/usr/bin/env bash

install_git() {
    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would configure Git and initialize Git LFS"
        return 0
    fi

    command -v git >/dev/null 2>&1 || die "Git is not installed"

    if command -v git-lfs >/dev/null 2>&1; then
        git lfs install
    fi

    if ! git config --global --get init.defaultBranch >/dev/null 2>&1; then
        git config --global init.defaultBranch main
    fi

    log_success "Git configured"
}
