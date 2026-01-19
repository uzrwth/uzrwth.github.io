.TL
git usage

.PP


--diff-filter=AD: Add and Delete

 -- : end of arguments, the remaining are the files for the command to apply on

 %ct: commit timestamp

<<>>
git log --diff-filter=A --follow --format=%ct -- 2.ms
[l@archlinux uzrwth.github.io]$ git log --diff-filter=A  --format=%ct -- 2.ms
1768613587
[l@archlinux uzrwth.github.io]$ git log -1 --format="%cd - %ct" -- 2.ms
Sun Jan 18 16:27:46 2026 +0100 - 1768750066
[l@archlinux uzrwth.github.io]$


[l@archlinux uzrwth.github.io]$ git log   --format=%ct -- 2.ms
1768750066
1768669815
1768642628
1768635646
1768632832
1768614580
1768614377
1768613587
<</>>

