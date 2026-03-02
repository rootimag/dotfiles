# 设置配置目录变量
ZSH_CONF_DIR="$HOME/.config/zsh"

# 自动加载 conf.d 目录下所有的 .zsh 文件
if [[ -d "$ZSH_CONF_DIR/conf.d" ]]; then
    for config_file ("$ZSH_CONF_DIR/conf.d"/*.zsh); do
        source "$config_file"
    done
fi
