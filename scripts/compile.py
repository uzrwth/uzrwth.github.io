import re
import subprocess
import sys
import html

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

    # 4️⃣ 调用 groff 生成 HTML
    result = subprocess.run(
        ["groff", "-Thtml", "-ms", "-Kutf8"],
        input=ms_content_placeholder,
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

    # 7️⃣ 写出最终 HTML 文件
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(html_content)

    print(f"生成完成：{output_file}")

if __name__ == "__main__":
    main()

