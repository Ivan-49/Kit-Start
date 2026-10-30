#!/usr/bin/env bash


# Выполнение команды с root-правами.
run_root() {
    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        printf '[DRY-RUN]'
        printf ' %q' "$@"
        printf '\n'

        return 0
    fi

    if [[ "$EUID" == "0" ]]; then
        "$@"
    else
        sudo "$@"
    fi
}

# Установка переданных пакетов.
install_packages() {
    (($#)) || return 0


    log_info "Installing packages: $*"

    run_root apt-get install -y --no-install-recommends "$@"
}

# Установка пакетов из текстового файла.
install_package_file() {
    local file="$1"

    [[ -f "$file" ]] ||
        die "Package list not found: $file"

    local packages=()
    local line


    while IFS= read -r line || [[ -n "$line" ]]; do

        # Удаляем комментарии.
        line="${line%%#*}"

        # Удаляем пробелы в начале и конце.
        line="${line#"${line%%[![:space:]]*}"}"
        line="${line%"${line##*[![:space:]]}"}"

        [[ -z "$line" ]] && continue

        # Допускаем только имена пакетов.
        [[ "$line" =~ ^[a-zA-Z0-9.+:-]+$ ]] ||
            die "Invalid package entry '$line' in $file"

        packages+=("$line")

    done < "$file"


    install_packages "${packages[@]}"
}

# Установка только тех пакетов, которые доступны в APT.
install_if_available() {
    local package
    local available=()

    for package in "$@"; do
        if apt-cache show "$package" >/dev/null 2>&1; then
            available+=("$package")
        else
            log_warn "APT package '$package' unavailable; skipping"
        fi

    done

    install_packages "${available[@]}"

}
