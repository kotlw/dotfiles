readonly brew="/opt/homebrew/bin/brew"

# zsh configuration
export SHELL_SESSIONS_DISABLE=1
export LS_COLORS="$LS_COLORS:di=0;34:ln=0;35:ex=0;31:"

# default paths
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export EDITOR="$($brew --prefix)/bin/nvim"

# apps paths
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"
export LEDGER_FILE="$HOME/.local/var/hledger/2023.journal"
eval "$($brew shellenv)"
