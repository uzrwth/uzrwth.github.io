.TL
github actions complete clone

.PP

By default, github actions only do:

.DS
git fetch --depth=1
.DE

This causes a small problem for my blog to create the index page. In my blog, I uses git commit timestamp to track the create time of each post.

Adding the following lines in workflows, it should be fine.

.DS
- uses: actions/checkout@v3
  with:
    fetch-depth: 0  # 完整 clone
.DE