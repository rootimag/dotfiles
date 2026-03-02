# 设置存储 zinit 和插件的目录
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# 下载 zinit, 如果它没有安装
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# 重载配置文件
source "${ZINIT_HOME}/zinit.zsh"

# 1. 补全插件（先加载，基础补全）
zinit ice wait lucid
zinit light zsh-users/zsh-completions

# 2. FZF 选项卡补全
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# 3. forgit 插件
zinit ice wait lucid
zinit light wfxr/forgit

# 4. 自动建议插件
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

# 5. 语法高亮插件
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting 

zstyle ':fzf-tab:*' fzf-flags \
  $(echo $FZF_DEFAULT_OPTS) \
  --height=60% \
  --layout=reverse \
  --border=rounded \
  --padding=0 \
  --pointer="▶"

# 定义缓存目录
ZSH_CACHE_DIR="$HOME/.cache/zsh"
[[ ! -d "$ZSH_CACHE_DIR" ]] && mkdir -p "$ZSH_CACHE_DIR"

ZCOMPDUMP="$ZSH_CACHE_DIR/zcompdump-$ZSH_VERSION"

# 检查缓存有效性
if [[ -s "$ZCOMPDUMP" && (! "$ZCOMPDUMP" -ot "${ZDOTDIR:-$HOME}/.zshrc") ]]; then
    autoload -Uz compinit
    compinit -C -d "$ZCOMPDUMP"
else
    autoload -Uz compinit
    compinit -d "$ZCOMPDUMP"
    touch "$ZCOMPDUMP"
fi

if [[ -s "$ZCOMPDUMP" && (! "${ZCOMPDUMP}.zwc" -nt "$ZCOMPDUMP") ]]; then
    zcompile "$ZCOMPDUMP"
fi
