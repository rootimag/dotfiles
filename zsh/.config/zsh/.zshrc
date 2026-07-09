ZSH_CONF_DIR="$HOME/.config/zsh"

source "$HOME/.cache/matugen/fzf-colors.zsh"

if [[ -d "$ZSH_CONF_DIR/conf.d" ]]; then
    for config_file ("$ZSH_CONF_DIR/conf.d"/*.zsh); do
        source "$config_file"
    done
fi
