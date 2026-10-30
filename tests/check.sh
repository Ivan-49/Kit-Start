#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"


required=(
    install.sh
    README.md
    Makefile

    scripts/lib/common.sh
    scripts/lib/logging.sh
    scripts/lib/platform.sh
    scripts/lib/packages.sh

    profiles/minimal.sh
    profiles/python.sh
    profiles/cpp.sh
    profiles/backend.sh

    profiles/full.sh

)


for path in "${required[@]}"; do

    [[ -f "$ROOT/$path" ]] ||
        {
            echo "Missing: $path" >&2
            exit 1
        }


done


# Check profile definitions.

for profile in minimal python cpp backend full; do

    grep -q '^PROFILE_PACKAGE_FILES=' \
        "$ROOT/profiles/$profile.sh"

    grep -q '^PROFILE_MODULES=' \
        "$ROOT/profiles/$profile.sh"

done



# Ensure we do not add users to Docker group
# or install database servers on the host.

if grep -R -nE \
    'usermod .*docker|gpasswd .*docker|redis-server' \
    "$ROOT/scripts" "$ROOT/packages"; then

    echo "Unexpected Docker group or Redis server installation pattern" >&2


    exit 1


fi


echo "Kit-Start structure checks passed."
