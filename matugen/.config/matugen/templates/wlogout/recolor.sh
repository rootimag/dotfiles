#!/bin/bash

SRC_DIR="$HOME/.config/matugen/templates/wlogout/icons"

DEST_DIR="$HOME/.cache/matugen/wlogout/icons"

TARGET_COLOR="{{colors.primary.default.hex}}"

if [ -z "$TARGET_COLOR" ]; then
    echo "错误: 未提供目标颜色。"
    echo "用法: $0 <十六进制颜色代码>"
    echo "示例: $0 \"#ff0000\""
    exit 1
fi

if ! command -v magick &> /dev/null; then
    echo "错误: 未找到 ImageMagick (magick 命令)。请先安装它。"
    exit 1
fi

if [ ! -d "$SRC_DIR" ]; then
    echo "错误: 源目录不存在: $SRC_DIR"
    exit 1
fi

echo "开始处理图标..."
echo "源目录: $SRC_DIR"
echo "目标目录: $DEST_DIR"
echo "应用颜色: $TARGET_COLOR"

mkdir -p "$DEST_DIR"

find "$SRC_DIR" -maxdepth 1 -name "*.png" -print0 | while IFS= read -r -d '' img_path; do
    filename=$(basename "$img_path")
    dest_path="$DEST_DIR/$filename"

    echo -n "正在处理: $filename ... "

    magick "$img_path" \
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
