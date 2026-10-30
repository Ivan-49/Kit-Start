#!/usr/bin/env bash

install_docker() {
    local keyring="/etc/apt/keyrings/docker.gpg"
    local source_file="/etc/apt/sources.list.d/docker.list"
    local architecture codename

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would add Docker's official APT repository"
        log_info "[DRY-RUN] Would install Docker Engine, Buildx and Compose plugins"
        return 0
    fi

    if command -v docker >/dev/null 2>&1 &&
       docker compose version >/dev/null 2>&1 &&
       docker buildx version >/dev/null 2>&1; then
        log_success "Docker Engine, Compose and Buildx are already installed"
        return 0
    fi

    # shellcheck disable=SC1091
    source /etc/os-release
    codename="${UBUNTU_CODENAME:-${VERSION_CODENAME:-}}"
    [[ -n "$codename" ]] || die "Could not determine Ubuntu codename"
    architecture="$(dpkg --print-architecture)"

    run_root install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
        run_root gpg --dearmor --yes -o "$keyring"
    run_root chmod a+r "$keyring"

    printf 'deb [arch=%s signed-by=%s] https://download.docker.com/linux/ubuntu %s stable\n' \
        "$architecture" "$keyring" "$codename" |
        run_root tee "$source_file" >/dev/null

    run_root apt-get update
    install_packages docker-ce docker-ce-cli containerd.io \
        docker-buildx-plugin docker-compose-plugin

    docker --version
    docker compose version
    docker buildx version

    log_success "Docker installed. Commands intentionally use sudo; no docker-group membership was added."
}
