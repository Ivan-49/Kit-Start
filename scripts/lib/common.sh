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
    local profile_file="$KIT_START_ROOT/profiles/$profile.sh"

    case "$profile" in
        minimal|python|cpp|backend|full) ;;
        *) die "Unknown profile: $profile" ;;
    esac

    [[ -f "$profile_file" ]] || die "Profile file not found: $profile_file"
    # Profiles must only declare arrays; they must not perform installation.
    source "$profile_file"
}

validate_profile() {
    local item module function_name

    for item in "${PROFILE_PACKAGE_FILES[@]}"; do
        [[ -f "$KIT_START_ROOT/packages/$item" ]] ||
            die "Missing package list: $item"
    done

    # Source every module before making system changes. This catches missing
    # functions and syntax/runtime errors while module files are being loaded.
    for module in "${PROFILE_MODULES[@]}"; do
        [[ -f "$KIT_START_ROOT/scripts/$module.sh" ]] ||
            die "Missing module: scripts/$module.sh"

        source "$KIT_START_ROOT/scripts/$module.sh"
        function_name="install_${module//-/_}"
        declare -F "$function_name" >/dev/null ||
            die "Module '$module' must define function '$function_name'"
    done
}
