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

# -----------------------------
# 3️⃣ 插入 CSS 链接到 HTML
# -----------------------------
for f in "$DIST_DIR"/*.html; do
  # 跳过 index.html，如果还没生成也没关系
  [ "$(basename "$f")" = "index.html" ] && continue

  # 在 <head> 标签后插入 link 标签
  sed -i "/<head>/a \  <link rel=\"stylesheet\" href=\"style.css\">" "$f"
done

# -----------------------------
# 4️⃣ 获取 HTML 文件 git 提交时间
# -----------------------------
files=()
declare -A file_times
for f in "$DIST_DIR"/*.html; do
  filename=$(basename "$f")
  [ "$filename" = "index.html" ] && continue
  files+=("$filename")

  if git ls-files --error-unmatch "$DIST_DIR/$filename" > /dev/null 2>&1; then
    last_commit_time=$(git log -1 --format="%cI" -- "$DIST_DIR/$filename")
    last_commit_time=$(date -d "$last_commit_time" +"%Y-%m-%d")
  else
    last_commit_time=$(date +"%Y-%m-%d")
  fi
  file_times["$filename"]="$last_commit_time"
done

# -----------------------------
# 5️⃣ 按时间降序排序
# -----------------------------
sorted_files=($(for f in "${files[@]}"; do
  echo "${file_times[$f]} $f"
done | sort -r | awk '{print $2}'))

# -----------------------------
# 6️⃣ 生成 index.html 列表页
# -----------------------------
cat > "$DIST_DIR/index.html" << EOF
<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset="UTF-8">
  <title>uz's blog</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <h1>uz's blog</h1>
  <ul>
EOF

for file in "${sorted_files[@]}"; do
  time="${file_times[$file]}"
  echo "    <li><a href='$file'>$file</a> <span class='time'>$time</span></li>" >> "$DIST_DIR/index.html"
done

cat >> "$DIST_DIR/index.html" << EOF
  </ul>
</body>
</html>
EOF

# -----------------------------
# 7️⃣ 生成 .nojekyll 避免 GitHub Pages 使用 Jekyll
# -----------------------------
touch "$DIST_DIR/.nojekyll"

echo "Site build complete in $DIST_DIR"

