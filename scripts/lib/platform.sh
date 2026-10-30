#!/usr/bin/env bash

check_platform() {
    [[ -r /etc/os-release ]] || die "/etc/os-release not found"
    # shellcheck disable=SC1091
    source /etc/os-release

    [[ "${ID:-}" == "ubuntu" ]] || die "Only Ubuntu is supported"

    case "${VERSION_ID:-}" in
        22.04|24.04|26.04)
            log_success "Supported OS: ${PRETTY_NAME:-Ubuntu}"
            ;;
        *)
            die "Unsupported Ubuntu version: ${VERSION_ID:-unknown}"
            ;;
    esac

    local architecture
    architecture="$(dpkg --print-architecture)"
    case "$architecture" in
        amd64|arm64) log_success "Architecture: $architecture" ;;
        *) die "Unsupported architecture: $architecture" ;;
    esac
}

check_dependencies() {
    local cmd
    local -a required=(bash apt-get dpkg)
    local -a missing=()

    for cmd in "${required[@]}"; do
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
    done

    ((${#missing[@]} == 0)) || die "Missing required commands: ${missing[*]}"

    if [[ "$KIT_START_DRY_RUN" == "0" && "$EUID" != "0" ]]; then
        command -v sudo >/dev/null 2>&1 || die "sudo is required"
    fi
}

check_sudo() {
    [[ "$EUID" == "0" ]] && return 0
    command -v sudo >/dev/null 2>&1 || die "sudo is required"
    sudo -v || die "Could not obtain sudo privileges"
}
