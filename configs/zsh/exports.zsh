# Default editor

export EDITOR="nvim"
export VISUAL="nvim"


# Pager


export PAGER="less"

export LESS="-FRX"


# User binaries

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"



# Go

export GOPATH="${GOPATH:-$HOME/go}"

export PATH="$GOPATH/bin:$PATH"



# Node.js / nvm


export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
