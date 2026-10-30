#!/usr/bin/env bash

install_git() {

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would configure Git"

        return 0
    fi

    # Git LFS initialization.
    if command -v git-lfs >/dev/null 2>&1; then
        git lfs install
    fi

    # Set the default branch only if it is not configured.
    if ! git config --global --get init.defaultBranch >/dev/null 2>&1; then
        git config --global init.defaultBranch main
    fi


    log_success "Git configured"
}
