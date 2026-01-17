.TL
using micromamba


.LP

A few days ago, when I finished the assignment from the IDS course, I upgraded my system. Python was unintentionally upgraded also. After that, I found that the virtual environment that I created with old Python no longer worked.

Then I did some research and tried to use pyenv. However, pyenv is still too intrusive for me and it won't help saving me from the broken virtual environment.

Then I learnt about micromamba. It does seem that micromamba offers a promising solution. I can created different environments with different Python versions and export the environment.yml file. With this file alone, anyone is able to recreate the environment I setup on my machine. 

