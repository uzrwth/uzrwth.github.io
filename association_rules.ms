.TL
association rules


.SH
frozenset: sets in .csv

.PP
Before writing code, we must decide how to represent sets in a .csv file.

<<>>
support,itemsets
0.11872533300444006,frozenset({13176})
0.05557782437099161,frozenset({47209})
0.002081277750370005,"frozenset({46979, 48679})"
<</>>

<<>>
>>> import pandas
>>> import pandas as pd
>>> df = pd.read_csv("frequent_itemsets.csv")
>>> df.dtypes
support     float64
itemsets     object
dtype: object
>>> df2 = pd.read_csv("groceries_basket.csv")
>>> df2.dtypes
order_id                       int64
product_id                     int64
product_name                  object
category                      object
add_to_cart_sequence_index     int64
dtype: object
>>>


>>> df2['product_name'].values
array(['Bulgarian Yogurt', 'Organic Celery Hearts',
       'Lightly Smoked Sardines in Olive Oil', ...,
       'Organic Unsweetened Almond Milk', 'Creamy Peanut Butter',
       'Broccoli Florettes'], shape=(573124,), dtype=object)
>>> type(df2['product_name'].values)
<class 'numpy.ndarray'>

>>> type(df2['product_name'].values[0])
<class 'str'>

<</>>

pandas' read_csv() parses data into basic types: int64, float64, object.

Although shown as 'object' by dtypes, its real data type is <class 'str'>.


When reduced to one dimension, df becomes a series.
<<>>

>>> type(df2['product_name'])
<class 'pandas.core.series.Series'>

<</>>

To construct a .csv file with strings that have "," within it, we need to quote the string. After that, the parsing has no difference from a normal .csv file.

To retrieve the original set object from the <class 'str'>, there is the frozenset library.


The ast module helps processing trees of the Python abstract syntax grammar. In fact, in the .csv file, the set is stored as a line of Python code. With literal_eval, we reconstruct the frozenset object from the literal.

<<>>
>>> import ast
>>> def safe_convert_frozenset(s):
...     if s.startswith("frozenset(") and s.endswith(")"):
...         inner = s[10:-1]
...         try:
...             inner_value = ast.literal_eval(inner)
...             return frozenset(inner_value)
...         except ValueError:
...             pass
...     raise ValueError("Invalid frozenset format")
...
... freq_df = df.copy()
... freq_df['itemsets'] = freq_df['itemsets'].apply(safe_convert_frozenset)
...
>>> freq_df.dtypes
support     float64
itemsets     object
dtype: object
<</>>

.PP

Why do we need frozenset? Why not just using the simple set?

frozenset is immutable and hashable. Therefore, if we want it to be used as the key in a dict, then we should use frozenset rather than the simple set.

For an object to be hashable, it must be immutable. A string can be used as a key because it is immutable. Any operation on a string always creates a new string object.


.B

something deep in Python

.PP

<<>>
>>> a = frozenset({1})
>>> b = frozenset({1})
>>> id(a)
140178894736064
>>> id(b)
140178894736288
>>> c[a] = 9
>>> c[b]
9
>>>

>>> a.__hash__()
-558064481276695278
>>> b.__hash__()
-558064481276695278
>>>

>>> e="a"
>>> e.__hash__()
-3006155391340656490
>>> "a".__hash__()
-3006155391340656490


>>> a = 5
>>> a.__hash__()
5
>>> a=1.23
>>> a.__hash__()
530343892119149569

>>> type(a)
<class 'float'>
>>> type(5)
<class 'int'>

>>> c[{}] = 9
Traceback (most recent call last):
  File "<python-input-58>", line 1, in <module>
    c[{}] = 9
    ~^^^^
TypeError: unhashable type: 'dict'

>>> t={}
>>> t.__hash__()
Traceback (most recent call last):
  File "<python-input-60>", line 1, in <module>
    t.__hash__()
    ~~~~~~~~~~^^
TypeError: 'NoneType' object is not callable
>>> t.__hash__
>>> type(t.__hash__)
<class 'NoneType'>


>>> type(None)
<class 'NoneType'>
>>> id(None)
94040144899728

>>> a = None
>>> b = None
>>> id(a)
94040144899728
>>> id(b)
94040144899728
>>> a = 3
>>> b = 3
>>> id(a)
94040145005360
>>> id(b)
94040145005360


# COW

>>> b = 4
>>> id(b)
94040145005392

<</>>

Everything in Python is an object. We’re getting off track, let’s return to the main point.

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