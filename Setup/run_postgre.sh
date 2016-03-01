#!/bin/sh

# USAGE: ./run_postgre.sh [number of runs] [number of clients/queries]
# EXAMPLE: ./run_postgre.sh 10 100

# forwarding postgre output to /dev/null
# to clear output

for i in `seq 1 ${1}`
do
    echo '\033[0;32mRun' $i '\033[0m'
    psql < scripts/drop.sql > /dev/null
    time psql < scripts/postgre/tables_postgre.sql > /dev/null
    time psql < scripts/postgre/load_postgre.sql > /dev/null
    time psql < scripts/postgre/keys_postgre.sql > /dev/null
    echo

    # warm up
    time ./code/bench 1 teste.sql postgre $2 > /dev/null

    # benchmark
    time ./code/bench 1  1.sql postgre $2 > /dev/null
    time ./code/bench 1  2.sql postgre $2 > /dev/null
    time ./code/bench 1  3.sql postgre $2 > /dev/null
    time ./code/bench 1  4.sql postgre $2 > /dev/null
    time ./code/bench 1  5.sql postgre $2 > /dev/null
    time ./code/bench 1  6.sql postgre $2 > /dev/null
    time ./code/bench 1  7.sql postgre $2 > /dev/null
    time ./code/bench 1  8.sql postgre $2 > /dev/null
    time ./code/bench 1  9.sql postgre $2 > /dev/null
    time ./code/bench 1 10.sql postgre $2 > /dev/null
    echo
done;
