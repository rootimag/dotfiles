bindkey "^n" history-substring-search-down
bindkey "^p" history-substring-search-up

bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^u" backward-kill-line
bindkey "^w" backward-kill-word

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3;5~" kill-word

[[ ! -d "$HOME/.local/state/zsh" ]] && mkdir -p "$HOME/.local/state/zsh"

HISTSIZE=100000
HISTFILE="$HOME/.local/state/zsh/history"
SAVEHIST=$HISTSIZE

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks

autoload -U colors && colors

eval "$(fzf --zsh)"

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"
