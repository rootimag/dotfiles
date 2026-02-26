#!/bin/bash

if pgrep -x "sing-box" > /dev/null; then
    pkill -x "sing-box"
    notify-send "Proxy" "sing-box 已关闭"
else
    sing-box run -c /home/rootimag/.config/sing-box/config.json &
    notify-send "Proxy" "sing-box 已启动"
fi
