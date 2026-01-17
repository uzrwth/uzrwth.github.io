import sys
import subprocess
import html
from pathlib import Path
from datetime import datetime


def extract_title_from_ms(ms_content: str) -> str | None:
    lines = ms_content.splitlines()
    title_lines = []
    in_title = False

    for line in lines:
        if line.strip() == ".TL":
            in_title = True
            continue

        if in_title:
            if line.startswith("."):
                break
            if line.strip():
                title_lines.append(line.strip())

    return " ".join(title_lines) if title_lines else None


def git_first_commit_time(path: str) -> int:
    try:
        result = subprocess.run(
            [
                "git",
                "log",
                "--diff-filter=A",
                "--follow",
                "--format=%ct",
                "--",
                path,
            ],
            capture_output=True,
            text=True,
            check=True,
        )
        lines = result.stdout.strip().splitlines()
        if lines:
            return int(lines[-1])
    except subprocess.CalledProcessError:
        pass
    return 0


def main():
    if len(sys.argv) != 3:
        print(f"用法: python {sys.argv[0]} <ms目录> <输出.html>")
        sys.exit(1)

    docs_dir = Path(sys.argv[1])
    output_html = Path(sys.argv[2])

    if not docs_dir.is_dir():
        print(f"错误：{docs_dir} 不是目录")
        sys.exit(1)

    entries = []

    for ms_file in docs_dir.glob("*.ms"):
        with open(ms_file, encoding="utf-8") as f:
            content = f.read()

        title = extract_title_from_ms(content) or ms_file.stem
        html_file = ms_file.with_suffix(".html").name
        ts = git_first_commit_time(str(ms_file))

        date_str = (
            datetime.fromtimestamp(ts).strftime("%Y-%m-%d")
            if ts > 0 else ""
        )

        entries.append((ts, date_str, html_file, title))

    # 按 Git 首次提交时间排序（早 → 晚）
    entries.sort(key=lambda x: x[0])

    with open(output_html, "w", encoding="utf-8") as f:
        f.write("""<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>uz's blog</title>
<style>
body {
    max-width: 900px;
    margin: 3em auto;
    padding: 0 1em;
    font-family: -apple-system, BlinkMacSystemFont,
                 "Segoe UI", Helvetica, Arial, sans-serif;
    color: #222;
    background: #fff;
}

h1 {
    font-weight: 600;
    margin-bottom: 1.5em;
}

ul.doc-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

ul.doc-list li {
    display: flex;
    gap: 1.2em;
    padding: 0.4em 0;
    border-bottom: 1px solid #eee;
}

.doc-date {
    color: #888;
    font-family: monospace;
    min-width: 7em;
    text-align: right;
}

.doc-title a {
    color: #0066cc;
    text-decoration: none;
}

.doc-title a:hover {
    text-decoration: underline;
}
</style>
</head>
<body>

<h1>uz's blog</h1>
<ul class="doc-list">
""")

        for _, date_str, href, title in entries:
            f.write(
                f"""<li>
  <span class="doc-date">{date_str}</span>
  <span class="doc-title">
    <a href="{href}">{html.escape(title)}</a>
  </span>
</li>
"""
            )

        f.write("""
</ul>
</body>
</html>
""")

    print(f"生成完成：{output_html}")


if __name__ == "__main__":
    main()

