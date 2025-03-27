
export SHELL_SESSIONS_DISABLE=1
export LS_COLORS="$LS_COLORS:di=0;34:ln=0;35:ex=0;31:"

export EDITOR=nvim

export PATH="$PATH:$HOME/.local/bin"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

eval "$(/opt/homebrew/bin/brew shellenv)"
