.TL
pandas

.SH
DataFrame

.DS
DataFrameGroupBy.size(): return a Series

    >>> lst = ['a', 'a', 'b']
    >>> ser = pd.Series([1, 2, 3], index=lst)
    >>> ser
    a     1
    a     2
    b     3
    dtype: int64
    >>> ser.groupby(level=0).size()
    a    2
    b    1
    dtype: int64

Series.reset_index(name=''): return a DataFrame
The name to use for the column containing the original Series values (here the sizes).
reset_index create a new index column from the index of Series.

>>> lst = ['a', 'a', 'b']
>>> ser = pd.Series([1, 2, 3], index=lst)
>>> ser.groupby(level=0).size()
a    2
b    1
dtype: int64
>>> a=ser.groupby(level=0).size()
>>> a.reset_index(name="abc")
  index  abc
0     a    2
1     b    1

>>> g.size()
category  order_id
alcohol   1325        1
          2985        1
          3209        1
          3819        1
          5466        5
                     ..
snacks    3420505     1
          3420788     3
          3420812     4
          3421058     1
          3421063     1
Length: 284264, dtype: int64


If g is the groupby from a list of columns, then the resulting g.size() uses a MultiIndex.

>>> b=g.size()



>>> b.index
MultiIndex([('alcohol',    1325),
            ('alcohol',    2985),
            ('alcohol',    3209),
            ('alcohol',    3819),
            ('alcohol',    5466),
            ('alcohol',    5535),
            ('alcohol',    9017),
            ('alcohol',    9238),
            ('alcohol',   13863),
            ('alcohol',   20253),
            ...
            ( 'snacks', 3419531),
            ( 'snacks', 3419613),
            ( 'snacks', 3420090),
            ( 'snacks', 3420257),

>>> b.reset_index(name='items_count')
       category  order_id  items_count
0       alcohol      1325            1
1       alcohol      2985            1
2       alcohol      3209            1
3       alcohol      3819            1
4       alcohol      5466            5
...         ...       ...          ...
284259   snacks   3420505            1

.DE