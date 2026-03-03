#!/bin/bash

# 配置区域
# 源图标目录 (Matugen 模板目录)
SRC_DIR="$HOME/.config/matugen/templates/wlogout/icons"

# 目标图标目录 (实际生效目录)
DEST_DIR="$HOME/.config/wlogout/icons"

# 脚本逻辑

# 获取目标颜色参数
TARGET_COLOR="#ffb693"

# 检查是否提供了颜色参数
if [ -z "$TARGET_COLOR" ]; then
    echo "错误: 未提供目标颜色。"
    echo "用法: $0 <十六进制颜色代码>"
    echo "示例: $0 \"#ff0000\""
    exit 1
fi

# 检查 ImageMagick 是否安装
if ! command -v magick &> /dev/null; then
    echo "错误: 未找到 ImageMagick (magick 命令)。请先安装它。"
    exit 1
fi

# 检查源目录是否存在
if [ ! -d "$SRC_DIR" ]; then
    echo "错误: 源目录不存在: $SRC_DIR"
    exit 1
fi

echo "开始处理图标..."
echo "源目录: $SRC_DIR"
echo "目标目录: $DEST_DIR"
echo "应用颜色: $TARGET_COLOR"

# 确保目标目录存在
mkdir -p "$DEST_DIR"

# 循环处理源目录下的所有 PNG 文件
find "$SRC_DIR" -maxdepth 1 -name "*.png" -print0 | while IFS= read -r -d '' img_path; do
    # 获取文件名 (例如 icon.png)
    filename=$(basename "$img_path")
    # 构建目标文件路径
    dest_path="$DEST_DIR/$filename"

    echo -n "正在处理: $filename ... "

    # 执行 ImageMagick 命令 (核心逻辑)
    # 1. 读取原图
    # 2. 转为灰度 (-colorspace Gray)
    # 3. 设置填充颜色 (-fill "$TARGET_COLOR")
    # 4. 应用着色 (-tint 100%)
    # 5. 输出到目标路径
    magick "$img_path" \
        -colorspace Gray \
        -fill "$TARGET_COLOR" \
        -colorize 100% \
        "$dest_path"

    if [ $? -eq 0 ]; then
        echo "完成"
    else
        echo "失败"
    fi
done

echo "所有图标处理完毕"
