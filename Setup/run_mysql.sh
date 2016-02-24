#!/bin/sh

# USAGE: ./run_mysql.sh [number of runs]
# EXAMPLE: ./run_mysql.sh 10

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

    # benchmark
    time --format='querie 1 (1 querie to n clients) took: %e seconds' ./code/bench 100 teste.sql mysql 1 > /dev/null
    time --format='querie 1 (n queries to 1 client) took: %e seconds' ./code/bench 1 teste.sql mysql 100 > /dev/null
    echo
done;
