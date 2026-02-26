#!/usr/bin/env bash

# 颜色定义
G='\033[0;32m'
Y='\033[0;33m'
R='\033[0;31m'
C='\033[0;36m'
N='\033[0m'

TARGET=$1
if [ -z "$TARGET" ]; then
    echo -e "${Y}Usage:${N} ./proxy.sh <url>"
    exit 1
fi

[[ ! $TARGET =~ ^http ]] && TARGET="https://$TARGET"
echo -e "${C}󰙚 Testing:${N} $TARGET"

# 执行测试
res=$(curl -m 5 -o /dev/null -s -w "%{time_connect} %{time_starttransfer} %{time_total}\n" "$TARGET")

if [ $? -ne 0 ]; then
    echo -e "${R}󰬭 [TIMEOUT/ERROR]${N}"
    exit 1
fi

eval $(echo "$res" | awk '{
    printf "ms_connect=%.0f; ms_start=%.0f; ms_total=%.0f;", $1*1000, $2*1000, $3*1000
}')

proxy_overhead=$((ms_start - ms_connect))

# 输出
echo -ne "${C}󰛳 TCP Connect: ${N}${ms_connect}ms | "
echo -ne "${C}󰒲 Proxy Handshake: ${N}${proxy_overhead}ms\n"

if [ "$ms_total" -lt 200 ]; then
    COLOR=$G; ICON="󰄬 [FAST]"
elif [ "$ms_total" -lt 600 ]; then
    COLOR=$Y; ICON="󰬫 [NORMAL]"
else
    COLOR=$R; ICON="󰬪 [SLOW]"
fi

echo -e "${COLOR}${ICON} Total Latency: ${ms_total}ms${N}"

# 自动诊断
if [[ "$ms_total" -gt 300 && ("$TARGET" == *"baidu.com"* || "$TARGET" == *"163.com"*) ]]; then
    echo -e "${Y}󱈸 Alert:${N} 检测到国内流量延迟过高，请检查 sing-box 分流规则是否绕路。"
fi
