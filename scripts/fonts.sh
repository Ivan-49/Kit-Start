#!/usr/bin/env bash

install_fonts() {
    local font_dir="$HOME/.local/share/fonts/MesloLGS-NF"
    local base_url="https://github.com/romkatv/powerlevel10k-media/raw/master"
    local font output
    local -a fonts=(
        "MesloLGS%20NF%20Regular.ttf"
        "MesloLGS%20NF%20Bold.ttf"
        "MesloLGS%20NF%20Italic.ttf"
        "MesloLGS%20NF%20Bold%20Italic.ttf"
    )

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would install Meslo Nerd Font"
        return 0
    fi

    mkdir -p "$font_dir"
    for font in "${fonts[@]}"; do
        output="${font//%20/ }"
        if [[ ! -s "$font_dir/$output" ]]; then
            curl -fL "$base_url/$font" -o "$font_dir/$output"
        fi
    done

    if command -v fc-cache >/dev/null 2>&1; then
        fc-cache -f "$font_dir"
    fi

    log_success "Meslo Nerd Font installed"
    log_info "Select 'MesloLGS NF' in your terminal settings"
}
