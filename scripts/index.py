import sys
import subprocess
import html
from pathlib import Path
from datetime import datetime
from itertools import chain

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
                "git", "log",
                "--diff-filter=A",
                "--follow",
                "--format=%ct",
                "--", path,
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


def render_template(template: str, **kwargs) -> str:
    for k, v in kwargs.items():
        template = template.replace(f"{{{{ {k} }}}}", v)
    return template


def main():
    if len(sys.argv) != 4:
        print(f"用法: python {sys.argv[0]} <ms目录> <模板.html> <输出.html>")
        sys.exit(1)

    docs_dir = Path(sys.argv[1])
    template_path = Path(sys.argv[2])
    output_html = Path(sys.argv[3])

    template = template_path.read_text(encoding="utf-8")

    entries = []

    files = chain.from_iterable(docs_dir.glob(ext) for ext in ["*.m", "*.ms"])
    for ms_file in files:
        content = ms_file.read_text(encoding="utf-8")
        title = extract_title_from_ms(content) or ms_file.stem
        ts = git_first_commit_time(str(ms_file))

        date_str = (
            datetime.fromtimestamp(ts).strftime("%Y-%m-%d")
            if ts else ""
        )

        entries.append((ts, date_str, ms_file.with_suffix(".html").name, title))

    entries.sort(key=lambda x: x[0], reverse=True)

    items_html = []
    for _, date_str, href, title in entries:
        items_html.append(
            f"""<li class="item">
  <span class="item-date">{date_str}</span>
  <span class="item-title">
    <a href="{href}">{html.escape(title)}</a>
  </span>
</li>"""
        )

    final_html = render_template(
        template,
        title="uz's blog",
        css_path="list.css",
        items="\n".join(items_html),
    )

    output_html.write_text(final_html, encoding="utf-8")
    print(f"生成完成：{output_html}")


if __name__ == "__main__":
    main()

