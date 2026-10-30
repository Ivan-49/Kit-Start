#!/usr/bin/env bash

run_root() {
    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        printf '[DRY-RUN]'
        printf ' %q' "$@"
        printf '\n'
        return 0
    fi

    if [[ "$EUID" == "0" ]]; then
        "$@"
    else
        sudo "$@"
    fi
}

install_packages() {
    (($#)) || return 0
    log_info "Installing APT packages: $*"
    run_root apt-get install -y --no-install-recommends "$@"
}

install_package_file() {
    local file="$1"
    local line
    local -a packages=()

    [[ -f "$file" ]] || die "Package list not found: $file"

    while IFS= read -r line || [[ -n "$line" ]]; do
        line="${line%%#*}"
        line="${line#"${line%%[![:space:]]*}"}"
        line="${line%"${line##*[![:space:]]}"}"
        [[ -z "$line" ]] && continue

        [[ "$line" =~ ^[a-zA-Z0-9.+:-]+$ ]] ||
            die "Invalid package entry '$line' in $file"
        packages+=("$line")
    done < "$file"

    install_packages "${packages[@]}"
}

install_if_available() {
    local package
    local -a available=()

    for package in "$@"; do
        if apt-cache show "$package" >/dev/null 2>&1; then
            available+=("$package")
        else
            log_warn "APT package '$package' is unavailable; skipping"
        fi
    done

    install_packages "${available[@]}"
}
