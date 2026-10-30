#!/usr/bin/env bash


install_cpp() {


    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] C/C++ version checks skipped"
        return 0
    fi


    log_info "Checking C/C++ toolchain"

    gcc --version | head -n 1
    g++ --version | head -n 1
    clang --version | head -n 1
    cmake --version | head -n 1


    log_success "C/C++ toolchain ready"
}
