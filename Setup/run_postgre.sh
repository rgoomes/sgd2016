#!/bin/sh

# USAGE: ./run_postgre.sh [number of runs]
# EXAMPLE: ./run_postgre.sh 10

# forwarding postgre output to /dev/null
# to clear output 

for i in `seq 1 ${1}`
do
    echo 'Run' $i
    psql < drop.sql > /dev/null
    time --format='gen took %e seconds' psql < gen_postgre.sql > /dev/null
    time --format='load took %e seconds' psql < load_postgre.sql > /dev/null
    echo
done;
