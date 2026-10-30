#!/usr/bin/env bash


KIT_START_ROOT="${KIT_START_ROOT:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)}"

KIT_START_DRY_RUN="${KIT_START_DRY_RUN:-0}"
KIT_START_NO_GUI="${KIT_START_NO_GUI:-0}"


source "$KIT_START_ROOT/scripts/lib/logging.sh"
source "$KIT_START_ROOT/scripts/lib/platform.sh"
source "$KIT_START_ROOT/scripts/lib/packages.sh"

PROFILE_PACKAGE_FILES=()
PROFILE_MODULES=()


load_profile() {
    local profile="$1"

    case "$profile" in
        minimal|python|cpp|backend|full)
            ;;
        *)

            die "Unknown profile: $profile"
            ;;
    esac

    local profile_file="$KIT_START_ROOT/profiles/$profile.sh"

    [[ -f "$profile_file" ]] ||
        die "Profile file not found: $profile_file"

    source "$profile_file"

}

validate_profile() {
    local item


    for item in "${PROFILE_PACKAGE_FILES[@]}"; do
        [[ -f "$KIT_START_ROOT/packages/$item" ]] ||
            die "Missing package list: $item"
    done

    for item in "${PROFILE_MODULES[@]}"; do
        [[ -f "$KIT_START_ROOT/scripts/$item.sh" ]] ||
            die "Missing module: $item.sh"
    done
}
