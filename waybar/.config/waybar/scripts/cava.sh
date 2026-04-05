#!/bin/bash

# 配置
CHARS="▁▂▃▄▅▆▇█"
BARS=10
CONF="/tmp/waybar_cava_config"

# 初始化
len=$((${#CHARS}-1))
idle_char="${CHARS:0:1}"
idle_output=$(printf "%0.s$idle_char" $(seq 1 $BARS))

sed_dict="s/;//g;"
for ((i=0; i<=${len}; i++)); do
    sed_dict="${sed_dict}s/$i/${CHARS:$i:1}/g;"
done

cat > "$CONF" <<EOF
[general]
bars = $BARS
[input]
method = pulse
source = auto
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = $len
EOF

cleanup() {
    trap - EXIT INT TERM
    pkill -P $$ 2>/dev/null
    echo "$idle_output"
    exit 0
}
trap cleanup EXIT INT TERM

is_audio_active() {
    pactl list sink-inputs 2>/dev/null | grep -q "Corked: no"
}

echo "$idle_output"

while true; do
    if is_audio_active; then
        if ! pgrep -P $$ -x cava >/dev/null; then
            cava -p "$CONF" 2>/dev/null | sed -u "$sed_dict" &
        fi
        sleep 1
    else
        if pgrep -P $$ -x cava >/dev/null; then
            pkill -P $$ -x cava 2>/dev/null
            wait 2>/dev/null
            echo "$idle_output"
        fi
        
        timeout 1s pactl subscribe 2>/dev/null | grep -m 1 "sink-input" >/dev/null
    fi
done
