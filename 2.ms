
.TL
for hacking


.PP
Data Science Msc. @RWTH 

.PP
I like sports. 

.IP \(bu 2
Basketball

.IP \(bu
Skateboard

.IP \(bu
Billiard

.IMG duck.png 300 300

.LP

This blog is built with groff. I thought about using hugo, but it makes the website fancier than I wanted it to be. So I chose a more traditional tool.

.LP

live reload

<<>>
browser-sync start --server --files "*.html, *.css, *.js"
<</>>

.LP

make after Put

<<>>
ls *.ms| entr -r make
<</>>
