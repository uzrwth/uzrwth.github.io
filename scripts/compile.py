import re
import subprocess
import sys
import html
import os

# 占位符标记
CODE_MARK = "CODECODECODE"
IMG_MARK = "IMGIMGIMG"

def parse_img_block(block):
    """
    解析 [[ filename width=... height=... align=... ]] 格式
    返回 (filename, width, height, align)
    """
    parts = block.strip().split()
    filename = parts[0]
    width = None
    height = None
    align = "center"  # 默认居中
    for part in parts[1:]:
        if part.startswith("width="):
            width = part.split("=")[1]
        elif part.startswith("height="):
            height = part.split("=")[1]
        elif part.startswith("align="):
            align = part.split("=")[1].lower()
            if align not in ["left", "center", "right"]:
                align = "center"
    return filename, width, height, align

def main():
    if len(sys.argv) != 3:
        print(f"用法: python {sys.argv[0]} 输入文件.ms 输出文件.html")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]
    file_ext = os.path.splitext(input_file)[1].lower()

    # 1️⃣ 读取 MS 文件
    with open(input_file, "r", encoding="utf-8") as f:
        ms_content = f.read()

    # 2️⃣ 提取代码块
    code_pattern = re.compile(r"<<>>\s*\n(.*?)\n\s*<</>>", re.DOTALL)
    code_blocks = code_pattern.findall(ms_content)
    ms_content_placeholder = code_pattern.sub(CODE_MARK, ms_content)

    # 3️⃣ 提取图片块 [[ ... ]]
    img_pattern = re.compile(r"\[\[\s*(.*?)\s*\]\]", re.DOTALL)
    img_blocks_raw = img_pattern.findall(ms_content_placeholder)

    # 替换图片块为占位符
    ms_content_placeholder = img_pattern.sub(IMG_MARK, ms_content_placeholder)

    # 解析每个图片块参数
    img_blocks = [parse_img_block(block) for block in img_blocks_raw]

    outputT = "-Thtml"

    is_ansi = file_ext == ".m"
    if is_ansi:
        outputT = "-Tutf8"

    # 4️⃣ 调用 groff 生成 HTML
    result = subprocess.run(
        ["groff", outputT, "-ms", "-Kutf8"],
        input=ms_content_placeholder,
        capture_output=True,
        text=True,
        check=True
    )
    html_content = result.stdout

    if is_ansi:
        result = subprocess.run(
            ["ansi2html"],
            input=html_content,
            capture_output=True,
            text=True,
            check=True
        )
        html_content = result.stdout


    # 5️⃣ 回填代码块
    for code in code_blocks:
        code_html = f"<pre><code>{html.escape(code.strip())}</code></pre>"
        html_content = html_content.replace(CODE_MARK, code_html, 1)

    # 6️⃣ 回填图片块
    for filename, width, height, align in img_blocks:
        # 默认 style
        style = ""
        if align == "center":
            style += "display:block; margin:auto;"
        elif align == "left":
            style += "display:block; margin-left:0; margin-right:auto;"
        elif align == "right":
            style += "display:block; margin-left:auto; margin-right:0;"

        width_attr = f' width="{width}"' if width and not width.endswith("%") else ""
        height_attr = f' height="{height}"' if height else ""
        # 百分比宽度放到 style
        if width and width.endswith("%"):
            style += f" width:{width};"

        img_html = f'<img src="{filename}"{width_attr}{height_attr} style="{style}">'
        html_content = html_content.replace(IMG_MARK, img_html, 1)

    html_content = add_home_and_css(html_content, "style.css", "/")
    # 7️⃣ 写出最终 HTML 文件
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(html_content)

    print(f"生成完成：{output_file}")

from bs4 import BeautifulSoup

def add_home_and_css(html_text: str, css_href: str, home_href: str = "index.html") -> str:
    """
    在 HTML 内容中：
    1. 删除 <style> 标签
    2. 在 <body> 开头插入 Home 按钮
    3. 在 <head> 中添加 <link rel="stylesheet" href="...">

    Args:
        html_text (str): 原 HTML 内容
        css_href (str): CSS 文件路径（href）
        home_href (str): Home 按钮链接（默认 "index.html"）

    Returns:
        str: 修改后的 HTML 内容
    """
    soup = BeautifulSoup(html_text, "html.parser")

    # 1️⃣ 删除所有 <style>
    for style in soup.find_all("style"):
        style.decompose()

    # 2️⃣ 确保 <head> 存在，并插入 <link>
    if soup.head is None:
        head = soup.new_tag("head")
        if soup.html is None:
            html_tag = soup.new_tag("html")
            html_tag.append(head)
            # 将原始内容放入 <body>
            body = soup.new_tag("body")
            for el in soup.contents:
                body.append(el)
            html_tag.append(body)
            soup = html_tag
        else:
            soup.html.insert(0, head)
    else:
        head = soup.head

    # 添加 <link>，避免重复
    if not head.find("link", href=css_href):
        link = soup.new_tag("link", rel="stylesheet", href=css_href)
        head.append(link)

    # 3️⃣ 确保 <body> 存在
    if soup.body is None:
        body = soup.new_tag("body")
        if soup.html is None:
            soup.append(body)
        else:
            soup.html.append(body)
    else:
        body = soup.body

    # 插入 Home 按钮到 <body> 开头（避免重复）
    if not body.find("a", href=home_href):
        home_btn = soup.new_tag("a", href=home_href, **{"class": "home-button"})
        home_btn.string = "Home"
        body.insert(0, home_btn)

    return str(soup)

if __name__ == "__main__":
    main()

