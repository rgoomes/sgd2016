\connect project1sgd;

ALTER TABLE NATION
ADD PRIMARY KEY (N_NATIONKEY);
ALTER TABLE NATION
ADD FOREIGN KEY (N_REGIONKEY) references REGION (R_REGIONKEY);
