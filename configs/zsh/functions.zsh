# Create a directory and enter it.
mkcd() {
    if [[ -z "${1:-}" ]]; then
        printf 'Usage: mkcd DIRECTORY\n' >&2
        return 2
    fi
    mkdir -p -- "$1" && cd -- "$1"
}

# Extract common archive formats.
extract() {
    if [[ -z "${1:-}" || ! -f "$1" ]]; then
        printf 'Usage: extract ARCHIVE\n' >&2
        return 2
    fi

    case "$1" in
        *.tar.gz|*.tgz) tar -xzf "$1" ;;
        *.tar.xz|*.txz) tar -xJf "$1" ;;
        *.tar.bz2|*.tbz2) tar -xjf "$1" ;;
        *.zip) unzip "$1" ;;
        *.gz) gunzip "$1" ;;
        *.xz) unxz "$1" ;;
        *)
            printf 'Unsupported archive: %s\n' "$1" >&2
            return 1
            ;;
    esac
}
