.TL
Union Bound

.PP
[[union_bound.png]]

Following is my proof. I didn't get full marks with this proof.

At the end of this post, there is another proof, which gets full marks.

base case: P(A1) <= P(A1)

P(A1 ∪ A2) = P(A1) + P(A2) - P(A1 ∩ A2) <= P(A1) + P(A2)

P((A1 ∪ A2) ∪ A3) = P(A1 ∪ A2) + P(A3) - P((A1 ∪ A2) ∩ A3)  <= P(A1 ∪ A2) + P(A3) <= P(A1) + P(A2) + P(A3)


[[union_a_b.png]]

[[disjoint_events.png]]


[[partition_a_set.png]]

[[union_a_b_c.png]]

proof:

[[proof_union_a_b_c.png]]

Bonferroni Inequality:

[[bonferroni_ineq.png]]

proof:

[[hint_for_proof_union_bound.png]]

use this:

[[partition_a_set.png]]


