#!/usr/bin/env bash
set -e

DIST_DIR="$1"
CSS_FILE="$2"

if [ -z "$DIST_DIR" ] || [ -z "$CSS_FILE" ]; then
  echo "Usage: $0 <dist-directory> <css-file>"
  exit 1
fi

for f in "$DIST_DIR"/*.html; do
  # 跳过 index.html（如果你想单独处理）
  # 或者也可以加上 index.html
  # [ "$f" == "$DIST_DIR/index.html" ] && continue

  # 在 <head> 标签后面插入 link 标签
  sed -i "/<head>/a \  <link rel=\"stylesheet\" href=\"$CSS_FILE\">" "$f"
done

