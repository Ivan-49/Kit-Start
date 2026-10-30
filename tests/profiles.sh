#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/scripts/lib/common.sh"

for profile in minimal python cpp backend full; do
    load_profile "$profile"
    validate_profile
    printf '[ OK ] %s: %d package lists, %d modules\n' \
        "$profile" "${#PROFILE_PACKAGE_FILES[@]}" "${#PROFILE_MODULES[@]}"
done
