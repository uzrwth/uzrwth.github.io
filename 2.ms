
.TL
2026

.AU
Rong

.AB
This is my blog for sharing hacking ideas.
.AE

.SH Base
Germany

.SH Studying
@RWTH

.PP
I like sports.

.IP \(bu 2
Basketball

.IP \(bu
Skateboard

.IMG duck.png 300 300

.LP

This blog is built with groff. Because I want it to be as simple as possible.

.LP

<<>>
/*
 *  do_pre - changes to preformated text.
 */

void html_text::do_pre (void)
{
  done_tt();
  if (is_present(P_TAG)) {
    html_indent *i = remove_indent(P_TAG);
    int space = retrieve_para_space();
    (void)done_para();
    if (! is_present(PRE_TAG))
      push_para(PRE_TAG, NULL, i);
    start_space = space;
  } else if (! is_present(PRE_TAG))
    push_para(PRE_TAG, NULL, NULL);
  dump_stack();
}
<</>>
