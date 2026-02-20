#!/bin/bash

# 1. 定义目录和临时文件
NIRI_DIR="$HOME/.config/niri"
MENU_FILE="/run/user/$UID/niri_menu"
CMDS_FILE="/run/user/$UID/niri_cmds"

# 确保清理旧数据
rm -f "$MENU_FILE" "$CMDS_FILE"

# 2. 全局递归扫描（保持你原有的 AWK 提取逻辑不变）
grep -r "hotkey-overlay-title=" "$NIRI_DIR" --include="*.kdl" | grep -v "^[^:]*:[[:space:]]*//" | awk -F'hotkey-overlay-title=' '
    {
        line = $0;
        sub(/^[^:]*:/, "", line);
        if (line ~ /^[ \t]*\/\//) next;

        sub(/^[ \t]*/, "", line);
        split(line, a, /[ \t]/);
        key = a[1];
        
        if (match(line, /hotkey-overlay-title="[^"]*"/)) {
            title_raw = substr(line, RSTART, RLENGTH);
            split(title_raw, t, "\"");
            title = t[2];

            if (match(line, /\{.*\}/)) {
                action = substr(line, RSTART+1, RLENGTH-2);
                gsub(/^[ \t]*|[ \t]*$/, "", action);
                sub(/;$/, "", action);

                if (key != "" && title != "") {
                    # 这里的格式可以根据 Rofi 的宽度自行调整
                    printf "%-18s │ %s\n", key, title > "'"$MENU_FILE"'"
                    printf "%s\n", action > "'"$CMDS_FILE"'"
                }
            }
        }
    }
'

# 3. 检查并调用 Rofi
if [ ! -f "$MENU_FILE" ]; then
    echo "未找到有效的快捷键。"
    exit 0
fi

# 调用 Rofi
IDX=$(rofi -dmenu -i -format i -p "快捷键  " \
     -l 15 -width 40 -font "JetBrainsMono Nerd Font 12" < "$MENU_FILE")

if [ -n "$IDX" ]; then
    # Rofi 的索引从 0 开始，所以需要 +1 适配 sed
    REAL_LINE=$((IDX + 1))
    FULL_ACTION=$(sed -n "${REAL_LINE}p" "$CMDS_FILE")
    
    if [[ "$FULL_ACTION" =~ ^spawn ]]; then
        ACT=$(echo "$FULL_ACTION" | awk '{print $1}')
        CMD=$(echo "$FULL_ACTION" | sed -E "s/^spawn(-sh)?[[:space:]]+//; s/^\"//; s/\"$//")
        niri msg action "$ACT" -- $CMD
    else
        niri msg action $FULL_ACTION
    fi
fi

# 清理
rm -f "$MENU_FILE" "$CMDS_FILE"
