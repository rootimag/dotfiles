#!/bin/bash

SAVE_DIR="$HOME/Videos/Recordings"
mkdir -p "$SAVE_DIR"

if pgrep -x "wl-screenrec" > /dev/null; then
    pkill -INT wl-screenrec
    gum style --foreground 212 --border double --margin "1 2" --padding "1 2" "󰑋 录制已停止" "文件已保存至 Videos/Recordings"
    sleep 1
    exit 0
fi

MODE=$(gum choose --header "选择录制模式 (Esc 退出)" \
    "󰹑 全屏录制" \
    "󰒉 区域录制" \
    "󰕧 全屏+系统音频")

[[ -z "$MODE" ]] && exit 0

NAME=$(gum input --placeholder "输入文件名 (直接回车使用时间戳)")
[[ -z "$NAME" ]] && NAME="rec_$(date +%Y%m%d_%H%M%S)"
FILEPATH="$SAVE_DIR/$NAME.mp4"

case $MODE in
    *"全屏录制")
        setsid wl-screenrec --low-power=off -f "$FILEPATH" > /dev/null 2>&1 &
        ;;
    *"区域录制")
        AREA=$(slurp)
        [[ -z "$AREA" ]] && exit 0
        setsid wl-screenrec --low-power=off -g "$AREA" -f "$FILEPATH" > /dev/null 2>&1 &
        ;;
    *"系统音频")
        setsid wl-screenrec --low-power=off --audio -f "$FILEPATH" > /dev/null 2>&1 &
esac

gum style --foreground 212 --border double --margin "1 2" --padding "1 2" "󰑊 录制已启动" "文件名: $NAME.mp4"
sleep 0.5
