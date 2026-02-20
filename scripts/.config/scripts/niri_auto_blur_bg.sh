#!/bin/bash

# 配置选项
CACHE_DIR="$HOME/.cache/blur-wallpapers"
LAST_WALL_FILE="/tmp/niri_last_wall_path"
BLUR_ARG="0x10"
DEBUG=0;
mkdir -p "$CACHE_DIR"

# 颜色日志输出函数
log_info() { [[ "$DEBUG" -eq 1 ]] && echo -e "\e[32m[INFO]\e[0m $1"; }
log_event() { [[ "$DEBUG" -eq 1 ]] && echo -e "\e[34m[EVENT]\e[0m $1"; }
log_warn() { [[ "$DEBUG" -eq 1 ]] && echo -e "\e[33m[WARN]\e[0m $1"; }

# 1. 获取壁纸路径逻辑
get_current_wall() {
    local raw=$(swww query 2>/dev/null)
    if [[ "$raw" =~ image:[[:space:]]*([^[:space:]].*) ]]; then
        local path="${BASH_REMATCH[1]}"
        # 如果当前 swww 是模糊图，则尝试读取记录的原图路径
        if [[ "$path" == *"blur-"* ]]; then
            if [[ -f "$LAST_WALL_FILE" ]]; then
                cat "$LAST_WALL_FILE"
            else
                log_warn "检测到当前为模糊图但缺失记录文件，请手动切换一次壁纸。"
                echo "$path"
            fi
        else
            echo "$path"
        fi
    else
        log_warn "swww query 失败，请确认 swww 是否运行。"
    fi
}

# 2. 核心处理函数
apply_logic() {
    local event="$1"
    local wall=$(get_current_wall)
    [[ -z "$wall" ]] && return
    
    local target_blur="$CACHE_DIR/blur-$(basename "$wall")"
    local tmp_blur="${target_blur}.tmp"

    # 壁纸变更检测
    if [[ "$wall" != "$(cat "$LAST_WALL_FILE" 2>/dev/null)" ]]; then
        log_info "发现新壁纸: $(basename "$wall")，开始生成模糊图..."
        echo "$wall" > "$LAST_WALL_FILE"
        # 异步生成：降采样保证速度，不缩放保证画质
        magick "$wall" -resize 50% -blur $BLUR_ARG -resize 200% "$tmp_blur" && mv "$tmp_blur" "$target_blur" && log_info "模糊图生成完毕。" &
        pkill -x swaybg
    fi

    if ! pgrep -x "swaybg" > /dev/null; then
        # 检查文件是否存在，防止 EOF
        if [[ ! -f "$target_blur" ]]; then
            log_warn "模糊图尚未就绪，等待中..."
            while [[ ! -f "$target_blur" ]]; do sleep 0.1; done
        fi
        swaybg -i "$target_blur" -m fill &>/dev/null &
        log_info "swaybg 已成功启动。"
    fi
        
    case "$event" in
        "WINDOW_BLUR")
            log_info "桌面有窗口：swww 正在切换至模糊图..."
            swww img "$target_blur" --transition-type fade --transition-duration 0.4 ;;
        "WINDOW_CLEAR")
            log_info "桌面清空：swww 正在切换至原图..."
            swww img "$wall" --transition-type fade --transition-duration 0.4 ;;
    esac
}

# --- 脚本入口 ---
clear
echo "------------------------------------------------"
echo "  Niri 背景自动化控制脚本已启动                 "
echo "------------------------------------------------"

# 启动瞬间先做一次自检
if niri msg focused-window &>/dev/null; then
    apply_logic "WINDOW_BLUR"
else
    apply_logic "WINDOW_CLEAR"
fi

# 监听 Niri 事件流
niri msg event-stream | while read -r line; do
    # 只要有输出，就说明监听没断
    if [[ "$line" == *"Window opened"* || "$line" == *"Window focus changed: Some"* ]]; then
        log_event "窗口聚焦"
        apply_logic "WINDOW_BLUR"
    elif [[ "$line" == *"Window focus changed: None"* ]]; then
        log_event "桌面清空"
        apply_logic "WINDOW_CLEAR"
    elif [[ "$line" == *"Overview toggled: true"* ]]; then
        log_event "预览模式开启"
        apply_logic "OVERVIEW_ON"
        apply_logic "WINDOW_CLEAR"
    elif [[ "$line" == *"Overview toggled: false"* ]]; then
        log_event "预览模式关闭"
        apply_logic "OVERVIEW_OFF"
    fi
done
