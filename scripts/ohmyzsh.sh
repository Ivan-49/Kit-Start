#!/usr/bin/env bash

install_ohmyzsh() {

    local omz_dir="$HOME/.oh-my-zsh"
    local theme_dir="$omz_dir/custom/themes/powerlevel10k"

    if [[ "$KIT_START_DRY_RUN" == "1" ]]; then

        log_info "[DRY-RUN] Would install Oh My Zsh and Powerlevel10k"
        return 0
    fi

    # Oh My Zsh.

    if [[ ! -d "$omz_dir" ]]; then

        log_info "Installing Oh My Zsh"

        RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -- --unattended

    else

        log_info "Oh My Zsh already installed"


    fi


    # Powerlevel10k.


    if [[ ! -d "$theme_dir" ]]; then

        log_info "Installing Powerlevel10k"


        git clone --depth=1 \

            https://github.com/romkatv/powerlevel10k.git \
            "$theme_dir"

    fi


    # Configure theme.

    touch "$HOME/.zshrc"

    if grep -q '^ZSH_THEME=' "$HOME/.zshrc"; then

        sed -i \
            's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' \
            "$HOME/.zshrc"

    else

        printf '\nZSH_THEME="powerlevel10k/powerlevel10k"\n' \

            >> "$HOME/.zshrc"

    fi


    # Ensure Oh My Zsh is loaded.

    if ! grep -Fq 'oh-my-zsh.sh' "$HOME/.zshrc"; then

        cat >> "$HOME/.zshrc" <<'EOF'

export ZSH="$HOME/.oh-my-zsh"
source "$ZSH/oh-my-zsh.sh"


EOF

    fi

    log_success "Oh My Zsh and Powerlevel10k installed"
}
