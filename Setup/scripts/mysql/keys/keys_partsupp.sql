USE Project1SGD;

ALTER TABLE PARTSUPP
ADD PRIMARY KEY (PS_PARTKEY,PS_SUPPKEY),
ADD KEY (PS_PARTKEY),
ADD KEY (PS_SUPPKEY);
ALTER TABLE PARTSUPP
ADD FOREIGN KEY PARTSUPP_FK1 (PS_SUPPKEY) references SUPPLIER (S_SUPPKEY),
ADD FOREIGN KEY PARTSUPP_FK2 (PS_PARTKEY) references PART (P_PARTKEY);
