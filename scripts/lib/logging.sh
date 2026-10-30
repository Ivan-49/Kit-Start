#!/usr/bin/env bash

log_info() {
    printf '\033[1;34m[INFO]\033[0m %s\n' "$*"
}

log_success() {
    printf '\033[1;32m[ OK ]\033[0m %s\n' "$*"
}

log_warn() {
    printf '\033[1;33m[WARN]\033[0m %s\n' "$*" >&2
}

log_error() {
    printf '\033[1;31m[FAIL]\033[0m %s\n' "$*" >&2
}

die() {
    log_error "$*"
    exit 1
}
