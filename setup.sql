CREATE DATABASE IF NOT EXISTS sgd;
USE sgd;

CREATE TABLE IF NOT EXISTS NATION  ( N_NATIONKEY  INTEGER NOT NULL,
                            N_NAME       CHAR(25) NOT NULL,
                            N_REGIONKEY  INTEGER NOT NULL,
                            N_COMMENT    VARCHAR(152));

CREATE TABLE IF NOT EXISTS REGION  ( R_REGIONKEY  INTEGER NOT NULL,
                            R_NAME       CHAR(25) NOT NULL,
                            R_COMMENT    VARCHAR(152));

CREATE TABLE IF NOT EXISTS PART  ( P_PARTKEY     INTEGER NOT NULL,
                          P_NAME        VARCHAR(55) NOT NULL,
                          P_MFGR        CHAR(25) NOT NULL,
                          P_BRAND       CHAR(10) NOT NULL,
                          P_TYPE        VARCHAR(25) NOT NULL,
                          P_SIZE        INTEGER NOT NULL,
                          P_CONTAINER   CHAR(10) NOT NULL,
                          P_RETAILPRICE DECIMAL(15,2) NOT NULL,
                          P_COMMENT     VARCHAR(23) NOT NULL );

CREATE TABLE IF NOT EXISTS SUPPLIER ( S_SUPPKEY     INTEGER NOT NULL,
                             S_NAME        CHAR(25) NOT NULL,
                             S_ADDRESS     VARCHAR(40) NOT NULL,
                             S_NATIONKEY   INTEGER NOT NULL,
                             S_PHONE       CHAR(15) NOT NULL,
                             S_ACCTBAL     DECIMAL(15,2) NOT NULL,
                             S_COMMENT     VARCHAR(101) NOT NULL);

CREATE TABLE IF NOT EXISTS PARTSUPP ( PS_PARTKEY     INTEGER NOT NULL,
                             PS_SUPPKEY     INTEGER NOT NULL,
                             PS_AVAILQTY    INTEGER NOT NULL,
                             PS_SUPPLYCOST  DECIMAL(15,2)  NOT NULL,
                             PS_COMMENT     VARCHAR(199) NOT NULL );

CREATE TABLE IF NOT EXISTS CUSTOMER ( C_CUSTKEY     INTEGER NOT NULL,
                             C_NAME        VARCHAR(25) NOT NULL,
                             C_ADDRESS     VARCHAR(40) NOT NULL,
                             C_NATIONKEY   INTEGER NOT NULL,
                             C_PHONE       CHAR(15) NOT NULL,
                             C_ACCTBAL     DECIMAL(15,2)   NOT NULL,
                             C_MKTSEGMENT  CHAR(10) NOT NULL,
                             C_COMMENT     VARCHAR(117) NOT NULL);

CREATE TABLE IF NOT EXISTS ORDERS  ( O_ORDERKEY       INTEGER NOT NULL,
                           O_CUSTKEY        INTEGER NOT NULL,
                           O_ORDERSTATUS    CHAR(1) NOT NULL,
                           O_TOTALPRICE     DECIMAL(15,2) NOT NULL,
                           O_ORDERDATE      DATE NOT NULL,
                           O_ORDERPRIORITY  CHAR(15) NOT NULL,
                           O_CLERK          CHAR(15) NOT NULL,
                           O_SHIPPRIORITY   INTEGER NOT NULL,
                           O_COMMENT        VARCHAR(79) NOT NULL);

CREATE TABLE IF NOT EXISTS LINEITEM ( L_ORDERKEY    INTEGER NOT NULL,
                             L_PARTKEY     INTEGER NOT NULL,
                             L_SUPPKEY     INTEGER NOT NULL,
                             L_LINENUMBER  INTEGER NOT NULL,
                             L_QUANTITY    DECIMAL(15,2) NOT NULL,
                             L_EXTENDEDPRICE  DECIMAL(15,2) NOT NULL,
                             L_DISCOUNT    DECIMAL(15,2) NOT NULL,
                             L_TAX         DECIMAL(15,2) NOT NULL,
                             L_RETURNFLAG  CHAR(1) NOT NULL,
                             L_LINESTATUS  CHAR(1) NOT NULL,
                             L_SHIPDATE    DATE NOT NULL,
                             L_COMMITDATE  DATE NOT NULL,
                             L_RECEIPTDATE DATE NOT NULL,
                             L_SHIPINSTRUCT CHAR(25) NOT NULL,
                             L_SHIPMODE     CHAR(10) NOT NULL,
                             L_COMMENT      VARCHAR(44) NOT NULL);



load data infile "part.tbl" into table part fields terminated by "|" lines terminated by "\r\n";
load data infile "partsupp.tbl" into table partsupp fields terminated by "|" lines terminated by "\r\n";
load data infile "customer.tbl" into table customer fields terminated by "|" lines terminated by "\r\n";
load data infile "nation.tbl" into table nation fields terminated by "|" lines terminated by "\r\n";
load data infile "orders.tbl" into table orders fields terminated by "|" lines terminated by "\r\n";
load data infile "region.tbl" into table region fields terminated by "|" lines terminated by "\r\n";
load data infile "supplier.tbl" into table supplier fields terminated by "|" lines terminated by "\r\n";
load data infile "lineitem.tbl" into table lineitem fields terminated by "|" lines terminated by "\r\n";



ALTER TABLE REGION
ADD PRIMARY KEY (R_REGIONKEY);

ALTER TABLE NATION
ADD PRIMARY KEY (N_NATIONKEY),
ADD PRIMARY KEY (N_REGIONKEY);

ALTER TABLE CUSTOMER
ADD PRIMARY KEY (C_CUSTKEY),
ADD KEY (C_NATIONKEY);

ALTER TABLE SUPPLIER
ADD PRIMARY KEY (S_SUPPKEY),
ADD KEY (S_NATIONKEY);

ALTER TABLE PART
ADD PRIMARY KEY (P_PARTKEY);

ALTER TABLE PARTSUPP
ADD PRIMARY KEY (PS_PARTKEY,PS_SUPPKEY),
ADD KEY (PS_PARTKEY),
ADD KEY (PS_SUPPKEY);

ALTER TABLE ORDERS
ADD PRIMARY KEY (O_ORDERKEY),
ADD KEY (O_CUSTKEY);

ALTER TABLE LINEITEM
ADD PRIMARY KEY (L_ORDERKEY,L_LINENUMBER),
ADD KEY (L_ORDERKEY),
ADD KEY (L_PARTKEY,L_SUPPKEY);



ALTER TABLE NATION
ADD FOREIGN KEY NATION_FK1 (N_REGIONKEY) references REGION (R_REGIONKEY);

ALTER TABLE SUPPLIER
ADD FOREIGN KEY SUPPLIER_FK1 (S_NATIONKEY) references NATION (N_NATIONKEY);

ALTER TABLE CUSTOMER
ADD FOREIGN KEY CUSTOMER_FK1 (C_NATIONKEY) references NATION (N_NATIONKEY);

ALTER TABLE PARTSUPP
ADD FOREIGN KEY PARTSUPP_FK1 (PS_SUPPKEY) references SUPPLIER (S_SUPPKEY),
ADD FOREIGN KEY PARTSUPP_FK2 (PS_PARTKEY) references PART (P_PARTKEY);

ALTER TABLE ORDERS
ADD FOREIGN KEY ORDERS_FK1 (O_CUSTKEY) references CUSTOMER (C_CUSTKEY);

ALTER TABLE LINEITEM
ADD FOREIGN KEY LINEITEM_FK1 (L_ORDERKEY)  references ORDERS (O_ORDERKEY),
ADD FOREIGN KEY LINEITEM_FK2 (L_PARTKEY,L_SUPPKEY) references PARTSUPP (PS_PARTKEY,PS_SUPPKEY);
