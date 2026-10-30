#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

required=(
    install.sh
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
    [[ -f "$ROOT/$path" ]] || {
        printf 'Missing required file: %s\n' "$path" >&2
        exit 1
    }
done

# Validate each profile's package lists and module/function mapping.
for profile in minimal python cpp backend full; do
    (
        source "$ROOT/scripts/lib/common.sh"
        load_profile "$profile"
        validate_profile
    )
    printf '[ OK ] profile: %s\n' "$profile"
done

# Check package lists for duplicate entries and malformed names.
for package_file in "$ROOT"/packages/*.txt; do
    [[ -f "$package_file" ]] || continue
    awk '
        {
            sub(/#.*/, "")
            gsub(/^[ \t]+|[ \t]+$/, "")
            if ($0 == "") next
            if ($0 !~ /^[[:alnum:].+:-]+$/) {
                print FILENAME ":" FNR ": invalid package: " $0
                bad = 1
            }
            if (seen[$0]++) {
                print FILENAME ":" FNR ": duplicate package: " $0
                bad = 1
            }
        }
        END { exit bad }
    ' "$package_file"
done

# Project requirements: no Go setup, no database servers on host,
# and no adding the user to the privileged docker group.
if grep -RniE 'GOPATH|go install|golang|redis-server|postgresql-[0-9]+|usermod .*docker|gpasswd .*docker' \
    "$ROOT/scripts" "$ROOT/packages" "$ROOT/configs"; then
    echo "Found a forbidden Go/server/docker-group setup pattern" >&2
    exit 1
fi

echo "Kit-Start checks passed."
