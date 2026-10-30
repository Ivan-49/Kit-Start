#!/usr/bin/env bash


install_nodejs() {
    local nvm_dir="$HOME/.nvm"
    local rc_file

    log_info "Installing Node.js LTS and npm through NVM"

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then
        log_info "[DRY-RUN] Would install NVM, Node.js LTS and npm"
        return 0

    fi

    if [[ ! -s "$nvm_dir/nvm.sh" ]]; then

        git clone --depth 1 https://github.com/nvm-sh/nvm.git "$nvm_dir"
    fi

    export NVM_DIR="$nvm_dir"

    # shellcheck disable=SC1091
    source "$NVM_DIR/nvm.sh"

    nvm install --lts
    nvm alias default 'lts/*'

    # Добавляем инициализацию NVM в конфигурации оболочек.
    for rc_file in "$HOME/.bashrc" "$HOME/.zshrc"; do
        touch "$rc_file"

        if ! grep -Fq '# >>> Kit-Start NVM >>>' "$rc_file"; then
            cat >> "$rc_file" <<'EOF'

# >>> Kit-Start NVM >>>
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# <<< Kit-Start NVM <<<

EOF
        fi
    done

    command -v node >/dev/null 2>&1 || die "Node.js installation failed"
    command -v npm >/dev/null 2>&1 || die "npm installation failed"

    log_success "Node.js: $(node --version)"
    log_success "npm: $(npm --version)"
}
