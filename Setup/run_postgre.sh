#!/bin/sh

# USAGE: ./run_postgre.sh [number of runs] [number of clients/queries]
# EXAMPLE: ./run_postgre.sh 10 100

# forwarding postgre output to /dev/null
# to clear output

for i in `seq 1 ${1}`
do
	echo '\033[0;32mRun' $i '\033[0m'
	psql < scripts/drop.sql > /dev/null
	echo

	echo '\033[0;31mdatabase creation\033[0m'
	time psql < scripts/postgre/tables_postgre.sql > /dev/null
	echo

	echo '\033[0;31mloads\033[0m'
	time psql < scripts/postgre/loads/load_region.sql > /dev/null
	time psql < scripts/postgre/loads/load_nation.sql > /dev/null
	time psql < scripts/postgre/loads/load_part.sql > /dev/null
	time psql < scripts/postgre/loads/load_supplier.sql > /dev/null
	time psql < scripts/postgre/loads/load_customer.sql > /dev/null
	time psql < scripts/postgre/loads/load_partsupp.sql > /dev/null
	time psql < scripts/postgre/loads/load_orders.sql > /dev/null
	time psql < scripts/postgre/loads/load_lineitem.sql > /dev/null
	echo

	echo '\033[0;31mkey gen\033[0m'
	time psql < scripts/postgre/keys/keys_region.sql > /dev/null
	time psql < scripts/postgre/keys/keys_nation.sql > /dev/null
	time psql < scripts/postgre/keys/keys_customer.sql > /dev/null
	time psql < scripts/postgre/keys/keys_supplier.sql > /dev/null
	time psql < scripts/postgre/keys/keys_part.sql > /dev/null
	time psql < scripts/postgre/keys/keys_partsupp.sql > /dev/null
	time psql < scripts/postgre/keys/keys_orders.sql > /dev/null
	time psql < scripts/postgre/keys/keys_lineitem.sql > /dev/null
	echo

	# warm up
	echo '\033[0;31mwarm up\033[0m'
	time ./code/bench 1 teste.sql postgre $2 > /dev/null
	echo

	# benchmark
	echo '\033[0;31mqueries\033[0m'
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
