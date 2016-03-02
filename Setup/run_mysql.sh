#!/bin/sh

# USAGE: ./run_mysql.sh [number of runs] [number of clients/queries]
# EXAMPLE: ./run_mysql.sh 10 100

# First disable mysql root password with:
# SET PASSWORD FOR root@localhost=PASSWORD('');

for i in `seq 1 ${1}`
do
	echo '\033[0;32mRun' $i '\033[0m'
	mysql -u root < scripts/drop.sql
	echo

	echo '\033[0;31mdatabase creation\033[0m'
	time mysql -u root < scripts/mysql/tables_mysql.sql
	echo

	echo '\033[0;31mloads\033[0m'
	time mysql -u root < scripts/mysql/loads/load_region.sql
	time mysql -u root < scripts/mysql/loads/load_nation.sql
	time mysql -u root < scripts/mysql/loads/load_part.sql
	time mysql -u root < scripts/mysql/loads/load_supplier.sql
	time mysql -u root < scripts/mysql/loads/load_customer.sql
	time mysql -u root < scripts/mysql/loads/load_partsupp.sql
	time mysql -u root < scripts/mysql/loads/load_orders.sql
	time mysql -u root < scripts/mysql/loads/load_lineitem.sql
	echo

	echo '\033[0;31mkey gen\033[0m'
	time mysql -u root < scripts/mysql/keys/keys_region.sql
	time mysql -u root < scripts/mysql/keys/keys_nation.sql
	time mysql -u root < scripts/mysql/keys/keys_customer.sql
	time mysql -u root < scripts/mysql/keys/keys_supplier.sql
	time mysql -u root < scripts/mysql/keys/keys_part.sql
	time mysql -u root < scripts/mysql/keys/keys_partsupp.sql
	time mysql -u root < scripts/mysql/keys/keys_orders.sql
	time mysql -u root < scripts/mysql/keys/keys_lineitem.sql
	echo

	# warm up
	echo '\033[0;31mwarm up\033[0m'
	time ./code/bench 1 teste.sql mysql $2 > /dev/null
	echo

	# benchmark
	echo '\033[0;31mqueries\033[0m'
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
