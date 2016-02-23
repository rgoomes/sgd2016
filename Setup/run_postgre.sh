#!/bin/sh

# USAGE: ./run_postgre.sh [number of runs]
# EXAMPLE: ./run_postgre.sh 10

# forwarding postgre output to /dev/null
# to clear output

for i in `seq 1 ${1}`
do
    echo '\033[0;32mRun' $i '\033[0m'
    psql < scripts/drop.sql > /dev/null
    time --format='tables creation took %e seconds' psql < scripts/postgre/tables_postgre.sql > /dev/null
    time --format='keys creation took %e seconds' psql < scripts/postgre/keys_postgre.sql > /dev/null
    time --format='load data took %e seconds' psql < scripts/postgre/load_postgre.sql > /dev/null
    echo

    # benchmark
    time --format='querie 1 (1 querie to n clients) took: %e seconds' ./code/bench 100 teste.sql postgre 1 > /dev/null
    time --format='querie 1 (n queries to 1 client) took: %e seconds' ./code/bench 1 teste.sql postgre 100 > /dev/null
    echo
done;
