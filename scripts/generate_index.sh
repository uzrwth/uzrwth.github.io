#!/usr/bin/env bash
set -e

# 输出目录
DIST_DIR="$1"

if [ -z "$DIST_DIR" ]; then
  echo "Usage: $0 <dist-directory>"
  exit 1
fi

mkdir -p "$DIST_DIR"

# 生成 index.html
echo "<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='UTF-8'>
  <title>MS Documents</title>
</head>
<body>
  <h1>MS Documents</h1>
  <ul>" > "$DIST_DIR/index.html"

# 遍历 HTML 文件，排除 index.html
for f in "$DIST_DIR"/*.html; do
  filename=$(basename "$f")
  if [ "$filename" != "index.html" ]; then
    echo "    <li><a href='$filename'>$filename</a></li>" >> "$DIST_DIR/index.html"
  fi
done

echo "  </ul>
</body>
</html>" >> "$DIST_DIR/index.html"

