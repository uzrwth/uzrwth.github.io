#!/usr/bin/env bash
set -e

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
cp style/* "$DIST_DIR/"

cp images/* "$DIST_DIR/"


python ./scripts/index.py . templates/index.html $DIST_DIR/index.html

# -----------------------------
# 2️⃣ 编译所有 .ms 文件 -> HTML
# -----------------------------
for f in *.ms *.m; do
  python ./scripts/compile.py "$f" "$DIST_DIR/${f%.*}.html"
  #sed -i '/<\/title>/a\<link rel="stylesheet" href="style.css">' "$DIST_DIR/${f%.*}.html"
  #sed -i 's|<body>|<body>\n<a href="index.html" class="home-button">Home</a>|' "$DIST_DIR/${f%.*}.html"


done


# -----------------------------
# 7️⃣ 生成 .nojekyll 避免 GitHub Pages 使用 Jekyll
# -----------------------------
touch "$DIST_DIR/.nojekyll"


