#!/usr/bin/env bash
set -e

shopt -s nullglob

# 参数：dist 目录
DIST_DIR="$1"
if [ -z "$DIST_DIR" ]; then
  echo "Usage: $0 <dist-directory>"
  exit 1
fi

mkdir -p "$DIST_DIR"

# -----------------------------
# 1️⃣ 复制 CSS
# -----------------------------
#cp style/* "$DIST_DIR/"

#cp images/* "$DIST_DIR/"

# 定义输入目录和输出目录（都与脚本所在目录同级）
input_base="posts"
output_base="$DIST_DIR"

# 创建输出目录（如果不存在）
mkdir -p "$output_base"

# 遍历 posts/ 下的每个子目录
for dir in "$input_base"/*/; do
    # 去掉末尾的斜杠，获取目录名
    dir="${dir%/}"
    dirname=$(basename "$dir")
    
    # 检查该目录下是否有 jpg 文件
    jpg_files=("$dir"/*.jpg)
    if [ ${#jpg_files[@]} -eq 0 ] || [ ! -e "${jpg_files[0]}" ]; then
        echo "跳过 $dirname：没有 JPG 文件"
        continue
    fi
    
    # 输出 PDF 路径（放在与 posts 同级的输出目录）
    output="$output_base/$dirname.pdf"
    
    echo "正在处理: $dirname ($(ls "$dir"/*.jpg 2>/dev/null | wc -l) 张图片)"
    
    # 使用 img2pdf 合并（按文件名自然排序）
    img2pdf "$dir"/*.jpg -o "$output"
    
    echo "  已生成: $output"
done

echo "全部完成！"

# python ./scripts/index.py . templates/index.html $DIST_DIR/index.html

# -----------------------------
# 2️⃣ 编译所有 .ms 文件 -> HTML
# -----------------------------
#for f in *.ms *.m; do
  #python ./scripts/compile.py "$f" "$DIST_DIR/${f%.*}.html"
  #sed -i '/<\/title>/a\<link rel="stylesheet" href="style.css">' "$DIST_DIR/${f%.*}.html"
  #sed -i 's|<body>|<body>\n<a href="index.html" class="home-button">Home</a>|' "$DIST_DIR/${f%.*}.html"
#done


# -----------------------------
# 7️⃣ 生成 .nojekyll 避免 GitHub Pages 使用 Jekyll
# -----------------------------
touch "$DIST_DIR/.nojekyll"

cd "$DIST_DIR"

tree -H . -o index.html
