ZPLUGIN_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ ! -d "$ZPLUGIN_DIR" ]] && mkdir -p "$ZPLUGIN_DIR"
[[ ! -d "$ZSH_CACHE_DIR" ]] && mkdir -p "$ZSH_CACHE_DIR"
ZCOMPDUMP="$ZSH_CACHE_DIR/zcompdump-$ZSH_VERSION"

fpath=("$ZPLUGIN_DIR/zsh-completions/src" $fpath)

bundle() {
    local repo="$1"
    local name="${repo:t}"
    local dir="$ZPLUGIN_DIR/$name"
    if [ ! -d "$dir" ]; then
        echo "Downloading $repo..."
        git clone --depth 1 https://github.com/$repo "$dir"
    fi
    
    if [ -f "$dir/$name.plugin.zsh" ]; then
        source "$dir/$name.plugin.zsh"
    elif [ -f "$dir/$name.zsh" ]; then
        source "$dir/$name.zsh"
    elif [ -f "$dir/main.plugin.zsh" ]; then
        source "$dir/main.plugin.zsh"
    else
        local match=("$dir"/*.plugin.zsh(N) "$dir"/*.zsh(N))
        [[ -n "$match" ]] && source "${match[1]}"
    fi
}

bundle romkatv/zsh-defer

autoload -Uz compinit
if [[ -s "$ZCOMPDUMP" && -n ${ZCOMPDUMP}(#qNmh-20) ]]; then
    compinit -C -i -d "$ZCOMPDUMP"
else
    compinit -i -d "$ZCOMPDUMP"
fi

if [[ -s "$ZCOMPDUMP" && (! "${ZCOMPDUMP}.zwc" -nt "$ZCOMPDUMP") ]]; then
    zcompile "$ZCOMPDUMP"
fi

zsh-defer bundle zsh-users/zsh-completions
zsh-defer bundle zsh-users/zsh-autosuggestions
zsh-defer bundle zsh-users/zsh-syntax-highlighting
zsh-defer bundle zsh-users/zsh-history-substring-search
zsh-defer bundle hlissner/zsh-autopair
zsh-defer bundle wfxr/forgit

zsh-defer bundle Aloxaf/fzf-tab

zstyle ':fzf-tab:*' fzf-flags \
    $(echo $FZF_DEFAULT_OPTS) \
    --height=60% \
    --layout=reverse \
    --border=rounded \
    --padding=0 \
    --pointer="▶" 

zstyle ':completion:*' rehash true
