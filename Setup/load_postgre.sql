\connect project1sgd;

/* LOAD DATA */
\copy REGION FROM 'region.tbl' DELIMITER '|';
\copy NATION FROM 'nation.tbl' DELIMITER '|';
\copy PART FROM 'part.tbl' DELIMITER '|';
\copy SUPPLIER FROM 'supplier.tbl' DELIMITER '|';
\copy CUSTOMER FROM 'customer.tbl' DELIMITER '|';
\copy PARTSUPP FROM 'partsupp.tbl' DELIMITER '|';
\copy ORDERS FROM 'orders.tbl' DELIMITER '|';
\copy LINEITEM FROM 'lineitem.tbl' DELIMITER '|';
