#!/usr/bin/env bash


install_terminal() {


    local zsh_config="$HOME/.config/zsh"

    log_info "Installing terminal configuration"

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would copy Zsh configuration"
        return 0
    fi

    mkdir -p "$zsh_config"
    mkdir -p "$HOME/.local/bin"


    cp "$KIT_START_ROOT/configs/zsh/"*.zsh "$zsh_config/"


    # Ubuntu uses fdfind instead of fd.

    if command -v fdfind >/dev/null 2>&1 &&
       ! command -v fd >/dev/null 2>&1; then

        ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"

    fi


    # Ubuntu uses batcat instead of bat.

    if command -v batcat >/dev/null 2>&1 &&
       ! command -v bat >/dev/null 2>&1; then

        ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"

    fi


    # Add Kit-Start configuration to .zshrc once.

    touch "$HOME/.zshrc"

    local marker="# >>> Kit-Start configuration >>>"

    if ! grep -Fq "$marker" "$HOME/.zshrc"; then


        cat >> "$HOME/.zshrc" <<'EOF'

# >>> Kit-Start configuration >>>

[[ -f "$HOME/.config/zsh/exports.zsh" ]] && source "$HOME/.config/zsh/exports.zsh"


[[ -f "$HOME/.config/zsh/aliases.zsh" ]] && source "$HOME/.config/zsh/aliases.zsh"

[[ -f "$HOME/.config/zsh/functions.zsh" ]] && source "$HOME/.config/zsh/functions.zsh"


# <<< Kit-Start configuration <<<


EOF

    fi

    log_success "Terminal configuration installed"
}
