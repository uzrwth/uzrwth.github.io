#!/usr/bin/env bash
set -e

DIST_DIR="$1"
if [ -z "$DIST_DIR" ]; then
  echo "Usage: $0 <dist-directory>"
  exit 1
fi

mkdir -p "$DIST_DIR"

# 复制 style.css 到 dist 目录
cp style/style.css "$DIST_DIR/"

# 获取 HTML 文件列表（排除 index.html）
files=()
for f in "$DIST_DIR"/*.html; do
  filename=$(basename "$f")
  if [ "$filename" != "index.html" ]; then
    files+=("$filename")
  fi
done

# 获取 git 提交时间
declare -A file_times
for file in "${files[@]}"; do
  if git ls-files --error-unmatch "$DIST_DIR/$file" > /dev/null 2>&1; then
    last_commit_time=$(git log -1 --format="%cI" -- "$DIST_DIR/$file")
  else
    last_commit_time=$(date -Iseconds)
  fi
  file_times["$file"]="$last_commit_time"
done

# 按时间降序排列
sorted_files=($(for f in "${files[@]}"; do
  echo "${file_times[$f]} $f"
done | sort -r | awk '{print $2}'))

# 生成 index.html，引用 style.css
cat > "$DIST_DIR/index.html" << EOF
<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='UTF-8'>
  <title>MS Documents</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <h1>MS Documents</h1>
  <ul>
EOF

# 写入文件列表
for file in "${sorted_files[@]}"; do
  time="${file_times[$file]}"
  echo "    <li><a href='$file'>$file</a> <span class='time'>$time</span></li>" >> "$DIST_DIR/index.html"
done

cat >> "$DIST_DIR/index.html" << EOF
  </ul>
</body>
</html>
EOF

