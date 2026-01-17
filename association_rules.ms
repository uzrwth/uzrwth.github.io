.TL
association rules


.SH
frozenset: sets in .csv

.PP
Before writing code, we must decide how to represent sets in a .csv file.

.SH
mlxtend association_rules

.PP

<<>>
from mlxtend.frequent_patterns import apriori, association_rules

def safe_convert_frozenset(s):
    if s.startswith("frozenset(") and s.endswith(")"):
        inner = s[10:-1]
        try:
            inner_value = ast.literal_eval(inner)
            return frozenset(inner_value)
        except ValueError:
            pass
    raise ValueError("Invalid frozenset format")

freq_df = df.copy()
freq_df['itemsets'] = freq_df['itemsets'].apply(safe_convert_frozenset)

rules = association_rules(freq_df, metric="confidence", min_threshold=0.2, num_itemsets=orders_num).round(2)
lifts = rules['lift']
display(f"Lift's mean: {lifts.mean().round(2)}. Lift's median: {lifts.median().round(2)}.")

<</>>