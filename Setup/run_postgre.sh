#!/bin/sh

# USAGE: ./run_postgre.sh [number of runs] [number of clients/queries]
# EXAMPLE: ./run_postgre.sh 10 100

# forwarding postgre output to /dev/null
# to clear output

for i in `seq 1 ${1}`
do
    echo '\033[0;32mRun' $i '\033[0m'
    psql < scripts/drop.sql > /dev/null
    time --format='tables creation took %e seconds' psql < scripts/postgre/tables_postgre.sql > /dev/null
    time --format='load data took %e seconds' psql < scripts/postgre/load_postgre.sql > /dev/null
    time --format='keys creation took %e seconds' psql < scripts/postgre/keys_postgre.sql > /dev/null
    echo

    # warm up
    time --format='test (1 querie to n clients) took: %e seconds' ./code/bench $2 teste.sql postgre 1 > /dev/null
    time --format='test (n queries to 1 client) took: %e seconds' ./code/bench 1 teste.sql postgre $2 > /dev/null

    # benchmark
    time --format='querie 1 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql postgre 1 > /dev/null
    time --format='querie 1 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql postgre $2 > /dev/null
    time --format='querie 2 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql postgre 1 > /dev/null
    time --format='querie 2 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql postgre $2 > /dev/null
    time --format='querie 3 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql postgre 1 > /dev/null
    time --format='querie 3 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql postgre $2 > /dev/null
    time --format='querie 4 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql postgre 1 > /dev/null
    time --format='querie 4 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql postgre $2 > /dev/null
    time --format='querie 5 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql postgre 1 > /dev/null
    time --format='querie 5 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql postgre $2 > /dev/null
    time --format='querie 6 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql postgre 1 > /dev/null
    time --format='querie 6 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql postgre $2 > /dev/null
    time --format='querie 7 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql postgre 1 > /dev/null
    time --format='querie 7 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql postgre $2 > /dev/null
    time --format='querie 8 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql postgre 1 > /dev/null
    time --format='querie 8 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql postgre $2 > /dev/null
    time --format='querie 9 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql postgre 1 > /dev/null
    time --format='querie 9 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql postgre $2 > /dev/null
    time --format='querie 10 (1 querie to n clients) took: %e seconds' ./code/bench $2 1.sql postgre 1 > /dev/null
    time --format='querie 10 (n queries to 1 client) took: %e seconds' ./code/bench 1 1.sql postgre $2 > /dev/null
    echo
done;
