import re
import subprocess
import re
import subprocess
import sys
import html

# 占位符标记
MARK = "CODECODECODE"

def main():
    if len(sys.argv) != 3:
        print(f"用法: python {sys.argv[0]} 输入文件.ms 输出文件.html")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    # 1️⃣ 读取 MS 文件
    with open(input_file, "r", encoding="utf-8") as f:
        ms_content = f.read()

    # 2️⃣ 提取占位符里的代码块（按顺序）
    # 支持占位符前后空格或缩进
    pattern = re.compile(r"<<>>\s*\n(.*?)\n\s*<</>>", re.DOTALL)
    code_blocks = pattern.findall(ms_content)

    # 3️⃣ 将原文中代码块替换为占位符
    ms_content_placeholder = pattern.sub(MARK, ms_content)

    # 4️⃣ 调用 groff，直接从内存获取 HTML
    result = subprocess.run(
        ["groff", "-Thtml", "-ms", "-Kutf8"],
        input=ms_content_placeholder,
        capture_output=True,
        text=True,
        check=True
    )
    html_content = result.stdout

    # 5️⃣ 按顺序回填代码块，自动 HTML 转义
    for code in code_blocks:
        code_html = f"<pre><code>{html.escape(code.strip())}</code></pre>"
        html_content = html_content.replace(MARK, code_html, 1)  # 只替换第一个匹配

    # 6️⃣ 写出最终 HTML 文件
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(html_content)

    print(f"生成完成：{output_file}")

if __name__ == "__main__":
    main()
