# Enable colors and change prompt
autoload -U colors && colors
PS1="%B%F{4}%~%f$%b "

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Basic auto/tab complete
fpath+=~/.config/zsh/.zfunc
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)  # Include hidden files

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape for different vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt

# Aliases
alias rzs='source $HOME/.config/zsh/.zshrc'
alias ah='cat $HOME/.config/zsh/aliases.sh'
alias ahg='cat $HOME/.config/zsh/aliases.sh | grep'
alias cl='clear'
alias lc='clear'

alias nv='nvim'

alias ls='gls --color=always --group-directories-first'
alias la='gls -A --color=always --group-directories-first'
alias lg='gls -A --color=always --group-directories-first | grep'
alias lsl='gls -XGlh --color=always --group-directories-first'
alias lal='gls -AXGlh --color=always --group-directories-first'
alias lgl='gls -AXGlh --color=always --group-directories-first | grep'

alias dp='docker ps'
alias dra='docker rm $(docker ps -aq)'
alias dil='docker image ls'
alias dira='docker image rm $(docker image ls -aq)'

# Load zsh-syntax-highlighting; should be last
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
