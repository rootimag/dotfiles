#!/usr/bin/env bash

# --- 基础配置 ---
TARGET_DEFAULT=$HOME                       # 默认 Stow 目标
DOT_DIR=$(pwd)                             # 仓库根目录
LOG_DIR="$DOT_DIR/.log"                     # 日志目录
SETUP_BASE_DIR="$DOT_DIR/.setup"           # 配置指令目录
mkdir -p "$LOG_DIR"

# --- 颜色标签定义 ---
L_INFO=$(gum style --foreground 46 "[INFO]")
L_WARN=$(gum style --foreground 226 "[WARN]")
L_WRONG=$(gum style --foreground 196 "[WRONG]")
L_EVENT=$(gum style --foreground 212 "[EVENT]")

# --- AUR 助手检测 ---
AUR_HELPER=$(command -v yay || command -v paru || echo "sudo pacman")

# --- 核心执行引擎 ---
run_task() {
    local folder=$1
    local type=$2
    local cmd=$3
    local log_file="$LOG_DIR/${folder}.log"

    echo "--- [$(date +%T)] [$type] Task ---" >> "$log_file"

    if [ "$SILENT" -eq 1 ]; then
        # [静默模式]
        if gum spin --spinner dot --title "$L_INFO Running [$type] for [$folder]..." -- bash -c "$cmd >> $log_file 2>&1"; then
            gum log --level none --prefix "$L_INFO [$folder] " "[$type] task completed"
        else
            gum log --level none --prefix "$L_WRONG [$folder] " "[$type] task failed. Check $log_file"
            return 1
        fi
    else
        # [详细模式]
        echo "$(gum style --foreground 212 "[EVENT]") Executing [$type] for [$folder]..."
        if eval "$cmd" 2>&1 | tee -a "$log_file"; then
            gum log --level none --prefix "$L_INFO [$folder] " "[$type] task completed"
        else
            return 1
        fi
    fi
}

# --- 核心解析器 ---
parse_and_run() {
    local folder=$1
    local setup_file="$SETUP_BASE_DIR/${folder}-setup"
    
    if [[ ! -f "$setup_file" ]]; then
        gum log --level none --prefix "$L_WARN [$folder] " "No .setup config found."
        return 0
    fi

    echo "$L_EVENT Found config: .setup/${folder}-setup"
    
    # 使用文件描述符 3 读取文件，避免抢占标准输入 (stdin)
    while IFS= read -r line <&3 || [[ -n "$line" ]]; do
        [[ -z "$line" || "$line" =~ ^# ]] && continue

        # 1. PKG 安装
        if [[ "$line" =~ ^pkg:[[:space:]]*(.*) ]]; then
            local pkgs=${BASH_REMATCH[1]}
            if gum confirm "[$folder] Install packages: $pkgs?"; then
                # 显式重定向 sudo pacman/yay 的输入，确保它们不会卡死
                local install_cmd="$AUR_HELPER -S --noconfirm --needed $pkgs"
                run_task "$folder" "PKG" "$install_cmd"
            fi

        # 2. CMD 执行
        elif [[ "$line" =~ ^cmd:[[:space:]]*(.*) ]]; then
            local cmd=${BASH_REMATCH[1]}
            if gum confirm "[$folder] Run command: $cmd?"; then
                run_task "$folder" "CMD" "$cmd"
            fi

        # 3. STOW 链接
        elif [[ "$line" =~ ^stow:[[:space:]]*(.*) ]]; then
            local stow_target=${BASH_REMATCH[1]}
            [[ -z "$stow_target" ]] && stow_target=$TARGET_DEFAULT
            if gum confirm "[$folder] Link to $stow_target with [STOW]?"; then
                run_task "$folder" "STOW" "stow -R -t $stow_target $folder"
            fi
        fi
    done 3< "$setup_file"  # 将配置文件定向到文件描述符 3
}

# --- 主 TUI 界面 ---
clear
gum style --border double --padding "1 2" --foreground 99 "DOTFILES ENGINE (Manual Control Mode)"

if gum confirm "Enable [SILENT] Mode?"; then
    SILENT=1
else
    SILENT=0
fi

# 扫描文件夹
packages=($(find . -maxdepth 1 -type d -not -path '*/.*' -not -path '.' -not -path './log' | sed 's|./||'))

ACTION=$(gum choose "Install All" "Select Components" "View Logs" "Exit")

case "$ACTION" in
    "Install All") SELECTED=("${packages[@]}") ;;
    "Select Components") SELECTED=($(gum choose --no-limit "${packages[@]}")) ;;
    "View Logs") 
        FILE=$(ls "$LOG_DIR" | gum filter)
        [[ -n "$FILE" ]] && gum pager < "$LOG_DIR/$FILE"
        exit 0 ;;
    *) exit 0 ;;
esac

# 执行主循环
for p in "${SELECTED[@]}"; do
    parse_and_run "$p"
done

gum style --foreground 46 --bold "[FINISHED] All defined tasks completed"
