#!/bin/sh

# Script that parses all tables to remove the delimiter
# character at the end of each line. This is only needed
# for postgres database although parsing doesn't break
# mysql data loading

python parse.py 'tables/nation.tbl' > 'nation.tbl'
python parse.py 'tables/region.tbl' > 'region.tbl'
python parse.py 'tables/part.tbl' > 'part.tbl'
python parse.py 'tables/supplier.tbl' > 'supplier.tbl'
python parse.py 'tables/partsupp.tbl' > 'partsupp.tbl'
python parse.py 'tables/customer.tbl' > 'customer.tbl'
python parse.py 'tables/orders.tbl' > 'orders.tbl'
python parse.py 'tables/lineitem.tbl' > 'lineitem.tbl'
