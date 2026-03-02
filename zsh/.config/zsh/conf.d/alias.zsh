# 别名，方便调用
alias so='echo "󱗘 Reloading Zsh Profile..." && source $HOME/.config/zsh/.zshrc && echo -e "\033[32m󰄬 Done!\033[0m"'

# 常用命令别名
alias ls='lsd -l'
alias ll='lsd -la'
alias history='history 1'
alias update='paru -Syu'
alias install='paru -S'
alias remove='paru -Rns'
alias search='paru -Ss'
alias about='paru -Si'

# 目录导航别名
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
