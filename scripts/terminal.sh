#!/usr/bin/env bash

install_terminal() {
    local config_dir="$HOME/.config/zsh"
    local zshrc="$HOME/.zshrc"
    local marker="# >>> Kit-Start configuration >>>"

    log_info "Installing terminal configuration"

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would copy Zsh config files to $config_dir"
        return 0
    fi

    mkdir -p "$config_dir" "$HOME/.local/bin"
    cp "$KIT_START_ROOT/configs/zsh/"*.zsh "$config_dir/"

    if command -v fdfind >/dev/null 2>&1 &&
       ! command -v fd >/dev/null 2>&1; then
        ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
    fi

    if command -v batcat >/dev/null 2>&1 &&
       ! command -v bat >/dev/null 2>&1; then
        ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
    fi

    touch "$zshrc"
    if ! grep -Fq "$marker" "$zshrc"; then
        cat >> "$zshrc" <<'EOF'

# >>> Kit-Start configuration >>>
[[ -f "$HOME/.config/zsh/exports.zsh" ]] && source "$HOME/.config/zsh/exports.zsh"
[[ -f "$HOME/.config/zsh/aliases.zsh" ]] && source "$HOME/.config/zsh/aliases.zsh"
[[ -f "$HOME/.config/zsh/functions.zsh" ]] && source "$HOME/.config/zsh/functions.zsh"
# <<< Kit-Start configuration <<<
EOF
    fi

    log_success "Terminal configuration installed"
}
