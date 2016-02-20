USE Project1SGD;

/* LOAD DATA */
load data infile "region.tbl" into table REGION fields terminated by "|" lines terminated by "\n";
load data infile "nation.tbl" into table NATION fields terminated by "|" lines terminated by "\n";
load data infile "part.tbl" into table PART fields terminated by "|" lines terminated by "\n";
load data infile "supplier.tbl" into table SUPPLIER fields terminated by "|" lines terminated by "\n";
load data infile "customer.tbl" into table CUSTOMER fields terminated by "|" lines terminated by "\n";
load data infile "partsupp.tbl" into table PARTSUPP fields terminated by "|" lines terminated by "\n";
load data infile "orders.tbl" into table ORDERS fields terminated by "|" lines terminated by "\n";
load data infile "lineitem.tbl" into table LINEITEM fields terminated by "|" lines terminated by "\n";
