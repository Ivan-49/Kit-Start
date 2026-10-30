#!/usr/bin/env bash

install_cpp() {
    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] C/C++ toolchain verification skipped"
        return 0
    fi

    local cmd
    local -a required=(gcc g++ clang gdb cmake ninja make clang-format clang-tidy valgrind pkg-config)
    local -a missing=()

    for cmd in "${required[@]}"; do
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
    done

    ((${#missing[@]} == 0)) || die "Missing C/C++ tools: ${missing[*]}"

    gcc --version | head -n 1
    clang --version | head -n 1
    cmake --version | head -n 1
    log_success "C/C++ toolchain is ready"
}
