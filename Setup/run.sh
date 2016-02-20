#!/bin/sh

# USAGE: ./run.sh [number of runs]
# EXAMPLE: ./run.sh 10

# First disable mysql root password with:
# SET PASSWORD FOR root@localhost=PASSWORD('');

for i in `seq 1 ${1}`
do
    echo 'Run' $i
    mysql -u root < drop.sql
    time --format='gen took %e seconds' mysql -u root < gen.sql
    time --format='load took %e seconds' mysql -u root < load.sql
    echo
done;
