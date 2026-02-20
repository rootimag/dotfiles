#!/usr/bin/env bash

# 新截图脚本
# 1. 在后台启动截图交互，不阻塞脚本继续执行
niri msg action screenshot &

# 2. 监听事件流，阻塞等待直到捕获到 "Screenshot captured" 这一行
# grep -m 1: 匹配到一行后立即停止监听，脚本继续向下
log_output=$(niri msg event-stream | grep -m 1 --line-buffered "Screenshot captured")

# 3. 提取路径字符串 (删除 "saved to " 及其之前的所有内容)
# 输出示例: ... saved to /home/user/Pic/1.png -> /home/user/Pic/1.png
file_path="${log_output##*saved to }"

# 4. 传递给 satty 编辑
# 检查路径是否非空（防止用户按 Esc 取消导致 grep 没抓到东西）
if [ -n "$file_path" ]; then
    satty --filename "$file_path"
fi
