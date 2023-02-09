export LS_COLORS="$LS_COLORS:di=0;34:ln=0;35:ex=0;31:"

export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export GOPATH="$HOME/Dev/go"
export PATH="$PATH:$GOPATH/bin"

eval "$(/opt/homebrew/bin/brew shellenv)"
