#!/usr/bin/env bash

# 1. 获取当前壁纸路径
WALLPAPER_PATH="$1"

# 2. 运行 Matugen 生成颜色变量
matugen image "$WALLPAPER_PATH"

# 3. 发送系统通知
notify-send "Matugen" "配色方案已根据壁纸同步更新" -i "$WALLPAPER_PATH"
