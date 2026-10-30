#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"
source "$(dirname "${BASH_SOURCE[0]}")/lib/packages.sh"

log_info "Installing additional system utilities"

# Packages that are available in standard Ubuntu repositories.
install_packages 
    tree 

    btop 
    htop 

    ncdu 
    bat 
    ripgrep 
    fzf 
    zoxide 
    jq 
    tldr 
    lsof 
    tmux 
    screen 
    rsync 

    curl 
    wget 
    unzip 
    zip 

    p7zip-full 
    xz-utils 
    gzip 
    gnupg 
    ca-certificates 
    man-db 

    openssh-client 
    net-tools 
    iproute2 
    dnsutils 
    nmap 
    tcpdump 
    mtr-tiny 
    traceroute 
    httpie 
    netcat-openbsd 
    shellcheck 
    shfmt 
    git-lfs


# Optional packages: absence must not interrupt installation.
install_if_available eza
install_if_available fd-find

log_success "Additional system utilities installed"
