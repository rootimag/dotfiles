alias re='echo "󱗘 Reloading Zsh Profile..." && exec zsh'
alias sr='sudo sing-box run -c'

alias ls='lsd --group-directories-first'
alias ll='lsd -l --group-directories-first'
alias la='lsd -la --group-directories-first'
alias lt='lsd --tree'

alias pcache='du -sh ~/.cache/paru'
alias pisu='paru -Syu'
alias pin='paru -S'
alias prm='paru -Rns'
alias pss='paru -Ss'
alias psi='paru -Si'

alias wenv='echo $XDG_SESSION_TYPE && echo $NIRI_SOCKET'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
