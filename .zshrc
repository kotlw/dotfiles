PS1="%B%F{4}%~%f$%b "

setopt globdots

bindkey "^N" menu-complete
bindkey "^P" reverse-menu-complete

alias ls="gls --color=always --group-directories-first"

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
