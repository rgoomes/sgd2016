#!/bin/sh

# USAGE: ./run_postgre.sh [number of runs] [number of clients/queries]
# EXAMPLE: ./run_postgre.sh 10 100

# First disable mysql root password with:
# SET PASSWORD FOR root@localhost=PASSWORD('');

for i in `seq 1 ${1}`
do
    echo '\033[0;32mRun' $i '\033[0m'
    mysql -u root < scripts/drop.sql
    time --format='tables creation took %e seconds' mysql -u root < scripts/mysql/tables_mysql.sql
    time --format='load data took %e seconds' mysql -u root < scripts/mysql/load_mysql.sql
    time --format='keys creation took %e seconds' mysql -u root < scripts/mysql/keys_mysql.sql
    echo

    # warm up
    time --format='test (1 querie to n clients) took: %e seconds' ./code/bench $2 teste.sql mysql 1 > /dev/null
    time --format='test (n queries to 1 client) took: %e seconds' ./code/bench 1 teste.sql mysql $2 > /dev/null

    # benchmark
    time --format='querie 1 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql mysql 1 > /dev/null
    time --format='querie 1 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql mysql $2 > /dev/null
    time --format='querie 2 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql mysql 1 > /dev/null
    time --format='querie 2 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql mysql $2 > /dev/null
    time --format='querie 3 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql mysql 1 > /dev/null
    time --format='querie 3 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql mysql $2 > /dev/null
    time --format='querie 4 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql mysql 1 > /dev/null
    time --format='querie 4 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql mysql $2 > /dev/null
    time --format='querie 5 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql mysql 1 > /dev/null
    time --format='querie 5 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql mysql $2 > /dev/null
    time --format='querie 6 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql mysql 1 > /dev/null
    time --format='querie 6 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql mysql $2 > /dev/null
    time --format='querie 7 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql mysql 1 > /dev/null
    time --format='querie 7 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql mysql $2 > /dev/null
    time --format='querie 8 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql mysql 1 > /dev/null
    time --format='querie 8 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql mysql $2 > /dev/null
    time --format='querie 9 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql mysql 1 > /dev/null
    time --format='querie 9 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql mysql $2 > /dev/null
    time --format='querie 10 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql mysql 1 > /dev/null
    time --format='querie 10 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql mysql $2 > /dev/null
    echo
done;
