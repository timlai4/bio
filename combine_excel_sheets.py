# -*- coding: utf-8 -*-
"""
Created on Sun Aug  1 08:28:31 2021

It is sometimes the case in bioinformatics that a dataset is given in Excel format
and is spread across multiple sheets. In this case, I got such a dataset but each
sheet should have simply been its own column. The sheets were even conveniently
named to be column names! 

This script takes such an Excel file and combines all the sheets into columns
in a single DataFrame. 

Obviously, we need Pandas. However, to read Excel files, we need some additional 
libraries that are not installed by default: xlrd openpyxl

@author: Tim
"""

import pandas as pd

PATH = "" # Insert path to Excel file, with extension .xlsx
# In my case, the column names are in the sneet names, so there were no headers.
d = pd.read_excel(PATH, sheet_name = None, header = None)
# This reads in a dictionary where the values are individual DataFrames
# Need to flatten this to combine into a single DataFrame
df = {}
for lot in d:
    df[lot] = d[lot].values.tolist()
    flatten = [val for sublist in df[lot] for val in sublist]
    df[lot] = flatten
    
# The resulting lists were of unequal length
# Consequently, cannot call pd.DataFrame() directly on dict.
df = pd.DataFrame(dict([(k, pd.Series(v)) for k, v in df.items()]))
