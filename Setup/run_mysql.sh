#!/bin/sh

# USAGE: ./run_mysql.sh [number of runs] [number of clients/queries]
# EXAMPLE: ./run_mysql.sh 10 100

# First disable mysql root password with:
# SET PASSWORD FOR root@localhost=PASSWORD('');

for i in `seq 1 ${1}`
do
    echo '\033[0;32mRun' $i '\033[0m'
    mysql -u root < scripts/drop.sql
    time mysql -u root < scripts/mysql/tables_mysql.sql
    time mysql -u root < scripts/mysql/load_mysql.sql
    time mysql -u root < scripts/mysql/keys_mysql.sql
    echo

    # warm up
    time ./code/bench 1 teste.sql mysql $2 > /dev/null

    # benchmark
    time ./code/bench 1  1.sql mysql $2 > /dev/null
    time ./code/bench 1  2.sql mysql $2 > /dev/null
    time ./code/bench 1  3.sql mysql $2 > /dev/null
    time ./code/bench 1  4.sql mysql $2 > /dev/null
    time ./code/bench 1  5.sql mysql $2 > /dev/null
    time ./code/bench 1  6.sql mysql $2 > /dev/null
    time ./code/bench 1  7.sql mysql $2 > /dev/null
    time ./code/bench 1  8.sql mysql $2 > /dev/null
    time ./code/bench 1  9.sql mysql $2 > /dev/null
    time ./code/bench 1 10.sql mysql $2 > /dev/null
    echo
done;
