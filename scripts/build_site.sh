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
cp style/style.css "$DIST_DIR/"

cp images/* "$DIST_DIR/"


# -----------------------------
# 2️⃣ 编译所有 .ms 文件 -> HTML
# -----------------------------
for f in *.ms; do
  python ./scripts/compile.py "$f" "$DIST_DIR/${f%.ms}.html"
done

python ./scripts/index.py . $DIST_DIR/index.html"

# -----------------------------
# 7️⃣ 生成 .nojekyll 避免 GitHub Pages 使用 Jekyll
# -----------------------------
touch "$DIST_DIR/.nojekyll"

echo "Site build complete in $DIST_DIR"

