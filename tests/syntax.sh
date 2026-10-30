#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
failed=0

while IFS= read -r -d '' file; do
    if bash -n "$file"; then
        printf '[ OK ] %s\n' "${file#"$ROOT"/}"
    else
        printf '[FAIL] %s\n' "${file#"$ROOT"/}" >&2
        failed=1
    fi
done < <(find "$ROOT" -type f -name '*.sh' -print0)

exit "$failed"
