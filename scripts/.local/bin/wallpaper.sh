#!/usr/bin/env bash

# 配置文件
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"

# 依赖检查
for cmd in fzf swww matugen; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Error: 未找到依赖 '$cmd'，请先安装" >&2
        exit 1
    fi
done

[[ -d "$WALLPAPER_DIR" ]] || { echo "Error: 壁纸目录不存在: $WALLPAPER_DIR" >&2; exit 1; }

selected_wallpaper=$(find "$WALLPAPER_DIR/" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
       -o -iname "*.webp" -o -iname "*.gif" \) \
    -printf "%f\n" | sort | \
    fzf \
        --preview='kitten icat --clear --stdin=no --silent --transfer-mode=memory \
           --place=50x50@50x15 -- '"$WALLPAPER_DIR"'/{} 2>/dev/null' \
        --preview-window="right:60%:wrap" \
        --height=80% \
        --layout=reverse \
        --prompt="壁纸 > " \
        --bind="focus:transform-preview-label:echo [ {} ]" \
        --bind="enter:accept" \
        --bind="esc:abort")

# 清理终端预览残影
kitten icat --clear --stdin=no --silent 2>/dev/null
stty sane
clear

[[ -z "$selected_wallpaper" ]] && exit 0

FULL_PATH="$WALLPAPER_DIR/$selected_wallpaper"

# 确认文件存在
[[ -f "$FULL_PATH" ]] || { echo "Error: 文件不存在: $FULL_PATH" >&2; exit 1; }

# 应用壁纸
if swww img "$FULL_PATH" --transition-fps 60 --transition-type center; then
    echo "壁纸已切换: $selected_wallpaper"
else
    echo "Error: swww 切换失败" >&2
    exit 1
fi

# 生成配色
if matugen image "$FULL_PATH"; then
    echo "配色已更新"
else
    echo "Warning: matugen 配色生成失败" >&2
fi
