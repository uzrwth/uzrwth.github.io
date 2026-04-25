
.TL
for hacking

.DA
.SH
some words to say about the blog

.LP

This blog is built with groff. I thought about using hugo, but it makes the website fancier than I wanted it to be. So I chose a more traditional approach. A small issue with this approach is that groff’s rendering of code blocks is not as well supported in HTML as it is in PDF. I failed to find any macros that output <pre>. Browsing through the source code of groff, I did find some references to PRE_TAG, but I am not certain about the way of invoke. Finally, I resorted to using Python to do some ugly placeholder and maneuver. It seems to be working sufficiently well enough not to distract me from writing blogs. 

It's possible to add some special css and javascript to this static blog website and that seems to be an interesting thing to do, even if it doesn't have much significance in itself, there's at least fun in it.

I am interested in code and maths. Posting ideas on coding here might be easier than posting ideas on maths, but I will try. Using images to illustrate maths might still be the best option I have.


.SH
some tools for the ease of serving the blog locally

.LP

live reload

<<>>
browser-sync start --server --files "*.html, *.css, *.js"
<</>>

.LP

make after Put (in acme)

<<>>
find . -maxdepth 1 -name '*.ms' | entr -dr make
<</>>


.SH
me

.PP
Data Science Msc. @RWTH 

Email: zhongjian.rong@rwth-aachen.de


I like sports. 
<<>>
Basketball
Skateboard
Billiard
<</>>

[[ duck.png width=20% align=left]]

There was a very strange bug. After replacing with placeholders, replace(old, new, 1) failed to effect. This might have to do with Python's inner representation of strings and bytes. This had caused me some troubles many years ago, and now the nightmare is back.

<<>>
import re
import subprocess
import re
import subprocess
import sys
import html

# 占位符标记
MARK = "###CODE###"

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

<</>>

[[ 1.JPG width=80%]]
