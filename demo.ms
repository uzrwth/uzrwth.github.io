.\" ===============================
.\" groff 文档 Demo（-ms 宏包）
.\" ===============================

.TL
用 groff 编写文档 Demo

.AU
你的名字

.AB
这是一个最小但完整的 groff 文档示例，
展示标题、段落、列表、代码块等常用元素。
.AE

.SH 引言
groff 是 Unix 世界中历史悠久且稳定的排版系统。
它使用纯文本编写，适合技术文档与长期保存的内容。

.SH 基本段落
这是一个普通段落。  
groff 会自动进行断行和排版。

.PP
这是通过 \fB.PP\fP 显式开始的新段落，
常用于强调结构。

.SH 列表示例

.IP \(bu 2
第一条项目符号

.IP \(bu
第二条项目符号

.IP 1.
编号列表第一项

.IP 2.
编号列表第二项

.SH 代码块示例
下面是一个等宽、保持格式的代码块：

.DS
.nf
#include <stdio.h>

int main(void) {
    printf("Hello, groff!\n");
    return 0;
}
.fi
.DE

.SH 字体样式
你可以使用
\fB粗体\fP、
\fI斜体\fP
以及
\f(CW等宽字体\fP
来强调内容。

.SH 链接示例
groff 也支持链接（HTML 输出时有效）：

.URL "https://www.gnu.org/software/groff/" "GNU groff 官方网站"

.SH 结语
这个 demo 展示了使用 groff 编写一篇
技术文档或博客文章所需的核心功能。

.lt 0
.fi
.nf
.ce
<HTML><img src="image.jpg" alt="示例图片" width="300"></HTML>
.fi