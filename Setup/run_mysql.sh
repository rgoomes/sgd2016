#!/bin/sh

# USAGE: ./run_mysql.sh [number of runs]
# EXAMPLE: ./run_mysql.sh 10

# First disable mysql root password with:
# SET PASSWORD FOR root@localhost=PASSWORD('');

for i in `seq 1 ${1}`
do
    echo 'Run' $i
    mysql -u root < drop.sql
    time --format='gen took %e seconds' mysql -u root < gen_mysql.sql
    time --format='load took %e seconds' mysql -u root < load_mysql.sql
    echo
done;
