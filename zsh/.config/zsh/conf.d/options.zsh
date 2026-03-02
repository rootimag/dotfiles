# 历史命令搜索（向前/向后）
bindkey "^n" history-search-forward  # Ctrl+n: 向前搜索历史命令
bindkey "^p" history-search-backward # Ctrl+p: 向后搜索历史命令

# 常用编辑快捷键
bindkey "^a" beginning-of-line      # Ctrl+a: 移动到行首
bindkey "^e" end-of-line            # Ctrl+e: 移动到行尾
bindkey "^k" kill-line               # Ctrl+k: 删除到行尾
bindkey "^u" backward-kill-line      # Ctrl+u: 删除到行首
bindkey "^w" backward-kill-word      # Ctrl+w: 删除上一个单词

# 单词移动快捷键
bindkey "^[[1;5C" forward-word       # Ctrl+右箭头: 向前移动一个单词
bindkey "^[[1;5D" backward-word      # Ctrl+左箭头: 向后移动一个单词

# 确保目录存在
[[ ! -d "$HOME/.local/state/zsh" ]] && mkdir -p "$HOME/.local/state/zsh"

# 历史记录设置
HISTSIZE=10000                      # 内存中保存的历史命令数量
HISTFILE="$HOME/.local/state/zsh/history" # 历史命令文件路径
SAVEHIST=$HISTSIZE                 # 保存到文件的历史命令数量
HISTDUP=erase                      # 删除重复的历史命令

# 历史记录选项
setopt appendhistory               # 追加历史记录，而不是覆盖
setopt sharehistory                # 共享历史记录（在多个终端之间）
setopt hist_ignore_space           # 忽略以空格开头的命令
setopt hist_ignore_all_dups        # 忽略所有重复的命令
setopt hist_save_no_dups           # 保存历史记录时不保存重复命令
setopt hist_ignore_dups            # 忽略连续重复的命令
setopt hist_find_no_dups           # 搜索历史记录时不显示重复命令
setopt hist_reduce_blanks          # 减少历史记录中的空白

# 启用彩色输出
autoload -U colors && colors

# FZF 配置
eval "$(fzf --zsh)"

# 配置 starship 命令提示符
eval "$(starship init zsh)"

# 配置 zoxide 快速目录跳转工具
eval "$(zoxide init zsh)"
