# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Safer defaults
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias md='mkdir'

# Listing
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons=auto'
    alias ll='eza -lah --icons=auto'
else
    alias ll='ls -lah'
fi

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Docker intentionally uses sudo.
alias dps='sudo docker ps'
alias dcu='sudo docker compose up -d'
alias dcd='sudo docker compose down'
alias dlogs='sudo docker compose logs -f'

# Ubuntu
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'

# Neovim
alias n='nvim'
