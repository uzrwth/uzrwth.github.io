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

Everything in Python is an object.

We’re getting off track, let’s return to the main point.

.SH
mlxtend association_rules

.PP

checking for the source file:

<<>>
>>> import mlxtend
>>> mlxtend.__file__
'/home/l/micromamba/envs/py313/lib/python3.13/site-packages/mlxtend/__init__.py'
<</>>


.B
some basic Python concepts

.PP
There is an __init__.py in the directory, so mlxtend is a package.

Every .py file is a module.

import mlxtend: importing the package.

from mlxtend.frequent_patterns import apriori, association_rules: importing functions apriori and association_rules.

functions are also objects, of type <class 'function'>.

<<>>
>>> type(association_rules)
<class 'function'>
>>> def a():
...     return 1
...
>>> type(a)
<class 'function'>
<</>>

import foo: first check if the name is a directory, if yes, look for __init__.py, if found, then this is a package. if not, look for foo.py. if found, it is a module. then load it.
loading a module: if the module object already exists, then returns. Otherwise, executes the code in foo.py from top to bottom, creates a module object and returns it.

What do we need to put in __init__.py when we want to create a package?

__init__.py can be empty if we just want a package.

In __init__.py we can expose some modules. We can use __all__ to control what we want to expose. Without __all__, everything will be exposed.

<<>>
from .module1 import foo
from .module2 import bar
<</>>


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


association_rules requires df to have mandatory columns:

<<>>
    # check for mandatory columns
    if not all(col in df.columns for col in ["support", "itemsets"]):
        raise ValueError(
            "Dataframe needs to contain the\
                         columns 'support' and 'itemsets'"
        )

<</>>

<<>>
>>> df.columns
Index(['order_id', 'product_id', 'product_name', 'category',
       'add_to_cart_sequence_index'],
      dtype='object')
>>> 'order_id' in df.columns
True
>>> type(df.columns)
<class 'pandas.core.indexes.base.Index'>
<</>>

How does 'in' work in Python?

<<>>
>>> df.columns.__contains__
<bound method Index.__contains__ of Index(['order_id', 'product_id', 'product_name', 'category',
       'add_to_cart_sequence_index'],
      dtype='object')>
>>> a=[]
>>> type(a.__contains__)
<class 'method-wrapper'>
<</>>

If I implement a class with the function __contains__, then such a class works with the 'in' keyword.

<<>>
>>> class MyContainer:
...     def __contains__(self, item):
...         return item % 2 == 0  # only even numbers are "in" this container
...
... c = MyContainer()
...
... print(2 in c)  # True
... print(3 in c)  # False
...
True
False
<</>>

Kulczynski similarity coefficient: it's a measure of similarity between sets or vectors.

<<>>
    def kulczynski_helper(sAC, sA, sC, disAC, disA, disC, dis_int, dis_int_):
        conf_AC = sAC * (num_itemsets - disAC) / (sA * (num_itemsets - disA) - dis_int)
        conf_CA = sAC * (num_itemsets - disAC) / (sC * (num_itemsets - disC) - dis_int_)
        kulczynski = (conf_AC + conf_CA) / 2
        return kulczynski


 # metrics for association rules
    metric_dict = {
        "antecedent support": lambda _, sA, ___, ____, _____, ______, _______, ________: sA,
        "consequent support": lambda _, __, sC, ____, _____, ______, _______, ________: sC,
        "support": lambda sAC, _, __, ___, ____, _____, ______, _______: sAC,
        "confidence": lambda sAC, sA, _, disAC, disA, __, dis_int, ___: (
            sAC * (num_itemsets - disAC)
        )
        / (sA * (num_itemsets - disA) - dis_int),
        "lift": lambda sAC, sA, sC, disAC, disA, disC, dis_int, dis_int_: metric_dict[
            "confidence"
        ](sAC, sA, sC, disAC, disA, disC, dis_int, dis_int_)
        / sC,
        "representativity": lambda _, __, ___, disAC, ____, ______, _______, ________: (
            num_itemsets - disAC
        )
        / num_itemsets,
        "leverage": lambda sAC, sA, sC, _, __, ____, _____, ______: metric_dict[
            "support"
        ](sAC, sA, sC, disAC, disA, disC, dis_int, dis_int_)
        - sA * sC,
        "conviction": lambda sAC, sA, sC, disAC, disA, disC, dis_int, dis_int_: conviction_helper(
            metric_dict["confidence"](
                sAC, sA, sC, disAC, disA, disC, dis_int, dis_int_
            ),
            sC,
        ),
        "zhangs_metric": lambda sAC, sA, sC, disAC, disA, disC, dis_int, dis_int_: zhangs_metric_helper(
            sAC, sA, sC, disAC, disA, disC, dis_int, dis_int_
        ),
        "jaccard": lambda sAC, sA, sC, _, __, ____, _____, ______: jaccard_metric_helper(
            sAC, sA, sC, disAC, disA, disC, dis_int, dis_int_
        ),
        "certainty": lambda sAC, sA, sC, _, __, ____, _____, ______: certainty_metric_helper(
            sAC, sA, sC, disAC, disA, disC, dis_int, dis_int_
        ),
        "kulczynski": lambda sAC, sA, sC, _, __, ____, _____, ______: kulczynski_helper(
            sAC, sA, sC, disAC, disA, disC, dis_int, dis_int_
        ),
    }

<</>>


What is the zip object?

<<>>
zip(*iterables, strict=False)

>>> a = range(3)
>>> type(a)
<class 'range'>
>>> a.__iter__()
<range_iterator object at 0x7f8f317819b0>
>>>
>>> b='abcd'
>>> b.__iter__()
<str_ascii_iterator object at 0x7f8f327acaf0>
>
>>> bi = b.__iter__()
>>> type(bi)
<class 'str_ascii_iterator'>
>>> ai=a.__iter__()
>>> type(ai)
<class 'range_iterator'>

>>> list(zip('abcdefg', range(3), range(4)))
[('a', 0, 0), ('b', 1, 1), ('c', 2, 2)]
>>> type(t)
<class 'zip'>
>>> t.__iter__()
<zip object at 0x7f8f31136000>
>>> type(t.__iter__())
<class 'zip'>

<</>>

*iterables: * unlimited input parameters.




<<>>
    # get dict of {frequent itemset} -> support
    keys = df["itemsets"].values
    values = df["support"].values
    frozenset_vect = np.vectorize(lambda x: frozenset(x))
    frequent_items_dict = dict(zip(frozenset_vect(keys), values))

<</>>

zip: create a zip object, each element is a tuple of key-value.

<<>>
>>> d = dict([('a', 2), ('b', 3)])
>>> d
{'a': 2, 'b': 3}

>>> type(df["order_id"].values)
<class 'numpy.ndarray'>
>>> type(df["order_id"].values[0])
<class 'numpy.int64'>

Help on class zip in module builtins:
Help on class int64 in module numpy:

import numpy
import builtins

help(numpy)
Help on package numpy:

NAME
    numpy

DESCRIPTION
    NumPy
    =====

    Provides
      1. An array object of arbitrary homogeneous items
      2. Fast mathematical operations over arrays
      3. Linear Algebra, Fourier Transforms, Random Number Generation

    How to use the documentation
    ----------------------------

help(builtins)
Help on built-in module builtins:

NAME
    builtins - Built-in functions, types, exceptions, and other objects.

DESCRIPTION
    This module provides direct access to all 'built-in'
    identifiers of Python; for example, builtins.len is
    the full name for the built-in function len().

    This module is not normally accessed explicitly by most
    applications, but can be useful in modules that provide
    objects with the same name as a built-in value, but in
    which the built-in of that name is also needed.

>>> builtins.__file__
Traceback (most recent call last):
  File "<python-input-59>", line 1, in <module>
    builtins.__file__
AttributeError: module 'builtins' has no attribute '__file__'. Did you mean: '__name__'?
>>> numpy.__file__
'/home/l/micromamba/envs/py313/lib/python3.13/site-packages/numpy/__init__.py'

<</>>

The builtins module is implemented in Python/bltinmodule.c (cpython).

builtins is a module, but numpy is a package.

<<>>
PyTypeObject PyFilter_Type = {
PyTypeObject PyMap_Type = {
PyTypeObject PyZip_Type = {

    SETBUILTIN("None",                  Py_None);
    SETBUILTIN("Ellipsis",              Py_Ellipsis);
    SETBUILTIN("NotImplemented",        Py_NotImplemented);
    SETBUILTIN("False",                 Py_False);
    SETBUILTIN("True",                  Py_True);
    SETBUILTIN("bool",                  &PyBool_Type);
    SETBUILTIN("memoryview",        &PyMemoryView_Type);
    SETBUILTIN("bytearray",             &PyByteArray_Type);
    SETBUILTIN("bytes",                 &PyBytes_Type);
    SETBUILTIN("classmethod",           &PyClassMethod_Type);
    SETBUILTIN("complex",               &PyComplex_Type);
    SETBUILTIN("dict",                  &PyDict_Type);
    SETBUILTIN("enumerate",             &PyEnum_Type);
    SETBUILTIN("filter",                &PyFilter_Type);
    SETBUILTIN("float",                 &PyFloat_Type);
    SETBUILTIN("frozenset",             &PyFrozenSet_Type);

    SETBUILTIN("dict",                  &PyDict_Type);

<</>>

<<>>
>>> type(numpy)
<class 'module'>
>>> type(numpy.int64)
<class 'type'>
>>> type(builtins)
<class 'module'>
<</>>

Both packages and modules are represented as <class 'module'> in Python's runtime.

packages and modules are mostly the same. A package in its nature is no more than modules living in a namespace specified by __init__.py.

Now that association_rules has built the frequent_items_dict. It's time to collect frequent rules.

<<>>
    # prepare buckets to collect frequent rules
    rule_antecedents = []
    rule_consequents = []
    rule_supports = []

<</>>


<<>>

    null_values : bool (default: False)
      In case there are null values as NaNs in the original input data


    # if null values exist, df_orig must be provided
    if null_values and df_orig is None:
        raise TypeError("If null values exist, df_orig must be provided.")
    # if null values exist, num_itemsets must be provided
    if null_values and num_itemsets == 1:
        raise TypeError("If null values exist, num_itemsets must be provided.")


    for k in frequent_items_dict.keys():
        sAC = frequent_items_dict[k]
        # to find all possible combinations

<</>>

Iteration through a dict with .keys() is not as efficient as with .items(). Because with .keys(), it needs one more indexing step to fetch the value.


<<>>
        # to find all possible combinations
        for idx in range(len(k) - 1, 0, -1):
            # of antecedent and consequent

>>> for i in range(5, 0, -1):
...     print(i)
...
5
4
3
2
1
>>> for i in range(0, 5):
...     print(i)
...
0
1
2
3
4

>>> a=frozenset({1,2})
>>> b=frozenset({2,1})
>>> a
frozenset({1, 2})
>>> b
frozenset({1, 2})
>>> a==b
True

>>> for i in range(0, 0, -1):
...     print(i)
...
>>>

# loops: 0
<</>>

<<>>
from itertools import combinations

            # of antecedent and consequent
            for c in combinations(k, r=idx):
                antecedent = frozenset(c)
                consequent = k.difference(antecedent)

class combinations(builtins.object)
 |  combinations(iterable, r)
 |
 |  Return successive r-length combinations of elements in the iterable.
 |
 |  combinations(range(4), 3) --> (0,1,2), (0,1,3), (0,2,3), (1,2,3)
<</>>

The support_only parameter:

<<>>
                    try:
                        sA = frequent_items_dict[antecedent]
                        sC = frequent_items_dict[consequent]


                    except KeyError as e:
                        s = (
                            str(e) + "You are likely getting this error"
                            " because the DataFrame is missing "
                            " antecedent and/or consequent "
                            " information."
                            " You can try using the "
                            " `support_only=True` option"
                        )
                        raise KeyError(s)

    support_only : bool (default: False)
      Only computes the rule support and fills the other
      metric columns with NaNs. This is useful if:

      a) the input DataFrame is incomplete, e.g., does
      not contain support values for all rule antecedents
      and consequents

      b) you simply want to speed up the computation because
      you don't need the other metrics.

<</>>

If a set is a frequent itemset, then all of its subsets are also frequent itemsets. This means we won't need to use the support_only in most cases.

How does it handle with null_values?
<<>>


    # if null values exist, df_orig must be provided
    if null_values and df_orig is None:
        raise TypeError("If null values exist, df_orig must be provided.")

    # check for valid input
    fpc.valid_input_check(df_orig, null_values)

<</>>

<<>>
>>> df.shape
(1977, 2)
>>> df.shape[0]
1977
>>> len(df)
1977

>>> hasattr(df, "sparse")
False
>>> hasattr(df, "dtypes")
True
>>> hasattr(df, "groupby")
True

Help on built-in function hasattr in module builtins:

hasattr(obj, name, /)
    Return whether the object has an attribute with the given name.

    This is done by calling getattr(obj, name) and catching AttributeError.
<</>>

df.dtypes is a series.

<<>>
>>> df.dtypes
support     float64
itemsets     object
dtype: object
>>> type(df.dtypes)
<class 'pandas.core.series.Series'>


    if f"{type(df)}" == "<class 'pandas.core.frame.SparseDataFrame'>":
        msg = (
            "SparseDataFrame support has been deprecated in pandas 1.0,"
            " and is no longer supported in mlxtend. "
            " Please"
            " see the pandas migration guide at"
            " https://pandas.pydata.org/pandas-docs/"
            "stable/user_guide/sparse.html#sparse-data-structures"
            " for supporting sparse data in DataFrames."
        )
        raise TypeError(msg)

    # Fast path: if all columns are boolean, there is nothing to checks
    if null_values:
        all_bools = (
            df.apply(lambda col: col.apply(lambda x: pd.isna(x) or isinstance(x, bool)))
            .all()
            .all()
        )
    else:
        all_bools = df.dtypes.apply(pd.api.types.is_bool_dtype).all()
    if not all_bools:
        ...


Help on function is_bool_dtype in module pandas.core.dtypes.common:

is_bool_dtype(arr_or_dtype) -> 'bool'
    Check whether the provided array or dtype is of a boolean dtype.

>>> df["a"]=False
>>> pd.api.types.is_bool_dtype(df["a"])
True
>>> pd.api.types.is_bool_dtype([True])
False
<</>>
